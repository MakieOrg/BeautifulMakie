# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie, NetCDF
using YAXArrays.Datasets: open_mfdataset
GLMakie.activate!() # HIDE
let
    dataset = open_mfdataset("./data/ETOPO1_halfdegree.nc")
    lon = dataset.lon.values
    lat = dataset.lat.values
    data = dataset.ETOPO1avg.data[:,:]

    fig = Figure(resolution = (1250,700),fontsize = 25, backgroundcolor = :black)
    ax = Axis3(fig, aspect = (1,0.6,0.1),azimuth = -0.65π, elevation = 0.225π)
    pltobj=surface!(ax,lon,lat, data, colormap = :starrynight, backlight = 1.0f0,
        colorrange =(-6500,5500))
    cbar  =Colorbar(fig,pltobj,label = "ETOPO1 [m]",ticklabelsize = 20,
        tickalign =1, vertical = true, ticksize=15, labelcolor = :white,
        ticklabelcolor = :white, tickcolor = :grey90, height = Relative(0.5))
    hidespines!(ax)
    hidedecorations!(ax)
    fig[1,1] = ax
    fig[1,2] = cbar
    save(joinpath(@__DIR__, "output", "topography.png"), fig, px_per_unit = 2.0) # HIDE
end

using Pkg # HIDE
Pkg.status(["GLMakie","NetCDF", "YAXArrays"]) # HIDE
