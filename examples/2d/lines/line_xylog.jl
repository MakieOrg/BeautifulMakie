# ## x and y log scales

# ![](line_xylog.png)

using CairoMakie, Random
CairoMakie.activate!(type = "png") #hide

Random.seed!(123)
x = 0.001:0.05:10
y = x .^ 2 .+ abs.(2 * randn(length(x)))
lines(x, y, color=:navy, figure=(size=(600, 400),),
    axis=(xscale=log10, yscale=log10, xlabel="x", ylabel="y",
        xgridstyle=:dash, ygridstyle=:dash, xminorticksvisible=true,
        xminorticks=IntervalsBetween(9), yminorticksvisible=true,
        yminorticks=IntervalsBetween(9)))

save("line_xylog.png", current_figure()); # hide