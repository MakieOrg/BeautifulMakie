# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    a = fill(1, n)
    fig = Figure(resolution = (700, 450), font = "sans")
    ax1 = Axis(fig, xlabel = "variable", ylabel = "values",
                xticks = ([1],["normal Distribution"]) )
    violin!(ax1, a, data; width = 0.35,  color = (:yellow, 0.45),
                show_median= true, mediancolor = :navy, strokecolor = :black,
                strokewidth = 1, label = "vertical")
    limits!(ax1, 0,2,-5,5)
    axislegend(ax1, position = :rt)
    fig[1,1] = ax1
    fig
    save(joinpath(@__DIR__, "output", "ViolinPlot.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
