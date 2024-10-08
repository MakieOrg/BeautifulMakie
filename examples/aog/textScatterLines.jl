using AlgebraOfGraphics, CairoMakie
using Random, DataFrames
CairoMakie.activate!(type = "png") #hide

Random.seed!(134)
## from this [post](https://discourse.julialang.org/t/how-to-make-this-plot-in-julia/75065/22).
d = DataFrame(name = repeat(["A","B","C","D","E","F"], inner=4), 
      time=repeat([0,1,3,6], outer=6), value = rand(24));

pSL = data(d)
pSL *= mapping(:time, :value)
pSL *= mapping(color = :name) * visual(ScatterLines) +
    mapping(color = :name, text = :name => verbatim) * visual(Makie.Text, align = (:center, :bottom))
with_theme(theme_ggplot2(), size = (600,400)) do
    draw(pSL)
end

save("textScatterLines.png", current_figure()); # hide

# ![](textScatterLines.png)