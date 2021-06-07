# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, RDatasets, Colors, ColorSchemes
CairoMakie.activate!() #HIDE
let
    cars = dataset("datasets", "mtcars")
    byCat = cars.Cyl
    categ = unique(byCat)
    fig = Figure(resolution = (700, 850), font = "sans")
    ax1 = Axis(fig, xlabel = "MPG", ylabel = "density", xgridstyle=:dash,
            ygridstyle=:dash, rightspinevisible = false, topspinevisible = false)
    ax2 = Axis(fig, xlabel = "MPG", ylabel = "density")
    colors1 = ColorScheme(range(colorant"#65ADC2", colorant"#E84646",
                    length=length(categ)))
    colors2 = ColorScheme(range(colorant"orange", colorant"dodgerblue",
                    length=length(categ)))
    legends1 = []
    legends2 = []
    for (i,c) in enumerate(categ)
        indc = findall(x->x == c, byCat)
        line1 = density!(ax1, cars.MPG[indc], color = (colors1[i],0.5),
                    strokewidth=1.25, strokecolor = colors1[i])
        line2 = density!(ax2, cars.MPG[indc], color = (colors2[i],0.5),
                    strokewidth=1.25, strokecolor = colors2[i])
        push!(legends1, line1)
        push!(legends2, line2)
    end
    leg1 = Legend(fig, legends1, string.(categ), "Cyl", orientation = :horizontal,
    tellheight = true,tellwidth = false,framevisible = false,titleposition = :left)
    leg2 = Legend(fig, legends2, string.(categ), "Cyl")

    fig[1,1] = leg1
    fig[2,1] = ax1
    fig[3,1] = ax2
    fig[3,2] = leg2
    fig
    #save("FigAirqualityBox.png", fig, px_per_unit = 2) # HIDE
    save(joinpath(@__DIR__, "output", "DensitiesDataSet.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "RDatasets", "Colors", "ColorSchemes"]) # HIDE
