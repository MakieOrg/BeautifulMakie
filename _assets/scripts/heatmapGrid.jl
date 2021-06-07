# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    n = 15
    x, y, color = rand(n), rand(n), rand(n)
    cmaps=[:cool,:viridis,:plasma,:inferno,:thermal,:leonardo,:winter,:spring,:ice]

    function FigGridHeat()
        fig = Figure(resolution = (1200, 800))
        axes = []
        c = 1
        for i in 1:2, j in 1:2:5
            ax=Axis(fig[i, j],aspect = 1,xgridvisible = false,ygridvisible = false)
            hmap = heatmap!(rand(10,10), colormap=cmaps[c], colorrange=(0, 1))
            ax.xticks = [1,10]
            ax.yticks = [1,10]
            ax.xticklabelsize = 20
            ax.yticklabelsize = 20
            cbar = Colorbar(fig,hmap,height = Relative(0.5),tickwidth = 2,
                                ticklabelsize = 18)
            cbar.ticks = [0,0.5,1]
            fig[i, j+1] = cbar
            c+=1
            push!(axes, ax) # just in case you need them later.
            fig
        end
        fig
    end
    fig = FigGridHeat()
    fig
    save(joinpath(@__DIR__, "output", "heatmapGrid.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
