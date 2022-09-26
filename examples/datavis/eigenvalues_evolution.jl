using CairoMakie
using StatsBase, LinearAlgebra
CairoMakie.activate!(type = "png")

# Let M1 and M2 be two complex valued random matrices nxn.
# How do eigenvalues of M1 (1-t) + M2 t move in ℂ when t ranges in [0,1]?
# Inspired by https://twitter.com/S_Conradi/status/1571205148914995200

function xy(a,b; n = 500)
    xs= Float64[]
    ys = Float64[]
    for t in range(0,1, length=n)
        vals = eigvals(a *(1-t) .+ b*t)
        x0 = real.(vals)
        y0 = imag.(vals)
        push!(xs, x0...)
        push!(ys, y0...)
    end
    return (xs, ys)
end

# ## Unitary matrices

function m12u(n=10)
    U = randn(n, n) .+ 2im * randn(n, n)
    u1 = eigvecs(U .+ transpose(conj(U)))
    U = randn(n, n) + 1im * randn(n, n)
    u2 = eigvecs(U .+ transpose(conj(U)))
    return u1, u2
end 

n = 500
a, b =  m12u(500)
xs, ys = xy(a,b)
colors = repeat(1:n,inner=500)

with_theme(theme_black()) do
    fig=Figure(resolution=(800,800))
    ax = Axis(fig[1,1])
    scatter!(Point2f.(xs,ys); color=colors, markersize = 1, 
        colormap=[:yellow, :white, :orangered]
        )
    limits!(ax, -0.7,0.7,-0.7,0.7)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## Complex valued random matrices

# https://twitter.com/S_Conradi/status/1571205148914995200

function m12(n=10)
    a = ((2rand(n,n) .-1) .+ (2im*rand(n,n) .-1))
    b = ((2rand(n,n) .-1) .+ (2im*rand(n,n) .-1))
    return a, b
end 

n = 500
a, b =  m12(500)
xs, ys = xy(a,b)
colors = repeat(1:n,inner=500)

with_theme(theme_black()) do
    fig=Figure(resolution=(800,800))
    ax = Axis(fig[1,1])
    scatter!(Point2f.(xs,ys); color=colors, markersize = 1, 
        colormap=[:yellow, :white, :orangered]
        )
    limits!(ax, -20,20,-20,20)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end