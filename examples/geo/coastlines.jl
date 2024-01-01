using GLMakie, GeoMakie
GLMakie.activate!()

fig = Figure(size=(1200, 800), fontsize=22)
ax = GeoAxis(fig[1, 1]; title="coastlines",
coastlines = true, # plot coastlines from Natural Earth.
)
fig