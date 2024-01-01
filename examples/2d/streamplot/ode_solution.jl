using CairoMakie
CairoMakie.activate!(type = "png") #hide

odeSol(x, y) = Point2f(-x, 2y) # x'(t) = -x, y'(t) = 2y
fig = Figure(size = (600, 400))
ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y", backgroundcolor = :black)
streamplot!(ax, odeSol, -2 .. 4, -2 .. 2, colormap = Reverse(:plasma),
    gridsize = (32, 32), arrow_size = 10)
fig
save("ode_solution.svg", fig); # hide

# ![](ode_solution.svg)