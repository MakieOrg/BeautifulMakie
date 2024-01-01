using GLMakie
using FileIO, Downloads, JSON
using Makie.GeometryBasics: Pyramid
using GeometryBasics
using Colors, LinearAlgebra
GLMakie.activate!()
GLMakie.closeall() # close any open screen

pyr = Pyramid(Point3f(0), 1.0f0, 1.0f0)
rectmesh = Rect3(Point3f(-0.5), Vec3f(1))
sphere = Sphere(Point3f(-0.5), 1)
Cone(; quality=10) = merge([
    Makie._circle(Point3f(0), 0.5f0, Vec3f(0, 0, -1), quality),
    Makie._mantle(Point3f(0), Point3f(0, 0, 1), 0.5f0, 0.0f0, quality)])
cone = Cone()

brain = load(assetpath("brain.stl"))
matball = load(assetpath("matball_base.obj"))
matball_inner = load(assetpath("matball_inner.obj"))
matball_outer = load(assetpath("matball_outer.obj"))
## download more ids from here:
## https://raw.githubusercontent.com/MakieOrg/BeautifulMakie/main/data/
#ids = JSON.parsefile("matcapIds.json")

ids = ["F79686_FCCBD4_E76644_E76B56",
    "F9E6C7_FCF7DF_EDD3AA_F1D4B4",
    "FBB43F_FBE993_FB552E_FCDD65",
    "FBB82D_FBEDBF_FBDE7D_FB7E05"]
function plotmat()
    idx = Observable(1)
    idpng = @lift(ids[$idx])
    matcap = @lift(load(Downloads.download("https://raw.githubusercontent.com/nidorx/matcaps/master/1024/$($idpng).png")))
    ambient = Vec3f(0.8, 0.8, 0.8)
    shading = FastShading
    fig = Figure(size=(1200, 900))
    axs = [LScene(fig[i, j]; show_axis=false)
            for j in 1:3, i in 1:2]
    mesh!(axs[5], sphere; matcap, shading, ambient)
    mesh!(axs[3], rectmesh; matcap, shading, ambient, transparency=true)
    mesh!(axs[4], pyr; matcap, shading, ambient)
    mesh!(axs[2], matball; matcap, shading, ambient)
    mesh!(axs[2], matball_inner; matcap, shading, ambient)
    mesh!(axs[2], matball_outer; matcap, shading, ambient)
    mesh!(axs[6], cone; matcap, shading, ambient)
    mesh!(axs[1], brain; matcap, shading, ambient)
    GLMakie.rotate!(axs[2].scene, 2.35)
    center!(axs[2].scene)
    zoom!(axs[2].scene, cameracontrols(axs[2].scene), 0.75)
    zoom!(axs[3].scene, cameracontrols(axs[3].scene), 1.2)
    zoom!(axs[4].scene, cameracontrols(axs[4].scene), 1.2)
    sl = Slider(fig[1:2, 4], range=1:length(ids), startvalue=2, horizontal=false)
    connect!(idx, sl.value)
    fig[0, 1:3] = GLMakie.Label(fig, @lift("idnum [$(1*$idx)] png material : $(ids[$idx])"), fontsize=20,
        tellheight=true, tellwidth=false)
    fig
end
fig = with_theme(plotmat, theme_dark())
save("matcap.png", fig); # hide

# ![](matcap.png)