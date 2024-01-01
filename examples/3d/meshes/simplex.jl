using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

vertices = [
    0 0 0
    1 0 0
    0 1 0 
    0 0 1
    ]
faces = [
    3 2 1
    4 1 2
    4 3 1
    4 2 3
    ]
## m = GLMakie.GeometryBasics.Mesh(GLMakie.Makie.to_vertices(vertices), GLMakie.Makie.to_triangles(faces))
## mesh(m)

marker = Sphere(Point3f(0), 1) # 0 -> -0.5, fully inside, 0 -> 0.5 fully outside

fig = Figure(size = (600,600))
ax = LScene(fig[1,1], show_axis=false)
m = mesh!(ax, vertices, faces; color = :white, transparency=true,)
poly!(ax, vertices, faces; color = :transparent, 
    transparency=true, strokewidth = 1.0)
meshscatter!(ax, 
    Point3f(1/3, 1/3,1/3),  # you need to calculate this for your use case
    marker = marker, markersize = 0.025, transparency=true)
## the following are not over the plane nither perpendicular.
arrows!(ax, 
    [Point3f(1/3, 1/3,1/3)],  # you need to calculate this for your use case
    [Point3f(0.2, 0.1,0.3)],  # you need to calculate this for your use case
    arrowsize = Vec3f(0.05, 0.05, 0.08),
    color = :red,
    arrowcolor = :black)
arrows!(ax, 
    [Point3f(1/3, 1/3,1/3)],  # you need to calculate this for your use case
    [Point3f(-0.1, -0.1,0.3)],  # you need to calculate this for your use case
    arrowsize = Vec3f(0.08, 0.08, 0.08),
    linewidth = 0.02,
    color = :dodgerblue,
    arrowcolor = :orange)
zoom!(ax.scene, cameracontrols(ax.scene), 0.9)
rotate!(ax.scene, -0.1)
fig
save("simplex.png", fig); # hide

# ![](simplex.png)