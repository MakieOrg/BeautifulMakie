using GLMakie, GeoMakie
GLMakie.activate!()

fig = Figure(; size=(600, 400))
ax = GeoAxis(fig[1, 1]; title="coastlines")
lines!(ax, GeoMakie.coastlines()) # plot coastlines from Natural Earth.
fig