@def title = "earthquakeswgl"
@def hascode = true
@def tags = ["syntax", "code"]

## Earthquakes (interactive), depth not at scale

```julia:ex0
#hideall
using WGLMakie, JSServe, FileIO
using CSV, DataFrames, Downloads
using Colors, ColorSchemes, NCDatasets
io = IOBuffer()
println(io, "~~~")
show(io, MIME"text/html"(), Page(exportable=true, offline=true))
app = JSServe.App() do session::Session
    earth_img = load(Downloads.download("https://upload.wikimedia.org/wikipedia/commons/9/96/NASA_bathymetric_world_map.jpg"))
    
    function sphere(; r = 1.0, n = 32)
        θ = LinRange(0, π, n)
        φ = LinRange(-π, π, 2 * n)
        x = [r * cos(φ) * sin(θ) for θ in θ, φ in φ]
        y = [r * sin(φ) * sin(θ) for θ in θ, φ in φ]
        z = [r * cos(θ) for θ in θ, φ in φ]
        return (x, y, z)
    end

    # https://earthquake.usgs.gov/earthquakes/map/?extent=-68.39918,-248.90625&extent=72.60712,110.74219
    file1 = Downloads.download("https://github.com/lazarusA/BeautifulMakie/raw/main/_assets/data/2021_01_2021_05.csv")
    file2 = Downloads.download("https://github.com/lazarusA/BeautifulMakie/raw/main/_assets/data/2021_06_2022_01.csv")
    earthquakes1 = DataFrame(CSV.File(file1))
    earthquakes2 = DataFrame(CSV.File(file2))
    earthquakes = vcat(earthquakes1, earthquakes2)

    # depth unit, km
    function toCartesian(lon, lat; r = 1.02, cxyz = (0, 0, 0))
        x = cxyz[1] + (r + 1000_000) * cosd(lat) * cosd(lon)
        y = cxyz[2] + (r + 1000_000) * cosd(lat) * sind(lon)
        z = cxyz[3] + (r + 1000_000) * sind(lat)
        return (x, y, z) ./ 1000_000
    end

    lons, lats = earthquakes.longitude, earthquakes.latitude
    depth = earthquakes.depth
    toPoints3D = [Point3f([toCartesian(lons[i], lats[i]; r = -depth[i] * 1000)...]) for i in 1:length(lons)]

    ms = (exp.(earthquakes.mag) .- minimum(exp.(earthquakes.mag))) ./ maximum(exp.(earthquakes.mag) .- minimum(exp.(earthquakes.mag)))

    set_theme!(theme_black())
    fig = Figure(resolution = (1400, 1400), fontsize = 24)
    #ax = Axis3(fig[1, 1]; perspectiveness = 0.5)
    ax = LScene(fig[1, 1], show_axis = false)
    #meshscatter!(ax,rand(5), rand(5), rand(5); color = :white, markersize = 0.15, shading = true,)
    pltobj = meshscatter!(ax, toPoints3D; markersize = ms/ 20 .+ 0.001,
        color = earthquakes.mag,
        colormap = Reverse(:amp),
        shading = true,
        ambient = Vec3f(0.99, 0.99, 0.99))
    surface!(ax, sphere(; r = 1.0)...; color = earth_img, shading = true,
        colormap =(:oslo, 0.15),
        transparency = true,
    )

    Colorbar(fig[1, 2], pltobj, label = "Magnitude",
        height = Relative(1.5 / 4))
    Label(fig[1, 1, Bottom()], "Visualization by @LazarusAlon\nusing Makie")
    Label(fig[1, 1, Top()], "Earthquakes on Earth between January 2021 and January 2022.\nOriginal data from USGS")
    zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
    rotate!(ax.scene, 3.0)
    fig
    set_theme!()
    return JSServe.record_states(session, DOM.div(fig))
end
show(io, MIME"text/html"(), app)
println(io, "~~~")
println(String(take!(io)))
```
\textoutput{ex0}