# ## Blue marble

# ![](blue_marble.png)

using GLMakie, FileIO
using Downloads: download
GLMakie.activate!() 
GLMakie.closeall() # hide

earth_img = load(download("https://upload.wikimedia.org/wikipedia/commons/5/56/Blue_Marble_Next_Generation_%2B_topography_%2B_bathymetry.jpg"))
n = 1024 ÷ 4 # 2048
θ = LinRange(0, π, n)
φ = LinRange(0, 2π, 2 * n)
x = [cos(φ) * sin(θ) for θ in θ, φ in φ]
y = [sin(φ) * sin(θ) for θ in θ, φ in φ]
z = [cos(θ) for θ in θ, φ in φ]

fig = Figure(size = (1200, 800), backgroundcolor = :grey80)
ax = LScene(fig[1, 1], show_axis = false)
surface!(ax, x, y, z; 
    color = earth_img,
    shading = NoShading,
    lightposition = Vec3f(-2, -3, -3), 
    ambient = Vec3f(0.8, 0.8, 0.8),
    backlight = 1.5f0,
    )
zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
GLMakie.rotate!(ax.scene, Vec3f(0, 0, 1), 3.0)
fig

save("blue_marble.png", fig; update=false); # hide