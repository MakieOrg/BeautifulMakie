# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,50)
    fig = Figure(resolution = (700, 450), font =:sans)
    ax = Axis(fig, xlabel = "x", ylabel = "")
    line1 = lines!(x, sin.(x), color = :black)
    pnts1 = scatter!(x, sin.(x), color = :black, markersize = 10)
    leg = Legend(fig, [[line1, pnts1]], ["sin(x)"], markersize = 8,
    tellheight = false, tellwidth = false, halign = :right, valign = :top,
    bgcolor = :transparent, margin = (10, 10, 10, 10), framevisible = true)
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    #save("FigLineScatter.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "FigLineScatter.png"), fig, px_per_unit = 2) # HIDE
end

using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
