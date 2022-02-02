# by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    x = y = -5:1:5
    z = [x^2 + y^2 for x in x, y in y]
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1]; aspect = 1, xlabel = "x", ylabel = "y",
        xticks = x, yticks = y)
    hmap = heatmap!(x, y, z, colormap = :Egypt)
    Colorbar(fig[1, 2], hmap, label = "z values", width = 15, ticksize = 15,
        tickalign = 0.5)
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    ## display(fig)
    save(joinpath(@__DIR__, "output", "heatmapxyz.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
