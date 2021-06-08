# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    f(x,y) = (x + 2y^2) * abs(sin(y) + cos(x))
    x = y = 1:0.2:20
    z = [f(x,y) for x in x, y in y]
    fig = Figure(resolution=(900,400), fontsize = 16)
    ax1 = Axis(fig, aspect = 1, xlabel = "x", ylabel = "y", tickalign = 1)
    ax2 = Axis(fig, aspect = 1,  xlabel = "x", tickalign = 1)
    ax3 = Axis(fig, aspect = 1,  xlabel = "x", tickalign = 1)
    p1 = heatmap!(ax1, x, y, z, colormap = :plasma)
    contour!(ax2, x, y, z, color = :black, levels = 100:1:101)
    heatmap!(ax3, x, y, z, colormap = (:plasma, 0.5))
    contour!(ax3, x, y, z, color = :white, levels = 100:1:101)
    cbar = Colorbar(fig, p1, width = 10, ticksize=10, ticklabelsize = 10,
        tickalign = 1, height = Relative(0.7))
    limits!(ax1, 1,20,1,20)
    limits!(ax2, 1,20,1,20)
    limits!(ax3, 1,20,1,20)
    hideydecorations!(ax2, grid = false, ticks = false)
    hideydecorations!(ax3, grid = false, ticks = false)
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[1,3] = ax3
    fig[1,4] = cbar

    fig
    save(joinpath(@__DIR__, "output", "ContourOverHeatmap.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
