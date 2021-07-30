# By Lazaro Alonso
using GLMakie, ColorSchemes, Random
GLMakie.activate!() # HIDE 
function plotVolColormaps(; rseed = 123)
    Random.seed!(rseed)
    # all colormaps from colorschemes
    cs = collect(keys(colorschemes))
    cmapIdx = Node(1) 
    cmap = @lift(cs[$cmapIdx]) # @lift(Reverse(cs[$cmapIdx]))
    colors = @lift(to_colormap($cmap, 101))
    n = @lift(length($colors))
    # some transparencies in the colors
    g(x) = 0.5 + 0.5*tanh((x+3)/3)
    alphas = g.(-10:0.2:10)
    cmap_alpha = @lift(RGBAf0.($colors, alphas))
    # the actual figure
    n = 15
    x = randn(n)
    y = randn(n)
    z = randn(n)
    A = randn(n, n, n) ./ 3

    fig = Figure(resolution = (800,800))
    ax = Axis3(fig, aspect = (1,1,1), perspectiveness = 0.5, elevation = π/9)
    volume!(ax, x, y ,z, A, colormap = cmap_alpha, transparency =false)
    sl = Slider(fig[1, 2], range = 1:length(cs), startvalue = 400, horizontal = false)
    connect!(cmapIdx, sl.value)
    fig[1,1] = ax
    fig[0,1] = Label(fig, @lift("Colormap: $(cs[$cmapIdx])"), textsize = 20, 
        tellheight = true, tellwidth = false)
    fig
end
fig = with_theme(plotVolColormaps, theme_black())
save(joinpath(@__DIR__, "output", "plotVolColormaps.png"), fig, px_per_unit = 2.0) # HIDE
using Pkg # HIDE 
Pkg.status(["GLMakie", "ColorSchemes"]) #HIDE 