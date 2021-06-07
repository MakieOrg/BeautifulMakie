# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    x = y = -5:1:5
    z = [x^2 + y^2 for x in x, y in y]
    fig = Figure(resolution = (450, 400))
    ax = Axis(fig,  aspect = 1, xlabel = "x", ylabel = "y")
    hmap = heatmap!(x,y,z, colormap = :ice)
    cbar = Colorbar(fig, hmap, label = "z values", width = 15, ticksize=15,
                tickalign = 1, height = Relative(0.945))
    ax.xticks = -5:5
    ax.yticks = -5:5
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7)
    fig
    save(joinpath(@__DIR__, "output", "heatmapxyz.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
