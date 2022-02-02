md"""
## Surface: complex function
"""
## by Lazaro Alonso
using GLMakie
GLMakie.activate!()
let
    x = -2:0.005:2
    y = -2:0.005:2
    f(z) = (z^2 + 1) / (z^2 - 1)
    fvals = [f(u + 1im * v) for u in x, v in y]
    fvalues = abs.(fvals)
    fargs = angle.(fvals)
    indxCut = fvalues .> 3
    fvalues[indxCut] .= 3.01

    fig, ax, pltobj = surface(x, y, fvalues, color = fargs,
        colormap = :roma, colorrange = (-π, π),
        backlight = 1.0f0, highclip = :black,
        figure = (; resolution = (1200, 800), fontsize = 22))
    Colorbar(fig[1, 2], pltobj, height = Relative(0.5))
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    save(joinpath(@OUTPUT, "surfaceComplexF.png"), fig, px_per_unit = 2.0) # HIDE
    ## display(fig)
end;
# \fig{surfaceComplexF.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
