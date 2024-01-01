using GLMakie, LaTeXStrings, Colors, ColorSchemes
using FileIO
GLMakie.activate!()
GLMakie.closeall() # close any open screen

function alpha_colorbuffer(scene)
    bg = scene.backgroundcolor[]
    scene.backgroundcolor[] = RGBAf(0, 0, 0, 1)
    b1 = copy(Makie.colorbuffer(scene))
    scene.backgroundcolor[] = RGBAf(1, 1, 1, 1)
    b2 = Makie.colorbuffer(scene)
    scene.backgroundcolor[] = bg
    return map(infer_alphacolor, b1, b2)
end

function infer_alphacolor(rgb1, rgb2)
    rgb1 == rgb2 && return RGBAf(rgb1.r, rgb1.g, rgb1.b, 1)
    c1 = Float64.((rgb1.r, rgb1.g, rgb1.b))
    c2 = Float64.((rgb2.r, rgb2.g, rgb2.b))
    alpha = @. 1 - (c1 - c2) * -1 # ( / (0 - 1))
    meanalpha = clamp(sum(alpha) / 3, 0, 1)
    meanalpha == 0 && return RGBAf(0, 0, 0, 0)
    c = @. clamp((c1 / meanalpha), 0, 1)
    return RGBAf(c..., meanalpha)
end

xx = 10 .^ (range(-1.5, stop = log10(4), length = 20))
xx = vcat([0], xx)
x = y = vcat(-xx[end:-1:1], xx)
x3 = -4:0.25:4
y3 = -4:0.25:4
r(i, j) = sqrt(i^2 + j^2)

z3 = [-1.5 / (1 + r(i, j))^(1 / 2) for i in x3, j in y3]
x2 = -10:0.25:10
y2 = -10:0.25:10
z2 = [0 for i in x2, j in y2]

pot(i, j) = -1.5 / (1 + r(i, j))^(1 / 2)
xx = 10 .^ (range(-1.5, stop = log10(4), length = 50))
xx = vcat([0], xx)
θ = collect(range(0, 2π, length = 50))

x2 = xx .* cos.(θ)'
y2 = xx .* sin.(θ)'
z2 = pot.(x2, y2)
vol = [-1.5 / (1 + r(i, j))^(1 / 2) for i in x, j in y]

n = 101
cmap = :cyclic_tritanopic_wrwc_70_100_c20_n256
g(x) = exp(-x^2)
alphas = [g(x) for x in range(-2, 3, 101)]
cmap = resample_cmap(cmap, n; alpha=alphas)
s = 8.0

fig = with_theme(theme_dark()) do 
    fig = Figure(size = (1200, 1200))
    axs = LScene(fig[1, 1], show_axis = false)
    surface!(axs, x2, y2, z2, colormap = cmap, #colorrange = (0, 1.5),
        transparency = :true)
    surface!(axs, x2 .+ s, y2, z2, colormap = cmap, #colorrange = (0, 1.5),
        transparency = :true)
    surface!(axs, x2 .+ s, y2 .+ s, z2, colormap = cmap, #colorrange = (0, 1.5),
        transparency = :true)
    surface!(axs, x2, y2 .+ s, z2, colormap = cmap, #colorrange = (0, 1.5),
        transparency = :true)
    wireframe!(axs, x2, y2, z2, color = (:grey65, 0.1), transparency = true)
    wireframe!(axs, x2 .+ s, y2, z2, color = (:grey65, 0.15), transparency = true)
    wireframe!(axs, x2 .+ s, y2 .+ s, z2, color = (:grey65, 0.35), transparency = true)
    wireframe!(axs, x2, y2 .+ s, z2, color = (:grey65, 0.15), transparency = true)

    meshscatter!(axs, Point3f(0, 0, 0.2); color = "#e4c92a", markersize = 1.2)
    meshscatter!(axs, Point3f(0 + s, 0, 0.2); color = :white, markersize = 1.0)
    meshscatter!(axs, Point3f(0 + s, 0 + s, 0.2); color = "#dd3365", markersize = 1.0)
    meshscatter!(axs, Point3f(0, 0 + s, 0.2); color = "#3782b9", markersize = 1.0)
    zoom!(axs.scene, cameracontrols(axs.scene), 0.87)
    fig 
end
save("gfield.png", alpha_colorbuffer(fig.scene))

# ![](gfield.png)