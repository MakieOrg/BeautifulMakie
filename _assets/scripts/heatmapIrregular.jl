# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    x = y = sqrt.(1:10:101)
    z = abs.(randn(10,10))
    fig = Figure(resolution = (450, 400))
    ax = Axis(fig, aspect = 1, xlabel = "x", ylabel = "y")
    hmap = heatmap!(x,y,z, colormap = :magma)
    cbar = Colorbar(fig, hmap, label = "z values", width = 15, ticksize=15,
                tickalign = 1, height = Relative(0.96))
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7) # HIDE
    fig
    save(joinpath(@__DIR__, "output", "heatmapIrregular.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
