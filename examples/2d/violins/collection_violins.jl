using CairoMakie, Distributions, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(124)
n = 4
colors = resample_cmap(:seaborn_colorblind, 8)
sides = [:left, :right, :right]

fig = Figure(size = (600,400))
ax = Axis(fig[1,1]; #palette = (; patchcolor = colors)
    )
for i in [-5,5], j in 1:n
    violin!(fill(j, 1000), rand(Normal(i,rand()+0.5), 1000),
    side = i >-3 ? sides[rand(1:3)] : :both
    )
end
violin!(fill(2.5, 1000), rand(Normal(0,2.5), 1000); color = :transparent,
    strokewidth = 0.85, strokecolor = :grey10, show_median = true, 
    mediancolor = :black)
violin!(fill(4.5, 1000), rand(Normal(2,2), 1000); color = (:dodgerblue,0.1),
    strokewidth = 0.85, strokecolor = :dodgerblue, show_median = true,
    medianlinewidth = 3)
ax.xticks = (1:n, string.('A':'D'))
hideydecorations!(ax; grid = false) 
fig
save("collection_violins.svg", fig); # hide

# ![](collection_violins.svg)