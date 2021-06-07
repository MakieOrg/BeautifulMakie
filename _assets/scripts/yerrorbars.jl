# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(145)
    x, y = 1:2:20, 5*rand(10)
    yerr, xerr = 0.4*abs.(randn(10)), abs.(randn(10))
    fig = Figure(resolution = (700, 450), font = "sans")
    ax = Axis(fig, xlabel = "variable", ylabel = "values", xgridstyle=:dash,
        ygridstyle=:dash,)
        errorbars!(ax, x, y, yerr, whiskerwidth = 12, color = yerr,
        linewidth = 2, colormap = :plasma)
    scatter!(ax, x, y, color = :black)
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "yerrorbars.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
