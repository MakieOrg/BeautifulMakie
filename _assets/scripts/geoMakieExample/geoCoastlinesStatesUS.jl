# by Lazaro Alonso 
using GeoMakie, Proj4, CairoMakie
using GeoMakie.GeoInterface
using GeoMakie.GeoJSON
using Downloads
CairoMakie.activate!()
let
    states = Downloads.download("https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json")
    states_geo = GeoJSON.read(read(states, String))
    n = length(GeoInterface.features(states_geo))

    trans = Proj4.Transformation("+proj=longlat +datum=WGS84", "+proj=wintri", 
        always_xy=true) 
    # see https://proj.org/operations/projections/index.html for more options 
    ptrans = Makie.PointTrans{2}(trans)

    fig = Figure(resolution = (1250,700), fontsize = 22)
    ax = Axis(fig[1,1], aspect = DataAspect(), 
        title = "Projection: Winkel Tripel, US States")
    # all input data coordinates are projected using this function
    ax.scene.transformation.transform_func[] = ptrans
    # add some limits, still it needs to be manual  
    lons = -180:180
    lats = -90:90
    points = [Point2f0(lon, lat) for lon in lons, lat in lats]
    rectLimits = FRect2D(Makie.apply_transform(ptrans, points))
    limits!(ax, rectLimits)
    # now the plot 
    lines!(ax, GeoMakie.coastlines(), color = :black)
    poly!(ax, states_geo, color= 1:n, colormap = :plasma, strokecolor = :black, 
        strokewidth = 1, overdraw = true, transformation=(:xy,10))

    hidedecorations!(ax, ticks = false, label = false, grid=false)
    hidespines!(ax)
    fig
    save(joinpath(@__DIR__, "output", "geoCoastlinesStatesUS.png"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["GeoMakie", "Proj4", "CairoMakie", "GeoInterface", "GeoJSON", "Downloads"]) # HIDE



