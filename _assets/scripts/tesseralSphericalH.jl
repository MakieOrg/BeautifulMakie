# by lazarusA # HIDE
# using GLMakie # HIDE
using Legendre, GLMakie
using GeometryBasics, LinearAlgebra, StatsBase
using Makie: get_dim, surface_normals
GLMakie.activate!() # HIDE
let
    function Y(θ, ϕ, l, m)
        if m < 0
            return (-1)^m * √2 * Nlm(l, abs(m)) * Plm(l, abs(m), cos(θ)) * sin(abs(m)*ϕ)
        elseif m == 0
            return sqrt((2*l+1)/4π)*Plm(l, m, cos(θ))
        else
            return (-1)^m * √2 * Nlm(l, m) * Plm(l, m, cos(θ)) * cos(m*ϕ)
        end
    end
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
    # Grids of polar and azimuthal angles
    θ = LinRange(0, π, 200)
    ϕ = LinRange(0, 2π, 200)
    x = [sin(θ)*sin(ϕ) for θ in θ, ϕ in ϕ]
    y = [sin(θ)*cos(ϕ) for θ in θ, ϕ in ϕ]
    z = [cos(θ)        for θ in θ, ϕ in ϕ]
    l = 4
    m = 1
    ambient =  Vec3f0(0.75, 0.75, 0.75)
    cmap = (:dodgerblue, :white)
    fig = Figure(resolution = (1200, 800), backgroundcolor = :black)

    Ygrid = [Y(θ, ϕ, l, m) for θ in θ, ϕ in ϕ]
    Ylm = abs.(Ygrid)
    Ygrid2 = vec(Ygrid)

    ax1 = Axis3(fig, aspect = :data)
    ax2 = Axis3(fig, aspect = :data)
    pltobj1 = mesh!(ax1, getMesh(x, y, z), color = Ygrid2, colormap = cmap,
        ambient = ambient)
    pltobj2 = mesh!(ax2, getMesh(Ylm .* x, Ylm .* y, Ylm .* z), color = Ygrid2,
        colormap = cmap,  ambient = ambient)
    hidespines!(ax1)
    hidedecorations!(ax1)
    hidespines!(ax2)
    hidedecorations!(ax2)
    cbar = Colorbar(fig, pltobj1, label = "Yₗₘ(θ,ϕ)", tickwidth = 2,
        labelcolor = :white, ticklabelcolor = :white, tickcolor = :grey,
        width = 25,ticklabelsize = 30,labelsize = 30,ticksize=25,tickalign = 1)
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[1,3] = cbar
    fig[0,1:2] = Label(fig, "Tesseral Spherical Harmonics l = $(l), m = $(m)",
        textsize = 30, color = (:white, 0.85))
    fig
    colgap!(fig.layout, 2)
    fig
    save(joinpath(@__DIR__, "output", "tesseralSphericalH.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie", "Legendre","GeometryBasics", "LinearAlgebra", "StatsBase", "Makie"]) # HIDE
