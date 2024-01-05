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
GLMakie.activate!()

# ### Getting the data

# First, we get the rasters.  This is made really easy with 
# Rasters.jl, and its integration with [RasterDataSources.jl](https://github.com/EcoJulia/RasterDataSources.jl).
# This allows you to effortlessly get rasters from several
# popular datasets on demand, including WorldClim and MODIS!

# Here, we get the WorldClim climate data, which is an average of the climate
# in a given month, for the entire globe.  We obtain the data for all 12 months.
worldclim_stacks = [RasterStack(WorldClim{Climate}, month=i) for i in 1:12];

# These are RasterStacks, which are basically a collection of associated rasters.  We can
# get individual rasters from these stacks:
worldclim_stacks[1].tmax

# In order to get them into a form which we can use directly with Makie, 
# we can call `Makie.convert_arguments` directly on individual rasters from these stacks.

# This will return a tuple of `(x::Vector, y::Vector, z::Matrix)`, where 
# `z` are the values of the raster at the points `(x, y)`.  This is the format
# that we can supply directly to Makie.

Makie.convert_arguments(Makie.VertexGrid(), worldclim_stacks[1].tmax);

# Let's extract two variables from this stack, the maximum temperature (`:tmax`),
# and the precipitation (`:prec`).

temp_rasters = getproperty.(worldclim_stacks, :tmax);
prec_rasters = getproperty.(worldclim_stacks, :prec);

# ### Interpolating Rasters in time
# This is good data, but we only have twelve time points.
# If we want a smooth animation, we could interpolate them.

# Let's take advantage of Julia's easy interoperability, and use a 
# totally different package, which has no idea that Rasters.jl
# exists, but works with it thanks to the generic nature of well-written
# Julia code!

# Here, we're performing a quadratic interpolation across the timeseries of rasters.

temp_interpolated = DataInterpolations.QuadraticInterpolation(temp_rasters, 1:length(temp_rasters), extrapolate=true)
prec_interpolated = DataInterpolations.QuadraticInterpolation(prec_rasters, 1:length(temp_rasters), extrapolate=true)

# This returned an interpolation object which can be called with any time value
# (as `temp_interpolated(1.5)`) between those it's given in the second parameter of the call.

# ## A simple animation

# Let's see if this interpolation worked.  We create a figure to animate:
ras_inter = temp_interpolated(1.0)
ras_inter = replace_missing(ras_inter, NaN)

temp_inter = Observable(temp_interpolated(1.0))
fig= Figure(; size = (800,800))
ax = Axis3(fig[1,1]; perspectiveness=0.5,
    azimuth=-0.5,
    elevation=0.57,
    aspect=(1, 1, 1))
plt = surface!(ax, ras_inter; transparency=true)
hm = heatmap!(ax, ras_inter; nan_color=:black)
translate!(hm, 0, 0, -30) # get the heatmap to the bottom of the plot
fig # hide

# Now that the figure has been created, we can animate and record it.

# This is done using Makie's `record` convenience function, which can iterate through a range,
# and capture each frame and stitch it into an animation (using FFMpeg) automatically!

# We use the `@time` macro to time how long the recording takes 
# (note that this is on a device without a GPU, it will be significantly faster with one).

@time record(fig, "temperature_surface_animation.mp4", LinRange(1, 12, 480÷4); framerate = 30) do i
    ax.title[] = @sprintf "%.2f" i
    temp_inter[] = replace_missing(temp_interpolated(i), NaN)
end;

# ![type:video](temperature_surface_animation.mp4)

# ## Animating a 3-D globe

# The last animation was pretty cool!  But let's do something a little more 3D.

# We can plot these fields on a sphere, so it looks like the actual Earth!  

# This is done by plotting the rasters on a spherical mesh, which we can color using a 
# matrix of color values as a "texture" (in computer graphics terminology).

# We want to represent the Earth as a sphere, 
# so we tesselate (break up in to triangles) a sphere, 
# which represents Earth, into a mesh.

