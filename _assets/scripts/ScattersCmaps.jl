# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    n = 50
    x, y, color = rand(n), rand(n), rand(n)
    cmaps =[:cool,:viridis,:plasma,:inferno,:thermal,:leonardo,:winter,:spring,:ice]
    markers = [:+,:diamond,:star4,:rtriangle,:rect,:circle,:pentagon,:cross,:star5]

    function FigGridScatters()
        fig = Figure(resolution = (1200, 800))
        c = 1
        for i in 1:2, j in 1:2:5
            ax = Axis(fig[i, j],aspect = 1,xgridstyle=:dash,ygridstyle=:dash,
                                xtickalign=1, ytickalign=1)
            pnts = scatter!(x, y.^c, color = color, colormap=cmaps[c],
                markersize = 15, marker = markers[c], strokewidth=0)
            limits!(ax, -0.1,1.1,-0.1,1.1)
            ax.xticks = [0,1]
            ax.yticks = [0,1]
            ax.xticklabelsize = 20
            ax.yticklabelsize = 20
            cbar = Colorbar(fig, pnts,height = Relative(0.75), tickwidth = 2,
                            tickalign=1, width = 14, ticksize=14)
            fig[i, j+1] = cbar
            c+=1
        end
        fig
    end
    fig = FigGridScatters()
    #save("FigLineScatter.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "ScattersCmaps.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie","Random"]) # HIDE
