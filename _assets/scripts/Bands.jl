# by Lazaro Alonso
using CairoMakie
let
    x = LinRange(-10,10,200)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], xlabel = "x", ylabel = "y")
    band!(x, sin.(x), sin.(x) .+ 1; color = (:blue, 0.2))
    band!(x, cos.(x), 1 .+ cos.(x); color = (:red, 0.2))
    display(fig)
    save(joinpath(@__DIR__, "output", "Bands.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
