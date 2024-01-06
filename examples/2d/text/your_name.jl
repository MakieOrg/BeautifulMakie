# ## text: rich text

# ![](your_name.svg)

using GLMakie
using CairoMakie
CairoMakie.activate!(type = "svg")
#GLMakie.activate!()

fig = Figure(figure_padding= 0, size = (320, 48),
    backgroundcolor=:transparent,
    fontsize = 48)
ax = Axis(fig[1,1], backgroundcolor=:transparent)
text!(ax, [0], [0],
    text= rich(rich("Your", font="Bold"), " Name", font =:regular),
    align = (:center, :center), color = :white, padding=0)
hidedecorations!(ax)
hidespines!(ax)
fig

save("your_name.svg", fig); # hide