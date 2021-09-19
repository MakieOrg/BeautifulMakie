# by Lazaro Alonso
using GLMakie, GeoMakie, CairoMakie, Downloads
using GeoJSON, GeoInterface
using HDF5
GLMakie.activate!()
let 
    # data from 
    # https://github.com/telegeography/www.submarinecablemap.com
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
    worldxm = h5open("./data/world_xm.h5", "r")
    world_110m = read(worldxm["world_110m"])
    close(worldxm )
    lonw, latw = world_110m["lon"], world_110m["lat"]
    # some 3D transformations 
    function toCartesian(lon, lat; r = 1.02, cxyz = (0,0,0) )
            lat, lon = lat*π/180, lon*π/180
            cxyz[1] + r * cos(lat) * cos(lon), cxyz[2] + r * cos(lat) * sin(lon), cxyz[3] + r *sin(lat)
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
    toPoints3D = [Point3f0([toCartesian(point[1], point[2])...]) for point in toPoints]
    
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
            push!(splitLines3D, Point3f0.(tmp3D))
        end
    end

    # the actual plot !
    function plotCables3D()
        fig, ax, = lines(xw, yw, zw, color = :white, linewidth = 0.15,
            figure = (;figure_padding = -650, resolution = (1400,1400), fontsize = 24), 
            axis = (;type = Axis3, aspect= (1,1,1), viewmode = :fit, 
            perspectiveness = 0.5, azimuth = 5.493108758326981, elevation = 0.41996470669872316))
        mesh!(Sphere(Point3(0),1), color = :black, shading = false, transparency = false)
        meshscatter!(toPoints3D, color = 1:length(toPoints3D), 
            markersize = 0.005, colormap = :plasma)
        [lines!(ax,splitLines3D[i], linewidth=0.75) for i in 1:length(splitLines3D)]
        hidedecorations!(ax)
        hidespines!(ax)
        fig, ax
    end
    fig, ax = with_theme(plotCables3D, theme_dark())
    #save(joinpath(@__DIR__, "output", "submarineCables3D.png"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie", "GeoMakie", "CairoMakie", "Downloads", "GeoJSON", "GeoInterface", "HDF5"]) # HIDE