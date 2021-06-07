# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie, ArchGDAL
GLMakie.activate!() # HIDE
let
    dataset = ArchGDAL.read("./data/fuji.tif")
    # just in case you want to know more about the file structure
    #ArchGDAL.read("fuji.tif") do ds
    #    println(ArchGDAL.gdalinfo(ds))
    #end
    dataset_read = ArchGDAL.read(dataset)
    topo = dataset_read[:,end:-1:1];

    fig, ax, pltobj = lines(topo[561,50:end-30], linewidth = 0.85,
        figure = (resolution = (800,1000),backgroundcolor = :black,),
        axis = (backgroundcolor = :black,))
    c = 560
    for i in 1:1:560
        lines!(ax, topo[i,50:end-30] .+ 15*c, linewidth = 0.85, overdraw = true,
            colorrange = (minimum(topo), maximum(topo)),
            color = topo[i,50:end-30], colormap = :turbo) # :linear_bmy_10_95_c78_n256
        c -= 1
    end
    text!(ax,"Fuji", position = (250, 0),color = :white, textsize = 24)
    text!(ax,"Visualization by",position=(0, -20),color = :white,textsize = 12)
    text!(ax,"@LazarusAlon", position = (0, -200),color = :white,textsize = 12)
    hidedecorations!(ax)
    hidespines!(ax)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
    #save("FigTOPOFuji.png", fig, px_per_unit = 2) # HIDE
    save(joinpath(@__DIR__, "output", "topoLinesFuji.png"), fig, px_per_unit = 2.0) # HIDE
end

using Pkg # HIDE
Pkg.status(["GLMakie","ArchGDAL"]) # HIDE
