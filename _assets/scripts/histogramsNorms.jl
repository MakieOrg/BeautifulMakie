# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    fig = Figure(resolution = (1200, 800), font = "sans", fontsize = 20)
    ax1 = Axis(fig, xlabel = "value" )
    ax2 = Axis(fig, xlabel = "value" )
    ax3 = Axis(fig, xlabel = "value")
    ax4 = Axis(fig, xlabel = "value" )
    hist!(ax1, data,normalization = :none, color = :black, label = "none")
    hist!(ax2, data,normalization = :pdf, color = :orange, label = "pdf")
    hist!(ax3, data,normalization = :density,color = :dodgerblue,label = "density")
    hist!(ax4, data,normalization = :probability, label = "probability")
    axislegend(ax1, position = :rt)
    axislegend(ax2, position = :rt)
    axislegend(ax3, position = :rt)
    axislegend(ax4, position = :rt)
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[2,1] = ax3
    fig[2,2] = ax4
    fig
    save(joinpath(@__DIR__, "output", "histogramsNorms.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
