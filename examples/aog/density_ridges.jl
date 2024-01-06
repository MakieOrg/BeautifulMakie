using GLMakie, PalmerPenguins, DataFrames
using AlgebraOfGraphics
import AlgebraOfGraphics as AoG

GLMakie.activate!()

function getPenguins()
    ## ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"
    penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    return penguins
end

penguins = getPenguins()
## declare new plot attributes
palette = (color=tuple.(["#FC7808", "#8C00EC", "#107A78"], 0.65),
    marker=[:circle, :utriangle, :rect])
cycle = Cycle([:color, :marker], covary=true)

p_len  = data(penguins) 
p_len *= AoG.density()
p_len *= mapping(:flipper_length_mm => (t -> t / 10), color=:species)

with_theme(theme_light(),size = (600,400), palette=palette, Scatter=(cycle=cycle,)) do
    p_len |> draw
end

save("densityridges1.png", current_figure()); # hide

# ![](densityridges1.png)

p_len  = data(penguins)
## p_len = AoG.density()
p_len *= mapping(:flipper_length_mm, color=:species)
p_len *= visual(AoG.Density, direction=:y, offset = 1.0,
    alpha = 0.2, strokewidth = 1.5, strokecolor = :grey20)
draw(p_len)

save("densityridges2.png", current_figure()); # hide

# ![](densityridges2.png)