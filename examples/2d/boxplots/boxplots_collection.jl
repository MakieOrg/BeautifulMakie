# ## boxplot collection: Normal distributions

# ![](boxplot_collection.svg)

using CairoMakie, Random, Distributions
CairoMakie.activate!(type = "svg") #hide

Random.seed!(13)
n = 3000
colors = resample_cmap(:spring, 8)[3:end]

fig = Figure(; size = (600, 400))
ax = Axis(fig[1,1]; # palette = (; patchcolor = colors), 
    xticks = (1:7, ["cat 1", "A", "B", "C", "D", "E", "F"]), 
    yticks = ([-5], ["cat 2"]), yticklabelrotation = π/2)
boxplot!(ax, fill(-5,n), rand(Normal(0, 0.5), n); orientation=:horizontal, 
    whiskerwidth = 1, width = 2, #color = (:orange, 0.95), 
    whiskercolor = :red, mediancolor = :yellow, markersize = 8, 
    strokecolor = :black, strokewidth = 1, label = "horizontal")
boxplot!(ax, fill(1,n), rand(Normal(1,  3), n); whiskerwidth = 1, 
    width = 0.5, color = :dodgerblue, whiskercolor = :dodgerblue, 
    mediancolor = :grey20, markersize = 5, strokecolor = :grey20, 
    strokewidth = 1, label = "vertical")
for i in 2:7
    boxplot!(ax, fill(i,n), rand(Normal(rand(-2:5), 2*rand() + 0.3), n); 
        whiskerwidth = 1, width = 0.35)
end
axislegend(ax, position = :lt)
fig
save("boxplot_collection.svg", fig); # hide