# ## heatmap with top colorbar

# ![](heatmapCbarTop.png)

using CairoMakie, Random
CairoMakie.activate!() #HIDE

Random.seed!(123)
fig = Figure(; size = (600, 400))
ax = Axis(fig[2, 1], aspect = 1, xlabel = "x", ylabel = "y")
hmap = heatmap!(rand(20, 20), colormap = :CMRmap)
Colorbar(fig[1, 1], hmap, label = "values", height = 15, vertical = false,
    ticksize = 15, tickalign = 1, width = Relative(0.5))
rowsize!(fig.layout, 2, Aspect(1, 0.5))
fig
save("heatmapCbarTop.png", fig); # hide
