# by Lazaro Alonso
# using GLMakie # HIDE
using GLMakie
GLMakie.activate!() # HIDE
let
    x = 1:10
    y = 1:10
    z = 1:10
    f(x,y,z) = x^2 + y^2 + z^2
    positions = vec([(i, j, k) for i in x,j in y, k in z])
    vals = [f(ix,iy,iz) for ix in x, iy in y, iz in z]
    fig, ax, pltobj = meshscatter(positions, color = vec(vals), 
        marker = FRect3D(Vec3f0(0), Vec3f0(10)), # here, if you use less than 10, you will see smaller squares. 
        colormap = :Spectral_11, colorrange = (minimum(vals), maximum(vals)), 
        transparency = true, # set to false, if you don't want the transparency. 
        shading= false, 
        figure = (; resolution = (800,800)),  
        axis=(; type=Axis3, perspectiveness = 0.5,  azimuth = 7.19, elevation = 0.57,  
            xlabel = "x label", ylabel = "y label", zlabel = "z label",
            aspect = (1,1,1)))
    cbar = Colorbar(fig, pltobj, label = "f values", height = Relative(0.5))
    xlims!(ax,-1,11)
    ylims!(ax,-1,11)
    zlims!(ax,-1,11)
    fig[1,2] = cbar
    fig
    #save("fileName.png", fig) # here, you save your figure. 
    save(joinpath(@__DIR__, "output", "volumeScatters.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie"]) # HIDE
