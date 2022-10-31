using CairoMakie
using StatsBase
using LinearAlgebra
using Interpolations
CairoMakie.activate!(type = "png")

# We use the following function to do histogram equalization over our fractals.
# This helps a lot with color instensities.

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

# Also, a smoothing function over the iterations is defined as
function normIterations(n, zn, b)
    return n - (log(log(abs(zn))) - log(log(b)))/log(2.0)
end

# ##  Mandelbrot definitions

function mandelbrot(c, b, itmap)
    z = c
    for n in 1:b
        if z.re * z.re + z.im * z.im > 4
            return itmap(n, z, b)
        end
        z = z^2 + c
    end
    return 0.0
end

function mandelbrot_set!(img, xi, xf, yi, yf, npoints; b=1024)
    for (i,x) in enumerate(range(xi, xf, length=npoints))
        for (j,y) in enumerate(range(yi, yf, length=npoints))
            color = mandelbrot(x + 1im*y, b, normIterations)
            img[i,j] = color
        end
    end
end

# ##  Mandelbrot plot

npoints = 600
img = zeros(npoints, npoints)
mandelbrot_set!(img, -2.0,0.5,-1.25,1.25, npoints)

fig = Figure(figure_padding=0,resolution=(600,600))
ax = Axis(fig[1,1]; aspect = DataAspect())
heatmap!(ax, eq_hist(img); colormap=:inferno)
hidedecorations!(ax)
hidespines!(ax)
fig

# A few more awesome examples can be done with the following parameters:

xyrange=[
    [ -0.74877,-0.74872,0.06505,0.06510],
    [0.32642717997233067, 0.3265289052327473,-0.05451000956418885, -0.05443371561887635],
    [-1.9963806954442953, -1.996380695443582,2.628704923646517e-7, 2.62871027270105e-7],
    [0.3476108223238668926295, 0.3476108223245338122665,0.0846794087369283253550, 0.0846794087374285150830],
    [-0.650790400000000001192,-0.648844800000000001192,0.44539837880859369792, 0.44685757880859369792],
    [-0.9548899408372031, -0.9548896813770819,0.2525416487455764, 0.2525418433406673],
    [0.254828857465066226270, 0.254828889245416226270,-0.000605561881950000235, -0.000605538046687500235],
    [-0.882297664710767940063, -0.882297662380940440063,0.235365461981556923486,0.235365463728927548486],
    [-0.6534376561891502063520, -0.6534376520406489856480,0.3635691455538367401120, 0.3635691486652126556400],
    [0.25740289813988496306, 0.25740289814296891154,0.49283797442018109421, 0.49283797442249278541]]

bs = [2500,3000,1000,10_000, 10_000,10_000, 50_000, 10_000,10_000,50_000]
cmaps = [:plasma, :bone_1, :viridis, :CMRmap, :gist_stern,
    :linear_bmy_10_95_c78_n256, :Hiroshige, :seaborn_icefire_gradient,
    :sunset, :sun]

fig = Figure(resolution=(1200,900))
axs = [Axis(fig[i,j]; aspect = DataAspect()) for i in 1:3 for j in 1:4]
npoints = 300
img = zeros(npoints, npoints)
for idx in 1:10
    mandelbrot_set!(img,xyrange[idx]..., npoints; b=bs[idx])
    heatmap!(axs[idx], eq_hist(img); colormap=cmaps[idx])
end
hidedecorations!.(axs)
colgap!(fig.layout, 1)
rowgap!(fig.layout,1)
hidespines!.(axs)
fig

# ## Julia set definitions
function juliamap(x, y, c, b, itmap)
    z = (x + 1im*y)^2 + c
    for k in 1:b
        if z.re * z.re + z.im * z.im > 4
            return itmap(k, z, b)
        end
        z = z^2 + c
    end
    return 0.0
end
function julia_set!(img, xi, xf, yi, yf, npoints; b=1024, c=-0.835 - 1im*0.2321)
    for (i,x) in enumerate(range(xi, xf, length=npoints))
        for (j,y) in enumerate(range(yi, yf, length=npoints))
            color = juliamap(x, y, c, b, normIterations)
            img[i,j] = color
        end
    end
end

# ## Julia set plot

npoints = 600
img = zeros(npoints, npoints)
julia_set!(img, -1.7, 1.7, -1.7, 1.7, npoints)

fig = Figure(figure_padding=0,resolution=(600,600))
ax = Axis(fig[1,1]; aspect = DataAspect())
heatmap!(ax, log10.(img); colormap=:bone_1)
hidedecorations!(ax)
hidespines!(ax)
fig

# ## Julia set examples
cvalues = [0.274 - 0.008 * 1im, 0.285 + 0.01*1im,
    -0.70176 - 0.3842*1im, -0.8 + 0.156*1im,
    -0.7269 + 0.1889*1im, -0.1 + 0.65*1im,
    -0.382 + 0.618*1im, -0.449 + 0.571*1im]

fig = Figure(resolution=(1200,600))
axs = [Axis(fig[i,j]; aspect = DataAspect()) for i in 1:2 for j in 1:4]
npoints = 300
img = zeros(npoints, npoints)
for idx in 1:8
    julia_set!(img,-1.7, 1.7, -1.7, 1.7, npoints; b=1000, c=cvalues[idx])
    heatmap!(axs[idx], log10.(img); colormap=cmaps[idx])
end
hidedecorations!.(axs)
colgap!(fig.layout, 1)
rowgap!(fig.layout,1)
hidespines!.(axs)
fig