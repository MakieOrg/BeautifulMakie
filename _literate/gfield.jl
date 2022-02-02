using GLMakie, LaTeXStrings, Colors, ColorSchemes
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
#z = -1.7:0.05:1.7
set_theme!(theme_dark())
pot(i, j) = -1.5 / (1 + r(i, j))^(1 / 2)
xx = 10 .^ (range(-1.5, stop = log10(4), length = 50))
xx = vcat([0], xx)
θ = collect(range(0, 2π, length = 50))

x2 = xx .* cos.(θ)'
y2 = xx .* sin.(θ)'
z2 = pot.(x2, y2)
fig = Figure(resolution = (1200, 1200))
axs = LScene(fig[1, 1], show_axis = false)
#vol = [rand()/r(i,j,k)^(3) for i in x, j in y, k in z]
vol = [-1.5 / (1 + r(i, j))^(1 / 2) for i in x, j in y]

cmap = :cyclic_tritanopic_wrwc_70_100_c20_n256
colors = to_colormap(cmap, 101)
n = length(colors)
g(x) = exp(-x^2)
alphas = [g(x) for x in LinRange(-2, 3, 101)]
cmap = RGBAf.(colors, alphas)
s = 8.0
surface!(axs, x2, y2, z2, colormap = cmap, #colorrange = (0, 1.5),
    transparency = :true)
surface!(axs, x .+ s, y, vol, colormap = cmap, #colorrange = (0, 1.5),
    transparency = :true)
surface!(axs, x .+ s, y .+ s, vol, colormap = cmap, #colorrange = (0, 1.5),
    transparency = :true)
surface!(axs, x, y .+ s, vol, colormap = cmap, #colorrange = (0, 1.5),
    transparency = :true)
#wireframe!(axs, x3, y3, z3*0, color = (:white, 0.05), transparency = true)
wireframe!(axs, x2, y2, z2, color = (:white, 0.025), transparency = true)
wireframe!(axs, x .+ s, y, vol, color = (:white, 0.1), transparency = true)
wireframe!(axs, x .+ s, y .+ s, vol, color = (:white, 0.1), transparency = true)
wireframe!(axs, x, y .+ s, vol, color = (:white, 0.1), transparency = true)
#wireframe!(axs, x2, y2, z2; color = (:white, 0.2), transparency = true)
meshscatter!(axs, Point3f(0, 0, 0); color = :yellow, markersize = 0.8)
#hidedecorations!(axs)
#save("gfield.png", fig)
fig
set_theme!()