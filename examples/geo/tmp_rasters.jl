# # Animating Rasters with Makie.jl
# Author: Anshul Singhvi

# "Rasters" are a common data format for representing spatial data, specifically
# data points on a uniform grid.  In Julia, we can represent and manipulate these 
# using the [Rasters.jl](https://github.com/rafaqz/Rasters.jl) package.

# Rasters.jl currently handles raster arrays like GeoTIFF and NetCDF, R grd files, 
# multi-layered stacks, and multi-file series of arrays and stacks.

# In this example, we'll use Rasters.jl to load some climate data from [WorldClim](https://www.worldclim.org),
# and then visualize it in multiple ways using Makie's recipe system (sometimes automatically, and sometimes manually!).

# We'll also show the Julia package ecosystem's effortless interoperability, by using [DataInterpolations.jl](https://github.com/PumasAI/DataInterpolations.jl)
# to smoothly interpolate a timeseries of rasters, and animate them in Makie!

# ENV["RASTERDATASOURCES_PATH"] = ".." # joinpath(tempdir(), "Rasters"), needed for RasterDataSources

# Let's load the packages:

using Rasters
using RasterDataSources
using ArchGDAL
using GLMakie
using Makie.GeometryBasics
using Makie.GeometryBasics: Tesselation, uv_normal_mesh
using DataInterpolations, Printf

# ### Getting the data

# First, we get the rasters.  This is made really easy with 
# Rasters.jl, and its integration with [RasterDataSources.jl](https://github.com/EcoJulia/RasterDataSources.jl).
# This allows you to effortlessly get rasters from several
# popular datasets on demand, including WorldClim and MODIS!

# Here, we get the WorldClim climate data, which is an average of the climate
# in a given month, for the entire globe.  We obtain the data for all 12 months.
worldclim_stacks = [RasterStack(WorldClim{Climate}, month=i) for i in 1:12]

# These are RasterStacks, which are basically a collection of associated rasters.  We can
# get individual rasters from these stacks:
worldclim_stacks[1].tmax

# In order to get them into a form which we can use directly with Makie, 
# we can call `Makie.convert_arguments` directly on individual rasters from these stacks.

# This will return a tuple of `(x::Vector, y::Vector, z::Matrix)`, where 
# `z` are the values of the raster at the points `(x, y)`.  This is the format
# that we can supply directly to Makie.

Makie.convert_arguments(Makie.ContinuousSurface(), worldclim_stacks[1].tmax)

# Let's extract two variables from this stack, the maximum temperature (`:tmax`),
# and the precipitation (`:prec`).

temp_rasters = getproperty.(worldclim_stacks, :tmax)
prec_rasters = getproperty.(worldclim_stacks, :prec)

# ### Interpolating Rasters in time
# This is good data, but we only have twelve time points.
# If we want a smooth animation, we could interpolate them.

# Let's take advantage of Julia's easy interoperability, and use a 
# totally different package, which has no idea that Rasters.jl
# exists, but works with it thanks to the generic nature of well-written
# Julia code!

# Here, we're performing a quadratic interpolation across the timeseries of rasters.

temp_interpolated = DataInterpolations.QuadraticInterpolation(temp_rasters, 1:length(temp_rasters))
prec_interpolated = DataInterpolations.QuadraticInterpolation(prec_rasters, 1:length(temp_rasters))

# This returned an interpolation object which can be called with any time value
# (as `temp_interpolated(1.5)`) between those it's given in the second parameter of the call.

# ## A simple animation

# Let's see if this interpolation worked.  We create a figure to animate:
fig, ax, plt = surface(temp_interpolated(1.0); transparency=true,
    axis=(; type=Axis3,
        perspectiveness=0.5,
        azimuth=-0.5,
        elevation=0.57,
        aspect=(1, 1, 1)),
    figure=(; resolution=(800, 800))
)
hm = heatmap!(ax, temp_interpolated(1.0); nan_color=:black)
translate!(hm, 0, 0, -30) # get the heatmap to the bottom of the plot
fig # hide


