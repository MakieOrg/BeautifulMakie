# example modified from  mthelm85
# by lazarusA # HIDE
# using GLMakie # HIDE
using GLMakie, ForwardDiff
GLMakie.activate!()
let
    f(x,y) = -5*x*y*exp(-x^2-y^2)
    x = -1:0.05:1.0
    y = -1:0.05:1.0
    z = [f(i,j) for i in x, j in y]
    # This is the same function as above, just modified so that it will
    # work with ForwardDiff
    g(x,y) = [-5*x*y*exp(-x^2-y^2)]
    J(xx,yy) = ForwardDiff.jacobian(x -> g(x[1], x[2]), [xx,yy])
    field(i,j) = Point(J(i,j)[1], J(i,j)[2])

    zmin, zmax = minimum(z), maximum(z)
    cmap = :viridis
    function plot()
        fig = Figure(resolution = (1200,600))
        ax1 = Axis3(fig, aspect = (1,1,1), perspectiveness = 0.5,
            elevation = π/3.5, azimuth = 0.1π, )
        ax2 = Axis(fig, aspect = DataAspect(), xlabel = "x", ylabel = "y")
        surface!(ax1, x, y, z, colormap = cmap, colorrange = (zmin, zmax))
        contour3d!(ax1, x, y, z .+ 0.005, levels = 15, linewidth = 2, color=(:white, 0.5))
        wireframe!(ax1, x, y, z, overdraw = false, transparency = true, color = (:black, 0.1))
        streamplot!(ax1, field, -1..1, -1..1, colormap = cmap, gridsize= (40,40),
            arrow_size = 0.05,linewidth=1, transformation = (:xy, -zmax))
        streamplot!(ax2, field, -1..1, -1..1, colormap = cmap, gridsize= (40,40),
                arrow_size = 0.03,linewidth=1)
        fig[1,1] = ax1
        fig[1,2] = ax2
        fig
    end
    fig = with_theme(plot, theme_dark())
    save(joinpath(@__DIR__, "output", "theme_dark_Contour3d.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie","ForwardDiff"]) # HIDE
