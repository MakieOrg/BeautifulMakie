md"""
## GeoMakie, Coastlines, US states
"""
## by Lazaro Alonso
using Makie, GLMakie, GeoMakie
import Downloads
using GeoMakie.GeoJSON
GLMakie.activate!()
let
    states = Downloads.download("https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json")
    states_geo = GeoJSON.read(read(states, String))
    n = length(GeoInterface.features(states_geo))

    fig = Figure(resolution=(1200, 800), fontsize=22)
    ax = GeoAxis(fig[1, 1]; dest="+proj=wintri",coastlines=true,
        title="Projection: Winkel Tripel, US States", tellheight=true)
    poly!(ax, states_geo, color=1:n, colormap=:plasma, strokecolor=:black,
        strokewidth=1, overdraw=true, transformation=(:xy, 10))
    fig
    save(joinpath(@OUTPUT, "geoCoastlinesStatesUS.png"), fig) # HIDE
end;
# \fig{geoCoastlinesStatesUS.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GeoMakie", "Proj4", "CairoMakie", "GeoInterface", "GeoJSON"]) # HIDE
