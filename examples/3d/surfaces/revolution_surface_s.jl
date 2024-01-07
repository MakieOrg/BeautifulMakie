# ## revolution surface s

# ![](revolution_surface_s.png)

using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

u = LinRange(-1.5, 2, 50)
v = LinRange(0, 2 * pi, 50)
X1 = [u for u in u, v in v]
Y1 = [(u^2 + 1) * cos(v) for u in u, v in v]
Z1 = [(u^2 + 1) * sin(v) for u in u, v in v]

fig, ax, pltobj = surface(X1, Y1, Z1; shading = FastShading, ambient = Vec3f(0.95, 0.95, 0.95),
    backlight = 1.0f0, color = sqrt.(X1 .^ 2 .+ Y1 .^ 2 .+ Z1 .^ 2),
    colormap = :Isfahan2, transparency = true,
    figure = (; size = (1200, 800), fontsize = 22))
wireframe!(X1, Y1, Z1; linewidth = 0.2, transparency = true)
Colorbar(fig[1, 2], pltobj, height = Relative(0.5))
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
save("revolution_surface_s.png", fig); # hide