using CairoMakie, GeoMakie, Proj4
using NetCDF 
using Base.Iterators: repeated, partition
CairoMakie.activate!()

path  = "/Users/lalonso/Documents/vizExperiment/ForestAge/BGI_ForestAge_MPI_BGC_1.0.0.nc" # hide
ageForest = ncinfo(path)
ForestAge_TC010
forest = NetCDF.open(path, "ForestAge_TC010")
lon = NetCDF.open(path, "longitude")
lat = NetCDF.open(path, "latitude")



fig, ax, pltobj = heatmap(lon[1:5000], lat[1:5000], forest[1:5000,1:5000]; 
    colormap = Reverse(:haline), colorrange = (0,150), highclip = (:black,0.85), 
    figure = (;resolution = (600,600)))
fig

lons2 = [lo for lo in lon[1500:2500], la in lat[1500:2500] ]
lats2 = [la for la in lat[1500:2500], lo in lon[1500:2500] ]

fig, ax, pltobj = surface(lon[2500:3500], lat[2500:3500], zeros(1001,1001); 
    color = forest[2500:3500,2500:3500], 
    colormap = Reverse(:haline), colorrange = (0,150), highclip = (:black,0.85), 
    figure = (;resolution = (600,600)))
fig

# Reverse(:avocado), :haline, :deep, :tempo, :speed are nice 
#:linear_protanopic_deuteranopic_kbw_5_98_c40_n256

batch_sizex = 10000 
batch_sizey = 5000 
mb_idxs = partition(1:size(forest)[1], batch_sizex)
mb_idys = partition(1:size(forest)[2], batch_sizey)

fig = Figure(resolution = (3072, 1600), backgroundcolor = :grey)
ax = Axis(fig[1,1])
for px in mb_idxs, py in mb_idys
    heatmap!(ax,lon[px], lat[py], forest.data[px, py], 
        colormap = Reverse(:haline), colorrange = (0, 150), highclip = :black)
    println("px = $(px) and  py = $(py)")
end
#fig
save("Forest2.png", fig)

#=
using YAXArrays
using YAXArrays.Datasets: open_mfdataset
ageForest = open_mfdataset(path)
forest = ageForest.ForestAge_TC010
africa = forest[lon=(-18,50), lat = (-35,20)]
lon = africa.longitude.values
lat = africa.latitude.values
africaData = africa.data[:,:]
#logArr = map(x-> isnan(x) ? NaN : log2.(x), africaData)
#cmap = cgrad(:plasma, scale = :log2)

lon = ageForest.longitude.values
lat = ageForest.latitude.values
forest = ageForest.ForestAge_TC010

batch_sizex = 10000 
batch_sizey = 5000 
mb_idxs = partition(1:size(forest.data)[1], batch_sizex)
mb_idys = partition(1:size(forest.data)[2], batch_sizey)
=#
