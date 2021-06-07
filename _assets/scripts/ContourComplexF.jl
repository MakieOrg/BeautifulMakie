# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = -2:0.005:2
    y = -2:0.005:2
    f(z) = (z^3 - 3)/z
    fvals = [f(u+1im*v) for u in x, v in y]
    fvalues = abs.(fvals)
    fargs = angle.(fvals)
    fig = Figure(resolution = (960,450))
    ax1 = Axis(fig, aspect = 1)
    ax2 = Axis(fig, aspect = 1)
    cmap = :diverging_rainbow_bgymr_45_85_c67_n256
    pltobj1 = contour!(ax1, x, y, fargs, levels = 30, colormap = cmap)
    pltobj2 = heatmap!(ax2, x, y, fargs, colorrange = (-π,π), colormap = cmap)
        contour!(ax2, x, y, fargs,levels = 30,color = :white,linewidth = 0.85)
    cbar = Colorbar(fig, pltobj2,
            ticks = ([-π,-π/2,0,π/2,π],["-π", "-π/2", "0", "π/2", "π"]))
    limits!(ax1, -2,2,-2,2)
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[1,3] = cbar
    save(joinpath(@__DIR__, "output", "ContourComplexF.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
