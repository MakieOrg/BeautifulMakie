md"""
## Log scale in x and y, scatters and colormap
"""

## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = 10 .^ (range(-1, stop=1, length=100))
    y = x .^ 2 .+ abs.(2 * randn(length(x)))
    cmap = cgrad(:viridis, scale=:log)
    cmapt = [(cmap[i], 0.65) for i in 1:length(cmap)]

    fig, ax, pltpbj = scatter(x, y; markersize=(x .^ 2/3)[end:-1:1] .+ 6,
        color=x, colormap=cmapt,
        figure=(resolution=(600, 400), font="CMU Serif"),
        axis=(xscale=log10, yscale=log10, xlabel="x", ylabel="y",
            xgridstyle=:dash, ygridstyle=:dash,
            xminorticksvisible=true, yminorticksvisible=true,
            xminorticks=IntervalsBetween(9), yminorticks=IntervalsBetween(9)))
    Colorbar(fig[1, 2], pltpbj)
    ylims!(ax, 1e-1, 1e2)
    ## display(fig)
    save(joinpath(@OUTPUT, "ScatterLogxyCbar.svg"), current_figure()) # HIDE
end;
# \fig{ScatterLogxyCbar.svg}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
