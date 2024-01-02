


```julia
using CairoMakie, Random

Random.seed!(123)
x = -3:0.05:3
y = exp.(-x .^ 2)
n = 15
y[1:n] = y[1:n] .+ 0.02 * randn(n)
fig = Figure(size = (600, 400))
ax1 = Axis(fig[1, 1], xlabel = "x", ylabel = "f(x)", xgridvisible = true,
    ygridvisible = true)
lines!(ax1, x, y, color = :red, label = "f(x)")
axislegend()
# inset
ax2 = Axis(fig, bbox = BBox(140, 250, 200, 300), xticklabelsize = 12,
    yticklabelsize = 12, title = "inset  at (140, 250, 200, 300)")
lines!(ax2, x, y, color = :red)
limits!(ax2, -3.1, -1.9, -0.05, 0.05)
ax2.yticks = [-0.05, 0, 0.05]
ax2.xticks = [-3, -2.5, -2]
translate!(ax2.scene, 0, 0, 10);
```


```
┌ Warning: Keyword argument `bgcolor` is deprecated, use `backgroundcolor` instead.
└ @ Makie ~/.julia/packages/Makie/Qvk4f/src/makielayout/blocks/legend.jl:22
```


![](line_inset.svg)

