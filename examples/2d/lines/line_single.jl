# ## simple line

# ![](line_single.svg) 

using CairoMakie
CairoMakie.activate!(type = "svg") #hide

x = 1:10
lines(x, x .^ 2; color = :black, linewidth = 2, linestyle = :dashdot, label = L"x^2",
    figure = (size = (600, 400), backgroundcolor = "#a5b4b5",
        fonts = (; regular = "CMU Serif")),
    axis = (xlabel = L"x", ylabel = L"x^2", backgroundcolor = :white,
        xlabelsize = 22, ylabelsize = 22))
axislegend("legend", position = :lt)
limits!(0, 10, 0, 100)

save("line_single.svg", current_figure()); # hide