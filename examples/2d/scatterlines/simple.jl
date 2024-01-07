# ## simple scatterlines

# ![](simple.svg)

using CairoMakie
CairoMakie.activate!(type = "svg") #hide

x = LinRange(0, 2π, 50)
fig = Figure(size = (600, 400))
ax = Axis(fig[1, 1], xlabel = "x", ylabel = "")
scatterlines!(x, sin.(x); 
    color = :black,
    markersize = 10,
    label = "sin(x)")
axislegend()
fig
save("simple.svg", fig); # hide