using CairoMakie, AlgebraOfGraphics
CairoMakie.activate!(type = "svg") #hide

# Here I try to follow as much as possible the [philosophy](https://aog.makie.org/stable/philosophy/) of AoG.
# from [here](https://aog.makie.org/stable/gallery/gallery/basic%20visualizations/lines_and_markers/#Lines-and-markers)

## create some data
x = range(-π, π, length=50)
y = sin.(x)
df = (; x, y)
## declare the dataset
xy  = data(df) 
## declare the arguments of the analysis
xy *= mapping(:x, :y)
## define your visual layer, what kind of plot do you want?
xy *= visual(ScatterLines)
## draw your figure
with_theme(theme_ggplot2(), size = (600,400)) do
    xy |> draw
end
save("scatterlinesAoG.svg", current_figure()); # hide

# ![](scatterlinesAoG.svg)