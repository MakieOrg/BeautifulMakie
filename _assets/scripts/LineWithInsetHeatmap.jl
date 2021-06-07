# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
    x = y = -10:0.11:10
    y1d =  sin.(x) ./ x
    # 3D heatmap
    sinc2d(x,y) = sin.(sqrt.(x.^2 + y.^2))./sqrt.(x.^2+y.^2)
    fxy = [sinc2d(x,y) for x in x, y in y]

    fig = Figure(resolution = (700, 450))
    ax1 = Axis(fig, xlabel = "x", ylabel = "f(x)", xgridvisible = true,
            ygridvisible = true)
    ax2 = Axis(fig, bbox = BBox(140, 260, 260, 350), xticklabelsize = 12,
          yticklabelsize = 12, showgrid=false,
          title = "inset  at (140, 260, 260, 350)")
    line1 = lines!(ax1, x, y1d, color = :red)
    # inset
    hmap = heatmap!(ax2, x, y,fxy, colormap = :Spectral_11)
    limits!(ax2, -10,10,-10,10)
    hidespines!(ax2)
    ax2.yticks = [-10,0,10]
    ax2.xticks = [-10,0,10]

    leg = Legend(fig, [line1], ["sinc(x)"], halign = :right, valign = :top,
        tellheight = false, tellwidth = false,)
    cbar = Colorbar(fig, hmap, label ="sinc(x,y)", labelpadding = 5,
        tellheight = false, tellwidth = false, ticklabelsize = 12,
        width = 10, height = Relative(1.5/4), halign = :right, valign = :center)

    fig[1, 1] = ax1
    fig[1, 1] = leg
    fig[1, 1] = cbar
    #save("LineWithInsetHeatmap.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "LineWithInsetHeatmap.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
