# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(124)
    n = 30
    x, y, z = randn(n), randn(n), randn(n)
    fig = Figure(resolution = (800, 450))
    ax = Axis(fig,xgridstyle=:dash,ygridstyle=:dash, xtickalign=1, ytickalign=1)
    pts1= scatter!(ax, x, y, color = z, colormap=:plasma, markersize = 15z,
                marker = :rect)
    pts2= scatter!(ax, 3x, 5y, color = z, colormap= (:thermal, 0.5),
                markersize = 45z, marker = :circle)

    leg1 = Colorbar(fig, pts1, label = "z1 value", ticklabelsize = 14,
                labelpadding = 5, width = 10)
    leg2= Colorbar(fig, pts2, label = "z2 value", ticklabelsize = 14,
                labelpadding = 5, width = 10)
    fig[1, 1] = ax
    fig[1, 2] = leg1
    fig[1, 3] = leg2
    fig
    #save("FilledLine.png"), fig, px_per_unit = 2.0) # HIDE
    save(joinpath(@__DIR__, "output", "BubblePlot.png"), fig, px_per_unit = 2.0) # HIDE
end


using Pkg # HIDE
Pkg.status(["CairoMakie","Random"]) # HIDE
