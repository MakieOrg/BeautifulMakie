# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, RDatasets, Colors, ColorSchemes
CairoMakie.activate!() #HIDE
let
    airquality = dataset("datasets", "airquality")
    categories = ["Ozone", "Solar.R", "Wind", "Temp"]
    colors = ColorScheme(range(colorant"black", colorant"red",
                length=length(categories)))

    fig = Figure(resolution = (700, 800), font = "sans")
    ax1 = Axis(fig, xlabel = "variable", ylabel = "",
            xticks = (1:length(categories), categories))
    ax2 = Axis(fig, xlabel = "variable", ylabel = "",
            xticks = (1:length(categories), categories))

    for (indx,f) in enumerate(categories)
        datam = []
        for v in airquality[:,f]
            if v !== missing
                push!(datam, v)
            end
        end
        a = fill(indx, length(datam))
        boxplot!(ax1, a, Float32.(datam); whiskerwidth = 1, width = 0.35,
         color = (colors[indx], 0.45), whiskercolor = (colors[indx], 1),
         mediancolor = :black) #show_outliers=false
        violin!(ax2,a,Float32.(datam);width = 0.35,color =(colors[indx], 0.45),
            strokecolor = colors[indx],show_median = true,mediancolor = :black)
    end
    fig[1,1] = ax1
    fig[2,1] = ax2
    fig
    #save("FigAirqualityBox.png", fig, px_per_unit = 2) # HIDE
    save(joinpath(@__DIR__, "output", "BarViolinDataSet.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "RDatasets", "Colors", "ColorSchemes"]) # HIDE
