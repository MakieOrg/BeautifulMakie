using GeoMakie, GLMakie, Downloads
using GeoJSON, GeoInterface
GLMakie.activate!()
## data from
## https://github.com/telegeography/www.submarinecablemap.com
urlPoints = "https://raw.githubusercontent.com/telegeography/www.submarinecablemap.com/master/web/public/api/v3/landing-point/landing-point-geo.json"
urlCables = "https://raw.githubusercontent.com/telegeography/www.submarinecablemap.com/master/web/public/api/v3/cable/cable-geo.json"

landPoints = Downloads.download(urlPoints, IOBuffer())
landCables = Downloads.download(urlCables, IOBuffer())

land_geoPoints = GeoJSON.read(seekstart(landPoints))
land_geoCables = GeoJSON.read(seekstart(landCables))

toPoints = GeoMakie.geo2basic(land_geoPoints)
## toLines = GeoMakie.geo2basic(land_geoCables) ## this should probably be supported.
feat = GeoInterface.features(land_geoCables)
toLines = GeoInterface.coordinates.(GeoInterface.geometry.(feat))
splitLines = []
for i in eachindex(toLines)
    for j in eachindex(toLines[i])
        push!(splitLines, Point2f.(toLines[i][j]))
    end
end
lons = -180:180
lats = -90:90
field = [exp(cosd(l)) + 3(y / 90) for l in lons, y in lats]

function plotCables()
    fig, ax, = scatter(toPoints; markersize=5, color=1:length(toPoints),
        colormap=:plasma, figure=(; resolution=(1200, 800), fontsize=24))
    [lines!(ax, splitLines[i]; linewidth=0.85) for i in eachindex(splitLines)]
    lines!(GeoMakie.coastlines(); color=:white, linewidth=0.35)
    limits!(ax, -185, 185, -95, 95)
    ax.xticks = -180:60:180
    ax.yticks = -90:30:90
    ax.xtickformat = "{:d}ᵒ"
    ax.ytickformat = "{:d}ᵒ"
    fig
end
fig = with_theme(plotCables, theme_dark())