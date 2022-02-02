# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = y = -10:0.11:10
    y1d =  sin.(x) ./ x
    lower = y1d .- 0.1
    upper = y1d .+ 0.1

    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x", ylabel = "y")
    lines!(x, y1d, color = :black)
    band!(x, lower, upper; color = (:green, 0.2))
    display(fig)
    save(joinpath(@__DIR__, "output", "ConfidenceRegion.svg"), fig) # HIDE
end


using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
