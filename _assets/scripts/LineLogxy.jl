# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = 0.001:0.05:10
    y = x.^2 .+ abs.(2*randn(length(x)))
    lines(x, y, color = :navy, figure = (resolution = (700,450),),
        axis = (xscale = log10, yscale = log10, xlabel = "x", ylabel = "y",
        xgridstyle=:dash, ygridstyle=:dash, xminorticksvisible = true,
        xminorticks = IntervalsBetween(9), yminorticksvisible = true,
        yminorticks = IntervalsBetween(9)))
    save(joinpath(@__DIR__, "output", "LineLogxy.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
