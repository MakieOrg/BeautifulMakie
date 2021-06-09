# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    t = 0:0.1:2π
    u = -1:0.1:1
    x = [u*sin(t) for t in t, u in u]
    y = [u*cos(t) for t in t, u in u]
    z = [u        for t in t, u in u]
    fig, _ = surface(x, y, z, colorrange = (-2,-1.1), highclip = :dodgerblue,
        lightposition = Vec3f0(0, 0, 0.8), ambient = Vec3f0(0.6, 0.6, 0.6),
        backlight = 5f0) # the colorrange must be outside the range of z
    wireframe!(x,y,z, overdraw = false, linewidth = 0.1) # try overdraw = true
    fig
    save(joinpath(@__DIR__, "output", "surface1Color.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
