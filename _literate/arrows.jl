md"""
## Arrows
"""

## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    xs = LinRange(-3, 3, 20)
    ys = LinRange(-3, 3, 20)
    us = [x + y for x in xs, y in ys]
    vs = [y - x for x in xs, y in ys]
    strength = vec(sqrt.(us .^2 .+ vs .^2))
    cmap = :gnuplot
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x", ylabel = "y", aspect = DataAspect())
    arrows!(ax, xs, ys, us, vs, arrowsize = 10, lengthscale = 0.1,
        arrowcolor = strength, linecolor = strength, colormap = cmap)
    Colorbar(fig[1,2], limits =(minimum(strength), maximum(strength)),
        nsteps =100, colormap = cmap, ticksize=15, width = 15, tickalign=1)
    limits!(ax, -3,3,-3,3)
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    ## display(fig)
    save(joinpath(@OUTPUT, "arrows.svg"), fig) # HIDE
end;
# \fig{arrows.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE