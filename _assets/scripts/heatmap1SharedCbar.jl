# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    n = 15
    x, y, color = rand(n), rand(n), rand(n)
    cmaps = [:cool, :viridis, :inferno, :thermal]

    function FigGridHeatSharedCbarH()
        fig = Figure(resolution = (600, 400))
        axes = []
        c = 1
        for i in 1:1, j in 1:2
            ax = Axis(fig[i, j],aspect=1,xgridvisible = false,ygridvisible = false)
            pnts = heatmap!(rand(10,10), colormap= :thermal, colorrange=(0, 1))
            ax.xticks = [1,10]
            ax.yticks = [1,10]
            cbar = Colorbar(fig, pnts, vertical = false, flipaxis = false,
            width = Relative(3/4), height = 15, tickwidth = 2, ticklabelsize = 14)
            cbar.ticks = [0,0.5,1]
            fig[2, 1:2] = cbar
            c+=1
            push!(axes, ax)
        end
        hideydecorations!(axes[2], ticks = false)
        fig
    end
    fig = FigGridHeatSharedCbarH()
    fig
    save(joinpath(@__DIR__, "output", "heatmap1SharedCbar.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
