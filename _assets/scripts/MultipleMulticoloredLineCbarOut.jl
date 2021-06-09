# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, ColorSchemes
CairoMakie.activate!() # HIDE
let
    x = LinRange(0,2π,50) # with 50 points in the interval.
    fig = Figure(resolution = (1200, 600), font =:sans, fontsize = 22)
    ax = Axis(fig, xlabel = "x", ylabel = "")
    line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 2)
    line2 = lines!(x, cos.(x), color = sqrt.(x),  colormap = :ice,linewidth = 2)
    line3 = lines!(x, -sin.(x), color = x.^2, colormap = :viridis,linewidth = 2)
    line4 = lines!(x, -cos.(x), color = x/2, colormap = :plasma,linewidth = 2)
    lineas = [line1, line2, line3, line4]
    labels = ["x", "sqrt(x)", "x²", "x/2"]
    cbars = [Colorbar(fig, lineas[i], label = labels[i]) for i in 1:4]
    fig[1, 1] = ax
    fig[1, 2] = cbars[1]
    fig[1, 3] = cbars[2]
    fig[1, 4] = cbars[3]
    fig[1, 5] = cbars[4]
    colgap!(fig.layout, 15)
    fig
    #save("MultipleMulticoloredLineCbarOut.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "MultipleMulticoloredLineCbarOut.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
