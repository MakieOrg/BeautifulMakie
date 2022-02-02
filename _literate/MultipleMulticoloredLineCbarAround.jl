md"""
## Lines & colormaps (colorbars around)
"""

## by Lazaro Alonso
using CairoMakie, ColorSchemes
CairoMakie.activate!() # HIDE
let
    x = LinRange(0, 2π, 50)
    fig = Figure(resolution = (800, 600), fontsize = 22)
    ax = Axis(fig, xlabel = L"x", ylabel = L"y")
    line1 = lines!(x, sin.(x), color = x, colormap = :thermal, linewidth = 4)
    line2 = lines!(x, cos.(x), color = sqrt.(x), colormap = :ice, linewidth = 4)
    line3 = lines!(x, -sin.(x), color = x .^ 2, colormap = :viridis, linewidth = 4)
    line4 = lines!(x, -cos.(x), color = x / 2, colormap = :plasma, linewidth = 4)
    labels = [L"x", L"\sqrt{x}", L"x^{2}", L"x/2"]
    cbar1 = Colorbar(fig, line1, label = labels[1], width = 10, ticksize = 5)
    cbar2 = Colorbar(fig, line2, label = labels[2], flipaxis = false,
        height = Relative(3.5 / 4), width = 10, ticksize = 10)
    cbar3 = Colorbar(fig, line3, label = labels[3], vertical = false, ticksize = 10,
        tickalign = 0, flipaxis = false, width = Relative(4 / 4), height = 10,
        tickcolor = :red)
    cbar4 = Colorbar(fig, line4, label = labels[4], vertical = false,
        width = Relative(3 / 4), height = 10, ticksize = 10, tickalign = 1)
    fig[1, 2] = cbar4
    fig[2, 1] = cbar2
    fig[2, 2] = ax
    fig[2, 3] = cbar1
    fig[3, 2] = cbar3
    colgap!(fig.layout, 5)
    rowgap!(fig.layout, 5)
    ## display(fig)
    save(joinpath(@OUTPUT, "MultipleMulticoloredLineCbarAround.svg"), fig) # HIDE
end;
# \fig{MultipleMulticoloredLineCbarAround.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
