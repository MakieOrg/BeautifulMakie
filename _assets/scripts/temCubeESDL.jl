# by lazarusA # HIDE
# using GLMakie # HIDE
using ESDL, GLMakie
GLMakie.activate!()# HIDE
# this is a raw approach to plot data cubes
let
    cube = esdc()
    #YAXArray with the following dimensions
    #lon                 Axis with 1440 Elements from -179.875 to 179.875
    #lat                 Axis with 720 Elements from 89.875 to -89.875
    #time                Axis with 1702 Elements from 1980-01-05T00:00:00 to 2016-12-30T00:00:00
    #Variable            Axis with 75 elements: soil_moisture leaf_area_index .. snow_sublimation Rg
    #Total size: 493.03 GB
    #then from here we just call what we need.
    function getCubeFaces(datCubes, timeRange, lonRange, latRange;
        variable = "air_temperature_2m" )
        #front face
        cubef = datCubes[
            var  = variable,
            time = timeRange[1],
            lon  = lonRange,
            lat  = latRange].data[:,:]
        #back face
        cubeb = datCubes[
            var  = variable,
            time = timeRange[2],
            lon  = lonRange,
            lat  = latRange].data[:,:];
        #rigth face
        cuber = datCubes[
            var  = variable,
            time = timeRange,
            lon  = lonRange[2],
            lat  = latRange].data[:,:];
        #left face
        cubel = datCubes[
            var   = variable,
            time  = timeRange,
            lon   = lonRange[1],
            lat   = latRange].data[:,:];
        #top face
        cubet = datCubes[
            var  = variable,
            time = timeRange,
            lon  = lonRange,
            lat  = latRange[2]].data[:,:];
        #bottom face
        cubebt = datCubes[
            var  = variable,
            time = timeRange,
            lon  = lonRange,
            lat  = latRange[1]].data[:,:]

        cubef  = replace(cubef[:,end:-1:1], missing => NaN)
        cubeb  = replace(cubeb[:,end:-1:1], missing => NaN)
        cubet  = replace(cubet', missing => NaN)
        cubebt = replace(cubebt', missing => NaN)
        cubel  = replace(cubel'[:,end:-1:1], missing => NaN)
        cuber = replace(cuber'[:,end:-1:1], missing => NaN) #
        return cubef, cubeb, cuber, cubel, cubet, cubebt
    end

    function cube!(ax; a1 = 1, a2 = 1, timeLonLat = (40,50,20), cxyz = (0,0,0),
        cmap = :plasma, transparent = false, limits = limits,
        topF    = randn(timeLonLat[1], timeLonLat[2]),
        bottomF = randn(timeLonLat[1], timeLonLat[2]),
        frontF  = randn(timeLonLat[2], timeLonLat[3]),
        backF   = randn(timeLonLat[2], timeLonLat[3]),
        leftF   = randn(timeLonLat[1], timeLonLat[3]),
        rightF  =  randn(timeLonLat[1], timeLonLat[3])) # highLimit=0, lowLimit=1

        highLimit = maximum(maximum.(x->isnan(x) ? -Inf : x, (topF, bottomF, frontF, backF, leftF, rightF)))
        lowLimit =  minimum(minimum.(x->isnan(x) ?  Inf : x, (topF, bottomF, frontF, backF, leftF, rightF)))

        x = LinRange(-a1, a1, size(topF)[1])
        y = LinRange(-a1, a1, size(topF)[2])
        z = LinRange(-a1, a1, size(leftF)[2])

        bsurf = heatmap!(ax, y .+ cxyz[2], z .+ cxyz[3], backF, transformation=(:yz, -a2 + cxyz[1]),
        colormap = cmap, transparency = transparent, limits = limits, colorrange = (lowLimit, highLimit)) # back, limits = FRect((-1,-1,-1), (2,2,2))
        heatmap!(ax, x .+ cxyz[1], z .+ cxyz[3], leftF, transformation=(:xz, -a2 + cxyz[2]),
            colormap = cmap, transparency = transparent, colorrange = (lowLimit, highLimit)) # left
        heatmap!(ax, x .+ cxyz[1], y .+ cxyz[2], bottomF, transformation=(:xy, -a2 + cxyz[3]),
            colormap = cmap, transparency = transparent, colorrange = (lowLimit, highLimit)) # bottom
        heatmap!(ax, y .+ cxyz[2], z .+ cxyz[3], frontF, transformation=(:yz,  a2 + cxyz[1]),
            colormap = cmap, transparency = transparent, colorrange = (lowLimit, highLimit)) # front
        heatmap!(ax, x .+ cxyz[1], z .+ cxyz[3], rightF, transformation=(:xz,  a2 + cxyz[2]),
            colormap = cmap, transparency = transparent, colorrange = (lowLimit, highLimit)) # right
        heatmap!(ax, x .+ cxyz[1], y .+ cxyz[2], topF, transformation = (:xy,  a2 + cxyz[3]),
            colormap = cmap, transparency = transparent, colorrange = (lowLimit, highLimit)) # top
        bsurf
    end

    ## Just tell me your variable, time range, lon range and lat range.
    timeRange = (Date("2003-01-01"), Date("2003-12-31"))#(Date("2003-12-31"), Date("2010-01-23"))
    lonRange = (-20, 60)
    latRange = (-40, 40)
    allFaces = getCubeFaces(cube, timeRange, lonRange, latRange; variable = "air_temperature_2m")
    cFront, cBack, cRight, cLeft, cTop, cBottom = allFaces;
    ## Just tell me your variable, time, lon and lat.
    function cubePlot()
        limits = Node(Rect(Vec3f0(-1), Vec3f0(2)))
        fig = Figure(resolution = (850, 800))
        ax = Axis3(fig, aspect = :data, perspectiveness = 0.5, xlabel = "time",
            ylabel = "longitude", zlabel = "latitude")
        cbox = cube!(ax; a1 = 1, a2 = 1, frontF = cFront, backF = cBack,
            topF = cTop, bottomF = cBottom, leftF   = cLeft, rightF  = cRight,
            limits = limits, cmap = :CMRmap, transparent=false)
        ax.yticks = (-1:2:1,string.([lonRange[1], lonRange[2]]))
        ax.zticks = (-1:2:1,string.([latRange[1], latRange[2]]))
        ax.xticks = (-1:2:1,string.([timeRange[1],timeRange[2]]))
        cbar  = Colorbar(fig, cbox,  label = "temperature", height = Relative(0.5))
        #limits[] = Rect(Vec3f0(-2,-2,-2), Vec3f0(4.5))
        fig[1, 1] = ax
        fig[1, 2] = cbar
        fig
    end
    fig = with_theme(cubePlot, theme_black())
    save(joinpath(@__DIR__, "output", "temCubeESDL.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie","ESDL"]) # HIDE
