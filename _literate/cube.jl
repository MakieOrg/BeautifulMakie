md"""
## Data Cube
"""
## by Lazaro Alonso
using GLMakie, Random
GLMakie.activate!() #HIDE
#let
x = LinRange(0.2, π - 0.2, 50) # time
y = LinRange(0.5, 2π - 0.5, 100) # lon
z = LinRange(0.2, 3π - 0.5, 150) # lat
dcube = [cos(X) * sin(Y) * sin(Z) for X ∈ x, Y ∈ y, Z ∈ z];
positions = vec([(i, j, k) for i in x, j in y, k in z])

xs = range(-1, 1, length = size(dcube)[1])
ys = range(-1, 1, length = size(dcube)[2])
zs = range(-1, 1, length = size(dcube)[3])
cmap = :viridis
fig = Figure(resolution = (1400, 800))
axs = [Axis(fig[i, j], aspect = 1) for j ∈ 1:3 for i ∈ 1:2]
hidedecorations!.(axs)
heatmap!(axs[1], dcube[1, :, :]; colormap = cmap)
axs[1].title = "yz plane-1 - x axis"
heatmap!(axs[2], dcube[end, :, :]; colormap = cmap)
axs[2].title = "yz plane-end - x axis"
heatmap!(axs[3], dcube[:, 1, :]; colormap = cmap)
axs[3].title = "xz plane-1 - y axis"
heatmap!(axs[4], dcube[:, end, :]; colormap = cmap)
axs[4].title = "xz plane-end - y axis"
heatmap!(axs[5], dcube[:, :, 1]; colormap = cmap)
axs[5].title = "xy plane-1 - z axis"
heatmap!(axs[6], dcube[:, :, end]; colormap = cmap)
axs[6].title = "xy plane-end - z axis"
axv1 = LScene(fig[1:2, 4])
axv2 = LScene(fig[3:4, 4])
axv3 = LScene(fig[3:4, 1])
axv4 = LScene(fig[3:4, 2])
axv5 = LScene(fig[3:4, 3])

volume!(axv1, xs, ys, zs, dcube, colormap = cmap, transparency = true, shading = false)
volume!(axv2, xs, ys, zs, dcube, colormap = cmap, transparency = true, shading = false)
volume!(axv3, dcube, colormap = cmap, transparency = true, shading = false)
volume!(axv4, xs, ys, zs, dcube, colormap = cmap, transparency = true, shading = false)
meshscatter!(axv5, positions, colormap = cmap, color = vec(dcube),
    marker = Rect3f(Vec3f(-2(x[2] - x[1]), -2(y[2] - y[1]), -2(z[2] - z[1])), 
        Vec3f(2(x[2] - x[1]), 2(y[2] - y[1]), 2(z[2] - z[1]))), transparency = false)
fig



fig = Figure(resolution = (600, 800))
ax = Axis3(fig[1, 1]; aspect = :data, perspectiveness = 0.5,
    xlabel = "", ylabel = "", zlabel = "")
heatmap!(ax, y, z, dcube; transformation = (:yz, -1), colorrange = (0.01, maxkNDVI),
    transparency = true)
fig
##
display(fig)
#save(joinpath(@OUTPUT, "dataCube.png"), fig) # HIDE
#end;
# \fig{dataCube.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie", "Colors", "ColorSchemes"]) # HIDE
