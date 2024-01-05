using GeoMakie
using GLMakie

# Double-sided disk map: Gott, Goldberg and Vanderbei’s"
fig = Figure(; size=(1200, 600))
ax_top = GeoAxis(fig[1, 1]; dest="+proj=aeqd +lat_0=90 +lon_0=-45",
    title="top"
    )
ax_bottom = GeoAxis(fig[1, 2]; dest="+proj=aeqd +lat_0=-90 +lon_0=135",
    title="bottom"
    )

lines!(ax_top, GeoMakie.coastlines())
lines!(ax_bottom, GeoMakie.coastlines())
#ylims!(ax_bottom, -90, 0)
#ylims!(ax_top, 0, 90)
fig