m = Makie.GeometryBasics.uv_normal_mesh(
    Makie.GeometryBasics.Tesselation(
        Makie.GeometryBasics.Sphere(
            Point3f(0), 1.0f0
        ),
        200
    )
);

p = decompose(Point3f0, m)
uv = decompose_uv(m)
norms = decompose_normals(m);

# Now, we move to the visualization!

# Let's first define a colormap which we'll use to plot:
cmap = [:darkblue, :deepskyblue2, :deepskyblue, :gold, :tomato3, :red, :darkred]
# this colormap is fun, but its confusing when including also the one for precipitation.
Makie.to_colormap(cmap) # hide

# We create the Figure, which is the top-level object in Makie,
# and holds the axis which holds our plots.
set_theme!(theme_black())
fig = Figure(resolution=(800 * 2, 800 * 2))
# First, we plot an empty the sphere
ax, plt_obj = mesh(fig[1, 1], uv_normal_mesh(Tesselation(Sphere(Point3f(0), 0.99), 128));
    color=(:white, 0.1), transparency=true,
    axis=(type=LScene, show_axis=false)
)
# Then, we plot the sphere, which displays temperature.
temperature_plot = mesh!(
    m;
    color=Makie.convert_arguments(Makie.ContinuousSurface(), worldclim_stacks[10].tmax)[3]',
    colorrange=(-50, 50),
    colormap=:tableau_temperature, #cmap, 
    shading=true,
    transparency=false
)
fig


# and resamples them to the mesh's nonlinear grid.
function watermap(uv, water, normalization=908.0f0 * 4.0f0)
    markersize = map(uv) do uv
        wsize = reverse(size(water))
        wh = wsize .- 1
        x, y = round.(Int, Tuple(uv) .* wh) .+ 1
        val = water[size(water)[1]-(y-1), x] / normalization
        (isnan(val) || (val < 0.0)) ? -1.0f0 : val
    end
end

# We don't want to call `convert_arguments` all the time, so let's 
# define a convenience function to do it:

raster2array(raster) = Makie.convert_arguments(Makie.ContinuousSurface(), raster)[3]
watervals = watermap(uv, raster2array(worldclim_stacks[1].prec)')

# Let's finally plot the meshscatter!

xy_width = 0.01
prec_plot = meshscatter!(
    p, # the positions of the tessellated mesh we got last time
    rotations=norms, # rotate according to the normal vector, pointing out of the sphere
    marker=Rect3(Vec3f(0), Vec3f(1)), # unit box
    markersize=Vec3f0.(xy_width, xy_width, max.(0, watervals)), # scale by 0.01 in x and y, and `watervals` in z
    color=max.(0, watervals),
    colorrange=(0, 0.2),
    colormap=[(:red, 0.01), (:dodgerblue, 0.7)],
    shading=false,
    transparency=true,
)
fig # hide



zoom!(ax.scene, cameracontrols(ax.scene), 0.8)
fig # hide

# Now, we animate the water and temperature plots!

record(fig, "worldclim_visualization_temp_precip.mp4", LinRange(1, 24, 600); framerate=24) do i
    #title_label.text[] = @sprintf "%.2f" (i % 12)
    temperature_plot.color[] = raster2array(temp_interpolated(i % 12))'
    watervals = max.(0, watermap(uv, raster2array(prec_interpolated(i % 12))'))
    prec_plot.color[] = watervals
    prec_plot.markersize[] .= Vec3f0.(xy_width, xy_width, watervals)
    ## since we modify markersize inplace above, we need to notify the signal
    rotate!(ax.scene, i / 7)
    notify(prec_plot.markersize)
end;



# This example, and some of the development work which made it possible, was funded by the [xKDR Forum](https://www.xkdr.org).
