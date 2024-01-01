using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

t = range(0, 2π, length = 50)
u = -1:0.1:1
x = [u * sin(t) for t in t, u in u]
y = [u * cos(t) for t in t, u in u]
z = [u for t in t, u in u]
fig = surface(x, y, z, colormap = [:dodgerblue, :dodgerblue],
    lightposition = Vec3f(0, 0, 0.8), ambient = Vec3f(0.6, 0.6, 0.6),
    backlight = 2.0f0)
wireframe!(x, y, z; overdraw = false, linewidth = 0.1) # try overdraw = true
fig