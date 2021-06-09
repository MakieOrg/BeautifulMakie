# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,50) # with 50 points in the interval.
    fig = Figure(resolution = (700, 450), font =:sans)
    ax = Axis(fig, xlabel = "x", ylabel = "")
    line1 = lines!(x, sin.(x), color = :red)
    line2 = lines!(x, cos.(x), color = :blue)
    points1 = scatter!(x, cos.(x), color = :black, markersize = 5)
    points2 = scatter!(x, -cos.(x), color = :red, strokecolor = :red,
        markersize = 5, marker = '■')
    leg = Legend(fig, [line1, [line2, points1], points2],
        [" sin(x)", " cos(x)",  "-cos(x)"], "f(x)", tellheight = false,
        tellwidth = false, halign = :left, valign = :top, markersize = 8,
        margin = (10, 10, 10, 10))
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    #save("FigLineScatter.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "FigLinesAndScatters.png"), fig, px_per_unit = 2) # HIDE
end

using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
