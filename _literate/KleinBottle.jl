md"""
## Surface: Klein Bottle
"""
## by Lazaro Alonso
using GLMakie
GLMakie.activate!()
let
    ## The bottle
    u = LinRange(0, π, 100)
    v = LinRange(0, 2π, 100)
    x = [-2 / 15 * cos(u) * (3 * cos(v) - 30 * sin(u) + 90 * cos(u)^4 * sin(u)
        - 60 * cos(u)^6 * sin(u) + 5 * cos(u) * cos(v) * sin(u)) for u in u, v in v]
    y = [-1 / 15 * sin(u) * (3 * cos(v) - 3 * cos(u)^2 * cos(v) - 48 * cos(u)^4 * cos(v) + 48 * cos(u)^6 * cos(v)
        - 60 * sin(u) + 5 * cos(u) * cos(v) * sin(u) - 5 * cos(u)^3 * cos(v) * sin(u)
        - 80 * cos(u)^5 * cos(v) * sin(u) + 80 * cos(u)^7 * cos(v) * sin(u)) for u in u, v in v]
    z = [2 / 15 * (3 + 5 * cos(u) * sin(u)) * sin(v) for u in u, v in v]

    fig = Figure(resolution = (1200, 800))
    ax = LScene(fig[1, 1], show_axis = false)
    surface!(ax, x, y, z; color = sqrt.(x.^2 .+ y.^2), colormap = (:Spectral_11, 0.8))
    save(joinpath(@OUTPUT, "KleinBottle.png"), fig, px_per_unit = 2.0) # HIDE
    ## display(fig)
end;
# \fig{KleinBottle.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
