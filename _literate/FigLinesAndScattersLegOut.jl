md"""
## scatterlines & legend out
"""
## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = LinRange(0, 2π, 50)
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1], xlabel = "x")
    lines!(x, sin.(x), color = :red, label = "sin(x)")
    scatterlines!(x, cos.(x), color = :blue, label = "cos(x)", markersize = 5)
    scatter!(x, -cos.(x), color = :red, label = "-cos(x)", strokewidth = 1,
        strokecolor = :red, markersize = 5, marker = '■')
    Legend(fig[1, 2], ax, merge = true)
    display(fig)
    save(joinpath(@OUTPUT, "FigLinesAndScattersLegOut.svg"), fig) # HIDE
end;

# \fig{FigLinesAndScattersLegOut.svg}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
