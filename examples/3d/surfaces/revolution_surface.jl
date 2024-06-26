# ## revolution surface

# ![](revolution_surface.png)

using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

u = LinRange(0, 1, 50)
v = LinRange(0, 2π, 50)
X1 = [u for u in u, v in v]
Y1 = [(u^4 - u^2) * cos(v) for u in u, v in v]
Z1 = [(u^4 - u^2) * sin(v) for u in u, v in v]

fig, ax, pltobj = surface(X1, Y1, Z1; shading = FastShading,
    #ambient = Vec3f(0.65, 0.65, 0.65),
    backlight = 1.0f0, color = sqrt.(X1 .^ 2 .+ Y1 .^ 2 .+ Z1 .^ 2),
    colormap = :viridis, transparency = true,
    figure = (; size = (1200, 800), fontsize = 22))
Colorbar(fig[1, 2], pltobj, height = Relative(0.5))
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
save("revolution_surface.png", fig); # hide