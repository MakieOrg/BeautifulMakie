using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(124)
n = 30
x, y, z = randn(n), randn(n), randn(n)

fig = Figure(; size = (600, 400), backgroundcolor=:transparent)
ax = Axis(fig[1, 1]; xgridstyle = :dashdot, ygridstyle = :dashdot,
    xtickalign = 1, ytickalign = 1,
    backgroundcolor=:transparent)
pts1 = scatter!(ax, 10x, y; color = z, colormap = (:viridis, 0.75),
    markersize = 20z, marker = :rect)
pts2 = scatter!(ax, 3x, 5y; color = z, colormap = (:thermal, 0.85),
    markersize = 45z)

Colorbar(fig[1, 2], pts1, label = "z1 value", ticklabelsize = 14,
    labelpadding = 5, width = 10)
Colorbar(fig[1, 3], pts2, label = "z2 value", ticklabelsize = 14,
    labelpadding = 5, width = 10)
fig

save("bubble_plot.svg", fig); # hide
# ![](bubble_plot.svg)
