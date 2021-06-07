# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    fig = Figure(resolution = (700, 450), font = "sans", fontsize = 20)
    ax1 = Axis(fig, xlabel = "value" )
    hist!(ax1,data,normalization=:pdf,color = (:red,0.5), label = "hist & pdf")
    density!(ax1, data, color =(:grey, 0.5), label = "density!", strokewidth=1)
    axislegend(ax1, position = :rt)
    fig[1,1] = ax1
    fig
    save(joinpath(@__DIR__, "output", "histDensity.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
