# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, TimeSeries, MarketData, Dates
CairoMakie.activate!() # HIDE
let
    # dummy data
    dates = Date(2018, 1, 1):Day(1):Date(2019, 12, 31)
    ta = TimeArray(dates, rand(length(dates)))
    vals = 0.5*values(ta)
    tempo = string.(timestamp(ta))
    lentime = length(tempo)
    slice_dates = range(1,lentime, step = lentime÷11)

    fig = Figure(resolution = (700, 450), font =:sans)
    ax = Axis(fig, xlabel = "Date", ylabel = "value")
    line1 = lines!(ax,1:lentime, vals, color = :black, linewidth = 0.85)
    ax.xticks = (slice_dates, tempo[slice_dates])
    ax.xticklabelrotation = π/4
    #ax.xticklabelalign = (:center, :center)
    fig[1,1] = ax
    save(joinpath(@__DIR__, "output", "timeSeries.png"), fig, px_per_unit = 2) # HIDE
end


using Pkg # HIDE
Pkg.status(["CairoMakie","TimeSeries","MarketData","Dates"]) # HIDE
