md"""
## Screen-Space Ambient Occlusion, SSAO
"""
## from https://makie.juliaplots.org/v0.15/documentation/lighting/#examples
using GLMakie, Colors, LinearAlgebra
using Random: seed!
seed!(1313)
GLMakie.activate!() # HIDE
GLMakie.enable_SSAO[] = true
close(GLMakie.global_gl_screen()) ## close any open screen
let
    function ssaom()
        positions = [Point3f(x, y, rand()) for x in -7:7 for y in -5:5]
        fig = Figure(resolution=(1200, 800))
        ax = LScene(fig[1, 1]; show_axis=false,
            scenekw=(SSAO = (radius=6.0, blur=3.5)))
        ax.scene.ssao.bias[] = 0.025
        meshscatter!(ax, positions; marker=Rect3(Point3f(-0.5), Vec3f(1)),
            markersize=1, color=norm.(positions),
            colormap=Reverse(:tol_light),
            ssao=true
        )
        zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
        fig
    end
    fig = ssaom()
    save(joinpath(@OUTPUT, "ssao_simple.png"), fig) # HIDE
end;
# \fig{ssao_simple.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie", "Colors", "LinearAlgebra", "Random"]) # HIDE
