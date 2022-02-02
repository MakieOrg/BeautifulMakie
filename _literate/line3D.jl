# by Lazaro Alonso
using GLMakie
GLMakie.activate!() # HIDE
let
    t = 0:0.1:15
    fig = lines(sin.(t), cos.(t), t/4, color = t/4, linewidth = 4,
        colormap = :plasma)
    save(joinpath(@__DIR__, "output", "line3D.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
