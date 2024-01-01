using GLMakie
GLMakie.activate!() 
GLMakie.closeall() # close any open screen

function peaks(; n = 49)
    x = LinRange(-3, 3, n)
    y = LinRange(-3, 3, n)
    a = 3 * (1 .- x').^2 .* exp.(-(x'.^2) .- (y .+ 1).^2)
    b = 10 * (x' / 5 .- x'.^3 .- y.^5) .* exp.(-x'.^2 .- y.^2)
    c = 1 / 3 * exp.(-(x' .+ 1).^2 .- y.^2)
    return (x, y, a .- b .- c)
end
x, y, z = peaks(; n=30)
with_theme(theme_dark()) do
    fig =  Figure(size = (1200,800))
    axs = [Axis3(fig[1,i]; aspect = :data) for i in 1:3]
    contour3d!(axs[1], x, y, z; levels = 20, transparency = true)
    contour!(axs[1], x, y, z; levels = 20, transformation = (:xy, minimum(z)), 
        transparency = true)
    lines!(axs[2], cat(x, NaN, dims=1), y, vcat(z, fill(NaN,30)'), 
        color = maximum(z, dims=1)[1,:], transparency = false)
    lines!(axs[2], cat(x, NaN, dims=1), y, 
        vcat(z, fill(NaN,30)')*0 .+ minimum(z); color = maximum(z, dims=1)[1,:], 
        transparency = true)
    wireframe!(axs[3], x, y, z; color = :grey90, transparency = true)
    wireframe!(axs[3], x, y, z*0 .+ minimum(z); color = :grey90, 
        transparency = true)
    hidedecorations!.(axs; grid = false)
    fig
end

save("lines_wire_contour_3d.png", current_figure()); # hide

# ![](lines_wire_contour_3d.png)