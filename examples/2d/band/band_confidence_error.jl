# ## band confidence error

# ![](band_confidence_error.svg)

using CairoMakie
CairoMakie.activate!(type = "svg") #hide

x = y = -10:0.11:10
y1d = sin.(x) ./ x
lower = y1d .- 0.1
upper = y1d .+ 0.1

fig = Figure(size = (600, 400))
ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y")
lines!(x, y1d, color = :black)
band!(x, lower, upper; color = (:green, 0.2))
fig
save("band_confidence_error.svg", fig); # hide