md"""
## Heatmap: right Colorbar
"""

## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1]; xlabel = "x", ylabel = "y")
    hmap = heatmap!(2rand(20, 20) .- 1; colormap = :Spectral_11)
    Colorbar(fig[1, 2], hmap; label = "values", width = 15, ticksize = 15, tickalign = 1)
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    colgap!(fig.layout, 7)
    display(fig)
    save(joinpath(@OUTPUT, "heatmap1.svg"), fig) # HIDE
end;
# \fig{heatmap1.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE