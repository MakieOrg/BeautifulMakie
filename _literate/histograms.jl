md"""
## Histograms, bins & counts
"""

## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    fig = Figure(resolution = (1200, 800), font = "sans", fontsize = 20)
    ax1 = Axis(fig[1, 1]; xlabel = "value", ylabel = "samples")
    ax2 = Axis(fig[1, 2]; xlabel = "value", ylabel = "counts")
    ax3 = Axis(fig[2, 1]; xlabel = "value", ylabel = "counts")
    ax4 = Axis(fig[2, 2]; xlabel = "value", ylabel = "counts")
    #scatter plot
    scatter!(ax1, data, 1:n; markersize = 4, color = :black)
    hist!(ax2, data; label = "default")
    hist!(ax3, data; bins = 20, color = :orange, strokewidth = 1,
        strokecolor = :black, label = "20 bins")
    hist!(ax4, data; bins = [-4, -2, -1, 0, 1, 2, 4], color = :gray90,
        strokewidth = 1, strokecolor = :black, label = "manual bins")
    axislegend(ax2; position = :rt)
    axislegend(ax3; position = :rt)
    axislegend(ax4; position = :rt)
    display(fig)
    save(joinpath(@OUTPUT, "histograms.svg"), fig) # HIDE
end;
# \fig{histograms.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE