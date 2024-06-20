# ## Time ticks on x axis

# ![](line_time.svg)

using CairoMakie, TimeSeries, Dates
CairoMakie.activate!(type = "svg") #hide
## dummy data
dates = Date(2018, 1, 1):Day(1):Date(2018, 12, 31)
ta = TimeArray(dates, rand(length(dates)))

fig = Figure(size=(600, 400), fonts=(;regular = "sans"))
ax = Axis(fig[1, 1], xlabel="Date", ylabel="value")
line1 = lines!(ax, timestamp(ta), values(ta); color=:black, linewidth=0.85)
# ax.xticklabelrotation = π / 4
# ax.xticklabelalign = (:right, :center)
fig
save("line_time.svg", fig); # hide