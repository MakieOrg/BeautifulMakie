using GLMakie
import YAML
include("eq_hist.jl")
include("attractors.jl")
vals = YAML.load_file("strange_attractors.yml")

getFunction(s) = getfield(Main, Symbol(s))
cmaps = [:CMRmap, :linear_kbgyw_5_98_c62_n256,
    :linear_kryw_5_100_c67_n256]
cmaps = repeat(cmaps, 4)

set_theme!(theme_black())
fig = Figure(resolution = (2400, 1600))
axs = [Axis(fig[i, j]; aspect = DataAspect()) for i = 1:3 for j = 1:4]
for i = 1:12
    x, y = trajectory(getFunction(vals[i][1]), vals[i][3:end]...; n = 10_000_000)
    o = aggHist(x, y; nbins = 300)
    m = eq_hist(o.counts)
    heatmap!(axs[i], o.xedges, o.yedges, m;
        colormap = cmaps[i])
    hidedecorations!(axs[i])
    hidespines!(axs[i])
end
fig

fig = Figure(resolution = (2400, 1000))
axs = [Axis(fig[i, j]; aspect = DataAspect()) for i = 1:2 for j = 1:4]
for i = 1:8
    x, y = trajectory(getFunction(vals[12+i][1]), vals[12+i][3:end]...; n = 10_000_000)
    o = aggHist(x, y; nbinsx = 1000, nbinsy = 1000)
    m = eq_hist(o.counts)
    heatmap!(axs[i], o.xedges, o.yedges, m;
        colormap = cmaps[i])
    hidedecorations!(axs[i])
    hidespines!(axs[i])
end
fig

fig = Figure(resolution = (2400, 600))
axs = [Axis(fig[i, j]; aspect = DataAspect()) for i = 1:1 for j = 1:4]
for i = 1:4
    x, y = trajectory(getFunction(vals[20+i][1]), vals[20+i][3:end]...; n = 10_000_000)
    o = aggHist(x, y; nbinsx = 1000, nbinsy = 1000)
    m = eq_hist(o.counts)
    heatmap!(axs[i], o.xedges, o.yedges, m;
        colormap = cmaps[i])
    hidedecorations!(axs[i])
    hidespines!(axs[i])
end
fig

fig = Figure(resolution = (2400, 600))
axs = [Axis(fig[i, j]; aspect = DataAspect()) for i = 1:1 for j = 1:4]
for i = 1:4
    x, y = trajectory(getFunction(vals[24+i][1]), vals[24+i][3:end]...; n = 10_000_000)
    o = aggHist(x, y; nbinsx = 1000, nbinsy = 1000)
    m = eq_hist(o.counts)
    heatmap!(axs[i], o.xedges, o.yedges, m;
        colormap = cmaps[i])
    hidedecorations!(axs[i])
    hidespines!(axs[i])
end
fig

x, y = trajectory(getFunction(vals[10][1]), vals[10][3:end]...; n = 10_000_000)

fig = Figure(resolution = (600, 400))
ax = Axis(fig[1, 1]; aspect = DataAspect())
o = aggHist(x, y; nbins = 300)
m = eq_hist(o.counts)
heatmap!(ax, o.xedges, o.yedges, m; colormap = :inferno)
fig