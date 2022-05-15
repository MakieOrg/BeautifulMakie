using GLMakie, Downloads
using ColorSchemes
using CSV, DataFrames, GeoInterface
using GeoJSON
using GeoMakie
file = "./_assets/data/DE-counties.geojson"
germany = GeoJSON.read(read(file))
feat = GeoInterface.features(germany)
n = length(feat)

ge = GeoInterface.coordinates.(GeoInterface.geometry.(feat))

fig = Figure(resolution = (1200, 800))
ax = Axis(fig[1,1])
for i in 1:431
    if length(ge[i]) == 1
        lines!(ax, Point2f.(ge[i][1]))
    end
end
fig

poly(germany, strokewidth = 0.1)
