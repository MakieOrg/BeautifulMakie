# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = -2π:0.1:2π
    lines(x, sin.(x), color = "#56B4E9", linewidth = 2, label = "sin",
        axis = (xlabel = "x", ylabel = "f(x)", xgridcolor = :red,
        xgridstyle=:dash, xgridwidth=0.85, xtickalign=1, xticksize=20),
        figure = (resolution = (700, 450), fontsize = 18, font = "sans"))

    lines!(x, cos.(x), color = :black, linestyle = :dash, label = "cos")
    limits!(-2π, 2π, -1,1)
    axislegend("legend", position = :lb)
    current_figure()
    #save("Fig2Lines.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "Fig2LinesEasy.png"), current_figure(), px_per_unit = 2) # HIDE
end

using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
