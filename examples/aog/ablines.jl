using CairoMakie, AlgebraOfGraphics
CairoMakie.activate!(type = "svg") #hide

# Following the syntax from https://docs.makie.org/v0.18.0/examples/plotting_functions/ablines/index.html
# for ablines, we reproduce that plot with AoG
p_1to1 =  mapping([0],[1]) * visual(ABLines) # declare data-arguments and visual layer
## declare the dataset
p_not1to1  = data((; intercepts = [1,2,3], slopes=[1,1.5,2]))
## declare the arguments of the analysis
p_not1to1 *= mapping(:intercepts, :slopes, color=:intercepts => nonnumeric)
## define your visual layer, what kind of plot do you want?
p_not1to1 *= visual(ABLines, color = [:red, :blue, :orange], linestyle=:dash)

with_theme(theme_ggplot2(), size = (600,400)) do
    p_1to1 + p_not1to1 |> draw
end

save("ablines1.svg", current_figure()); # hide

# ![](ablines1.svg)

with_theme(theme_ggplot2(), size = (600,400)) do
    fig = Figure()
    ax = Axis(fig[1,1])
    aog = draw!(ax, p_1to1 + p_not1to1)
    scatter!(ax, 10*rand(10), 10*rand(10); color=:red, label = "scatter")
    limits!(ax, 0, 10, 0, 10)
    legend!(fig[1, 2], aog)
    Legend(fig[1,2], ax, valign = 0.2)
    fig
end

save("ablines2.svg", current_figure()); # hide
# ![](ablines2.svg)