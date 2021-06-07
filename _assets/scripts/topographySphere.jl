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
    function toCartesian(lon, lat; r = 1, cxyz = (0,0,0) )
        lat, lon = lat*π/180, lon*π/180
        x = cxyz[1] + r * cos(lat) * cos(lon)
        y = cxyz[2] + r * cos(lat) * sin(lon)
        z = cxyz[3] + r *sin(lat)
        x,y,z
    end
    function lonlat3D(lon, lat, data; cxyz = (0,0,0))
        xyzw = zeros(size(data)..., 3)
        for (i,lon) in enumerate(lon), (j,lat) in enumerate(lat)
            x, y, z = toCartesian(lon, lat; cxyz = cxyz)
            xyzw[i,j,1] = x
            xyzw[i,j,2] = y
            xyzw[i,j,3] = z
        end
        xyzw[:,:,1], xyzw[:,:,2], xyzw[:,:,3]
    end
    # this is needed in order to have a closed surface
    lonext  = cat(collect(lon), lon[1], dims = 1)
    dataext = begin
        tmpdata = zeros(size(lon)[1]+1,  size(lat)[1])
        tmpdata[1:size(lon)[1],:] = data
        tmpdata[size(lon)[1]+1,:] = data[1,:]
        tmpdata
    end
    #now let's plot that surface!
    xetopo, yetopo, zetopo = lonlat3D(lonext, lat, dataext)

    fig = Figure(resolution =(950,900),fontsize = 25,backgroundcolor = :black)
    ax = Axis3(fig, aspect = :data, azimuth = -0.2π, elevation = -0.05π)
    pltobj=surface!(ax,xetopo, yetopo, zetopo, color = dataext,
        colormap = :hot, backlight = 1.0f0, colorrange =(-6000,5000))
    cbar  =Colorbar(fig,pltobj,label = "ETOPO1 [m]",ticklabelsize = 20,
        tickalign =1, vertical = true, ticksize=15, labelcolor = :white,
        ticklabelcolor = :white, tickcolor = :grey90, height = Relative(0.5))
    hidespines!(ax)
    hidedecorations!(ax)
    fig[1,1] = ax
    fig[1,2] = cbar
    save(joinpath(@__DIR__, "output", "topographySphere.png"), fig, px_per_unit = 2.0) # HIDE
end

using Pkg # HIDE
Pkg.status(["GLMakie","NetCDF", "YAXArrays"]) # HIDE
