# by Lazaro Alonso
using CairoMakie, TimeSeries, Dates
CairoMakie.activate!() # HIDE
let
    # dummy data
    dates = Date(2018, 1, 1):Day(1):Date(2018, 12, 31)
    ta = TimeArray(dates, rand(length(dates)))
    vals = 0.5*values(ta)
    tempo = string.(timestamp(ta))
    lentime = length(tempo)
    slice_dates = range(1,lentime, step = lentime÷8)

    fig = Figure(resolution = (600, 400), font =:sans)
    ax = Axis(fig[1,1], xlabel = "Date", ylabel = "value")
    line1 = lines!(ax, 1:lentime, vals; color = :black, linewidth = 0.85)
    ax.xticks = (slice_dates, tempo[slice_dates])
    ax.xticklabelrotation = π/4
    ax.xticklabelalign = (:right, :center)
    ## display(fig)
    save(joinpath(@__DIR__, "output", "timeSeries.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie","TimeSeries","Dates"]) # HIDE