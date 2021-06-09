# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, ColorSchemes
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,50) # with 50 points in the interval.
    fig = Figure(resolution = (1200, 800), font =:sans, fontsize = 22)
    ax = Axis(fig, xlabel = "x", ylabel = "y")

    line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 4)
    line2 = lines!(x, cos.(x), color = sqrt.(x),  colormap = :ice,linewidth = 4)
    line3 = lines!(x, -sin.(x), color = x.^2, colormap = :viridis,linewidth = 4)
    line4 = lines!(x, -cos.(x), color = x/2, colormap = :plasma,linewidth = 4)
    #lineas = [line1, line2, line3, line4]
    labels = ["x", "sqrt(x)", "x²", "x/2"]
    cbar1 = Colorbar(fig, line1, label = labels[1], width = 25, ticksize=20)
    cbar2 = Colorbar(fig, line2, label = labels[2], flipaxis = false,
        height = Relative(3.5/4), width = 25, ticksize=20)
    cbar3 = Colorbar(fig, line3, label = labels[3], vertical = false, ticksize=20,
        tickalign=0, flipaxis = false, width = Relative(4/4), height = 20,
        tickcolor = :red)
    cbar4 = Colorbar(fig, line4, label = labels[4], vertical = false,
        width = Relative(3/4), height = 20,ticksize=20, tickalign=1,
        # cbar's frame
        topspinevisible = false,
        bottomspinevisible = true,
        leftspinevisible = false,
        rightspinevisible = true)
    fig[1, 2] = cbar4
    fig[2, 1] = cbar2
    fig[2, 2] = ax
    fig[2, 3] = cbar1
    fig[3, 2] = cbar3
    colgap!(fig.layout, 15)
    fig
    #save("MultipleMulticoloredLineCbarAround.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "MultipleMulticoloredLineCbarAround.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
