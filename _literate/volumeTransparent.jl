# by Lazaro Alonso
using GLMakie, ColorSchemes
using GeometryBasics: Rect3f
GLMakie.activate!() # HIDE
let
    x = y = z = -1:0.2:1
    vol1 = [ix * iy * iz for ix in x, iy in y, iz in z]
    points3d = [Point3f(ix, iy, iz) for ix in x, iy in y, iz in z]
    # scale everything to the interval 0,1 (things don't seem to work with colorrange)
    vol2 = (vol1 .+ 1) ./ 2
    # colormap with transparency in the middle
    cmap = :Hiroshige
    colors = to_colormap(cmap, 101)
    n = length(colors)
    g(x) = x^2
    alphas = [g(x) for x in range(-1, 1, length = n)]
    cmap_alpha = RGBAf.(colors, alphas)
    # the plot
    fig = Figure(resolution = (1200, 1200))
    ax1 = Axis3(fig[1, 1], perspectiveness = 0.5, azimuth = 7.19,
        elevation = 0.57, aspect = (1, 1, 1))
    ax2 = Axis3(fig[1, 2], perspectiveness = 0.5, azimuth = 6.62,
        elevation = 0.57, aspect = (1, 1, 1))
    ax3 = Axis3(fig[2, 1], perspectiveness = 0.5, azimuth = 7.38,
        elevation = 0.57, aspect = (1, 1, 1))
    ax4 = Axis3(fig[2, 2], perspectiveness = 0.5, azimuth = 6.64,
        elevation = 0.57, aspect = (1, 1, 1))

    volume!(ax1, x, y, z, vol2; colormap = cmap, transparency = true)
    contour!(ax2, x, y, z, vol1; colormap = cmap, alpha = 0.05,
        levels = [collect(-1:0.01:-0.3)..., collect(0.3:0.01:1)...])
    meshscatter!(ax3, vec(points3d); color = vec(vol1), colormap = cmap_alpha)
    meshscatter!(ax4, vec(points3d); color = vec(vol1), colormap = cmap_alpha,
        marker = Rect3f(Vec3f(-1), Vec3f(2)))
    limits!(ax4, -1.2, 1.2, -1.2, 1.2, -1.2, 1.2)
    save(joinpath(@__DIR__, "output", "volumeTransparent.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
