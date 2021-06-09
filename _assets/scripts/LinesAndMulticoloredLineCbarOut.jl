# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, ColorSchemes
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,100) # with 100 points in the interval.
    fig = Figure(resolution = (700, 450), font =:sans)
    ax = Axis(fig, xlabel = "x", ylabel = "")
    line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 2)
    line2 = lines!(x, cos.(x), color = :black,  linewidth = 1)
    line3 = lines!(x, -cos.(x), color = :dodgerblue)
    leg = Legend(fig, [line2, line3], ["  sin(x)", "- cos(x)"], tellwidth = false,
    halign = :left, valign = :top, margin = (10, 10, 10, 10))
    cbar = Colorbar(fig, line1, label = "cos(x)", ticklabelsize = 14,
        labelpadding = 5, width = 10)
    #limits!(ax, 0,2π,-1.01,1.01)
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig[1, 2] = cbar
    colgap!(fig.layout, 5)
    fig
    #save("MulticoloredLinesCbarOut.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "LinesAndMulticoloredLineCbarOut.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
