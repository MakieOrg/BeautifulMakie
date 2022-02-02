# by Lazaro Alonso
using GLMakie
GLMakie.activate!() # HIDE
let
    u = LinRange(0, 1, 50)
    v = LinRange(0, 2π, 50)
    X1 = [u for u in u, v in v]
    Y1 = [(u^4 - u^2) * cos(v) for u in u, v in v]
    Z1 = [(u^4 - u^2) * sin(v) for u in u, v in v]

    fig, ax, pltobj = surface(X1, Y1, Z1; shading = true, ambient = Vec3f(0.65, 0.65, 0.65),
        backlight = 1f0, color = sqrt.(X1 .^ 2 .+ Y1 .^ 2 .+ Z1 .^ 2),
        colormap = :viridis, transparency = true,
        figure = (; resolution = (1200, 800), fontsize = 22))
    Colorbar(fig[1, 2], pltobj, height = Relative(0.5))
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    save(joinpath(@__DIR__, "output", "revolutionSurf.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status("GLMakie") # HIDE
