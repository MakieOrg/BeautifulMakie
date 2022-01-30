# by Lazaro Alonso
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    fig = Figure(resolution = (600, 400))
    axs = [Axis(fig[1, j], aspect = 1, xticks = [1, 10], yticks = [1, 10]) for j in 1:2]
    [heatmap!(axs[i], 1:10, 1:10, rand(10, 10); colormap = :plasma,
        colorrange = (0, 1)) for i in 1:2]
    Colorbar(fig[2, :1:2], colormap = :plasma, limits= (0,1),
        vertical = false, flipaxis = false, height = 15, tickwidth = 2,
        ticklabelsize = 14, ticks = [0, 0.5, 1])
    hideydecorations!(axs[2], ticks = false)
    display(fig)
    save(joinpath(@__DIR__, "output", "heatmap1SharedCbar.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
