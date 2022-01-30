md"""
## Line, x-log10
"""

## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0.01, 30π, 2000)
    y = sin.(x)
    lines(x, y; color = :black, figure = (resolution = (600, 400),),
        axis = (xscale = log10, xlabel = "x", ylabel = "y", xgridstyle = :dash,
            ygridstyle = :dash, xminorticksvisible = true,
            xminorticks = IntervalsBetween(9))) # possible issue with log-ticks
    ylims!(-1, 1)
    display(current_figure())
    save(joinpath(@OUTPUT, "LineLogx.svg"), current_figure()) # HIDE
end;
# \fig{LineLogx.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
