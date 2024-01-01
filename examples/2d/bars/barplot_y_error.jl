using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(145)
x, y, yerr = 1:2:20, 5 * rand(10), 0.4 * abs.(randn(10))

fig = Figure(size = (600, 400))
ax = Axis(fig[1, 1], xlabel = "variable", ylabel = "values")
barplot!(ax, x, y; strokewidth = 1, color = :transparent, strokecolor = :black)
errorbars!(ax, x, y, yerr; whiskerwidth = 12)
fig
save("band_y_error.svg", fig); # hide

# ![](band_y_error.svg)