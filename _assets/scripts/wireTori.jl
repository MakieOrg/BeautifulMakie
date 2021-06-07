# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    U = LinRange(-pi, pi, 100) # 50
    V = LinRange(-pi, pi, 20)
    x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
    y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
    z1 = [.5 * sin(v)                        for u in U, v in V]
    x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
    y2 = [.5 * sin(v)                        for u in U, v in V]
    z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
    fig = Figure(resolution =(900,600))
    ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
    wireframe!(x1,y1,z1, shading = false)
    axis = ax.scene[OldAxis]
    tstyle = axis[:names]
    tstyle[:textsize] = 16
    tstyle[:gap] = 8
    axis[:ticks][:textcolor] = :black
    axis[:ticks][:textsize] = 10
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "wireTori.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
