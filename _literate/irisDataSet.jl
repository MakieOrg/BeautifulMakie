# by Lazaro Alonso
using CairoMakie, RDatasets
CairoMakie.activate!()
let
    dset = dataset("datasets", "iris")
    byCat = dset.Species
    categ = unique(byCat)
    markers = [:circle, :diamond, :utriangle]

    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1, 1], xlabel = "Sepal Length", ylabel = "Sepal Width")
    for (idx, c) in enumerate(categ)
        indices = findall(x -> x == c, byCat)
        scatter!(dset.SepalLength[indices], dset.SepalWidth[indices],
            marker = markers[idx], markersize = 15, label = "$(c)")
    end
    axislegend("Species")
    ## display(fig)
    save(joinpath(@__DIR__, "output", "irisDataSet.svg"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "RDatasets"]) # HIDE
