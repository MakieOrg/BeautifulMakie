# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    U = LinRange(-pi, pi, 100)
    V = LinRange(-pi, pi, 20)
    x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
    y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
    z1 = [.5 * sin(v)                        for u in U, v in V]
    x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
    y2 = [.5 * sin(v)                        for u in U, v in V]
    z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]

    fig = Figure(resolution =(1200,800))
    ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))

    tori1 = surface!(ax, x1, y1, z1, colormap = :viridis, shading=false)
    tori2 = surface!(ax, x2, y2, z2, colormap = :plasma, shading=false)
    wireframe!(ax, x1, y1, z1, linewidth = 0.85)

    axis = ax.scene[OldAxis]
    axis[:names, :axisnames] = ("x", "y", "z")
    tstyle = axis[:names] #  get the nested attributes and work directly with them

    tstyle[:textsize] = 15
    tstyle[:textcolor] = (:red, :green, :black)
    tstyle[:font] = "helvetica"
    tstyle[:gap] = 10
    axis[:ticks][:textcolor] = :black
    axis[:ticks][:textsize] = 10
    cbar1 = Colorbar(fig, tori1, label = "z",width = 25, ticklabelsize = 30,
        labelsize = 30, ticksize=25, tickalign = 1, height = Relative(3/4)
    )
    cbar2 = Colorbar(fig, tori2, label = "z",width = 25, flipaxis = false,
        labelsize = 30, ticklabelsize = 30, ticksize=25, tickalign = 1,
        height = Relative(3/4))
    fig[1, 2] = ax
    fig[1, 3] = cbar1
    fig[1, 1] = cbar2
    colgap!(fig.layout, 2)
    fig
    save(joinpath(@__DIR__, "output", "wireSurfToris.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
