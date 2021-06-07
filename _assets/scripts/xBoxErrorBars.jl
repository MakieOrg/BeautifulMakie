# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(145)
    x, y = 1:2:20, 5*rand(10)
    yerr, xerr = 0.4*abs.(randn(10)), abs.(randn(10))
    fig = Figure(resolution = (700, 450), font = "sans")
    ax = Axis(fig, xlabel = "variables", ylabel = "values")
    barplot!(ax, x, y, width = 1.8xerr, strokewidth = 1, color = :transparent,
                strokecolor = :black)
    errorbars!(ax, x, y, yerr, whiskerwidth = 12)
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "xBoxErrorBars.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
