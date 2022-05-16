md"""
## Bands-ribbon, Filled-Between
"""
## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(-10, 10, 200)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y")
    band!(x, sin.(x), sin.(x) .+ 1; color = (:blue, 0.2))
    band!(x, cos.(x), 1 .+ cos.(x); color = (:red, 0.2))
    ## display(fig)
    save(joinpath(@OUTPUT, "Bands.png"), fig) # HIDE
end;
# \fig{Bands.png}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status(["CairoMakie"]) # HIDE
