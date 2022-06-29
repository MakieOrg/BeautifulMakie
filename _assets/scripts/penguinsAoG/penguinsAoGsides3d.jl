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

    penguin_bill = data(penguins) * mapping( :bill_length_mm  => "bill length mm",
        :bill_depth_mm  => "bill depth mm")

    layers = AlgebraOfGraphics.density() * visual(Contour) + linear() +
                visual(alpha = 0.5, markersize = 15)
    aesPoints = penguin_bill * layers * mapping(color = :species, marker = :species,)
    aesHist = data(penguins) * mapping(:bill_length_mm => "bill length mm",
        color = :species, stack = :species) * AlgebraOfGraphics.histogram(;bins = 20)

    estilo = (color=["#FC7808", "#8C00EC", "#107A78"],
                marker=[:circle, :utriangle, :rect])

    layer = AlgebraOfGraphics.density() * visual(Wireframe, linewidth=0.05)
    plt3d = penguin_bill * layer * mapping(color = :species)
    # the actual plot with AoG and Makie
    set_aog_theme!()
    fig = Figure(; resolution = (700, 700))
    aes3d = draw!(fig[2,1], plt3d; axis = (type = Axis3,), palettes = estilo)
    aesH = draw!(fig[1,1], aesHist, palettes = estilo)
    ax1 = Axis(aesH[1,1])
    ax2 = Axis(aes3d[1,1])

    ax3 = Axis(fig[2,2], ylabel = "bill depth mm")
    chin = density!(ax3, ychi, direction = :y, color =("#8C00EC", 0.25),
        strokewidth = 1, strokecolor = "#8C00EC")
    ade = density!(ax3, yade, direction = :y, color =("#FC7808", 0.25),
        strokewidth = 1, strokecolor = "#FC7808")
    gen = density!(ax3, ygen, direction = :y, color =("#107A78", 0.25),
        strokewidth = 1, strokecolor = "#107A78")
    leg = Legend(fig, [chin,ade,gen], ["Chinstrap", "Adelie", "Gentoo"],)
    fig[1,2] = leg
    colsize!(fig.layout, 1, Relative(3/4))
    rowsize!(fig.layout, 1, Relative(1/4))
    fig
    save(joinpath(@__DIR__, "output", "penguinsAoGsides3d.png"), fig) # HIDE
end
Pkg.status() # HIDE
Pkg.activate() # HIDE
