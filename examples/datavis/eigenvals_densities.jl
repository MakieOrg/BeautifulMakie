using CairoMakie
using StatsBase, LinearAlgebra
using Interpolations, OnlineStats
using Distributions
CairoMakie.activate!(type = "png")

function eq_hist(matrix; nbins = 256 * 256)
    h_eq = fit(Histogram, vec(matrix), nbins = nbins)
    h_eq = normalize(h_eq, mode = :density)
    cdf = cumsum(h_eq.weights)
    cdf = cdf / cdf[end]
    edg = h_eq.edges[1]
    interp_linear = LinearInterpolation(edg, [cdf..., cdf[end]])
    out = reshape(interp_linear(vec(matrix)), size(matrix))
    return out
end

function getcounts!(h, fn; n = 100)
    for _ in 1:n
        vals = eigvals(fn())
        x0 = real.(vals)
        y0 = imag.(vals)
        fit!(h, zip(x0,y0))
    end
end

# See http://www.bohemianmatrices.com/gallery/ for more info and inspiration!

# ## 4x4 random

m(;a=10rand()-5, b=10rand()-5) = [0 0 0 a; -1 -1 1 0; b 0 0 0; -1 -1 -1 -1]

h = HeatMap(range(-3.5,3.5,length=1200), range(-3.5,3.5, length=1200))
getcounts!(h, m; n=500_000)

with_theme(theme_black()) do
    fig = Figure(figure_padding=0,size=(600,600))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax,-3.5..3.5, -3.5..3.5, eq_hist(h.counts); colormap = :bone_1)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## Tridiagonal

mtri() = Array(Tridiagonal(2rand(19) .-1, 2rand(20) .-1, 2rand(19) .-1))

h = HeatMap(range(-3,3,length=1200÷2),range(-2,2,length=1200÷2))
getcounts!(h, mtri; n=250_000)

with_theme(theme_black()) do
    fig = Figure(figure_padding=0,size=(600,400))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax, -3..3, -2..2, eq_hist(h.counts); colormap = :bone_1)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## Beta distribution

mβ(; n = 6) = 2rand(Beta(0.01,0.01), n,n) .-1
h = HeatMap(range(-3,3,length=1200),range(-2,2,length=1200))
getcounts!(h, mβ; n=500_000)

with_theme(theme_black()) do
    fig = Figure(figure_padding=0,size=(600,400))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax, -3..3, -2..2,eq_hist(h.counts);
        colormap = [:black, :white, :white])
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## 3x3 random

m3(;a=9rand()-5,b=9rand()-5) = [a 1 -1; -1 b 0; 1 -1 -1]
h = HeatMap(range(-4,4,length=1200),range(-2,2,length=1200))
getcounts!(h, m3; n = 500_000)

with_theme(theme_dark()) do
    fig = Figure(figure_padding=0,size=(600,400))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax, -4..4, -2..2,eq_hist(h.counts);
        colormap = :CMRmap)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## Tridiagonal 30x30 [-1,1]

mtrin(; n =30) = Array(Tridiagonal(rand([-1.0,1.0],n-1), zeros(n), rand([-1.0,1.0],n-1)))

h = HeatMap(range(-2,2,length=1200),range(-2,2,length=1200))

getcounts!(h, mtrin; n = 50_000)

with_theme(theme_dark()) do
    fig = Figure(figure_padding=0,size=(600,600))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax, -2..2, -2..2, eq_hist(h.counts);
        colormap = :linear_kry_5_95_c72_n256)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end

# ## 8x8 random [-1, -1/f, 0, 1/f, 1]

mrand(; f=1000,n=8) = rand([-1.0, -1/f, 0, 1/f, 1.0],n,n)
h = HeatMap(range(-2,2,length=800), range(-2,2,length=800))
getcounts!(h, mrand; n = 250_000)

with_theme(theme_dark()) do
    fig = Figure(figure_padding=0,size=(600,600))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    heatmap!(ax, -2..2, -2..2, eq_hist(h.counts);
        colormap = :hot)
    hidedecorations!(ax)
    hidespines!(ax)
    fig
end