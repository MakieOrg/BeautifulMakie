# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
using GeometryBasics, LinearAlgebra, StatsBase
using Makie: get_dim, surface_normals
GLMakie.activate!() # HIDE
let
    ### The bottle
    u = LinRange(0,π,100)
    v = LinRange(0,2π,100)
    x = [-2/15 * cos(u)*(3*cos(v) - 30*sin(u) + 90*cos(u)^4 *sin(u)
            - 60*cos(u)^6 * sin(u) + 5*cos(u)*cos(v)*sin(u)) for u in u, v in v]
    y = [-1/15 * sin(u)*(3*cos(v) - 3*cos(u)^2*cos(v) - 48*cos(u)^4 *cos(v) + 48*cos(u)^6 *cos(v)
            - 60*sin(u) + 5*cos(u)*cos(v)*sin(u) - 5*cos(u)^3*cos(v)*sin(u)
            -80*cos(u)^5 * cos(v)*sin(u) + 80*cos(u)^7*cos(v)*sin(u)) for u in u, v in v]
    z = [2/15 * (3 + 5*cos(u)*sin(u))*sin(v) for u in u, v in v]

    function getMesh(x,y,z)
        positions = vec(map(CartesianIndices(z)) do i
        GeometryBasics.Point{3, Float32}(
            get_dim(x, i, 1, size(z)),
            get_dim(y, i, 2, size(z)),
            z[i])
        end)
        faces = decompose(GLTriangleFace, Rect2D(0f0, 0f0, 1f0, 1f0), size(z))
        normals = surface_normals(x, y, z)
        vertices = GeometryBasics.meta(positions; normals=normals)
        meshObj = GeometryBasics.Mesh(vertices, faces)
        meshObj
    end
    meshKlein = getMesh(x,y,z)
    fig = Figure(resolution = (1200, 800), backgroundcolor = :white)
    fig.layout.alignmode[] = Outside(0)
    ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = false))
    mesh!(ax,meshKlein, color = [norm(v) for v in coordinates(meshKlein)],
        colormap = (:Spectral_11,0.95))
    rotate_cam!(ax.scene, (-1.5,0,0))
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "KleinBottle.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie", "GeometryBasics", "LinearAlgebra", "StatsBase", "Makie"]) # HIDE
