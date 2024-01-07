# ## US-States polygons

# ![](us_states.png)

using Makie, GLMakie, GeoMakie
import Downloads
using GeoMakie.GeoJSON
using GeoMakie.GeoInterface
GLMakie.activate!()
GLMakie.closeall() # hide

states = Downloads.download("https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json")
states_geo = GeoJSON.read(read(states, String))
## n = length(GeoInterface.features(states_geo))
n = length(states_geo)
@show n

fig = Figure(size=(1200, 800), fontsize=22)
ax = GeoAxis(fig[1, 1]; dest="+proj=wintri", title="Projection: Winkel Tripel, US States")
poly!(ax, states_geo, color=1:n, colormap=:plasma, strokecolor=:black, strokewidth=1)
ylims!(ax,-90,90)
fig

save("us_states.png", fig); # hide