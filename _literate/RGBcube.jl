# by Lazaro Alonso
using GLMakie, Colors
using GeometryBasics: Rect3f
GLMakie.activate!() # HIDE
let
    positions = vec([Point3f(i / 5, j / 5, k / 5) for i = 1:7, j = 1:7, k = 1:7]) # note 7 > 5 [factor in each i,j,k], whichs is misleading
    fig, ax, obj = meshscatter(positions; marker = Rect3f(Vec3f(-0.5), Vec3f(1.8)),
        transparency = true,
        color = [RGBA(positions[i]..., 0.5) for i in 1:length(positions)],
        figure = (; resolution = (1200, 800))
    )
    save(joinpath(@__DIR__, "output", "RGBcube.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie", "GeometryBasics", "Colors"]) # HIDE
