# ## heatmap with bottom colorbar

# ![](heatmapCbarBottom.png)

using CairoMakie, Random
CairoMakie.activate!() # hide

Random.seed!(123)
fig = Figure(;size = (600, 400))
ax = Axis(fig[1, 1], aspect = 1, xlabel = "x", ylabel = "y")
hmap = heatmap!(rand(20, 20), colormap = :lajolla)
Colorbar(fig[2, 1], hmap, label = "values", height = 15, vertical = false,
    flipaxis = false, ticksize = 15, tickalign = 1, width = Relative(0.5))
rowsize!(fig.layout, 1, Aspect(1, 0.5))
fig
save("heatmapCbarBottom.png", fig); # hide
