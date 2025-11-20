# ## Meshes: Cylinder, Pyramid, Cone, Cube

# ![](meshes.png)

using GLMakie, Random, Colors, LinearAlgebra
using GeometryBasics: Cylinder, Pyramid
using Makie
using GeometryBasics
GLMakie.activate!() # hide
GLMakie.closeall() # close any open screen

Random.seed!(3)

cyl = Cylinder(Point{3, Float64}(1,2,3), Point{3, Float64}(2,3,4), 1.0)
pyr = Pyramid(Point3f(0), 1f0, 1f0)
rectmesh = Rect3(Point3f(-0.5), Vec3f(1))
rectthin = Rect3(Point3f(-1), Vec3f(2,2,0.25))
sphere = Sphere(Point3f(-0.5), 1)
function Kone(; quality = 10)
    ## Create base circle points
    base_radius = 0.5f0
    base_points = Point3f[]
    for i in 0:quality-1
        angle = 2π * i / quality
        x = base_radius * cos(angle)
        y = base_radius * sin(angle)
        push!(base_points, Point3f(x, y, 0))
    end
    
    ## Apex point
    apex = Point3f(0, 0, 1)
    
    ## Create faces connecting base to apex
    faces = TriangleFace{Int}[]
    for i in 1:quality
        next_i = (i % quality) + 1
        ## Triangle: base point i, base point next, apex
        push!(faces, TriangleFace(i, next_i, quality + 1))
    end
    ## Base circle face
    for i in 2:quality-1
        push!(faces, TriangleFace(1, i, i + 1))
    end
    
    ## Combine all points
    all_points = vcat(base_points, [apex])
    
    return GeometryBasics.Mesh(all_points, faces)
end
cone = Kone()
rectMesh = GeometryBasics.mesh(rectmesh)
rectThin = GeometryBasics.mesh(rectthin)
cyL = GeometryBasics.mesh(cyl)

cmap = resample_cmap(:Spectral_11, 3*length(rectMesh.position))
colors1 = [cmap[i] for i in 1:3*length(rectMesh.position)]
colors2 = repeat([RGBA(rand(4)...) for v in rectThin.position], 3)
colors3 = repeat([norm(v) for v in cyL.position], 2)[1:62]
markers = [sphere, rectmesh, cyl, pyr, cone]

with_theme(theme_dark()) do
    fig = Figure(size = (1200,800))
    axs = [Axis3(fig[i,j]; aspect = :data, perspectiveness = 0.5) 
        for j in 1:3, i in 1:2]
    mesh!(axs[1], sphere, color = :white)
    mesh!(axs[2], rectmesh, color = colors1)
    mesh!(axs[3], pyr; color = (:dodgerblue, 0.85))
    wireframe!(axs[3], pyr; color = :grey90)
    mesh!(axs[4], cyl; color = colors3, 
        colormap = :diverging_tritanopic_cwr_75_98_c20_n256)
    mesh!(axs[5], cone; transparency = true)
    wireframe!(axs[5], cone; color = :grey90, linewidth = 0.5)
    mesh!(axs[6], rectthin; color = colors2, shading = NoShading)
    [meshscatter!(axs[6], Point3f(1.5rand(3) .- 0.5); marker = markers[i], 
        markersize = 0.25) for i in 1:5]
    fig
end
save("meshes.png", current_figure()); # hide