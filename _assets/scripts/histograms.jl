# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    fig = Figure(resolution = (1200, 800), font = "sans", fontsize = 20)
    ax1 = Axis(fig, xlabel = "value", ylabel = "samples" )
    ax2 = Axis(fig, xlabel = "value", ylabel = "counts" )
    ax3 = Axis(fig, xlabel = "value", ylabel = "counts")
    ax4 = Axis(fig, xlabel = "value", ylabel = "counts" )
    #scatter plot
    scatter!(ax1, data, 1:n, markersize = 4, color = :black)
    hist!(ax2, data, label = "default")
    hist!(ax3, data, bins = 20, color = :orange, strokewidth = 1,
    strokecolor = :black, label = "20 bins")
    hist!(ax4, data, bins = [-4, -2, -1, 0, 1, 2, 4], color = :gray90,
    strokewidth = 1, strokecolor = :black, label = "manual bins")
    axislegend(ax2, position = :rt)
    axislegend(ax3, position = :rt)
    axislegend(ax4, position = :rt)
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[2,1] = ax3
    fig[2,2] = ax4
    fig
    save(joinpath(@__DIR__, "output", "histograms.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
