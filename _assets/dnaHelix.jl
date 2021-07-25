using GLMakie
npairs = 20
θinit = 10*π/180
offset = 10
pairs = collect(1:npairs)
θ = pairs .* θinit
x(θ; rₕ = 1) = rₕ * cos(θ) 
y(θ; rₕ = 1) = rₕ * sin(θ) 
z = pairs #.+ offset
colors1 = rand(1:4, npairs) # 1, 2, 3, 4 =>  'A', 'T', 'C', 'G'
colors2 = [i == 1 ? 2 : i==2 ? 1 : i == 3 ? 4 : 3 for i in colors1]
cmap = cgrad(:Set1_4, 4, categorical = true) 
x1, y1 = x.(θ), y.(θ)
x2, y2 = x.(θ .+ π), y.(θ .+ π)
with_theme(theme_dark()) do  
    fig, ax, pltobj = meshscatter(x1, y1,  z, color = colors1, colormap = cmap, colorrange = (0.5, 4.5),
        axis=(type=Axis3, aspect = :data,))
    meshscatter!(ax, x2, y2,  z, color = colors2, colormap = cmap, colorrange = (0.5, 4.5) )
    [lines!(ax, [x1[i], x2[i]], [y1[i], y2[i]], [z[i], z[i]]) for i in 1:npairs] # a better way to do it? 

    
    cbar = Colorbar(fig, pltobj, vertical = false, flipaxis = false,
        ticks =(1:4, ["A", "T", "C", "G"]))
    hidedecorations!(ax, grid=false)
    fig[2,1] = cbar
    fig
end