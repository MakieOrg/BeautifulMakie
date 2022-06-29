md"""
## EarthDataLab
"""
## by Lazaro Alonso

using CairoMakie, EarthDataLab
CairoMakie.activate!() # HIDE
let
    cube = esdc()
    cubeTemP = subsetcube(cube, variable=["air_temperature_2m", "precipitation"],
        time=Date(2003, 1, 1))
    ## data_preci = readcubedata(cubeTemP)
    ## datpreci = data_preci.data
    lon = getAxis("lon", cubeTemP).values
    lat = getAxis("lat", cubeTemP).values
    ## time = getAxis("time", cube).values;
    precipitation = cubeTemP[var="precipitation"].data[:, :]
    temperature = cubeTemP[var="air_temperature_2m"].data[:, :]

    fig = Figure(resolution=(1250, 1200), font="sans", fontsize=24)
    ax1 = Axis(fig[1, 1], xlabel="lon", ylabel="lat")
    ax2 = Axis(fig[2, 1], xlabel="lon", ylabel="lat")

    map1 = heatmap!(ax1, lon, lat, temperature, colormap=:plasma)
    cbar1 = Colorbar(fig[1, 2], map1, label="temperature", ticklabelsize=18,
        labelpadding=5, width=10)
    map2 = heatmap!(ax2, lon, lat, precipitation, colormap=:turbo,
        colorrange=(5, 30))
    cbar2 = Colorbar(fig[2, 2], map2, label="precipitation", ticklabelsize=18,
        labelpadding=5, width=10) ## scale = log10 not working properly

    ax1.xticks = -180:60:180
    ax1.yticks = -90:30:90
    ax1.xtickformat = "{:d}ᵒ"
    ax1.ytickformat = "{:d}ᵒ"
    ax2.xticks = -180:60:180
    ax2.yticks = -90:30:90
    ax2.xtickformat = "{:d}ᵒ"
    ax2.ytickformat = "{:d}ᵒ"
    hidespines!(ax1, :t, :r)
    hidexdecorations!(ax1, ticks=false)
    hidespines!(ax2, :t, :r)
    save(joinpath(@OUTPUT, "temPrecESDL.png"), fig) # HIDE
end;
# \fig{temPrecESDL.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "EarthDataLab"]) # HIDE
