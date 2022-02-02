md"""
## Scatters and colormaps
"""

## by Lazaro Alonso
using CairoMakie, Random, ColorSchemes
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    n = 50
    x, y, color = rand(n), rand(n), rand(n)
    cmaps = [:cool, :viridis, :plasma, :inferno, :thermal, :leonardo, :winter, :spring, :ice]
    markers = [:+, :diamond, :star4, :rtriangle, :rect, :circle, :pentagon, :cross, :star5]

    function FigGridScatters()
        fig = Figure(resolution = (1200, 800))
        c = 1
        for i in 1:2, j in 1:2:5
            ax = Axis(fig[i, j], aspect = AxisAspect(1))
            pnts = scatter!(x, y .^ c; color = color, colormap = cmaps[c],
                markersize = 15, marker = markers[c], strokewidth = 0)
            cbar = Colorbar(fig, pnts, height = Relative(0.75), tickwidth = 2,
                tickalign = 1, width = 14, ticksize = 14)
            fig[i, j+1] = cbar
            limits!(ax, -0.1, 1.1, -0.1, 1.1)
            ax.xticks = [0, 1]
            ax.yticks = [0, 1]
            ax.xticklabelsize = 20
            ax.yticklabelsize = 20
            c += 1
        end
        fig
    end
    fig = FigGridScatters()
    ## display(fig)
    save(joinpath(@OUTPUT, "ScattersCmaps.svg"), fig) # HIDE
end;
# \fig{ScattersCmaps.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
