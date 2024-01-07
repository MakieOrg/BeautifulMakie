# ## stripped bars

# ![](stripped_bars.png)

## This currently fails with CairoMakie
## https://discourse.julialang.org/t/striped-colors-for-e-g-bar-plots-in-julia/64435/3
using GLMakie.Makie, GLMakie, Random
GLMakie.activate!()
GLMakie.closeall() # close any open screen
Random.seed!(13)
## patterns
## `'/'`, `'\\'`, `'-'`, `'|'`, `'x'`, and `'+'`
directions = [Vec2f(1), Vec2f(1, -1), Vec2f(1, 0), Vec2f(0, 1),
    [Vec2f(1), Vec2f(1, -1)], [Vec2f(1, 0), Vec2f(0, 1)]]
colors = [:white, :orange, (:green, 0.5), :yellow, (:blue, 0.85), :black]
## then defining the patches are defined by calling LinePattern
patternColors = [Makie.LinePattern(direction = hatch; width = 5, tilesize = (20, 20),
    linecolor = colors[indx], background_color = colors[end-indx+1])
        for (indx, hatch) in enumerate(directions)];

## We could start with normal barplots
fig, ax, pltobj = barplot(1:2, strokewidth = 2, color = ["grey", "orange"],
    figure = (; size = (600, 400)))
## and then append new bars with the patterns defined above
for (idx, pattern) in enumerate(patternColors)
    barplot!(ax, [idx + 2], [idx * (2rand() + 1)], color = pattern, strokewidth = 2)
end
## change x ticks at every bar
ax.xticks = (1:8, ["grey", "orange", "/", "\\", "-", "|", "x", "+"])
fig
save("stripped_bars.png", fig); # hide