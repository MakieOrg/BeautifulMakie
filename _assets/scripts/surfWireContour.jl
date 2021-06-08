# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    x = y =  LinRange(-2, 2, 51)
    z = (-x .* exp.(-x .^ 2 .- (y') .^ 2)) .* 4
    zmin, zmax = minimum(z), maximum(z)
    cmap = :plasma
    fig = Figure(resolution = (900,900))
    ax = Axis3(fig, aspect = :data, perspectiveness = 0.5, elevation = π/9,
        xzpanelcolor=:black)
    surface!(ax, x, y, z, colormap = cmap, colorrange = (zmin, zmax))
    xm, ym, zm = minimum(ax.finallimits[])
    contour!(ax, x, y, z, levels = 20, colormap = cmap, linewidth = 2,
        colorrange=(zmin, zmax), transformation = (:xy, zm))
    contour!(ax, x, y, z, levels = 20, colormap = cmap, linewidth = 1.5,
        colorrange=(zmin, zmax), transformation = (:zy, -xm))
    contour!(ax, x, y, z, levels = 20, colormap = cmap, linewidth = 1,
        colorrange=(zmin, zmax), transformation = (:xz, -ym))
    wireframe!(ax, x, y, z, overdraw = true, transparency = true,
        color = (:black, 0.1))
    fig[1,1] = ax
    save(joinpath(@__DIR__, "output", "surfWireContour.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
