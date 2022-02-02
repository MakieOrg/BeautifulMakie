# by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = 0.001:0.05:10
    y = x.^2 .+ abs.(2*randn(length(x)))
    lines(x, y, color = :navy, figure = (resolution = (600,400),),
        axis = (xscale = log10, yscale = log10, xlabel = "x", ylabel = "y",
        xgridstyle=:dash, ygridstyle=:dash, xminorticksvisible = true,
        xminorticks = IntervalsBetween(9), yminorticksvisible = true,
        yminorticks = IntervalsBetween(9)))
    ## display(current_figure())
    save(joinpath(@__DIR__, "output", "LineLogxy.svg"), current_figure()) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
