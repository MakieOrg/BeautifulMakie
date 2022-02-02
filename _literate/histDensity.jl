md"""
## Histogram with pdf => density
"""

## by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    fig = Figure(resolution = (600, 400))
    ax1 = Axis(fig[1, 1], xlabel = "value")
    hist!(ax1, data; normalization = :pdf, color = (:green, 0.5), label = "hist & pdf")
    density!(ax1, data, color = (:orange, 0.25), label = "density!", strokewidth = 1)
    axislegend(ax1, position = :rt)
    ## display(fig)
    save(joinpath(@OUTPUT, "histDensity.svg"), fig) # HIDE
end;
# \fig{histDensity.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
