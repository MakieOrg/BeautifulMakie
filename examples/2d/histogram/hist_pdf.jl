# ## Histogram and pdf

# ![](hist_pdf.svg)

using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(13)
n = 3000
data = randn(n)
fig = Figure(size = (600, 400))
ax1 = Axis(fig[1, 1], xlabel = "value")
hist!(ax1, data; normalization = :pdf, color = (:green, 0.5), label = "hist & pdf")
density!(ax1, data; color = (:orange, 0.25), label = "density!", strokewidth = 1)
axislegend(ax1, position = :rt)
fig
save("hist_pdf.svg", fig); # hide