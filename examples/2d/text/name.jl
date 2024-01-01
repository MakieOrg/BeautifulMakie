using GLMakie
using CairoMakie
CairoMakie.activate!()
#GLMakie.activate!()

fig = Figure(figure_padding= 0, resolution = (320, 48),
    backgroundcolor=:transparent,
    fontsize = 48)
ax = Axis(fig[1,1], backgroundcolor=:transparent)
text!(ax, [0], [0],
    text= rich(rich("Lazaro", font="Bold"), " Alonso", font =:regular),
    align = (:center, :center), color = :white, padding=0)
hidedecorations!(ax)
hidespines!(ax)
fig

save("logo_lazaro.svg", fig)