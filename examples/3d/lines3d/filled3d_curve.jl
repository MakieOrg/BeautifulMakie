# ## Filled curve in 3d

# From: https://discourse.julialang.org/t/fill-a-curve-in-3d/37890/8

using GLMakie
GLMakie.activate!()

x = 0:0.05:3;
y = 0:0.05:3;
z = @. sin(x) * exp(-(x+y))

fig = Figure(; size=(600, 400))
ax = Axis3(fig[1,1]; limits=((0,3), (0,3), (0,0.2)),
    perspectiveness = 0.5,
    azimuth = -0.5,
    elevation = 0.3,)
lines!(Point3f.(x, 0, z), transparency=true)
lines!(Point3f.(0, y, z), transparency=true)
band!(Point3f.(x, y, 0), Point3f.(x, y, z);
    color=(:orangered, 0.25), transparency=true)
lines!(Point3f.(x, y, z); color=(:orangered, 0.9), transparency=true)
fig

# ## Filled gradient under 3D curve

fig = Figure(; size=(600, 400))
ax = Axis3(fig[1,1]; limits=((0,3), (0,3), (0,0.2)),
    perspectiveness = 0.5,
    azimuth = -0.5,
    elevation = 0.3,)

band!(Point3f.(x, y, 0), Point3f.(x, y, z); color = z,
    colormap = (:Spectral, 0.85), transparency=true)
lines!(Point3f.(x, y, z); color=(:black, 0.9), transparency=true)
fig
