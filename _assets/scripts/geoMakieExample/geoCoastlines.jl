# by Lazaro Alonso 
using GeoMakie, Proj4, CairoMakie
CairoMakie.activate!()
let
    trans = Proj4.Transformation("+proj=longlat +datum=WGS84", "+proj=wintri", 
        always_xy=true) 
    # see https://proj.org/operations/projections/index.html for more options 
    ptrans = Makie.PointTrans{2}(trans)

    fig = Figure(resolution = (1200,800), fontsize = 22)
    ax = Axis(fig[1,1], aspect = DataAspect(), 
        title = "Projection: Winkel Tripel")
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
    hidedecorations!(ax, ticks = false, label = false, grid=false)
    hidespines!(ax)
    fig
    save(joinpath(@__DIR__, "output", "geoCoastlines.png"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["GeoMakie", "Proj4", "CairoMakie"]) # HIDE



