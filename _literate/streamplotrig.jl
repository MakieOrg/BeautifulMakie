# by Lazaro Alonso
using GLMakie
set_theme!()
#let
    cossin(x, y) = Point2f(cos(abs(x) + abs(y)), -sin(abs(x) + abs(y))) # x'(t) = -x, y'(t) = 2y
    fig = Figure(resolution = (1200, 800))
    ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y", aspect = 1)
    pltobj = streamplot!(ax, cossin, -5 .. 5, -5 .. 5, colormap = :viridis,
        gridsize = (64, 64), arrow_size = 10, color = 2)
    #fig
    display(fig)
#end;