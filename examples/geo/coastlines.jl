# ## Coastlines

# ![](coastlines.png)

using GLMakie, GeoMakie
GLMakie.activate!()
GLMakie.closeall() # hide

fig = Figure(; size=(600, 400))
ax = GeoAxis(fig[1, 1]; title="coastlines")
lines!(ax, GeoMakie.coastlines()) # plot coastlines from Natural Earth.
fig

save("coastlines.png", fig); # hide