# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, GeoDatasets
CairoMakie.activate!() # HIDE
let
    lon, lat, data = GeoDatasets.landseamask(;resolution='c',grid=10)
    fig = Figure(resolution = (1250,700), fontsize = 25)
    ax = Axis(fig, xlabel = "lon", ylabel = "lat", xtickalign = 1,
        ytickalign = 1, xticksize=15, yticksize=15, spinewidth = 0.75)
    cmap = cgrad(:Greys_4, 3, categorical = true, rev = false)
    pltobj = heatmap!(ax, lon, lat, data, colormap = cmap)
    cbar   = Colorbar(fig, pltobj, width = 11,ticklabelsize = 25,tickalign =1,
        spinewidth = 0.5, ticks = ([0.35,1,1.65],["Ocean", "Land", "Lakes"]),
        ticklabelrotation = Quaternionf0(0,0,0,0)) #
    limits!(ax, round(lon[1]), round(lon[end]), round(lat[1]), round(lat[end]))
    hidespines!(ax, :t, :r)
    ax.xticks = -180:60:180
    ax.yticks = -90:30:90
    ax.xtickformat = "{:d}ᵒ"
    ax.ytickformat = "{:d}ᵒ"
    fig[1,1] = ax
    fig[1,2] = cbar
    fig
    save(joinpath(@__DIR__, "output", "landSea.png"), fig, px_per_unit = 2.0) # HIDE
end


using Pkg # HIDE
Pkg.status(["CairoMakie","GeoDatasets"]) # HIDE
