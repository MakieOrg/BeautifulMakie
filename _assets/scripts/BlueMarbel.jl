# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie, FileIO
GLMakie.activate!() # HIDE
let
    earth_img = load(download("https://upload.wikimedia.org/wikipedia/commons/5/56/Blue_Marble_Next_Generation_%2B_topography_%2B_bathymetry.jpg"))
    n = 1024 # 2048
    θ = LinRange(0,pi,n)
    φ = LinRange(0,2*pi,2*n)
    x = [cos(φ)*sin(θ) for θ in θ, φ in φ]
    y = [sin(φ)*sin(θ) for θ in θ, φ in φ]
    z = [cos(θ) for θ in θ, φ in φ]
    fig = Figure(resolution = (900,900), backgroundcolor = :grey90)
    ax = Axis3(fig, aspect = :data, viewmode = :fitzoom, #perspectiveness = 0.5,
        azimuth = 0.4π, elevation = 0.2π,)
    surface!(ax, x, y, z, color = earth_img, shading = true,
        lightposition = Vec3f0(-2, -3, -3), ambient = Vec3f0(0.8, 0.8, 0.8),
        backlight = 1.5f0)
    hidedecorations!(ax)
    hidespines!(ax)
    fig[1,1] = ax
    fig
    save(joinpath(@__DIR__, "output", "BlueMarbel.png"), fig, px_per_unit = 2.0) # HIDE
end


using Pkg # HIDE
Pkg.status(["GLMakie","FileIO", "ImageMagick", "QuartzImageIO"]) # HIDE
