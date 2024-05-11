# ## histogram pdf normalization

# ![](hist.svg)

using CairoMakie, Distributions, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(124)
cmap = resample_cmap(:linear_wcmr_100_45_c42_n256, 256; 
    alpha = rand(256))

fig = Figure(; size = (600,400))
ax = Axis(fig[1,1])
hist!(rand(Normal(2.6,0.4), 1000), normalization = :pdf, offset = -1,
    #colormap=:plasma,
    color = :values, direction = :x, fillto = -0.5)
hist!(rand(Normal(2.6,0.4), 1000), normalization = :pdf, offset = 1, 
    color = :grey10, direction = :x, scale_to = -0.5)
hist!(rand(Normal(0.2,0.2), 1000), normalization = :pdf, offset = 4, 
    strokewidth = 1, color = :transparent, strokecolor = :black, 
    direction = :y, scale_to = -1)
hist!(rand(Normal(0.2,0.2), 1000), normalization = :pdf, color = :values, 
    #colormap = cmap,
    strokewidth = 1, strokecolor = :black, 
    bar_labels = :values, label_color = :black, label_size = 12,
    label_formatter=x-> round(x, digits=1))
hidedecorations!(ax; grid = false)
fig
save("hist.svg", fig); # hide