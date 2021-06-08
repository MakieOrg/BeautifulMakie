# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Colors, ColorSchemes, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(38)
    x = y = 1:100
    z = exp10.(2*rand(100,100))
    fig = Figure(resolution = (450, 400))
    ax = Axis(fig, xscale = log10, yscale = log10, aspect = 1, xlabel = "x",
        ylabel = "y", yminorticksvisible = true, xminorticksvisible = true,
        yminorticks = IntervalsBetween(9),xminorticks = IntervalsBetween(9))
    cmap = cgrad(:CMRmap, scale = :log)
    hmap = heatmap!(x,y,z, colormap = cmap, colorrange = (1,100))
    cbar = Colorbar(fig, hmap, label = "z values", width = 15, ticksize=15,
        minorticks = IntervalsBetween(9), minorticksvisible=true,labelsize=12,
        ticklabelsize = 12,tickalign = 1, minortickalign =1,
        height = Relative(0.91),scale = log10) # log10 colorbar
    ax.xticks = [1,10,100]
    ax.yticks = [1,10,100]
    cbar.ticks = [1,10,100]
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7) # HIDE
    fig
    save(joinpath(@__DIR__, "output", "heatmapLogIrregular.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Colors", "ColorSchemes", "Random"]) # HIDE
