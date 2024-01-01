using GLMakie, TestImages, FileIO
using GeometryBasics, Colors
using Downloads
GLMakie.activate!()
GLMakie.closeall() # close any open screen

# ## Simple cubed mesh
mr = Rect3f(Vec3f(-0.5), Vec3f(1))

fig, ax, obj = mesh(mr; color = :white, transparency=true,
    figure = (; size = (1200,600)))
wireframe!(ax, mr; color = :black, transparency=true)
mesh(fig[1,2], mr; color = [v[3] for v in coordinates(mr)],
    colormap = :Spectral_11)
fig

# Adding some colours at random

fig, ax, obj = mesh(mr; color = rand(length(coordinates(mr))),
    colormap = :sunset, figure = (; size = (1200,600)))
mesh(fig[1,2], mr; color = 1:length(coordinates(mr)),
    colormap = :sunset)
fig

# ## A matrix (image) as colors

img = testimage("chelsea")
fig, ax, obj = mesh(mr; color =rand(10,10), interpolate=false,
    colormap = :seaborn_icefire_gradient,
    figure = (; size = (1200,600)))
mesh(fig[1,2], mr; color = img, interpolate=false)
fig

# Note that the image is simple wrap around the mesh, and not in a goog way.

# ## Wrap individual colors around mesh
# Solution by ffreyer, define new uvs

function meshcube(o=Vec3f(0), sizexyz = Vec3f(1))
    uvs = map(v -> v ./ (3, 2), Vec2f[
    (0, 0), (0, 1), (1, 1), (1, 0),
    (1, 0), (1, 1), (2, 1), (2, 0),
    (2, 0), (2, 1), (3, 1), (3, 0),
    (0, 1), (0, 2), (1, 2), (1, 1),
    (1, 1), (1, 2), (2, 2), (2, 1),
    (2, 1), (2, 2), (3, 2), (3, 1),
    ])
    m = normal_mesh(Rect3f(Vec3f(-0.5) .+ o, sizexyz))
    m = GeometryBasics.Mesh(meta(coordinates(m);
        uv = uvs, normals = normals(m)), faces(m))
end
m = meshcube();

## +z, +x, +y,
## -x, -y, -z
img = rand(RGBf, 2, 3)
fig, ax, obj = mesh(m; color = img, interpolate=false,
    figure = (; size = (1200,600)))
mesh(fig[1,2], m; color = img)
fig

# Increasing the number of colours

img = rand(RGBf, 2*6, 3*6)
mesh(m; color = img, interpolate=false)

# Putting an image

img = testimage("chelsea");
mesh(m; color = img, interpolate=false)

# Now the image is splitted all around, hence, something else will be needed.
# I found the following work around. Where, an image with ratio (2,3) is pre-process, 
# and where each entry corresponds to a different face. 

# Remember again, the position for each one of them are: 
# +z, +x, +y,
# -x, -y, -z

# ## Individual images per face

timgs = ["bark_512", "bark_he_512", "brick_wall_he_512",
    "woolen_cloth_he_512", "wood_grain_he_512", "straw_he_512"];


fig = Figure(figure_padding=0, size =(600,400))
axs = [Axis(fig[i,j], aspect=1) for i in 1:2 for j in 1:3]
[heatmap!(axs[i], testimage(timgs[i])) for i in 1:6]
hidedecorations!.(axs)
hidespines!.(axs)
colgap!(fig.layout,0)
rowgap!(fig.layout,0)
imgOut = Makie.colorbuffer(fig.scene)

mesh(m; color = imgOut, interpolate=false)
