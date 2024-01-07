# ## vertical and horizontal boxplots

# ![](vertical_horizontal.svg)

using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(13)
n = 3000
data_r = randn(n)
a = fill(1, n)
fig = Figure(size = (600, 400))
ax1 = Axis(fig[1, 1], xlabel = "variable", ylabel = "values",
    xticks = ([1], ["normal Distribution"]))
ax2 = Axis(fig[1, 2], xlabel = "values", ylabel = "variable",
    yticks = ([1], ["normal Distribution"]), yticklabelrotation = pi / 2)

boxplot!(ax1, a, data_r; whiskerwidth = 1, width = 0.35, color = (:red, 0.45),
    whiskercolor = (:red, 1), mediancolor = :red, markersize = 8,
    strokecolor = :black, strokewidth = 1, label = "vertical")
limits!(ax1, 0, 2, -5, 5)
boxplot!(ax2, a, data_r; orientation = :horizontal, whiskerwidth = 1, width = 0.35,
    color = (:navy, 0.45), whiskercolor = (:navy, 1), mediancolor = :navy,
    markersize = 8, strokecolor = :black, strokewidth = 1,
    label = "horizontal")
limits!(ax2, -5, 5, 0, 2)
axislegend(ax1, position = :rb, framecolor = :transparent)
axislegend(ax2, position = :rt, backgroundcolor = (:dodgerblue, 0.2))
fig
save("vertical_horizontal.svg", fig); # hide