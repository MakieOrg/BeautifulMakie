# ## broken y axis

# ![](line_broken_y_axis.svg) 

using CairoMakie
CairoMakie.activate!(type="svg") #hide

# define some data
x = [1, 2, 3, 4, 5, 6, 7, 8]
y = [1.6022884252337856e-15
    1.0982140221904354e-15
    5.463801624996023e-15
    5.317256161421627e-7
    8.476518770185598e-5
    0.0005105758346367672
    0.006769803152530791
    0.0791149895645982]

fig = Figure()
gL = GridLayout(fig[1, 1])

row1 = 1
row2 = 2

ax_top = Axis(gL[1, 1], yscale=log10, ygridvisible=false, xgridvisible=false)
ax_bot = Axis(gL[2, 1], yscale=log10, xlabel="x axis label", ygridvisible=false, xgridvisible=false)

Label(gL[1:2, 1, Left()], "y axis Label", rotation=π / 2, padding=(0, 60, 0, 0))

below_break_min = 1E-16
below_break_max = 1E-14
above_break_min = 1E-6
above_break_max = 1E-1

ax_top_fraction = 0.65
ax_bot_fraction = 1 - ax_top_fraction

below_break = (below_break_min, below_break_max)
above_break = (above_break_min, above_break_max)
lims = Observable((below_break, above_break))
on(lims) do (bottom, top)
    ylims!(ax_bot, bottom)
    ylims!(ax_top, top)
    rowsize!(gL, row1, Auto(ax_top_fraction))
    rowsize!(gL, row2, Auto(ax_bot_fraction))
end

hidexdecorations!(ax_top, grid=false)
ax_top.bottomspinevisible = false
ax_bot.topspinevisible = false

linkxaxes!(ax_top, ax_bot)
gap_size = 25
rowgap!(gL, gap_size)

angle_ = pi / 8
linelength = 10

segments = lift(
    @lift($(ax_top.yaxis.attributes.endpoints)[1]),
    @lift($(ax_bot.yaxis.attributes.endpoints)[2]),
    @lift($(ax_top.elements[:yoppositeline][1])[1]),
    @lift($(ax_bot.elements[:yoppositeline][1])[2]),
) do p1, p2, p3, p4
    ps = Point2f[p1, p2, p3, p4]

    map(ps) do p
        a = p + Point2f(cos(angle_), sin(angle_)) * 0.5 * linelength
        b = p - Point2f(cos(angle_), sin(angle_)) * 0.5 * linelength
        (a, b)
    end
end

linesegments!(fig.scene, segments, color=:black)

scatterlines!(ax_top, x, y)
scatterlines!(ax_bot, x, y)
hlines!(ax_top, above_break_min, linestyle=:dash, color=:gray)
hlines!(ax_bot, below_break_max, linestyle=:dash, color=:gray)
notify(lims)

save("line_broken_y_axis.svg", current_figure()); # hide