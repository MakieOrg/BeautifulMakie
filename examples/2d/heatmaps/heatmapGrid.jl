# ## heatmaps: grid

# ![](heatmapGrid.png)

using CairoMakie, Random, ColorSchemes
CairoMakie.activate!() # hide

Random.seed!(21)
cmaps = collect(keys(colorschemes))
fig = Figure(; size = (1200, 800), fontsize = 20)
for i in 1:2, j in 1:2:5
    ax = Axis(fig[i, j], aspect = 1, xticks = [1, 10], yticks = [1, 10])
    hmap = heatmap!(ax, 1:10, 1:10, rand(10, 10); colorrange = (0, 1),
        colormap = cmaps[rand(1:length(cmaps))])
    Colorbar(fig[i, j+1], hmap; height = Relative(0.5), tickwidth = 2,
        ticks = [0, 0.5, 1])
end
fig
save("heatmapGrid.png", fig); # hide