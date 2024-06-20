# ## density plot

# ![](density.png)

using CairoMakie, Distributions, Random
CairoMakie.activate!(type = "png") #hide

Random.seed!(124)
colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]
μσpairs = [[2,0.5], [-1,2], [0.25,1], [1,0.1], [1, 0.05], [1.2,0.1]]

fig = Figure(; size = (600,400))
ax = Axis(fig[1,1]; palette = (; patchcolor = tuple.(colors, 0.45)))
for (idx, μσ) in enumerate(μσpairs)
    density!(rand(Normal(μσ...), 1000), strokewidth = 1.5, 
        strokecolor = :grey20, direction = idx > 3 ? :x : :y, 
        linestyle = idx > 3 ? :dash : :solid, 
        label = "$(μσ[1]),  $(μσ[2])")
end
axislegend(L"\mu,\quad\sigma"; position= :cb, titlesize= 22)
hidedecorations!(ax; grid = false)
fig
save("density.png", fig); # hide