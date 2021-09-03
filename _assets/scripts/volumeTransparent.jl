# by Lazaro Alonso
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    x = -1:0.2:1
    y = -1:0.2:1
    z = -1:0.2:1
    vol1 = [ix*iy*iz for ix in x, iy in y, iz in z]
    points3d = [Point3f0(ix, iy, iz) for ix in x, iy in y, iz in z]
    vol2 = (vol1 .+ 1)./2 # send everything to the interval 0,1 (things don't seem to work with colorrange)
    # colormap with transparency in the middle 
    cmap = :viridis
    colors = to_colormap(cmap, 101)
    n = length(colors)
    g(x) = x^2
    alphas = [g(x) for x in LinRange(-1,1,101)]
    cmap_alpha = RGBAf0.(colors, alphas)
    # the plot
    fig = Figure(resolution = (1200,1200))
    ax1 = Axis3(fig[1,1], perspectiveness = 0.5, azimuth = 7.19, 
        elevation = 0.57, aspect = (1,1,1))
    ax2 = Axis3(fig[1,2], perspectiveness = 0.5, azimuth = 6.62, 
        elevation = 0.57, aspect = (1,1,1))
    ax3 = Axis3(fig[2,1], perspectiveness = 0.5, azimuth = 7.38, 
        elevation = 0.57, aspect = (1,1,1))
    ax4 = Axis3(fig[2,2], perspectiveness = 0.5, azimuth = 6.64, 
        elevation = 0.57, aspect = (1,1,1))

    volume!(ax1, x, y, z, vol2; colormap = cmap, transparency = true)
    contour!(ax2, x, y, z, vol1; colormap = cmap, alpha=0.05,
        levels=[collect(-1:0.01:-0.3)..., collect(0.3:0.01:1)...])
    meshscatter!(ax3, vec(points3d); color = vec(vol1), colormap = cmap_alpha)
    meshscatter!(ax4, vec(points3d); color = vec(vol1), colormap = cmap_alpha,
        marker =  FRect3D(Vec3f0(0), Vec3f0(2)))
    xlims!(ax4, -1.2,1.2)
    ylims!(ax4, -1.2,1.2)
    zlims!(ax4, -1.2,1.2)
    fig
    save(joinpath(@__DIR__, "output", "volumeTransparent.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
