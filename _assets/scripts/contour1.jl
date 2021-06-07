# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    x = -1:0.02:1
    y = -1.5:0.02:2
    egg(x,y) = x^2 + y^2/(1.4 + y/5)^2
    segg = [egg(x,y) for x in x, y in y]
    fig = Figure(resolution = (470, 550))
    ax = Axis(fig, xlabel = "x", ylabel = "y", backgroundcolor = :black,
    xgridstyle=:dash, ygridstyle=:dash, xgridcolor = :grey, ygridcolor = :grey)
    cl =contour!(x, y, segg, linewidth = 0.85,colormap = :viridis,
                levels = 0:0.02:1)
    cbar = Colorbar(fig, cl, label ="egg-l", labelpadding = 0, width = 15,
                ticksize=15, tickalign = 1, height = Relative(1))
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7)
    fig
    save(joinpath(@__DIR__, "output", "contour1.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
