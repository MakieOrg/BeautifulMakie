# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = -2π:0.1:2π
    fig = Figure(resolution = (700, 450), fontsize = 18, font = "sans")
    ax = Axis(fig, xlabel = "x", ylabel = "f(x)", xgridcolor = :red,
                xgridstyle=:dash, xgridwidth=0.85, xtickalign=1, xticksize=20)
    line1 = lines!(x, sin.(x), color = "#56B4E9", linewidth = 2)
    line2 = lines!(x, cos.(x), color = :black, linewidth = 2, linestyle = :dash)
    leg = Legend(fig, [line1, line2], ["sin(x)", "cos(x)"], tellheight = false,
    tellwidth = false, halign = :left, valign = :bottom, labelsize = 14,
    linewidth = 2, margin = (10, 10, 10, 10), framevisible = true)
    limits!(ax, -2π, 2π, -1,1)
    fig[1, 1] = ax
    fig[1, 1] = leg
    #save("Fig2Lines.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "Fig2Lines.png"), fig, px_per_unit = 2) # HIDE
end


using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
