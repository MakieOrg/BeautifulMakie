# by Lazaro Alonso
#using GLMakie, Random # HIDE
using GLMakie, Proj4, NPZ, FileIO
using Colors, ColorSchemes
GLMakie.activate!()
let
    # this data can be download from here:
    # https://github.com/lazarusA/BeautifulMakie/tree/main/_assets/data

    x = npzread("./data/aggregationOSMx.npy")
    y = npzread("./data/aggregationOSMy.npy")
    aggOSM = npzread("./data/aggregationOSM.npy")'
    img = load("./data/osm_kbc.png") # osm_bmy.png

    # getting back to lon and lat coordinates
    source = Projection("+proj=webmerc +datum=WGS84")
    dest = Projection("+proj=longlat +datum=WGS84")
    lonlat = transform(source, dest, [x y])

    function toCartesian(lon, lat; r = 1, cxyz = (0,0,0) )
        lat, lon = lat*π/180, lon*π/180
        cxyz[1] + r * cos(lat) * cos(lon), cxyz[2] + r * cos(lat) * sin(lon), cxyz[3] + r *sin(lat)
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

    x, y, z = lonlat3D(lonlat[:,1], lonlat[:,2], aggOSM)

    fig = Figure(figure_padding = -650, resolution = (1400,1400), 
        backgroundcolor = "#141414")
    ax = Axis3(fig, aspect = :data, viewmode = :fit, perspectiveness = 0.5,
        azimuth = 6.49150301535897, elevation = 0.8516713267948967)
    mesh!(Sphere(Point3(0),1), color = :black, shading = false)
    surface!(ax, x, y, z, color = rotr90(img), shading = false, 
        transparency = false)
    hidedecorations!(ax)
    hidespines!(ax)
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "proj4_to_Sphere.png"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie","FileIO", "ImageMagick", "QuartzImageIO", "Proj4", "Colors", "ColorSchemes"]) # HIDE
