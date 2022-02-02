md"""
## Twin Axis
"""
## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() #HIDE
let
    fig = Figure(resolution = (600, 400))
    ax1 = Axis(fig[1, 1], yticklabelcolor = :black, rightspinevisible = false)
    ax2 = Axis(fig[1, 1], yaxisposition = :right,
        yticklabelcolor = :dodgerblue,
        rightspinecolor = :dodgerblue,
        ytickcolor = :dodgerblue)
    lines!(ax1, 0 .. 10, x -> x; color = :black)
    lines!(ax2, 0 .. 10, x -> exp(-x); color = :dodgerblue)
    hidespines!(ax2, :l, :b, :t)
    hidexdecorations!(ax2)
    ## display(fig)
    save(joinpath(@OUTPUT, "twinAxis.svg"), fig) # HIDE
end;

# \fig{twinAxis.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status("CairoMakie") # HIDE
