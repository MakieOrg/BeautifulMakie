# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0.01,30π,3000)
    y = cos.(x)
    lines(y, x, color = :orangered, figure = (resolution = (700,450),),
        axis = (yscale = log10, xlabel = "x", ylabel = "y",xgridstyle=:dash,
            ygridstyle=:dash, yminorticksvisible = true,
            yminorticks = IntervalsBetween(9)))
    xlims!(-1,1)
    save(joinpath(@__DIR__, "output", "LineLogy.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
