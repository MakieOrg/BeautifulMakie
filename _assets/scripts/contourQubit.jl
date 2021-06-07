# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    function tα_qubit(β, ψ1, ψ2, fα, f)
        2 + 2*β - cos(ψ1) - cos(ψ2) - 2*β*cos(π*fα)*cos(2*π*f + π*fα - ψ1- ψ2)
    end
    ψ1 = ψ2 = LinRange(0, 4*π, 100)
    z = [tα_qubit(.61, x, y, 0.2, .1) for x in ψ1, y in ψ2]

    fig = Figure(resolution = (470, 400))
    ax = Axis(fig, aspect = 1, xlabel = "ψ1", ylabel = "ψ2")
    clines = contour!(ψ1, ψ2, z,colormap = :plasma,levels = 20,linewidth = 1.5)
    limits!(ax, 0, 4π, 0, 4π)
    cbar  = Colorbar(fig, clines, label ="α-q", height = Relative(3.55/4))
    fig[1, 1] = ax
    fig[1, 2] = cbar
    save(joinpath(@__DIR__, "output", "contourQubit.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