# Makie uses GeometryBasics.jl to represent geometries, and it has very simple and efficient
# routines to create meshes from simple shapes!

m = Makie.GeometryBasics.uv_normal_mesh(
    Makie.GeometryBasics.Tesselation(
        Makie.GeometryBasics.Sphere(
            Point3f(0), 1.0f0
        ),
        200
    )
);

# Now, we can decompose this mesh into its vertices, uv coordinates, and normals.
# - The vertices of the mesh are the coordinates of the points on the sphere.
# - "UV coordinates" are 2-vectors, going from 0 to 1.  Each vertex has an associated UV coordinate.
#   They provide the link between a mesh and how an image texture, like the raster we're going to color
#   the mesh by, gets applied onto that mesh.
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
fig = Figure(; size=(800, 800))
# First, we plot an empty the sphere
ax, plt_obj = mesh(fig[1, 1], uv_normal_mesh(Tesselation(Sphere(Point3f(0), 0.99), 128));
    color=(:white, 0.1), transparency=true,
    axis=(type=LScene, show_axis=false)
)
# Then, we plot the sphere, which displays temperature.
temperature_plot = mesh!(
    m;
    color=Makie.convert_arguments(Makie.VertexGrid(), worldclim_stacks[10].tmax)[3]'[end:-1:1,:] |> Matrix,
    colorrange=(-65, 50),
    lowclip=:transparent,
    colormap=:tableau_temperature, #cmap, 
    shading = FastShading,
    transparency=false
)
fig

# Note how we defined the color!  
# We called `Makie.convert_arguments` on a `Raster` to get a tuple of `(x, y, z)`, 
# then used the `z` matrix as a texture to color the mesh.

# The auto-generated UV coordinates are in the convention which devices use,
# and are actually swapped from the dimensions of column-major matrices in Julia.
# That's why we have to transpose the matrix we get from `convert_arguments`.

# Next, we plot the water as a meshscatter plot, in this case
# kind of like a 3-D barplot on the sphere.

# This is a simple utility function which retrieves the water values from the raster,
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

raster2array(raster) = Makie.convert_arguments(Makie.VertexGrid(), raster)[3]'[end:-1:1,:]
watervals = watermap(uv, raster2array(worldclim_stacks[1].prec))

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

# Before we animate, we could change the camera angles with:

#eye_position = Vec3f(0.31496838, -1.1342758, 2.535153)
#lookat = Vec3f(0.084392734, -0.011545606, 0.12137972)
#upvector = Vec3f(0.29894897, 0.71282643, 0.6344353)
#update_cam!(ax.scene, eye_position, lookat, upvector)

# Let's also add a little title which tells us which season we're in:
title_label = Label(fig[0, 1]; tellwidth = false, font = :bold, fontsize = 20)
Colorbar(fig[1,2], temperature_plot, label="Temperature", height = Relative(0.5))
Colorbar(fig[2,1], prec_plot, label="Precipitation", width = Relative(0.5), vertical=false)

zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
display(fig; update=false) # hide

# Now, we animate the water and temperature plots!

record(fig, "worldclim_visualization.mp4", LinRange(1, 24, 600÷4); framerate = 24, update=false) do i
    title_label.text[] = @sprintf "%.2f" (i % 12)
    temperature_plot.color[] = raster2array(temp_interpolated(i % 12))
    watervals = max.(0, watermap(uv, raster2array(prec_interpolated(i % 12))))
    prec_plot.color[] = watervals
    prec_plot.markersize[] .= Vec3f0.(xy_width, xy_width, watervals)
    ## since we modify markersize inplace above, we need to notify the signal
    rotate!(ax.scene, i / 7)
    notify(prec_plot.markersize)
end;

# ![type:video](worldclim_visualization.mp4)

# This example, and some of the development work which made it possible, was funded by the [xKDR Forum](https://www.xkdr.org).
