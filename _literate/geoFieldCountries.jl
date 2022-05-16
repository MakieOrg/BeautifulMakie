md"""
## GeoMakie, Field and world Countries
"""
## by Lazaro Alonso
using Makie, GLMakie, GeoMakie
import Downloads
using GeoMakie.GeoJSON
GLMakie.activate!()
let
    ## https://datahub.io/core/geo-countries#curl # download data from here
    worldCountries = GeoJSON.read(read(Downloads.download("https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json"), String))
    n = length(GeoMakie.GeoInterface.features(worldCountries))
    lons = -180:180
    lats = -90:90
    field = [exp(cosd(l)) + 3(y / 90) for l in lons, y in lats]


    fig = Figure(resolution=(1200, 800), fontsize=22)
    ax = GeoAxis(fig[1, 1]; dest="+proj=wintri", title="World Countries", tellheight=true)
    surface!(ax, lons, lats, field; shading=false)
    poly!(ax, worldCountries; color=1:n, colormap=Reverse(:plasma),
        strokecolor=:black, strokewidth=0.25, transformation=(:xy, 10))

    Colorbar(fig[1, 2]; colorrange=(1, n), colormap=Reverse(:plasma),
        label="variable, color code", height=Relative(0.65))
    fig
    save(joinpath(@OUTPUT, "mapCountries.png"), fig) # HIDE
end;
# \fig{mapCountries.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GeoMakie", "Proj4", "CairoMakie", "GeoInterface", "GeoJSON"]) # HIDE
