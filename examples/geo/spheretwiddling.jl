
using GRIBDatasets # io
using GLMakie, GeoMakie # visualization
using Delaunator # fast meshing of 2d point clouds

ds = GRIBDataset("path_to_ds.grib")

# Create a triangulation of the points with Delaunator.jl
# (this only triangulates on the plane - there are ways to triangulate on the sphere, but all quite complex)
t1 = Delaunator.triangulate(tuple.(ds["longitude"], ds["latitude"]))

# Plot it using Makie.jl's `mesh` plot function,
# in a GeoMakie.GlobeAxis (3d globe).
# You can also use a GeoMakie.GeoAxis (2d projected map) or a Makie.Axis (pure 2d, no geospatial awareness).
fig, ax, plt = mesh(
    t1.points, GLMakie.TriangleFace.(t1.triangles); 
    color = replace(ds["msl"][:, 1], missing => NaN), # Makie cannot handle `missing` so we convert to NaN, Rasters.jl can handle this for you.
    shading = NoShading, # flat lighting on the mesh 
    axis = (; type = GeoMakie.GlobeAxis, show_axis = false),
    figure = (; backgroundcolor = :black)
)

# Plot coastlines, color black with 10% opacity, 20km above sea level
coastlines_plt = lines!(ax, GeoMakie.coastlines(); color = (:black, 0.1), zlevel = 20_000)

# Display the figure so you can see it and interact with it!
# GlobeAxis user controls are not the greatest at the moment but that
# will improve this summer.
fig

# Animate the whole thing
# first, add a title to the top
title = Label(fig[0, 1]; text = string(ds["valid_time"][1]), tellwidth = false, tellheight = true, color = :white)
msl = ds["msl"]

using FlyThroughPaths, GLMakie
using FlyThroughPaths.Rotations
initialstate = capture_view(ax)
path = Path(ViewState(; eyeposition = initialstate.eyeposition, lookat = Point3f(0,0,0), fov = initialstate.fov, upvector = initialstate.upvector))
path *= SlerpMove(
    length(ds["valid_time"])/2, 
    ViewState(; eyeposition = Rotations.AngleAxis(pi-eps(), 0,0,1) * initialstate.eyeposition)
)
path *= SlerpMove(
    length(ds["valid_time"])/2, 
    ViewState(; eyeposition = initialstate.eyeposition)
)
# then, simply loop over the frames and update the color of the mesh plot, and the title!
# Animation in Makie is really simple using Observables.
@time record(fig, "over_time.mp4", 1:10:length(ds["valid_time"]), framerate = 6, px_per_unit = 1, update = false) do i
    set_view!(ax, path(i))
    plt.color[] = replace(msl[:, i], missing => NaN)
    title.text[] = string(ds["valid_time"][i])
end

path = Path(ViewState(; eyeposition = initialstate.eyeposition, lookat = Point3f(0,0,0), fov = initialstate.fov, upvector = initialstate.upvector))
path *= SlerpMove(
    length(ds["valid_time"])/4, 
    ViewState(; eyeposition = Rotations.AngleAxis(pi/2, 0,0,1) * initialstate.eyeposition),
    ViewState(; eyeposition = Point3f(0, 0, initialstate.eyeposition[3])),
    nothing
)
path *= SlerpMove(
    length(ds["valid_time"])/4, 
    ViewState(; eyeposition = Rotations.AngleAxis(pi, 0,0,1) * initialstate.eyeposition),
    ViewState(; eyeposition = Point3f(0, 0, initialstate.eyeposition[3])),
    nothing
)
path *= SlerpMove(
    length(ds["valid_time"])/4, 
    ViewState(; eyeposition = Rotations.AngleAxis(3pi/2, 0,0,1) * initialstate.eyeposition),
    ViewState(; eyeposition = Point3f(0, 0, initialstate.eyeposition[3])),
    nothing
)
path *= SlerpMove(
    length(ds["valid_time"])/4, 
    ViewState(; eyeposition = initialstate.eyeposition),
    ViewState(; eyeposition = Point3f(0, 0, initialstate.eyeposition[3])),
    nothing
)
# then, simply loop over the frames and update the color of the mesh plot, and the title!
# Animation in Makie is really simple using Observables.
@time record(fig, "over_time.mp4", 1:length(ds["valid_time"]), framerate = 60, px_per_unit = 3, compression = 16, update = false) do i
    set_view!(ax, path(i))
    plt.color[] = replace(msl[:, i], missing => NaN)
    title.text[] = string(ds["valid_time"][i])
end
