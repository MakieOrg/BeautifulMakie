# by Lazaro Alonso
using GLMakie, FileIO
using Downloads: download
GLMakie.activate!() # HIDE
let
    earth_img = load(download("https://upload.wikimedia.org/wikipedia/commons/5/56/Blue_Marble_Next_Generation_%2B_topography_%2B_bathymetry.jpg"))
    n = 1024 ÷ 4 # 2048
    θ = LinRange(0, π, n)
    φ = LinRange(0, 2π, 2 * n)
    x = [cos(φ) * sin(θ) for θ in θ, φ in φ]
    y = [sin(φ) * sin(θ) for θ in θ, φ in φ]
    z = [cos(θ) for θ in θ, φ in φ]
    fig = Figure(resolution = (1200, 800), backgroundcolor = :grey80)
    ax = LScene(fig[1, 1], show_axis = false)
    surface!(ax, x, y, z; color = earth_img, shading = true,
        lightposition = Vec3f(-2, -3, -3), ambient = Vec3f(0.8, 0.8, 0.8),
        backlight = 1.5f0)
    save(joinpath(@__DIR__, "output", "BlueMarbel.png"), fig, px_per_unit = 2.0) # HIDE
    display(fig)
end
using Pkg # HIDE
Pkg.status(["GLMakie", "FileIO", "ImageMagick", "QuartzImageIO"]) # HIDE
