# ## Coastlines

# ![](coastlines.png)

# This should create a GeoAxis, then on top we plot the coastlines from from Natural Earth.
using GLMakie, GeoMakie
GLMakie.activate!()
GLMakie.closeall() # hide

fig = Figure(; size=(600, 400))
ax = GeoAxis(fig[1, 1]; title="coastlines")
lines!(ax, GeoMakie.coastlines())
fig

save("coastlines.png", fig); # hide