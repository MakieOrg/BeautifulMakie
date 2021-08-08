# by Lazaro Alonso
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    x = 1:10
    y = 1:10
    z = 1:10
    f(x,y,z) = x^2 + y^2 + z^2
    vol = [f(ix,iy,iz) for ix in x, iy in y, iz in z]
    fig, ax, _ = volume(x, y, z, vol, colormap = :plasma, colorrange = (minimum(vol), maximum(vol)),
        figure = (; resolution = (800,800)),  
        axis=(; type=Axis3, perspectiveness = 0.5,  azimuth = 7.19, elevation = 0.57,  
            aspect = (1,1,1)))

    fig
    save(joinpath(@__DIR__, "output", "volume.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
