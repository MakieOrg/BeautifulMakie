# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, Random
CairoMakie.activate!() # HIDE
let
    Random.seed!(123)
    x = -3:0.05:3
    y = exp.(-x.^2)
    n = 15
    y[1:n] = y[1:n] .+ 0.02*randn(n)
    fig = Figure(resolution = (700, 450))
    ax1 = Axis(fig, xlabel = "x", ylabel = "f(x)", xgridvisible = true,
              ygridvisible = true)
    ax2 = Axis(fig, bbox = BBox(140, 260, 260, 350), xticklabelsize = 12,
            yticklabelsize = 12, showgrid=false,
            title = "inset  at (100, 300, 100, 200)")
    line1 = lines!(ax1, x, y, color = :red)
    # inset
    lines!(ax2, x, y, color = :red)
    limits!(ax2, -3.1,-1.9,-0.05,0.05)
    ax2.yticks = [-0.05,0,0.05]
    ax2.xticks = [-3,-2.5,-2]
    translate!(ax2.scene, 0, 0, 10)
    translate!(ax2.elements[:background], 0, 0, 9)
    translate!(ax2.elements[:xgridlines], 0, 0, 9)
    translate!(ax2.elements[:ygridlines], 0, 0, 9)

    leg = Legend(fig, [line1], ["f(x)"], halign = :right, valign = :top,
    tellheight =false, tellwidth = false, margin = (10, 10, 10, 10),)
    fig[1, 1] = ax1
    fig[1, 1] = leg
    #save("Fig2Lines.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "LineWithInset.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
