# ## line with colormap

# ![](line_cmap.png)

using CairoMakie, ColorSchemes
CairoMakie.activate!(type = "png") #hide

x = range(0, 2π, 100)
fig = Figure(; size = (600, 400))
ax = Axis(fig[1, 1], xlabel = "x")
obj = lines!(x, sin.(x); color = x, colormap = :viridis, linewidth = 5)
lines!(x, cos.(x), color = :black, label = "cos(x)", linewidth = 1)
lines!(x, -cos.(x), color = :dodgerblue, label = "-cos(x)")
axislegend(ax)
Colorbar(fig[1, 2], obj, label = "sin(x)")
colgap!(fig.layout, 5)
fig
save("line_cmap.png", fig); # hide