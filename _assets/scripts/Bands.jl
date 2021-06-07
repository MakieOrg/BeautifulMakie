# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
let
    x = LinRange(-10,10,200)
    fig = Figure(resolution = (700, 450))
    ax = Axis(fig, xlabel = "x", ylabel = "y")
    # filled curve 1
    band!(x, sin.(x), sin.(x) .+ 1; color = ("#E69F00", 0.2))
    # filled curve 2
    band!(x, cos.(x), 1 .+ cos.(x); color = (:red, 0.2))
    fig[1,1] = ax
    #save("Bands.png"), fig, px_per_unit = 2.0)
    save(joinpath(@__DIR__, "output", "Bands.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
