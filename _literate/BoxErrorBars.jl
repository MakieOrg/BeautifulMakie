md"""
## Barplot and y error bars
"""
## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(145)
    x, y, yerr = 1:2:20, 5 * rand(10), 0.4 * abs.(randn(10))
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1], xlabel = "variable", ylabel = "values")
    barplot!(ax, x, y; strokewidth = 1, color = :transparent, strokecolor = :black)
    errorbars!(ax, x, y, yerr; whiskerwidth = 12)
    ## display(fig)
    save(joinpath(@OUTPUT, "BoxErrorBars.svg"), fig) # HIDE
end;
# \fig{BoxErrorBars.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE