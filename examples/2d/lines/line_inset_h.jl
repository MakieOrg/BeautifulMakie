# ## Inset heatmap

# ![](line_inset_h.svg)

using CairoMakie
CairoMakie.activate!(type = "svg") #hide

x = y = -10:0.11:10
y1d = sin.(x) ./ x
## 3D heatmap
sinc2d(x, y) = sin.(sqrt.(x .^ 2 + y .^ 2)) ./ sqrt.(x .^ 2 + y .^ 2)
fxy = [sinc2d(x, y) for x in x, y in y]

fig = Figure(size = (600, 400))
ax1 = Axis(fig[1, 1], xlabel = "x", ylabel = "f(x)", xgridvisible = true,
    ygridvisible = true)
lines!(ax1, x, y1d, color = :red, label = "sinc(x)")
axislegend()
## inset
ax2 = Axis(fig, bbox = BBox(140, 260, 260, 350), xticklabelsize = 12,
    yticklabelsize = 12, title = "inset  at (140, 260, 260, 350)")
hmap = heatmap!(ax2, x, y, fxy, colormap = :Spectral_11)
Colorbar(fig[1, 1], hmap, label = "sinc(x,y)", labelpadding = 5,
    tellheight = false, tellwidth = false, ticklabelsize = 12,
    width = 10, height = Relative(1.5 / 4),
    halign = :right, valign = :center)
limits!(ax2, -10, 10, -10, 10)
hidespines!(ax2)
ax2.yticks = [-10, 0, 10]
ax2.xticks = [-10, 0, 10]
fig
save("line_inset_h.svg", fig); # hide