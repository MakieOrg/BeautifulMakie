# ## scatters and axislegend: Legend inside

# ![](scatters_legend.svg)

using GLMakie
fig = Figure()
ax = Axis(fig[1,1])
lines!(ax, 1:10, rand(10); label = "uno")
lg = axislegend(ax)
fig
save("scatters_legend.svg", fig); # hide