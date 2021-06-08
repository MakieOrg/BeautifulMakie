# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random, TimeSeries, MarketData, Dates
CairoMakie.activate!() #HIDE
let
    tempo = string.(timestamp(ohlc))
    lentime = length(tempo)
    slice_dates = range(1,lentime, step = lentime÷20)

    colors = values(ohlc.Close) .> values(ohlc.Open)
    lowV = values(ohlc.Low)
    highV = values(ohlc.High)
    linesegs = []
    for i in 1:lentime
        push!(linesegs, Point2f0(i, lowV[i]))
        push!(linesegs, Point2f0(i, highV[i]))
    end
    linesegs = Point2f0.(linesegs)
    cmap = colormap = ("#f64325", "#78f518")

    fig = Figure(resolution = (1200, 700), font = "sans", fontsize = 20)
    ax = Axis(fig, backgroundcolor = :black, ygridcolor = "#65866b",
        xgridcolor = "#65866b", xgridstyle=:dash, ygridstyle=:dash)
    barplot!(ax, 1:lentime, values(ohlc.Open), fillto = values(ohlc.Close),
        color = colors,strokewidth = 0.5, strokecolor = colors,colormap = cmap)
    linesegments!(ax, linesegs, color = colors, colormap = cmap)
    xlims!(ax, 200, 300)
    ylims!(ax, 13,24)
    ax.xticks = (slice_dates, tempo[slice_dates])
    ax.xticklabelrotation = π/4
    fig[1,1] = ax
    save(joinpath(@__DIR__, "output", "candlestick.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
