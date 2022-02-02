md"""
## Single line
`linewidth, linestyle, backgroundcolor,
font, xlabelsize, ylabelsize, legend, label`
"""
## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = 1:10
    lines(x, x .^ 2; color = :black, linewidth = 2, linestyle = ".-", label = L"x^2",
        figure = (resolution = (600, 400), backgroundcolor = "#D0DFE6FF",
            font = "CMU Serif"),
        axis = (xlabel = L"x", ylabel = L"x^2", backgroundcolor = :white,
            xlabelsize = 22, ylabelsize = 22))
    axislegend("legend", position = :lt)
    limits!(0, 10, 0, 100)
    ## current_figure()
    save(joinpath(@OUTPUT, "lines1.svg"), current_figure()) # HIDE
end;

# \fig{lines1.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status("CairoMakie") # HIDE