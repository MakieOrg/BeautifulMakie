# ## SSAO and meshscatters

# ![](SSAO_meshscatter.png)

## from https://makie.juliaplots.org/v0.15/documentation/lighting/#examples
using GLMakie, Colors, LinearAlgebra
using Random: seed!
seed!(1313)
GLMakie.activate!(ssao=true)
GLMakie.closeall() # close any open screen

function ssaom()
    positions = [Point3f(x, y, rand()) for x in -7:7 for y in -5:5]
    fig = Figure(size=(1200, 800))
    ssao = Makie.SSAO(radius = 6.0, blur = 3)
    ax = LScene(fig[1, 1]; show_axis=false, scenekw=(ssao=ssao,))
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
save("SSAO_meshscatter.png", fig); # hide