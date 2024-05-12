# ## heatmap: log scales

# ![](heatmapLogIrregular.png)

using CairoMakie, Colors, ColorSchemes, Random
CairoMakie.activate!() # hide

Random.seed!(38)
x = y = 1:100
z = exp10.(2 * rand(100, 100))
z[1, 1] = 99
z[2, 1] = 90
z[3, 1] = 10
cmap = cgrad(:gnuplot, scale = :log10)
ticks = (vcat(collect(1:9), collect(10:10:100)),
    ["1", fill("", 8)..., "10", fill("", 8)..., "10²"])

fig = Figure(; size = (600, 400))
ax = Axis(fig[1, 1], xscale = log10, yscale = log10,
    xlabel = "x", ylabel = "y")
hmap = heatmap!(x, y, z, colormap = cmap, colorrange = (1, 100))
cbar = Colorbar(fig[1, 2], hmap, label = "z values",
    width = 15, ticksize = 15, labelsize = 18, ticklabelsize = 18,
    tickalign = 1, minortickalign = 1,
    scale = log10)
ax.xticks = ticks
ax.yticks = ticks
cbar.ticks = ticks
colsize!(fig.layout, 1, Aspect(1, 1.0))
colgap!(fig.layout, 7)
fig
save("heatmapLogIrregular.png", fig); # hide
