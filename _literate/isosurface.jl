# by Lazaro Alonso 
using GLMakie
GLMakie.activate!()
let
    n = 50
    x = y = z = LinRange(-5,5,n)
    vals = zeros(n,n,n)
    for i in 1:n, j in 1:n, k in 1:n
        vals[i,j,k] = 0.5*i^2  + j^2 + 2*k^2
    end
    cmap = :Spectral_11
    fig, _ = contour(x, y, z, vals, colormap = cmap, levels=[100,2500,7000],
         algorithm=:mip, alpha = 0.05, ambient = Vec3f0(0.65, 0.65, 0.65))
    fig
end