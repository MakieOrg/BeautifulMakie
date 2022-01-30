#by Lazaro Alonso
using CSV, DataFrames
using GLMakie
using FileIO, Downloads
let
    urlimg = "https://upload.wikimedia.org/wikipedia/commons/9/96/NASA_bathymetric_world_map.jpg"
    earth_img = load(Downloads.download(urlimg))
    function sphere(; r = 1.0, n = 32)
        θ = LinRange(0, π, n)
        φ = LinRange(-π, π, 2 * n)
        x = [r * cos(φ) * sin(θ) for θ in θ, φ in φ]
        y = [r * sin(φ) * sin(θ) for θ in θ, φ in φ]
        z = [r * cos(θ) for θ in θ, φ in φ]
        return (x, y, z)
    end

    # https://earthquake.usgs.gov/earthquakes/map/?extent=-68.39918,-248.90625&extent=72.60712,110.74219
    path = "/Users/lalonso/Desktop/BeautifulMakie/_assets" # hide
    urldata = "https://github.com/lazarusA/BeautifulMakie/raw/main/_assets/data/"

    file1 = Downloads.download(urldata * "2021_01_2021_05.csv")
    file2 = Downloads.download(urldata * "2021_06_2022_01.csv")
    earthquakes1 = DataFrame(CSV.File(file1))
    earthquakes2 = DataFrame(CSV.File(file2))
    earthquakes3 = DataFrame(CSV.File(path * "/data/2022_01_08_2022_02_15.csv"))

    earthquakes = vcat(earthquakes1, earthquakes2, earthquakes3)
    earthquakes = unique(sort(earthquakes, [:time]))

    # depth unit, km
    function toCartesian(lon, lat; r = 1.02, cxyz = (0, 0, 0))
        x = cxyz[1] + (r + 1500_000) * cosd(lat) * cosd(lon)
        y = cxyz[2] + (r + 1500_000) * cosd(lat) * sind(lon)
        z = cxyz[3] + (r + 1500_000) * sind(lat)
        return (x, y, z) ./ 1500_000
    end

    lons, lats = earthquakes.longitude, earthquakes.latitude
    depth = earthquakes.depth
    mag = earthquakes.mag

    toPoints3D = [Point3f([toCartesian(lons[i], lats[i];
        r = -depth[i] * 1000)...]) for i in 1:length(lons)]
    ms = (exp.(mag) .- minimum(exp.(mag))) ./ maximum(exp.(mag) .- minimum(exp.(mag)))
    index = Observable(length(toPoints3D))

    set_theme!(theme_black())
    fig = Figure(resolution = (1400, 1400), fontsize = 24)
    ax = LScene(fig[1, 1], show_axis = false)
    pltobj = meshscatter!(ax, @lift(toPoints3D[1:$index]);
        markersize = @lift(ms[1:$index] / 20 .+ 0.001),
        color = 1:length(toPoints3D),
        colormap = tuple.(to_colormap(:Spectral_11)[5:end-5], 0.75),
        shading = true, ambient = Vec3f(1, 1, 1))
    surface!(ax, sphere(; r = 1.0)..., color = tuple.(earth_img, 0.1), shading = true,
        transparency = true)
    cbar = Colorbar(fig[1, 2], pltobj, height = Relative(1.5 / 4))
    cbar.ticks = ([1, length(toPoints3D) ÷ 4, length(toPoints3D) ÷ 2, 3(length(toPoints3D) ÷ 4), length(toPoints3D)],
        [earthquakes[1, :time][1:10], earthquakes[length(toPoints3D)÷3, :time][1:10],
            earthquakes[length(toPoints3D)÷2, :time][1:10], earthquakes[3(length(toPoints3D)÷4), :time][1:10], earthquakes[end, :time][1:10]])
    Label(fig[1, 1, Bottom()], "Visualization by @LazarusAlon\nusing Makie")
    Label(fig[1, 1, Top()], @lift("Earthquakes on Earth between January 2021 and January 2022.\nOriginal data from USGS\n $(earthquakes[1, :time]) : $(earthquakes[$index, :time])"))
    zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
    rotate!(ax.scene, 3.0)
    display(fig)
    save(joinpath(@__DIR__, "output", "earthquakesTimeSd_1.png"), fig, px_per_unit = 2.0)

    record(fig, joinpath(@__DIR__, "output", "earthquakesTimeSd_1.mp4"), framerate = 24) do io
        for i in 3.0:0.015:10.5
            rotate!(ax.scene, i)
            recordframe!(io)  # record a new frame
        end
    end
end

using Pkg # HIDE
Pkg.status(["GLMakie", "CSV", "DataFrames", "FileIO", "Downloads"]) # HIDE