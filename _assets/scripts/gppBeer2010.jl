# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, NetCDF
using YAXArrays.Datasets: open_mfdataset
CairoMakie.activate!() # HIDE
let
    dataset = open_mfdataset("./data/GPPdata_Beer_etal_2010_Science.nc")
    lon = dataset.lon.values
    lat = dataset.lat.values
    data = dataset.gpp.data[:,:]

    fig = Figure(resolution = (1250,700), fontsize = 25)
    ax = Axis(fig, xlabel= "lon",ylabel = "lat", xticksize=15, yticksize=15,
        xgridstyle=:dash, ygridstyle=:dash,)
    pltobj=heatmap!(ax,lon,lat,replace(data,-9999=>NaN),colormap = :Spectral_11)
    cbar  =Colorbar(fig,pltobj,label = "gpp",ticklabelsize = 25,tickalign =1)
    ax.xticks = -180:60:180
    ax.yticks = -90:30:90
    ax.xtickformat = "{:d}ᵒ"
    ax.ytickformat = "{:d}ᵒ"
    hidespines!(ax, :t, :r)
    fig[1,1] = ax
    fig[1,2] = cbar
    save(joinpath(@__DIR__, "output", "gppBeer2010.png"), fig, px_per_unit = 2.0) # HIDE
end

using Pkg # HIDE
Pkg.status(["CairoMakie","NetCDF", "YAXArrays"]) # HIDE
