using CairoMakie
CairoMakie.activate!(type = "svg") #hide

x = range(0.01, 30π, 2000)
y = sin.(x)
lines(x, y; color = :black, figure = (size = (600, 400),),
    axis = (xscale = log10, xlabel = "x", ylabel = "y", xgridstyle = :dash,
        ygridstyle = :dash, xminorticksvisible = true,
        xminorticks = IntervalsBetween(9))) ## possible issue with log-ticks
ylims!(-1, 1)
current_figure()
save("line_xlog.svg", current_figure()); # hide

# ![](line_xlog.svg)