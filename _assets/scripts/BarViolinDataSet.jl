# by Lazaro Alonso
using CairoMakie, RDatasets, Colors, ColorSchemes
CairoMakie.activate!() #HIDE
let
    airquality = dataset("datasets", "airquality")
    categories = ["Ozone", "Solar.R", "Wind", "Temp"]
    colors = to_colormap(:Set1, length(categories))

    fig = Figure(resolution = (600, 800))
    axs = [Axis(fig[i,1], xticks = (1:length(categories), categories)) for i in 1:2]
    for (indx, f) in enumerate(categories)
        datam = filter(x -> x !== missing, airquality[:, f])
        a = fill(indx, length(datam))
        boxplot!(axs[1], a, datam; whiskerwidth = 1, width = 0.35,
            color = (colors[indx], 0.45), whiskercolor = (colors[indx], 1),
            mediancolor = :black) #show_outliers=false
        violin!(axs[2], a, datam; width = 0.35, color = (colors[indx], 0.45),
            strokecolor = colors[indx], show_median = true, mediancolor = :black)
    end
    display(fig)
    save(joinpath(@__DIR__, "output", "BarViolinDataSet.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "RDatasets", "Colors", "ColorSchemes"]) # HIDE
