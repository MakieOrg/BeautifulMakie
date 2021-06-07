# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    testField(x,y) = Point(-x, 2y) # x'(t) = -x, y'(t) = 2y
    x =  -2:0.1:4
    y =  -2:0.1:2
    u2(x,y) = -x
    v2(x,y) = 2y
    z = [log10(sqrt(u2(x,y)^2 + v2(x,y)^2)) for x in x, y in y]

    fig = Figure(resolution = (700, 450), fontsize = 18, font = "sans")
    ax = fig[1, 1] = Axis(fig, xlabel = "x", ylabel = "y")
    fs = heatmap!(ax, x, y, z, colormap = Reverse(:plasma))
    streamplot!(ax, testField, x, y, colormap = Reverse(:plasma),
        gridsize= (32,32), arrow_size = 10)
    #limits!(ax, -2, 4, -2, 2)
    cbar = fig[1,2] = Colorbar(fig, fs, label = "log10[(u²+v²)½]",
        labelsize = 14, ticklabelsize=14)
    cbar.width = 20
    colgap!(fig.layout, 5)
    #save("Fig2Lines.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "streamplotAndHeatmap.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
