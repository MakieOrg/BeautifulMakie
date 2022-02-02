# by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    x = y = sqrt.(1:10:101)
    z = abs.(randn(10, 10))
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1]; aspect = 1, xlabel = "x", ylabel = "y")
    hmap = heatmap!(x, y, z; colormap = :magma)
    Colorbar(fig[1, 2], hmap; label="z values", width=15, ticksize=15, tickalign=1)
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    colgap!(fig.layout, 7)
    ## display(fig)
    save(joinpath(@__DIR__, "output", "heatmapIrregular.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
