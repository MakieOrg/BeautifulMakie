using GLMakie
fig = Figure(resolution =(600,400), font = "Arial")
ax = Axis(fig[1,1])

f(x, y) = sin(x) * cos(y)
xrange = lift(ax.finallimits) do lims
    xr = range(minimum(lims)[1], maximum(lims)[1], length = 10)
end
yrange = lift(ax.finallimits) do lims
    range(minimum(lims)[2], maximum(lims)[2], length = 10)
end

heatmap!(ax, xrange, yrange, f)

fig