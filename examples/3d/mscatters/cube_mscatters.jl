using GLMakie, ColorSchemes
using GeometryBasics: Rect3f
GLMakie.activate!()
GLMakie.closeall() # close any open screen

x = y = z = 1:10
f(x, y, z) = x^2 + y^2 + z^2
positions = vec([(i, j, k) for i in x, j in y, k in z])
vals = [f(ix, iy, iz) for ix in x, iy in y, iz in z]
m = Rect3f(Vec3f(-0.5), Vec3f(1))

fig, ax, pltobj = meshscatter(positions; 
    color = vec(vals),
    marker = m, markersize = 0.9,
    colormap = (:Egypt, 0.75), 
    colorrange = (minimum(vals), maximum(vals)),
    transparency = true, 
    shading = NoShading,
    figure = (; 
        size = (1200, 800)
        ),
    axis = (; 
        type = Axis3, 
        perspectiveness = 0.5, 
        azimuth = 2.19, 
        elevation = 0.57,
        xlabel = "x label", 
        ylabel = "y label", 
        zlabel = "z label",
        aspect = (1, 1, 1))
        )
Colorbar(fig[1, 2], pltobj; label = "f values", height = Relative(0.5))
colsize!(fig.layout, 1, Aspect(1, 1.0))
limits!(ax, -1, 11, -1, 11, -1, 11)
fig

save("cube_mscatters.png", fig); # hide

# ![](cube_mscatters.png)