# ## heatmap with text on top

# ![](text_heatmap.png)

using CairoMakie, Random
CairoMakie.activate!(type = "png") #hide

Random.seed!(123)
m = 15
n = 5
data = rand(m, n)
## some fake ticks
alphabet = 'A':'E'
yticks = string.(collect(alphabet))
k = 4
itr = Iterators.product(ntuple(_ -> alphabet, k)...)
xticks = []
for word in Base.Generator(join, itr)
    push!(xticks, word)
    if length(xticks) == m
        break
    end
end
xticks = string.(xticks)

fig = Figure(size = (1200, 600), fontsize = 20)
ax = Axis(fig[1, 1], xticks = (1:m, xticks), yticks = (1:n, yticks))
hmap = heatmap!(ax, data, colormap = :plasma)
for i in 1:15, j in 1:5
    txtcolor = data[i, j] < 0.15 ? :white : :black
    text!(ax, "$(round(data[i,j], digits = 2))", position = (i, j),
        color = txtcolor, align = (:center, :center))
end
Colorbar(fig[1, 2], hmap; label = "values", width = 15, ticksize = 15)
ax.xticklabelrotation = π / 3
ax.xticklabelalign = (:right, :center)
fig
save("text_heatmap.png", fig); # hide