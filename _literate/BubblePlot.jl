md"""
## Bubble Plot
"""

## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(124)
    n = 30
    x, y, z = randn(n), randn(n), randn(n)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1]; xgridstyle = :dashdot, ygridstyle = :dashdot,
        xtickalign = 1, ytickalign = 1)
    pts1 = scatter!(ax, 10x, y; color = z, colormap = (:viridis, 0.75),
        markersize = 20z, marker = :rect)
    pts2 = scatter!(ax, 3x, 5y; color = z, colormap = (:thermal, 0.85),
        markersize = 45z, marker = :circle)

    Colorbar(fig[1, 2], pts1, label = "z1 value", ticklabelsize = 14,
        labelpadding = 5, width = 10)
    Colorbar(fig[1, 3], pts2, label = "z2 value", ticklabelsize = 14,
        labelpadding = 5, width = 10)
    ## display(fig)
    save(joinpath(@OUTPUT, "BubblePlot.svg"), fig) # HIDE
end;
# \fig{BubblePlot.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status(["CairoMakie"]) # HIDE
