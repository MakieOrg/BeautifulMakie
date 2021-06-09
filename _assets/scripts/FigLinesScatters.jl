# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,50)
    fig = Figure(resolution = (700, 450), font =:sans)
    ax = Axis(fig, xlabel = "x", ylabel = "")
    line1 = lines!(x, sin.(x), color = :black)
    pnts1 = scatter!(x, sin.(x), color = :black, marker = '◆', markersize = 10)
    line2 = lines!(x, cos.(x), color = :black)
    pnts2 = scatter!(x, cos.(x), color = :red, strokecolor = :red, marker = '■',
                    markersize = 10)
    leg = Legend(fig, [[line1, pnts1], [line2, pnts2]], ["sin(x)", "cos(x)"],
        halign = :center, valign = :center, markersize = 7,tellheight = false,
        tellwidth = false, bgcolor = :white, framecolor=:white)
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    #save("FigLineScatter.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "FigLinesScatters.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
