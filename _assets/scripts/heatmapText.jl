# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(123)
    m = 15
    n = 5
    data = rand(m,n)
    # some fake ticks
    alphabet = 'A':'E' 
    yticks = string.(collect(alphabet))
    k = 4
    itr = Iterators.product(ntuple(_ -> alphabet, k)...)
    xticks = []
    for word in Base.Generator(join, itr)
        push!(xticks, word)
        if length(xticks) == m
            break
        end
    end
    xticks = string.(xticks)

    fig = Figure(resolution = (1200, 600), fontsize = 20)
    ax = Axis(fig)
    hmap = heatmap!(ax, data, colormap = :plasma)
    for i in 1:15, j in 1:5
        if data[i,j] < 0.15
            txtcolor = :white
        else
            txtcolor = :black
        end
        text!(ax, "$(round(data[i,j], digits = 2))", position = (i,j),
            color = txtcolor, align = (:center, :center))
    end

    cbar = Colorbar(fig, hmap, label = "values", width = 15,
                ticksize=15, tickalign = 1, height = Relative(3.55/4))
    ax.xticks = (1:m, xticks)
    ax.yticks = (1:n, yticks)
    ax.xticklabelrotation = π/3
    #ax.xticklabelsize = 12
    #ax.xticklabelalign = (:center, :center)
    #ax.xticklabelpad = 20
    fig[1, 1] = ax
    fig[1, 2] = cbar
    colgap!(fig.layout, 7)
    fig
    save(joinpath(@__DIR__, "output", "heatmapText.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
