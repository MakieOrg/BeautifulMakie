md"""
## Scatterlines & markers
"""

## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0, 2π, 50)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1], xlabel = "x")
    scatterlines!(x, sin.(x), color = :black, label = "sin(x)",
        marker = '◆', markersize = 10)
    scatterlines!(x, cos.(x), color = :black, label = "cos(x)",
        marker = '■', markercolor = :red, markersize = 10,
        strokewidth = 1, strokecolor = :red)
    axislegend(; position = :cc)
    ## display(fig)
    save(joinpath(@OUTPUT, "FigLinesScatters.svg"), fig) # HIDE
end;

# \fig{FigLinesScatters.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status("CairoMakie") # HIDE
