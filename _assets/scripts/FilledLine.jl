# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = 0:0.05:1
    y = x.^2
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x", ylabel = "y")
    lines!(x, y, color = :orangered, label = "Label")
    band!(x, fill(0,length(x)), y; color = (:orange, 0.25), label = "Label")
    axislegend(; merge = true, position = :lt)
    display(fig)
    save(joinpath(@__DIR__, "output", "FilledLine.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
