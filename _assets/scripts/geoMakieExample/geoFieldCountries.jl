using CairoMakie
using GeoMakie
using GeoMakie.GeoInterface
using GeoMakie.GeoJSON
using Proj4
CairoMakie.activate!()
let
    # https://datahub.io/core/geo-countries#curl # download data from here
    worldCountries = GeoJSON.read(read("countries.geojson"))
    n = length(GeoInterface.features(worldCountries))
    lons = -180:180
    lats = -90:90
    field = [exp(cosd(l)) + 3(y/90) for l in lons, y in lats]
    
    trans = Proj4.Transformation("+proj=longlat +datum=WGS84", "+proj=wintri", 
        always_xy=true) 
    #+proj=wintri, natearth2
    ptrans = Makie.PointTrans{2}(trans)
    fig = Figure(resolution = (1200,800), fontsize = 22)
    ax = Axis(fig[1,1], aspect = DataAspect(), title = "World Countries")
    # all input data coordinates are projected using this function
    ax.scene.transformation.transform_func[] = ptrans
    # add some limits, still it needs to be manual  
    points = [Point2f0(lon, lat) for lon in lons, lat in lats]
    rectLimits = FRect2D(Makie.apply_transform(ptrans, points))
    limits!(ax, rectLimits)

    hm1 = surface!(ax, lons, lats, field, shading = false, overdraw = false)

    hm2 = poly!(ax, worldCountries, color= 1:n, colormap = Reverse(:plasma), 
        strokecolor = :black, strokewidth = 0.25, overdraw = true, 
        transformation=(:xy, 10))

    Colorbar(fig[1,2], hm1, label = "variable, color code", 
        height = Relative(0.65))

    # drawing the correct lines and ticks is still a little bit cumbersome and manual
    # you could ignore the rest and just hide everything 
    # hidedecorations!(ax)
    # hidespines!(ax)
    lonrange = -180:60:180
    latrange = -90:30:90

    lonlines = [Point2f0(j,i) for i in lats, j in lonrange]
    latlines = [Point2f0(j,i) for j in lons, i in latrange]

    [lines!(ax, lonlines[:,i], color = (:black,0.25), 
        linestyle = :dash, overdraw = true) for i in 1:size(lonlines)[2]]
    [lines!(ax, latlines[:,i], color = (:black,0.25), linestyle = :dash, 
        overdraw = true) for i in 1:size(latlines)[2]]

    xticks = first.(trans.(Point2f0.(lonrange, -90))) 
    yticks = last.(trans.(Point2f0.(-180,latrange)))
    ax.xticks = (xticks, string.(lonrange, 'ᵒ'))
    ax.yticks = (yticks, string.(latrange, 'ᵒ'))
    # hide just original grid 
    hidedecorations!(ax, ticks = false, label = false, ticklabels=false)
    hidespines!(ax)
    fig
    save(joinpath(@__DIR__, "output", "geoFieldCountries.png"), fig) # HIDE

end
using Pkg # HIDE 
Pkg.status(["GeoMakie", "Proj4", "CairoMakie", "GeoInterface", "GeoJSON"]) # HIDE
