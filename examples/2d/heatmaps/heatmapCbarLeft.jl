# ## heatmap with left colorbar

# ![](heatmapCbarLeft.png)

using CairoMakie, Random
CairoMakie.activate!() # hide

Random.seed!(123)
fig = Figure(; size = (600, 400))
ax = Axis(fig[1, 2]; xlabel = "x", ylabel = "y")
hmap = heatmap!(2rand(20, 20) .- 1; colormap = :Spectral_11)
Colorbar(fig[1, 1], hmap; label = "values", width = 15, flipaxis = false,
    ticksize = 15, tickalign = 1)
colsize!(fig.layout, 2, Aspect(1, 1.0))
fig
save("heatmapCbarLeft.png", fig); # hide