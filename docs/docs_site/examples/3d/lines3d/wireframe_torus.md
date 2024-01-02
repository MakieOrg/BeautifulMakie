


```julia
using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

U = LinRange(-pi, pi, 100)
V = LinRange(-pi, pi, 20)
x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
z1 = [.5 * sin(v)                        for u in U, v in V]
x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
y2 = [.5 * sin(v)                        for u in U, v in V]
z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]

fig = Figure(size =(1200,800))
ax = LScene(fig[1,1], show_axis = true)
wireframe!(ax, x1, y1, z1; transparency = true)
axis = ax.scene[OldAxis]
tstyle = axis[:names]
tstyle[:fontsize] = 16
tstyle[:gap] = 8
axis[:ticks][:textcolor] = :black
axis[:ticks][:fontsize] = 10
fig
```


![](wireframe_torus.png)

