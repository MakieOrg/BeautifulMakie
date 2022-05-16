md"""
## Line, y-log10
"""

## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0.01, 30π, 2000)
    y = cos.(x)
    lines(y, x; color=:orangered, figure=(resolution=(600, 400),),
        axis=(yscale=log10, xlabel="x", ylabel="y", xgridstyle=:dash,
            ygridstyle=:dash, yminorticksvisible=true,
            yminorticks=IntervalsBetween(9))) # possible issue with log-ticks
    xlims!(-1, 1)
    ## display(current_figure())
    save(joinpath(@OUTPUT, "LineLogy.svg"), current_figure()) # HIDE
end;
# \fig{LineLogy.svg}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
