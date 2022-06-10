# by Lazaro Alonso
using GLMakie
GLMakie.activate!() # HIDE
let
    U = LinRange(-pi, pi, 100)
    V = LinRange(-pi, pi, 20)
    x1 = [cos(u) + 0.5 * cos(u) * cos(v) for u in U, v in V]
    y1 = [sin(u) + 0.5 * sin(u) * cos(v) for u in U, v in V]
    z1 = [0.5 * sin(v) for u in U, v in V]
    x2 = [1 + cos(u) + 0.5 * cos(u) * cos(v) for u in U, v in V]
    y2 = [0.5 * sin(v) for u in U, v in V]
    z2 = [sin(u) + 0.5 * sin(u) * cos(v) for u in U, v in V]

    fig = Figure(resolution = (1200, 800))
    ax = LScene(fig, show_axis = true)
    tori1 = surface!(ax, x1, y1, z1; colormap = :viridis, shading = false,
        transparency = true)
    tori2 = surface!(ax, x2, y2, z2; colormap = :plasma, shading = false,
        transparency = false)
    wireframe!(ax, x1, y1, z1; linewidth = 0.5, transparency = true)

    axis = ax.scene[OldAxis]
    axis[:names, :axisnames] = ("x", "y", "z")
    tstyle = axis[:names] #  get the nested attributes and work directly with them

    tstyle[:textsize] = 15
    tstyle[:textcolor] = (:red, :green, :black)
    tstyle[:font] = "helvetica"
    tstyle[:gap] = 10
    axis[:ticks][:textcolor] = :black
    axis[:ticks][:textsize] = 10
    cbar1 = Colorbar(fig, tori1, label = "z", width = 25, ticklabelsize = 20,
        labelsize = 20, ticksize = 25, tickalign = 1, height = Relative(0.5))
    cbar2 = Colorbar(fig, tori2, label = "z", width = 25, flipaxis = false,
        labelsize = 20, ticklabelsize = 20, ticksize = 25, tickalign = 1,
        height = Relative(0.5))
    fig[1, 2] = ax
    fig[1, 3] = cbar1
    fig[1, 1] = cbar2
    colgap!(fig.layout, 2)
    save(joinpath(@__DIR__, "output", "wireSurfToris.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
