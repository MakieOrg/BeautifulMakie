# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    odeSol(x,y) = Point2f(-x, 2y) # x'(t) = -x, y'(t) = 2y
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x", ylabel = "y", backgroundcolor = :black)
    streamplot!(ax, odeSol, -2..4, -2..2, colormap = Reverse(:plasma),
        gridsize= (32,32), arrow_size = 10)
    display(fig)
    save(joinpath(@__DIR__, "output", "streamplot.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
