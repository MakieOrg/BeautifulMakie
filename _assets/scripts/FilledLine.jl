# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = 0:0.05:1
    y = x.^2
    fig = Figure(resolution = (700, 450))
    ax = Axis(fig, xlabel = "x", ylabel = "y")
    linea = lines!(x, y, color = :dodgerblue)
    fillB = band!(x, fill(0,length(x)), y; color = (:dodgerblue, 0.1))
    leg = Legend(fig, [[linea, fillB]], ["Label"], halign = :left, valign = :top,
                tellheight = false, tellwidth = false, margin = (10, 10, 10, 10))
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    #save("FilledLine.png"), fig, px_per_unit = 2.0)
    save(joinpath(@__DIR__, "output", "FilledLine.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
