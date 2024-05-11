# ## meshscatters and distributions

# ![](gauss2d.png)

using GLMakie, Random
GLMakie.activate!()
GLMakie.closeall() # close any open screen

Random.seed!(13)
x = -6:0.5:6
y = -6:0.5:6
z = 6exp.( -(x.^2 .+ y' .^ 2)./4)

box = Rect3(Point3f(-0.5), Vec3f(1))
n = 100
g(x) = x^(1/10)
alphas = [g(x) for x in range(0,1,length=n)]
cmap_alpha = resample_cmap(:linear_worb_100_25_c53_n256, n, alpha = alphas)

with_theme(theme_dark()) do
    fig, ax, = meshscatter(x, y, z; 
        marker=box, 
        markersize = 0.5, 
        color = vec(z), 
        colormap = cmap_alpha,
        colorrange = (0,6),
        axis = (; 
            type = Axis3, 
            aspect = :data, 
            azimuth = 7.3, 
            elevation = 0.189, 
            perspectiveness = 0.5), 
        figure = (;
            size =(1200,800)))
    meshscatter!(ax, x .+ 7, y, z./2; 
        markersize = 0.25, 
        color = vec(z./2), 
        colormap = cmap_alpha, 
        colorrange = (0, 6), 
        #ambient = Vec3f(0.85, 0.85, 0.85), # lights?
        backlight = 1.5f0)
    xlims!(-5.5,10)
    ylims!(-5.5,5.5)
    hidedecorations!(ax; grid = false)
    hidespines!(ax)
    fig
end
save("gauss2d.png", current_figure()); # hide