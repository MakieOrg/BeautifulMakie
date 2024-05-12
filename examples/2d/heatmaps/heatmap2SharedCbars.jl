# ## heatmap with 2 shared colorbars

# ![](heatmap2SharedCbars.png)

using CairoMakie, Random
using ColorSchemes
CairoMakie.activate!() # hide

Random.seed!(123)
cmaps = collect(keys(colorschemes))
fig = Figure(; size = (600, 400))
for i in 1:2, j in 1:2:3
    ax = Axis(fig[i, j]; aspect = 1)
    hm = heatmap!(ax, 1:10, 1:10, rand(10, 10); colorrange = (0, 1),
        colormap = cmaps[5j])
    Colorbar(fig[1:2, j+1]; limits=(0,1), colormap = cmaps[5j], ticklabelsize = 14,
        height = Relative(0.85), ticks = [0, 0.5, 1], tickwidth = 2)
end
fig
save("heatmap2SharedCbars.png", fig); # hide
