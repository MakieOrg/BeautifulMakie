# ## twin axis

# ![](line_twin_axis.svg)

using CairoMakie
CairoMakie.activate!(type = "svg") #hide

fig = Figure(size = (600, 400))
ax1 = Axis(fig[1, 1], yticklabelcolor = :black, rightspinevisible = false)
ax2 = Axis(fig[1, 1], yaxisposition = :right,
    yticklabelcolor = :dodgerblue,
    rightspinecolor = :dodgerblue,
    ytickcolor = :dodgerblue)
lines!(ax1, 0 .. 10, x -> x; color = :black)
lines!(ax2, 0 .. 10, x -> exp(-x); color = :dodgerblue)
hidespines!(ax2, :l, :b, :t)
hidexdecorations!(ax2);
save("line_twin_axis.svg", fig); # hide