# ## heatmap irregular steps

# ![](heatmapIrregular.png)

using CairoMakie, Random
CairoMakie.activate!() # hide

Random.seed!(123)
x = y = sqrt.(1:10:101)
z = abs.(randn(10, 10))
fig = Figure(; size = (600, 400))
ax = Axis(fig[1, 1]; aspect = 1, xlabel = "x", ylabel = "y")
hmap = heatmap!(x, y, z; colormap = :magma)
Colorbar(fig[1, 2], hmap; label="z values", width=15, ticksize=15, tickalign=1)
colsize!(fig.layout, 1, Aspect(1, 1.0))
colgap!(fig.layout, 7)
fig
save("heatmapIrregular.png", fig); # hide
