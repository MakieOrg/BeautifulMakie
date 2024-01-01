using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

x = range(-3, 3, length=100)
y = range(-2, 2, length=100)
z = [sin(x + y^2) for x in x, y in y]
xpt = [x for x in x, y in y]
ypt = [y for x in x, y in y];

function boundary_values(a)
    return [a[1,:]..., a[2:end,end]..., a[end,end-1:-1:1]...,a[end-1:-1:1,1]...]
end

bxpt = boundary_values(xpt)
bypt = boundary_values(ypt)
bzpt = boundary_values(z)

upper = Point3f.(bxpt, bypt, bzpt)
lower = Point3f.(bxpt, bypt, bzpt*0.0 .+ minimum(bzpt))
lower_colors = bzpt*0.0 .+ minimum(bzpt);

# ## Plotting sides
with_theme(theme_dark()) do 
    colormap = :linear_worb_100_25_c53_n256
    fig = Figure()
    ax  = Axis3(fig[1,1]; aspect =(1,1,0.5),
        perspectiveness = 0.5f0,
        azimuth = -1.275π * 1.77,
        elevation = pi/4.5, protrusions=0)

    surface!(ax, xpt, ypt, z;
        colormap=(colormap, 0.1),
        shading = FastShading,
        transparency=true,
        )
    lines!(ax, upper; color = :white, linewidth=1.25,
        transparency=true)
    lines!(ax, lower; color = :gold, linewidth=1.25,
        transparency=true)
    band!(ax, lower, upper; color = bzpt, colormap)
    fig
end

# ## Sides, colour gradient bottom to top
with_theme(theme_dark()) do 
    colormap = :linear_worb_100_25_c53_n256
    fig = Figure()
    ax  = Axis3(fig[1,1]; aspect =(1,1,0.5),
        perspectiveness = 0.5f0,
        azimuth = -1.275π * 1.77,
        elevation = pi/4.5, protrusions=0)

    surface!(ax, xpt, ypt, z;
        colormap=(colormap, 0.1),
        shading = FastShading,
        transparency=true,
        )
    lines!(ax, upper; color = :white, linewidth=1.25,
        transparency=true)
    lines!(ax, lower; color = :gold, linewidth=1.25,
        transparency=true)
    band!(ax, lower, upper; color = [lower_colors..., bzpt...], colormap)
    fig
end

# ## Different views and options

with_theme(theme_dark(), size = (1250,1200)) do 
    colormap = :linear_worb_100_25_c53_n256
    fig = Figure()
    axs  = [Axis3(fig[i,j]; aspect =(1,1,0.5),
        perspectiveness = 0.5f0,
        azimuth = -1.275π * 1.77,
        elevation = pi/4.5, protrusions=0)
        for i in 1:2 for j in 1:2
    ]
    surface!(axs[1], xpt, ypt, z;
        colormap,
        shading = FastShading,
        transparency=false,
        )
    surface!(axs[2], xpt, ypt, z;
        colormap,
        shading = FastShading,
        transparency=true)
    lines!(axs[2], upper; color = :white, linewidth=1.25,
        transparency=true)
    lines!(axs[2], lower; color = :gold, linewidth=1.25,
        transparency=true)

    surface!(axs[3], xpt, ypt, z;
        colormap=(colormap, 0.1),
        shading = FastShading,
        transparency=true,
        )
    lines!(axs[3], upper; color = :white, linewidth=1.25,
        transparency=true)
    lines!(axs[3], lower; color = :gold, linewidth=1.25,
        transparency=true)
    band!(axs[3], lower, upper; color = bzpt, colormap)

    surface!(axs[4], xpt, ypt, z;
        colormap,
        shading = FastShading,
        transparency=false
        )
    lines!(axs[4], upper; color = :white, linewidth=1.25,
        transparency=true)
    lines!(axs[4], lower; color = :gold, linewidth=1.25,
        transparency=true)
    band!(axs[4], lower, upper; color = bzpt, colormap)
    fig
end