# ## lines colored with discrete colors from colormap: Colorbar

# ![](line_colored_cbar.png)

using CairoMakie, ColorSchemes
CairoMakie.activate!(type = "png") #hide
xs = 0:0.01:1
p = -10:1:10
p = filter(x -> x != 0, collect(p))
psize = length(p)
ys = zeros(length(xs), psize)
for (indx, i) in enumerate(p)
    if i <= -1
        ys[:, indx] = xs .^ (1 / abs(i))
    elseif i >= 1
        ys[:, indx] = xs .^ i
    end
end
cbarPal = :thermal
cmap = cgrad(colorschemes[cbarPal], psize, categorical = true)
fig = Figure(size = (600, 400), fonts = (; regular= "CMU Serif"))
ax = Axis(fig[1, 1], xlabel = L"x", ylabel = L"x^{p}",
    xlabelsize = 22, ylabelsize = 22)
[lines!(xs, ys[:, v], color = cmap[v]) for v in 1:psize]
Colorbar(fig[1, 2], limits = (-10, 10), nsteps = psize, colormap = cmap,
    label = L"p", ticksize = 20, width = 20, tickalign = 1)
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
save("line_colored_cbar.png", fig); # hide