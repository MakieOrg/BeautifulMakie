using CairoMakie 
fig = Figure(; resolution = (700, 700))
ax1 = Axis(fig, ylabel = "y")
ax2 = Axis(fig, xlabel = "x", ylabel = "y")
ax3 = Axis(fig, xlabel = "x", yaxisposition =:right)
pltobj1 = lines!(ax1, rand(10), rand(10), color = :red)
pltobj2 = lines!(ax2, rand(10), rand(10))
pltobt3 = lines!(ax3, rand(10), rand(10), color = :black)
leg = Legend(fig, [pltobj1, pltobj2, pltobt3],  ["one", "two", "three"], 
    tellheight = false, tellwidth = false, halign = :left, valign = :top, 
    framecolor = :orange)
fig[1,1] = ax1
fig[2,1] = ax2 
fig[2,2] = ax3
fig[1,2] = leg 
colsize!(fig.layout, 1, Relative(1/2))
rowsize!(fig.layout, 1, Relative(1/2))
fig
save("layout4.png", fig, px_per_unit = 2)