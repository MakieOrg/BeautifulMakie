using CairoMakie
using Colors
function light_dark_colors(alpha=1.0)
    colors = [RGB(0.3, 0.3, 0.3), RGB(0.082, 0.643, 0.918), RGB(0.91, 0.122, 0.361),
              RGB(0.929, 0.773, 0.0), RGB(0.588, 0.196, 0.722), RGB(0.361, 0.722, 0.361),
              RGB(0.622, 0.622, 0.622)]
    @. RGBAf(red(colors), green(colors), blue(colors), alpha)
end

"""
    theme_light_dark()()::Attributes
A theme by Lazaro Alonso (`@lazarusa`).
Code to set the theme to `theme_light_dark` is as follows: `Makie.set_theme!(theme_light_dark())`.
The first 3 colours in the palette definition are close to the ones used in the logo of Makie. The other two are close to those of the Julia logo.
"""
function theme_light_dark()
    my_colors = light_dark_colors(0.8)
    my_markers = [:circle, :utriangle, :rect, :diamond, :dtriangle, :diamond, :pentagon]
    my_linestyle = [:solid, :dash, :dot, :dashdot, :dashdotdot, :dash]
    cycle1 = Cycle([:color, :linestyle], covary=true)
    cycle2 = Cycle([:color, :marker, :strokecolor], covary=true)
    cycle3 = Cycle([:color, :marker, :linestyle, :strokecolor], covary=true)
    cycle4 = Cycle([:color, :linestyle, :strokecolor], covary=true)
    cycle5 = Cycle([:color, :marker, :stemcolor, :stemlinestyle], covary=true)
    Theme(
        palette=(color=my_colors, marker=my_markers, linestyle=my_linestyle,
            strokecolor=my_colors, patchcolor = my_colors,
            stemcolor = my_colors, stemlinestyle=my_linestyle,
            mediancolor = my_colors, whiskercolor = my_colors),
        Lines=(cycle=cycle1,),
        Scatter=(cycle=cycle2,),
        ScatterLines = (cycle=cycle3,),
        Density = (cycle = cycle4,),
        BarPlot = (cycle = Cycle([:color, :strokecolor], covary=true),),
        BoxPlot = (cycle = Cycle([:color, :strokecolor, :whiskercolor], covary=true),),
        Errorbars = (cycle = [:color],),
        Hist = (cycle = Cycle([:color, :strokecolor], covary=true),),
        Stairs = (cycle=cycle1,),
        Stem= (cycle=cycle5,),
        Text = (cycle = [:color],),
        Violin = (cycle = [:color, :strokecolor, :mediancolor],),
        strokewidth=0.5,
        colormap= Reverse(:Hokusai3),
        backgroundcolor = :transparent,
        textcolor = :grey45,
        linecolor = :grey45,
        Axis = (
            backgroundcolor = :transparent,
            xlabel = "x",
            ylabel = "y",
            xtickalign=0.5,
            ytickalign=0.5,
            yticksize=15,
            xticksize=15,
            xminorgridvisible = true,
            yminorgridvisible = true,
            bottomspinecolor = :grey45,
            topspinecolor = :grey45,
            leftspinecolor = :grey45,
            rightspinecolor = :grey45,
            xgridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            ygridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            xtickcolor = :grey45,
            ytickcolor = :grey45,
            xminorgridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            yminorgridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            xminortickcolor = :grey45,
            yminortickcolor = :grey45,
        ),
        Legend=(framecolor=(:black, 0.35),
            backgroundcolor=(:white, 0.1)),
        Axis3 = (
            zlabelrotation = 0π,
            xlabeloffset = 50,
            ylabeloffset = 55,
            zlabeloffset = 70,
            perspectiveness = 0.5f0,
            azimuth = 1.275π * 1.77,
            xgridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            ygridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            zgridcolor = RGBAf(0.55, 0.55, 0.55, 0.16),
            xspinecolor_1 = :grey45,
            yspinecolor_1 = :grey45,
            zspinecolor_1 = :grey45,
            xspinecolor_2 = :grey45,
            yspinecolor_2 = :grey45,
            zspinecolor_2 = :grey45,
            xspinecolor_3 = :grey45,
            yspinecolor_3 = :grey45,
            zspinecolor_3 = :grey45,
            xticklabelpad = 3,
            yticklabelpad = 3,
            zticklabelpad = 6,
            xtickcolor = :grey45,
            ytickcolor = :grey45,
            ztickcolor = :grey45,
        ),
        Colorbar=(
            label = "f(x,y)",
            ticksize=15,
            tickalign=0.5,
            spinewidth=0.0,
            minorticksvisible= true,
            tickcolor = :grey45,
            minortickcolor = :grey45,
            spinecolor = :grey45,
            topspinecolor = :grey45,
            bottomspinecolor = :grey45,
            leftspinecolor = :grey45,
            rightspinecolor = :grey45,
            ),
        LScene = (
            show_axis = true,
            backgroundcolor = (:white,0.1)
    )
    )
end