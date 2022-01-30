# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0.01, 30π, 2000)
    y = cos.(x)
    lines(y, x; color = :orangered, figure = (resolution = (600, 400),),
        axis = (yscale = log10, xlabel = "x", ylabel = "y", xgridstyle = :dash,
            ygridstyle = :dash, yminorticksvisible = true,
            yminorticks = IntervalsBetween(9))) # possible issue with log-ticks
    xlims!(-1, 1)
    display(current_figure())
    save(joinpath(@__DIR__, "output", "LineLogy.svg"), current_figure()) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
