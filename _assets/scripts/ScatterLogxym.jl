# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = y = 1:100
    z = exp10.(2*rand(100))
    cmap = cgrad(:plasma)
    cmapt = [(cmap[i],0.75) for i in 1:length(cmap)]
    fig = Figure(resolution = (700,450), font=:sans)
    ax = Axis(fig, xscale = log10, yscale = log10, xlabel = "x", ylabel = "y",
        xgridstyle=:dash, ygridstyle=:dash, xminorticksvisible = true,
        xminorticks = IntervalsBetween(9), yminorticksvisible = true,
        yminorticks = IntervalsBetween(9))
    hm = scatter!(ax, x, y, color = z,markersize = z/2.5 .+ 6, colormap = cmapt)
    cbar = Colorbar(fig, hm)
    limits!(ax,5e-1,1.5e2, 5e-1,1.5e2)
    fig[1,1] = ax
    fig[1,2] = cbar
    save(joinpath(@__DIR__, "output", "ScatterLogxym.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie","Random"]) # HIDE
