# ## vertical 3d band over map

# ![](vertical_feature_mask.png)

using GLMakie, GeoMakie
using Downloads: download
using FileIO
GLMakie.activate!()
GLMakie.closeall() # hide

earth_img = load(download("https://upload.wikimedia.org/wikipedia/commons/5/56/Blue_Marble_Next_Generation_%2B_topography_%2B_bathymetry.jpg"))

fig = Figure(; size=(800, 400), fontsize=22)
ax = LScene(fig[1,1])
lines!(ax, GeoMakie.coastlines(), transparency=true)
lines!(ax, GeoMakie.coastlines()[95], color=:red, linewidth=5, transparency=true)
image!(ax, -180..180, -90..90, earth_img'[:,end:-1:1])
fig

idx_l = findmax(length.(GeoMakie.coastlines()))
longpath = GeoMakie.coastlines()[idx_l[2]]
@show idx_l


linepath = Point3f[]
for p in longpath
    push!(linepath, Point3f(p[1]..., 0))
    push!(linepath, Point3f(p[1]..., 0))
end

linepathh = Point3f[]
for p in longpath
    push!(linepathh, Point3f(p[1]..., 20))
    push!(linepathh, Point3f(p[1]..., 20))
end

fig = Figure(size=(800, 400), fontsize=22)
ax = LScene(fig[1,1]; show_axis=false)
lines!(ax, GeoMakie.coastlines(), transparency=true, color=:white)
lines!(ax, linepath, color = :orangered, linewidth=2.5, transparency=true)
lines!(ax, linepathh, color = :white, linewidth=2.5, transparency=true)
band!(ax, linepath, linepathh, color = repeat(1:1384,outer=2), transparency=true)
image!(ax, -180..180, -90..90, earth_img'[:,end:-1:1])
rotate!(ax.scene, 2*pi/2.6)
fig
zoom!(ax.scene, cameracontrols(ax.scene), 30)
## center!(ax.scene)
save("vertical_feature_mask.png", fig, update=false); # hide