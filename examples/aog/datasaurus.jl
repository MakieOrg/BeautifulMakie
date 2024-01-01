using CSV, Downloads, DataFrames
using AlgebraOfGraphics, CairoMakie
using Statistics
CairoMakie.activate!(type = "svg") #hide
# https://github.com/jumpingrivers/datasauRus
# https://www.autodesk.com/research/publications/same-stats-different-graphs

link = "https://raw.githubusercontent.com/jumpingrivers/datasauRus/main/inst/extdata/DatasaurusDozen-Long.tsv"
file = Downloads.download(link)
dsaurus = CSV.read(file, DataFrame, delim = '\t')

plt = data(dsaurus) * mapping(:x => "", :y => "", layout=:dataset)
with_theme(theme_light(), size = (1600,1200), fontsize = 24) do
    draw(plt) ## palettes = (layout=wrap(cols=3),)
end

# ## ggplot2 theme 

with_theme(theme_ggplot2(), size = (1600,1200), fontsize = 24) do
    fig = Figure()
    g = GridLayout(fig[1,1])
    wfacet = draw!(g, plt)
    bxs = [Box(g[i,j, Top()], color = (:grey70, 0.95),
        strokevisible = false) for i in 1:4 for j in 1:4]
    [translate!(bxs[i].blockscene, 0,0,-1) for i in 1:15]
    delete!.(bxs[14:end])
    fig
end

# Adding some stats

gdf = groupby(dsaurus, :dataset);
stats = sort(combine(gdf, [:x, :y] .=> mean, [:x, :y] .=> std, [:x, :y] => cor));

plt *= visual(strokewidth=0.95, strokecolor=:black, color =(:white,0.5));

# ## dark theme 

with_theme(theme_dark(), size = (1600,1200), fontsize = 24) do

    fig = Figure()
    g = GridLayout(fig[1,1])
    wfacet = draw!(g, plt) ## palettes = (layout=wrap(cols=3),)
    ## this should be also something automatic from AoG
    bxs = [Box(g[i,j, Top()], color = (:grey30, 0.25),
        strokevisible = false) for i in 1:4 for j in 1:4]
    [translate!(bxs[i].blockscene, 0,0,-1) for i in 1:15]
    delete!.(bxs[14:end])
    ## plot some stats 
    axstats = Axis(g[4, 2])
    [text!(axstats, t, position = (0.05, 0.9 - (i-1)*0.15), align = (:left, :top))
        for (i,t) in enumerate(names(stats)[2:end])]
    [text!(axstats, ":  "*string(t), position = (0.3, 0.9 - (i-1)*0.15), align = (:left, :top))
            for (i,t) in enumerate(values(stats[1,2:end]))]
    limits!(0,1,0,1)
    hidedecorations!(axstats)
    fig
end
