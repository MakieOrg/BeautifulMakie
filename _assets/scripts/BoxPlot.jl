# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    a = fill(1, n)
    fig = Figure(resolution = (700, 800), font = "sans")
    ax1 = Axis(fig, xlabel = "variable", ylabel = "values",
                xticks = ([1],["normal Distribution"]) )
    ax2 = Axis(fig, xlabel = "values", ylabel = "variable",
        yticks = ([1],["normal Distribution"]), yticklabelrotation = pi/2)
    boxplot!(ax1, a, data; whiskerwidth = 1, width = 0.35,color = (:red, 0.45),
                whiskercolor = (:red, 1), mediancolor = :red, markersize = 8,
                strokecolor = :black, strokewidth = 1, label = "vertical")
    limits!(ax1, 0,2,-5,5)
    boxplot!(ax2,a,data;orientation=:horizontal, whiskerwidth = 1, width = 0.35,
            color = (:navy, 0.45),whiskercolor = (:navy, 1),mediancolor = :navy,
                markersize = 8, strokecolor = :black, strokewidth = 1,
                label = "horizontal")
    limits!(ax2, -5,5,0,2)
    axislegend(ax1, position = :rt)
    axislegend(ax2, position = :rt)
    fig[1,1] = ax1
    fig[2,1] = ax2
    fig
    save(joinpath(@__DIR__, "output", "BoxPlot.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
