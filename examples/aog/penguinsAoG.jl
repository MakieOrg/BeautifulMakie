using GLMakie, PalmerPenguins, DataFrames
using AlgebraOfGraphics
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
## declare the dataset
p_len  = data(penguins) 
## declare the arguments of the analysis
p_len *= mapping(:flipper_length_mm => (t -> t / 10) => "flipper length (cm)",
    :bill_length_mm => (t -> t / 10) => "bill length (cm)")
## declare the grouping and the respective visual attribute
p_len *= mapping(color=:species)

with_theme(theme_ggplot2(),size = (600,400), palette=palette, Scatter=(cycle=cycle,)) do
    draw(p_len * mapping(marker=:species) + p_len * linear(); 
        axis = (; title="Flipper and bill length"))
end

save("penguinsAoG.png", current_figure()); # hide

# ![](penguinsAoG.png)