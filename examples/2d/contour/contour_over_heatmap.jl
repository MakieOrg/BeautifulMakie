using CairoMakie
CairoMakie.activate!(type = "png") #hide

f(x, y) = (x + 2y^2) * abs(sin(y) + cos(x))
x = y = 1:0.2:20
z = [f(x, y) for x in x, y in y]

fig = Figure(size=(1200, 400), fontsize=22)
axs = [Axis(fig[1, j], aspect=1, xlabel="x", ylabel=j == 1 ? "y" : "")
        for j in 1:3]
p1 = heatmap!(axs[1], x, y, z, colormap=:plasma)
contour!(axs[2], x, y, z; color=:black, levels=100:1:101)
heatmap!(axs[3], x, y, z; colormap=(:plasma, 0.5))
contour!(axs[3], x, y, z; color=:white, levels=100:1:101)
Colorbar(fig[1, 4], p1, width=20, ticksize=20, tickalign=1)
[limits!(axs[i], 1, 20, 1, 20) for i in 1:3]
[hideydecorations!(axs[i], grid=false, ticks=false) for i in 2:3]
fig

save("contour_over_heatmap.png", fig); # hide

# ![](contour_over_heatmap.png)