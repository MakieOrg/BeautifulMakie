# ## candlestick

# ![](candlestick.png)

using CairoMakie, Random, TimeSeries, MarketData, Dates
CairoMakie.activate!() # hide

tempo = string.(timestamp(ohlc))
lentime = length(tempo)
slice_dates = range(1,lentime, step = lentime÷20)

colors = values(ohlc.Close) .> values(ohlc.Open)
lowV = values(ohlc.Low)
highV = values(ohlc.High)
linesegs = []
for i in 1:lentime
    push!(linesegs, Point2f(i, lowV[i]))
    push!(linesegs, Point2f(i, highV[i]))
end
linesegs = Point2f.(linesegs)
cmap = ["#f64325", "#78f518"]
with_theme(theme_dark()) do
    fig = Figure(; size = (1200, 700), font = "sans", fontsize = 20)
    ax = Axis(fig; ygridcolor = "#65866b",
        xgridcolor = "#65866b", xgridstyle=:dash, ygridstyle=:dash)
    barplot!(ax, 1:lentime, values(ohlc.Open), fillto = values(ohlc.Close),
        color = colors,strokewidth = 0.5, strokecolor = colors, colormap = cmap)
    linesegments!(ax, linesegs, color = colors, colormap = cmap)
    xlims!(ax, 200, 300)
    ylims!(ax, 13,24)
    ax.xticks = (slice_dates, tempo[slice_dates])
    ax.xticklabelrotation = π/4
    fig[1,1] = ax
    fig
end
save("candlestick.png", current_figure(), px_per_unit = 2.0); # hide