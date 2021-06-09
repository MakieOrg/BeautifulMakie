# by lazarusA # HIDE
#using GLMakie, Random # HIDE
using GLMakie
GLMakie.activate!() #HIDE
let
    x = LinRange(-2, 0.5, 501)
    y = LinRange(-2, 2, 501)
    # objective function
    z = 100 .* (y' .- x .^ 2) .^ 2 .+ (1 .- x) .^ 2
    # build constraints
    zin = copy(z)
    zout1 = copy(z)
    zout2 = copy(z)
    for (i,x) in enumerate(x), (j,y) in enumerate(y)
        if x*y >=1
            zin[i,j] = NaN
            zout1[i,j] = z[i,j]
            zout2[i,j] = NaN
        elseif (x + y^2) >=1
            zin[i,j] = NaN
            zout1[i,j] = NaN
            zout2[i,j] = z[i,j]
        else
            zin[i,j] = z[i,j]
            zout1[i,j] = NaN
            zout2[i,j] = NaN
        end
    end
    fig = Figure(resolution = (1200,900), fontsize = 20)
    ax = Axis3(fig, aspect = (1,1,1), perspectiveness = 0.5, elevation = π/9,
        azimuth = 0.2π, zgridcolor = :grey,ygridcolor=:grey,xgridcolor = :grey)
    pltobj = surface!(ax, x, y, zin, colormap = Reverse(:inferno))
    surface!(ax, x, y, zout1, colormap = (:orangered,:red))
    surface!(ax, x, y, zout2, colormap = (:dodgerblue,:blue))
    cbar = Colorbar(fig, pltobj, label = "xy <=1 & x + y^2<=1",
        height = Relative(0.5), width = 20 )
    fig[1,1] = ax
    fig[1,2] = cbar
    fig
    save(joinpath(@__DIR__, "output", "surfaceConstraints.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
