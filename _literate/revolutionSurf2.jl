md"""
## Surface of revolution2
"""
## by Lazaro Alonso
using GLMakie
GLMakie.activate!() # HIDE
let
    u = LinRange(-1.5, 2, 50)
    v = LinRange(0, 2 * pi, 50)
    X1 = [u for u in u, v in v]
    Y1 = [(u^2 + 1) * cos(v) for u in u, v in v]
    Z1 = [(u^2 + 1) * sin(v) for u in u, v in v]

    fig, ax, pltobj = surface(X1, Y1, Z1; shading = true, ambient = Vec3f(0.95, 0.95, 0.95),
        backlight = 1.0f0, color = sqrt.(X1 .^ 2 .+ Y1 .^ 2 .+ Z1 .^ 2),
        colormap = :Isfahan2, transparency = true,
        figure = (; resolution = (1200, 800), fontsize = 22))
    wireframe!(X1, Y1, Z1; linewidth = 0.2, transparency = true)
    Colorbar(fig[1, 2], pltobj, height = Relative(0.5))
    colsize!(fig.layout, 1, Aspect(1, 1.0))
    save(joinpath(@OUTPUT, "revolutionSurf2.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end;
# \fig{revolutionSurf2.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status("GLMakie") # HIDE
