using CairoMakie
CairoMakie.activate!(type = "png") #hide

x = -2π:0.1:2π
lines(x, sin.(x); color = "#56B4E9", linewidth = 2, label = L"sin",
    axis = (xlabel = L"x", ylabel = L"f(x)", xgridcolor = :red,
        xlabelsize = 22, ylabelsize = 22,
        xgridstyle = :dashdot, xgridwidth = 0.85,
        xtickalign = 1, xticksize = 20),
    figure = (resolution = (600, 400), fonts = (; regular= "CMU Serif")))

lines!(x, cos.(x); color = :black, linestyle = :dash, label = L"cos")
limits!(-2π, 2π, -1, 1)
axislegend("Legend", position = :lb);
save("line_two.png", current_figure()); # hide

# ![](line_two.png)