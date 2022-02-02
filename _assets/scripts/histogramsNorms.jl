# by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n = 3000
    data = randn(n)
    normf = [:none, :pdf, :density, :probability]
    colors = Makie.wong_colors()
    fig = Figure(resolution = (1200, 800), font = "sans", fontsize = 20)
    axs = [Axis(fig[i, j], xlabel = i==2 ? "value" : "") for i in 1:2 for j in 1:2]
    [hist!(axs[i], data; normalization = normf[i], color = colors[i],
        label = "$(normf[i])") for i in 1:4]
    [axislegend(axs[i], position = :rt) for i in 1:4]
    display(fig)
    save(joinpath(@__DIR__, "output", "histogramsNorms.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
