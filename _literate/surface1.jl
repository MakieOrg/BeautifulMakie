md"""
## Surface: branching
"""
## by Lazaro Alonso
using GLMakie
GLMakie.activate!()
let
    t = 0:0.1:15
    u = -1:0.1:1
    x = [u * sin(t) for t in t, u in u]
    y = [u * cos(t) for t in t, u in u]
    z = [t / 4 for t in t, u in u]
    set_theme!()
    fig = surface(x, y, z; colormap = (:orangered, :orangered),
        lightposition = Vec3f(0, 0, 0), ambient = Vec3f(0.65, 0.65, 0.65),
        backlight = 5.0f0, figure = (; resolution = (1200, 800)))
    wireframe!(x, y, z, overdraw = false, linewidth = 0.1) # try overdraw = true
    save(joinpath(@OUTPUT, "surface1.png"), fig) # HIDE
    display(fig)
end;
# \fig{surface1.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
