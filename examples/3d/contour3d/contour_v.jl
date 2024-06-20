# ## contour in 3d

# ![](contour_v.png)

using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

x = y = z = 1..10 # start, stop, intervl
x_r = y_r = z_r = 1:10
f(x, y, z) = x^2 + y^2 + z^2
vol = [f(ix, iy, iz) for ix in x_r, iy in y_r, iz in z_r]
## now the figure
fig = Figure(; size = (800,800))
ax = Axis3(fig[1,1]; perspectiveness = 0.5, azimuth = 2.19,
    elevation = 0.57, aspect = (1, 1, 1))
contour!(ax, x, y, z, vol; levels = 10, colormap = :Egypt, transparency = true)
fig

save("contour_v.png", fig); # hide