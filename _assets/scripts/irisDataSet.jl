# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, RDatasets
let
    dset = dataset("datasets", "iris")
    byCat = dset.Species
    categ = unique(byCat)
    markers = [:circle, :diamond, :utriangle]

    fig = Figure(resolution = (700, 450))
    ax = Axis(fig, xlabel = "Sepal Length", ylabel = "Sepal Width")
    for (idx,c) in enumerate(categ)
        indc = findall(x->x == c, byCat)
        scatter!(dset.SepalLength[indc], dset.SepalWidth[indc],
            marker = markers[idx], markersize = 15, label = "$(c)")
    end
    axislegend("Species")
    fig[1,1] = ax

    save(joinpath(@__DIR__, "output", "irisDataSet.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "RDatasets"]) # HIDE
