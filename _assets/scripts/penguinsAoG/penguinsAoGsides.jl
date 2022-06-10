# by Lazaro Alonso # HIDE
using Pkg # HIDE
Pkg.activate(@__DIR__) # HIDE #
Pkg.add(["CairoMakie","PalmerPenguins", "DataFrames", "AlgebraOfGraphics"]) # HIDE
using PalmerPenguins, DataFrames, AlgebraOfGraphics, CairoMakie
let
    penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    ychi = filter(:species => x -> x == "Chinstrap", penguins)[!,:bill_depth_mm]
    yade = filter(:species => x -> x == "Adelie", penguins)[!,:bill_depth_mm]
    ygen = filter(:species => x -> x == "Gentoo", penguins)[!,:bill_depth_mm]

    penguin_bill = data(penguins) * mapping(:bill_length_mm  => "bill length mm",
        :bill_depth_mm  => "bill depth mm")

    layers = AlgebraOfGraphics.density() * visual(Contour) + linear() +
                visual(alpha = 0.5, markersize = 15)
    aesPoints = penguin_bill * layers * mapping(color = :species, marker = :species,)
    aesHist = data(penguins) * mapping(:bill_length_mm  => "bill length mm",
        color = :species, stack = :species) * AlgebraOfGraphics.histogram(;bins = 20)

    estilo = (color=["#FC7808", "#8C00EC", "#107A78"],
                marker=[:circle, :utriangle, :rect])
    # the actual plot with AoG and Makie
    fig = Figure(; resolution = (700, 700))
    axP = draw!(fig[2,1], aesPoints, palettes = estilo)
    axH = draw!(fig[1,1], aesHist, palettes = estilo)
    ax1 = Axis(axH[1,1])
    ax2 = Axis(axP[1,1])

    ax3 = Axis(fig[2,2],xgridstyle=:dash,ygridstyle=:dash,xtickalign=1, ytickalign=1)
    chin = density!(ax3, ychi, direction = :y, color =("#8C00EC", 0.25),
            strokewidth = 1, strokecolor = "#8C00EC")
    ade = density!(ax3, yade, direction = :y, color =("#FC7808", 0.25),
            strokewidth = 1, strokecolor = "#FC7808")
    gen = density!(ax3, ygen, direction = :y, color =("#107A78", 0.25),
            strokewidth = 1, strokecolor = "#107A78")
    leg = Legend(fig, [chin,ade,gen], ["Chinstrap", "Adelie", "Gentoo"],)
    fig[1,2] = leg
    limits!(ax2, 30, 60, 10, 25)
    xlims!(ax1, 30,60)
    ylims!(ax3, 10, 25)
    hidexdecorations!(ax1, ticks = false, grid = false)
    hideydecorations!(ax3, ticks = false, grid = false)
    hidespines!(ax3, :b,:r,:t)
    hidespines!(ax1, :l,:r,:t)
    colsize!(fig.layout, 1, Relative(3/4))
    rowsize!(fig.layout, 1, Relative(1/4))
    fig
    save(joinpath(@__DIR__, "output", "penguinsAoGsides.png"), fig) # HIDE
end
Pkg.status() # HIDE
Pkg.activate() # HIDE
