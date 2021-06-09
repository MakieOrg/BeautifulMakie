# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie
CairoMakie.activate!() #HIDE
let
    fig = Figure(resolution = (700,450))
    ax1 = Axis(fig[1, 1], yticklabelcolor = :black, rightspinevisible = false)
    ax2 = Axis(fig[1, 1], yticklabelcolor = :orangered, yaxisposition = :right,
        rightspinecolor = :orangered, ytickcolor = :orangered)
    lines!(ax1, 0..10, x -> x, color = :black)
    lines!(ax2, 0..10, x -> exp(-x), color = :orangered)
    hidespines!(ax2, :l,:b, :t)
    hidexdecorations!(ax2)
    fig
    save(joinpath(@__DIR__, "output", "twinAxis.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
