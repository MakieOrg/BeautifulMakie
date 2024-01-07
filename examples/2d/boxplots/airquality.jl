# ## boxplots for airquality data

# ![](airquality.svg)

using CairoMakie, RDatasets, Colors, ColorSchemes
CairoMakie.activate!(type = "svg") #hide

airquality = dataset("datasets", "airquality")
categories = ["Ozone", "Solar.R", "Wind", "Temp"]
colors = categorical_colors(:Set1, length(categories))

fig = Figure(size = (600, 400))
ax = Axis(fig[1, 1], xticks = (1:length(categories), categories))
for (indx, f) in enumerate(categories)
    datam = filter(x -> x !== missing, airquality[:, f])
    a = fill(indx, length(datam))
    boxplot!(ax, a, datam; whiskerwidth = 1, width = 0.35,
        color = (colors[indx], 0.45), whiskercolor = (colors[indx], 1),
        mediancolor = :black)
end
fig
save("airquality.svg", fig); # hide