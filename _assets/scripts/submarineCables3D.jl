## by Lazaro Alonso
using GLMakie, GeoMakie, CairoMakie, Downloads
using GeoJSON, GeoInterface, ColorSchemes
using HDF5
GLMakie.activate!()
let 
    ## data from
    ## https://github.com/telegeography/www.submarinecablemap.com
    urlPoints = "https://raw.githubusercontent.com/telegeography/www.submarinecablemap.com/master/web/public/api/v3/landing-point/landing-point-geo.json"
    urlCables = "https://raw.githubusercontent.com/telegeography/www.submarinecablemap.com/master/web/public/api/v3/cable/cable-geo.json"

    landPoints = Downloads.download(urlPoints, IOBuffer())
    landCables = Downloads.download(urlCables, IOBuffer())

    land_geoPoints = GeoJSON.read(seekstart(landPoints))
    land_geoCables = GeoJSON.read(seekstart(landCables))

    toPoints = GeoMakie.geo2basic(land_geoPoints)
    #toLines = GeoMakie.geo2basic(land_geoCables) # this should probably be supported. 
    feat = GeoInterface.features(land_geoCables)
    toLines = GeoInterface.coordinates.(GeoInterface.geometry.(feat))
    # broken lines at -180 and 180... they should 
    # be the same line and be in the same array.

    # also the coastlines data
    # this data can be download from here:
    # https://github.com/lazarusA/BeautifulMakie/tree/main/_assets/data
    worldxm = h5open("./_assets/data/world_xm.h5", "r")
    world_110m = read(worldxm["world_110m"])
    close(worldxm )
    lonw, latw = world_110m["lon"], world_110m["lat"]
    # some 3D transformations 
    function toCartesian(lon, lat; r = 1.02, cxyz = (0,0,0) )
        x = cxyz[1] + r * cosd(lat) * cosd(lon)
        y = cxyz[2] + r * cosd(lat) * sind(lon)
        z = cxyz[3] + r *sind(lat)
        return x, y, z
    end
    function lonlat3D2(lon, lat; cxyz = (0,0,0))
        xyzw = zeros(length(lon), 3)
        for (i,lon) in enumerate(lon)
            x, y, z = toCartesian(lon, lat[i]; cxyz = cxyz)
            xyzw[i,1] = x
            xyzw[i,2] = y
            xyzw[i,3] = z
        end
        xyzw[:,1], xyzw[:,2], xyzw[:,3]
    end
    xw, yw, zw = lonlat3D2(lonw, latw)
    toPoints3D = [Point3f([toCartesian(point[1], point[2])...]) for point in toPoints]
    splitLines3D = []
    for i in 1:length(toLines)
        for j in 1:length(toLines[i])
            ptsLines = toLines[i][j]
            tmp3D = []
            for k in 1:length(ptsLines)
                x, y = ptsLines[k]
                x,y,z = toCartesian(x,y)
                push!(tmp3D, [x,y,z])
            end
            push!(splitLines3D, Point3f.(tmp3D))
        end
    end

    # the actual plot !
    function plotCables3D()
        colors = to_colormap(:Hiroshige, length(splitLines3D))
        fig = Figure(resolution = (1200, 800))
        ax = LScene(fig[1,1]; show_axis = false)
        lines!(xw, yw, zw; color = :white, linewidth = 0.5)
        mesh!(Sphere(Point3(0), 1), color = (:black, 0.35), shading = false,
            transparency = true)
        meshscatter!(toPoints3D, color = 1:length(toPoints3D),
            markersize = 0.008, colormap = :Hiroshige, shading = false)
        [lines!(splitLines3D[i]; linewidth = 0.75, color = colors[i])
         for i in 1:length(splitLines3D)]
        zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
        fig
    end
    fig = with_theme(plotCables3D, theme_dark())
    save(joinpath(@__DIR__, "output", "submarineCables3D.png"), fig) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie", "GeoMakie", "CairoMakie", "Downloads", "GeoJSON", "GeoInterface", "HDF5"]) # HIDE