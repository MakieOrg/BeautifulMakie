# by Lazaro Alonso
using GLMakie, GeoMakie, CairoMakie, Downloads
using GeoJSON, GeoInterface, FileIO
using HDF5
using Downloads: download 
GLMakie.activate!()
#let 
    earth_img = load(download("https://upload.wikimedia.org/wikipedia/commons/5/56/Blue_Marble_Next_Generation_%2B_topography_%2B_bathymetry.jpg"))
    n = 1024 ÷ 4 # 2048
    θ = LinRange(0,pi,n)
    φ = LinRange(-pi,pi,2*n)
    xe = [cos(φ)*sin(θ) for θ in θ, φ in φ]
    ye = [sin(φ)*sin(θ) for θ in θ, φ in φ]
    ze = [cos(θ) for θ in θ, φ in φ]

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
    
    #worldxm = h5open("world_xm.h5", "r")
    #world_110m = read(worldxm["world_110m"])
    #close(worldxm )
    #lonw, latw = world_110m["lon"], world_110m["lat"]
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
    
    #xw, yw, zw = lonlat3D2(lonw, latw)
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
        fig = Figure(;figure_padding = -600,resolution = (1200,1200))
        ax = Axis3(fig[1,1], aspect = (1,1,1), viewmode = :fit, 
            perspectiveness = 0.5, azimuth = 4.9, elevation = -0.8)

        surface!(ax, xe, ye, ze, color = earth_img, shading = true,
            transparency = false,
            lightposition = Vec3f0(-2, -3, -3), 
            ambient = Vec3f0(0.75, 0.75, 0.75),
        #backlight = 1.5f0
        )
        meshscatter!(ax, toPoints3D, color = 1:length(toPoints3D), 
            markersize = 0.005, colormap = :plasma)
        [lines!(ax, splitLines3D[i], linewidth = 3) for i in 1:length(splitLines3D)]
        
        hidedecorations!(ax)
        hidespines!(ax)
        fig, ax
    end
    fig, ax = with_theme(plotCables3D, theme_black())
    #save(joinpath(@__DIR__, "output", "submarineCables3D.png"), fig) # HIDE
    record(fig, joinpath(@__DIR__, "output", "submarineCables3DSouth.mp4")) do io
        for i in 2π:-0.015:0
            ax.azimuth = i
            recordframe!(io)  # record a new frame
        end
    end
    
    #fig, ax =  plotCables3D()

    #display(fig)
#end
#using Pkg # HIDE
#Pkg.status(["GLMakie", "GeoMakie", "CairoMakie", "Downloads", "GeoJSON", "GeoInterface", "HDF5"]) # HIDE