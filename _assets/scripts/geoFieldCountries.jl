using GLMakie, Proj4, HDF5
using GeoMakie, GeoInterface, GeoJSON
using GeometryBasics: Polygon
using GeometryBasics
GLMakie.activate!()
# https://datahub.io/core/geo-countries#curl # download data from here
worldCountries = GeoJSON.read(read("./_assets/data/countries.geojson"))
n = length(GeoInterface.features(worldCountries))

function projdata(x, y; source = "+proj=longlat +datum=WGS84", dest = "+proj=wintri")
    trans = Proj4.Transformation(source, dest, always_xy = true)
    trans([x, y])
end

function projdata(xy; source = "+proj=longlat +datum=WGS84", dest = "+proj=wintri")
    x, y = xy
    trans = Proj4.Transformation(source, dest, always_xy = true)
    trans([x, y])
end

lons, lats = -180:180, -90:90
field = [exp(cosd(l)) + 3(y / 90) for l in lons, y in lats]

function lonlatproj(lons, lats, data)
    xyzw = zeros(size(data)..., 3)
    for (i, lon) in enumerate(lons), (j, lat) in enumerate(lats)
        x, y = projdata(lon, lat)
        xyzw[i, j, 1] = x
        xyzw[i, j, 2] = y
        xyzw[i, j, 3] = data[i, j] # this should be zero, and pass the values to color instead
    end
    return xyzw[:, :, 1], xyzw[:, :, 2], xyzw[:, :, 3]
end

x, y, z = lonlatproj(lons, lats, field)
worldxm = h5open("./_assets/data/world_xm.h5", "r")
world_m = read(worldxm["world_50m"])
close(worldxm)
lonw, latw = world_m["lon"], world_m["lat"]
coastlines = [Point2f(projdata(lonw[i], latw[i])) for i in 1:length(lonw)]

polys = geo2basic(worldCountries)
function polysign(polygon::Polygon)
    xycoord = GeometryBasics.coordinates(polygon)
    Polygon([Point2f(projdata(p)) for p in xycoord])
end
function polysign(polygon::Vector)
    [polysign(p) for p in polygon]
end

# ugly part :D
topoly = []
colors = []
for i in 1:length(polys)
    transpoly = polysign(polys[i])
    if typeof(transpoly) <: Vector
        for j in 1:length(transpoly)
            push!(topoly, transpoly[j])
            push!(colors, i)
        end
    else
        push!(topoly, transpoly)
        push!(colors, i)
    end
end
# vector of polygons
topoly = [topoly[i] for i in 1:length(topoly)];

# nice part :D
fig = Figure(resolution = (1200, 800))
ax = Axis(fig[1, 1], aspect = DataAspect())
surface!(x, y, z; shading = false, colormap = :cyclic_tritanopic_cwrk_40_100_c20_n256)
lines!(coastlines; overdraw = true, color = :black, linewidth = 0.5)
poly!(topoly; color = colors / maximum(colors), colormap = :Hiroshige,
    transformation = (:xy, 100))
hidedecorations!(ax)
hidespines!(ax)
#save(joinpath(@__DIR__, "output", "mapCountries.png"), fig)
fig

using Pkg # HIDE 
Pkg.status(["GeoMakie", "Proj4", "CairoMakie", "GeoInterface", "GeoJSON"]) # HIDE
