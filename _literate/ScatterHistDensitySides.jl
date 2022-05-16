md"""
## Scatter, Histogram and Density on the Sides
"""
## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    ## see also https://discourse.julialang.org/t/beautiful-makie-gallery/62523/31
    Random.seed!(123)
    n = 200
    x, y, color = randn(n) / 2, randn(n), randn(n)
    fig = Figure(resolution=(600, 400))
    ax1 = Axis(fig[1, 1])
    ax2 = Axis(fig[2, 1])
    ax3 = Axis(fig[2, 2])
    hist!(ax1, x, color=(:orangered, 0.5), strokewidth=0.5)
    scatter!(ax2, x, y, color=color, markersize=10,
        marker=:circle, strokewidth=0)
    density!(ax3, y, direction=:y, color=(:dodgerblue, 0.5),
        strokewidth=0.5)
    xlims!(ax1, -4, 4)
    limits!(ax2, -4, 4, -3, 3)
    ylims!(ax3, -3, 3)
    hideydecorations!(ax3, ticks=false, grid=false)
    hidexdecorations!(ax1, ticks=false, grid=false)
    colsize!(fig.layout, 1, Relative(2 / 3))
    rowsize!(fig.layout, 1, Relative(1 / 3))
    colgap!(fig.layout, 10)
    rowgap!(fig.layout, 10)
    ## display(fig)
    save(joinpath(@OUTPUT, "ScatterHistDensitySides.svg"), fig) # HIDE
end;
# \fig{ScatterHistDensitySides.svg}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
