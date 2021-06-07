# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, ESDL
CairoMakie.activate!() # HIDE
let
    cube = esdc()
    cubeTemP =subsetcube(cube,variable=["air_temperature_2m", "precipitation"],
        time = Date(2003,1,1))
    #data_preci = readcubedata(cubeTemP)
    #datpreci = data_preci.data
    lon = getAxis("lon", cubeTemP).values
    lat = getAxis("lat", cubeTemP).values
    #time = getAxis("time", cube).values;
    precipitation = cubeTemP[var="precipitation"].data[:,:]
    temperature = cubeTemP[var="air_temperature_2m"].data[:,:]

    fig = Figure(resolution = (1250, 1200), font = "sans", fontsize = 24)
    ax1 = Axis(fig, xlabel = "lon", ylabel = "lat")
    ax2 = Axis(fig, xlabel = "lon", ylabel = "lat")

    map1 = heatmap!(ax1, lon, lat, temperature, colormap = :plasma)
    cbar1 = Colorbar(fig, map1, label = "temperature", ticklabelsize = 18,
        labelpadding = 5, width = 10)
    map2 = heatmap!(ax2, lon, lat, precipitation, colormap = :turbo,
        colorrange = (5,30))
    cbar2 = Colorbar(fig, map2, label = "precipitation", ticklabelsize = 18,
            labelpadding = 5, width = 10) #scale = log10 not working properly

    ax1.xticks = -180:60:180
    ax1.yticks = -90:30:90
    ax1.xtickformat = "{:d}ᵒ"
    ax1.ytickformat = "{:d}ᵒ"
    ax2.xticks = -180:60:180
    ax2.yticks = -90:30:90
    ax2.xtickformat = "{:d}ᵒ"
    ax2.ytickformat = "{:d}ᵒ"
    hidespines!(ax1, :t, :r)
    hidexdecorations!(ax1, ticks = false)
    hidespines!(ax2, :t, :r)
    fig[1,1] = ax1
    fig[1,2] = cbar1
    fig[2,1] = ax2
    fig[2,2] = cbar2
    save(joinpath(@__DIR__, "output", "temPrecESDL.png"), fig, px_per_unit = 2.0) # HIDE
end

using Pkg # HIDE
Pkg.status(["CairoMakie","ESDL"]) # HIDE
