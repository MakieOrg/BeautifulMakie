using GLMakie, LaTeXStrings, SpecialFunctions, Random
GLMakie.activate!()
GLMakie.closeall() # close any open screen

Random.seed!(13)
with_theme(theme_black()) do
    fig = Figure(size = (1200,800)) 
    ax = Axis3(fig; 
        aspect = (1,0.5,0.5), 
        azimuth = 10.42, 
        elevation = 0.027, 
        perspectiveness=0.5)
    x = 0:0.1:15
    y = -1:0.1:7
    horizontal = Point3f.(tuple.(15, y, 3exp.(-(y .-3).^2/3)))
    for ν in 0:7
        lines!(ax, x, x*0 .+ ν, besselj.(ν, x) .+ ν/3; 
            linewidth = 2, 
            color = :grey90, 
            label = latexstring("J_{$(ν)}(x)"))
        band!(ax, Point3f.(tuple.(x, ν, ν/3)), 
            Point3f.(tuple.(x, ν, besselj.(ν, x) .+ ν/3));
            color = 1:length(x), 
            colormap = :plasma)
        text!(ax, latexstring("J_{$(ν)}(x)"), position = Point3f(15.2,ν, ν/3))
    end
    band!(ax, Point3f.(tuple.(0, y, 0.0)), 
        Point3f.(tuple.(0, y, 3exp.(-(y .-3).^2/3))); color = rand(length(y)))
    band!(ax, horizontal[1:40], reverse(horizontal[42:end]); color = 1:40, 
        colormap = :bone_1)
    lines!(ax, horizontal; color= :white, linewidth = 2)
    hidedecorations!(ax; grid = false)
    fig[1,1] = ax
    fig
end