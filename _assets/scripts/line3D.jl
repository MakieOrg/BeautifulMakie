# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    t = 0:0.1:15
    fig, _ = lines(sin.(t), cos.(t), t/4, color = t/4, linewidth = 4,
        colormap = :plasma)
    fig
    save(joinpath(@__DIR__, "output", "line3D.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
