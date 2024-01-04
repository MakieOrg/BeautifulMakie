# ## Multiple overlayed contour plots
using CairoMakie
CairoMakie.activate!(type = "svg") #hide

f(x, y) = abs(sin(x)* sin(y))
g(x, y) = abs(cos(x)* cos(y))

x = y = -3:0.1:3
zf = [f(x, y) for x in x, y in y]
zg = [g(x, y) for x in x, y in y]

fig = Figure(; size=(600, 400))
ax = Axis(fig[1,1]; xlabel="x", ylabel="y")
contour!(ax, x, y, zf; labels=true, color=:orangered, linestyle=:dash,
    linewidth=2, label = "f(x,y)",
    labelcolor=:red, levels = [0.5,1], labelsize=14)
contour!(ax, x, y, zg; labels=true, color=:dodgerblue, linewidth=2,
    label = "g(x,y)", labelcolor=:blue, levels = [0.5,1], labelsize=14)  
axislegend()
fig

save("overlayed_functions.svg", fig); # hide

# ![](overlayed_functions.svg)