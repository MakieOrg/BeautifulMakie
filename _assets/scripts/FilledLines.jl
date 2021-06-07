# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(-10,10,200)
    fg(x,μ,σ) = exp.(.-(x.-μ).^2 ./(2σ^2))./(σ*√(2π))
    fig = Figure(resolution = (700, 450))
    ax = Axis(fig, xlabel = "x", ylabel = "y")
    # filled curve 1
    linea1 = lines!(x, fg(x, 0.25, 1.5), color = "#E69F00")
    fillB1 = band!( x, fill(0,length(x)), fg(x, 0.25, 1.5); color =("#E69F00", 0.1))
    # filled curve 2
    linea2 = lines!(x, fg(x, 2, 1), color = "#56B4E9")
    fillB2 = band!( x, fill(0,length(x)), fg(x, 2, 1); color = ("#56B4E9", 0.1))
    # filled curve 3
    linea3 = lines!(x, fg(x, -1, 2), color = "#009E73")
    fillB3 = band!( x, fill(0,length(x)), fg(x, -1, 2); color = ("#009E73", 0.1))
    leg = Legend(fig, [[linea1, fillB1], [linea2, fillB2], [linea3, fillB3]],
    ["μ = 0.25, σ = 1.25", "μ = 2, σ = 1", "μ = -1, σ = 2"], halign = :left,
    valign = :top, tellheight = false, tellwidth = false, margin = (10, 10, 10, 10))
    fig[1, 1] = ax
    fig[1, 1] = leg
    #save("FilledLines.png"), fig, px_per_unit = 2.0)
    save(joinpath(@__DIR__, "output", "FilledLines.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
