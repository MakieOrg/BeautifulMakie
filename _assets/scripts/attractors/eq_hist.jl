using OnlineStats, StatsBase
using LinearAlgebra, Interpolations
function aggHist(x, y; nbinsx = 400, nbinsy = 400)
    xedges = range(extrema(x)..., length = nbinsx)
    yedges = range(extrema(y)..., length = nbinsy)
    o = fit!(HeatMap(xedges, yedges), zip(x, y))
    return o
end

function getbinsxy(x,y; nbins = 400)
    xex = extrema(x)
    dx = xex[2] - xex[1]
    yex = extrema(y)
    dy = yex[2] - yex[1]
    if dx > dy
        nbinsy = nbins
        nbinsx = Int64(round(dx / dy * nbins))
    else
        nbinsx = nbins
        nbinsy = Int64(round(dy / dx * nbins))
    end
    return nbinsx, nbinsy, xex, yex
end

function aggHist(x, y; nbins = 400)
    nbinsx, nbinsy, xex, yex = getbinsxy(x, y; nbins = nbins)
    xedges = range(xex..., length = nbinsx)
    yedges = range(yex..., length = nbinsy)
    o = fit!(HeatMap(xedges, yedges), zip(x, y))
    return o
end

function aggHist(x, y; nbins = 400, lim=lim)
    nbinsx, nbinsy, xex, yex = getbinsxy(x, y; nbins = nbins)
    xedges = range(xex..., length = nbinsx)
    yedges = range(yex..., length = nbinsy)
    o = fit!(HeatMap(xedges, yedges), zip(x, y))
    return o
end



function eq_hist(matrix; nbins = 256 * 256)
    h_eq = fit(Histogram, vec(matrix), nbins = nbins)
    h_eq = normalize(h_eq, mode = :density)
    cdf = cumsum(h_eq.weights)
    cdf = cdf / cdf[end]
    edg = h_eq.edges[1]
    interp_linear = LinearInterpolation(edg, vcat(cdf, cdf[end]))
    out = reshape(interp_linear(vec(matrix)), size(matrix))
    return out
end