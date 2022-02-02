# by Lazaro Alonso
using GLMakie, ColorSchemes
GLMakie.activate!() # HIDE
let
    x = y = z = 1:10
    f(x, y, z) = x^2 + y^2 + z^2
    vol = [f(ix, iy, iz) for ix in x, iy in y, iz in z]
    fig, ax, _ = volume(x, y, z, vol; colorrange = (minimum(vol), maximum(vol)),
        colormap = :Egypt, transparency = true,
        figure = (; resolution = (1200, 800)),
        axis = (; type = Axis3, perspectiveness = 0.5, azimuth = 2.19, elevation = 0.57,
            aspect = (1, 1, 1)))
    save(joinpath(@__DIR__, "output", "volume.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
