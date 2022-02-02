# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0, 2π, 50)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x")
    lines!(x, sin.(x); color = :red, label = "sin(x)")
    scatterlines!(x, cos.(x); color = :blue, label = "cos(x)", markercolor = :black,
        markersize = 10)
    scatter!(x, -cos.(x); color = :red, label = "-cos(x)", strokewidth = 1,
        strokecolor = :red, markersize = 5, marker = '■')
    axislegend(; position = :lt, bgcolor = (:white, 0.85), framecolor = :green)
    display(fig)
    save(joinpath(@__DIR__, "output", "FigLinesAndScatters.svg"), fig) # HIDE
end

using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
