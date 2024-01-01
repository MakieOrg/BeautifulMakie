using Makie, GLMakie, GeoMakie
import Downloads
using GeoJSON
using GeoInterface

GLMakie.activate!()

states = Downloads.download("https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json")
states_geo = GeoJSON.read(read(states, String))
#n = length(GeoInterface.features(states_geo))
n = length(states_geo)

fig = Figure(size=(1200, 800), fontsize=22)
ax = GeoAxis(fig[1, 1]; dest="+proj=wintri",coastlines=true,
    title="Projection: Winkel Tripel, US States", tellheight=true)
poly!(ax, states_geo, color=1:n, colormap=:plasma, strokecolor=:black,
    strokewidth=1, overdraw=true, transformation=(:xy, 10))
fig