# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = 10 .^(range(-1,stop=1,length=100))
    y = x.^2 .+ abs.(2*randn(length(x)))
    cmap = cgrad(:gist_stern, scale = :log)
    cmapt = [(cmap[i],0.65) for i in 1:length(cmap)]
    fig,ax,pltpbj = scatter(x, y,color = x, markersize = (x.^2/3)[end:-1:1] .+6,
        colormap = cmapt, figure = (resolution = (700,450),font=:sans),
        axis = (xscale = log10, yscale = log10, xlabel = "x", ylabel = "y",
        xgridstyle=:dash, ygridstyle=:dash, xminorticksvisible = true,
        xminorticks = IntervalsBetween(9), yminorticksvisible = true,
        yminorticks = IntervalsBetween(9)))
    cbar = Colorbar(fig, pltpbj)
    ylims!(ax,1e-1,1e2)
    fig[1,2] = cbar
    save(joinpath(@__DIR__, "output", "ScatterLogxyCbar.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie","Random"]) # HIDE
