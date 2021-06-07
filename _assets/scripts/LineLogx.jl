# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0.01,30π,3000)
    y = sin.(x)
    lines(x, y, color = :black, figure = (resolution = (700,450),),
        axis = (xscale = log10, xlabel = "x", ylabel = "y", xgridstyle=:dash,
            ygridstyle=:dash, xminorticksvisible = true,
            xminorticks = IntervalsBetween(9)))
    ylims!(-1,1)
    save(joinpath(@__DIR__, "output", "LineLogx.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
