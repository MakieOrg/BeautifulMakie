using GLMakie, TestImages, FileIO
using GeometryBasics, Colors
using Downloads
GLMakie.activate!()
GLMakie.closeall() # close any open screen

# ## Simple cubed mesh
mr = Rect3f(Vec3f(-0.5), Vec3f(1))
mr_n = GeometryBasics.normal_mesh(mr)

fig, ax, obj = mesh(mr; color = :white, transparency=true,
    figure = (; size = (1200,600)))
wireframe!(ax, mr; color = :black, transparency=true)
mesh(fig[1,2], mr_n; color = Array(vcat(coordinates(mr_n)...)),
    colormap = :Spectral_11)
fig

# Adding some colours at random

fig, ax, obj = mesh(mr; color = rand(24),
    colormap = :sunset, figure = (; size = (1200,600)))
mesh(fig[1,2], mr; color = 1:24,
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
    uvs = [Vec2f(x, y) for y in 0:0.5:1 for x in range(0, 1, length=4)]
    ##          -              + 
    fs = QuadFace[
        (1, 2, 6, 5), (6, 7, 11, 10),  # x
        (2, 3, 7, 6), (7, 8, 12, 11),  # y
        (3, 4, 8, 7), (5, 6, 10, 9),   # z
    ]
    r = Rect3f(Vec3f(-0.5) .+ o, sizexyz)
    m = GeometryBasics.Mesh(coordinates(r), faces(r);
        uv = GeometryBasics.FaceView(uvs, fs), normal = normals(r))
    return m
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

fig = Figure(figure_padding=0, size =(600,400))
axs = [Axis(fig[i,j], aspect=1) for i in 1:2 for j in 1:3]
[heatmap!(axs[i], testimage("chelsea")) for i in 1:6]
hidedecorations!.(axs)
hidespines!.(axs)
colgap!(fig.layout,0)
rowgap!(fig.layout,0)
imgOut = Makie.colorbuffer(fig.scene)

mesh(m; color = imgOut, interpolate=false)
