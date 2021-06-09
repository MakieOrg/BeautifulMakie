# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    x = -2:0.005:2
    y = -2:0.005:2
    f(z) = (z^2 + 1)/(z^2 - 1)
    fvals = [f(u+1im*v) for u in x, v in y]
    fvalues = abs.(fvals)
    fargs = angle.(fvals)
    indxCut = fvalues .> 3
    fvalues[indxCut] .= 3.01
    fig, ax, pltobj = surface(x, y, fvalues, color = fargs,
        colormap = :diverging_rainbow_bgymr_45_85_c67_n256,
        colorrange = (-π,π), backlight = 1f0, highclip = :black)
    fig
    save(joinpath(@__DIR__, "output", "surfaceComplexF.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
