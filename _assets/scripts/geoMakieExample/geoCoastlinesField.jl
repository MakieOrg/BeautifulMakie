# by Lazaro Alonso 
using GeoMakie, Proj4, CairoMakie
CairoMakie.activate!()
let
    lons = -180:180
    lats = -90:90
    field = [exp(cosd(l)) + 3(y/90) for l in lons, y in lats]

    trans = Proj4.Transformation("+proj=longlat +datum=WGS84", "+proj=wintri", 
        always_xy=true) 
    # see https://proj.org/operations/projections/index.html for more options 
    ptrans = Makie.PointTrans{2}(trans)

    fig = Figure(resolution = (1250,700), fontsize = 22)
    ax = Axis(fig[1,1], aspect = DataAspect(), 
        title = "Projection: Winkel Tripel, Field")
    # all input data coordinates are projected using this function
    ax.scene.transformation.transform_func[] = ptrans
    # add some limits, still it needs to be manual  
   
    points = [Point2f0(lon, lat) for lon in lons, lat in lats]
    rectLimits = FRect2D(Makie.apply_transform(ptrans, points))
    limits!(ax, rectLimits)
    # now the plot 
    hm = surface!(ax, lons, lats, field, shading = false)
    Colorbar(fig[1,2], hm, label = "variable, color code", height = Relative(0.65))
    lines!(ax, GeoMakie.coastlines(), color = :black, overdraw = true)

    hidedecorations!(ax, ticks = false, label = false, grid=false)
    hidespines!(ax)
    fig
    save(joinpath(@__DIR__, "output", "geoCoastlinesField.png"), fig) # HIDE
end
using Pkg # HIDE
Pkg.status(["GeoMakie", "Proj4", "CairoMakie"]) # HIDE



