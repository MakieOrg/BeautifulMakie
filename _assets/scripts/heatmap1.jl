# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    fig = Figure(resolution = (450, 400))
    ax = Axis(fig,  aspect = 1, xlabel = "x", ylabel = "y")
    hmap = heatmap!(rand(20,20), colormap = :plasma)
    cbar = Colorbar(fig, hmap, label = "values", width = 15,
                ticksize=15, tickalign = 1, height = Relative(3.55/4))
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7)
    fig
    save(joinpath(@__DIR__, "output", "heatmap1.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
