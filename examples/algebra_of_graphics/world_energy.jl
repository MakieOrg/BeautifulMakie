using CSV, DataFrames, FileIO, Downloads
using GeoMakie.GeoJSON
using GeoMakie
using GLMakie
using AlgebraOfGraphics

#https://github.com/owid/energy-data/blob/master/owid-energy-codebook.csv
# https://datahub.io/core/geo-countries#curl # download data from here
worldCountries = GeoJSON.read(read(Downloads.download("https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson"), String))
n = length(worldCountries)
country_ISO3 = worldCountries.ISO_A3

urldata = "https://raw.githubusercontent.com/owid/energy-data/master/owid-energy-data.csv"
wfile = Downloads.download(urldata)
wdata = CSV.read(wfile, DataFrame)

wydata = filter(:year => ==(2018), wdata)
wydata = filter(:iso_code => c -> !ismissing(c), wydata)
new_wydata = similar(wydata, n)

ciso3 = wydata[!, :iso_code]
fmiss(x) = ismissing(x) ? missing : typeof(x) ==Float64 ? x*NaN : x/x
valsList = values(wydata[1, Not([:country, :iso_code])])
valsList = fmiss.(valsList)

for (j, iso3) in enumerate(country_ISO3)
    idx = findall(x->x==iso3, ciso3)
    if length(idx)>0
        new_wydata[j, :]= wydata[idx[1], :]
    else
        new_wydata[j, [:country, :iso_code]]=["not in",iso3]
        new_wydata[j, Not([:country, :iso_code])] = valsList
    end
end

colors = new_wydata[!, :primary_energy_consumption];

fig, ax, obj = poly(worldCountries; color= log10.(replace(colors, missing=>NaN)),
    colormap=:Spectral_11 #cgrad(:plasma, 10, categorical=true)
    )
#Colorbar(fig[1,2], colormap=cgrad(:plasma, 10, categorical=true))
fig



snew = filter(:primary_energy_consumption => c -> !ismissing(c), new_wydata) 
snew = filter(:primary_energy_consumption => c -> !isnan(c), snew) 
snews = sort(snew, :primary_energy_consumption, rev=true)
n10d = first(snews, 20)
n10d[!, :primary_energy_consumption]
n10d[!, :country]


#=
fig, ax, obj = barplot(10:-1:1, n10d[!, :primary_energy_consumption];
    direction=:x, color= 10:-1:1)
ax.yticks =(1:10, n10d[end:-1:1, :country])
ax.xtickformat = "{:s}"
xlims!(0,nothing)
fig
=#
energySectors= [
    "wind_electricity", 
    "solar_electricity",
    "oil_electricity",
    "nuclear_electricity",
    "low_carbon_electricity",
    "hydro_electricity",
    "gas_electricity",
    "coal_electricity",
    "biofuel_electricity",
    ]

esec = snews[!, energySectors]
total = [sum(skipmissing(esec[!, c])) for c in names(esec)]
psor = sortperm(total)

fig, ax, obj = barplot(1:9, total[psor];
    direction=:x, color= total[psor])
ax.yticks =(1:9, energySectors[psor])
ax.xtickformat = "{:s}"
xlims!(0,nothing)
fig

prim_ener =  n10d[!, :primary_energy_consumption];
allcols = log10.(replace(colors, missing=>NaN))
#minimum(replace(allcols[.!isnan.(allcols)], -Inf=>Inf))
#maximum(replace(allcols[.!isnan.(allcols)], -Inf=>0))
using ColorSchemeTools, Colors, ColorSchemes
terrain = (
           (0.00, (0.2, 0.2,  0.6)),
           (0.2, (0.0, 0.6,  1.0)),
           (0.35, (0.0, 0.8,  0.4)),
           (0.50, (1.0, 1.0,  0.6)),
           (0.75, (0.5, 0.36, 0.33)),
           (1.00, (1.0, 1.0,  1.0))
          );
cmaps = resample_cmap(:Hiroshige, 20)[end:-1:1]
cmapsvals = [(c.r, c.g, c.b) for c in cmaps]
steps = [0.0, 0.01, collect(range(0.1,1,length=18))...]

newmap = tuple.(steps, cmapsvals)
newmap = Tuple(newmap[i] for i in 1:20)

cmapH = make_colorscheme(newmap, length=20);

with_theme(theme_black()) do
    colormap = cmapH  #cgrad(:viridis, scale = log10)
    fig = Figure(size = (2400, 800), fontsize=24)
    ax1 = Axis(fig[1,1], xlabel = "terawatt-hour")
    ax2 = GeoAxis(fig[1,2]; dest = "+proj=crast"
        )
    ax3 = Axis(fig[1,3], xlabel = "terawatt-hour")
    hidedecorations!(ax2)
    hmap=poly!(ax2, worldCountries; color= replace(colors, missing=>NaN),
        strokewidth= 0.1, strokecolor = (:white, 0.1),
        colormap= cgrad(:plasma,100, scale = exp10), #resample_cmap(:fastie,100)[55:85], #[:seagreen, :olive, :springgreen3, :green, :black,
            #:orange, :orangered,:red, :yellow] #cgrad(:speed, scale=log2), #cgrad(:gnuplot2, scale = log10), #[:grey30, :gainsboro, :blue,:dodgerblue, :dodgerblue, :orange, :orangered, :firebrick, :yellow],
        colorrange=(0, 40_000)
        )
    Colorbar(fig[1, 2], colormap = cgrad(:plasma,100, scale = exp10), #resample_cmap(:fastie,100)[55:85],
        colorrange = (0, 40_000),
        label = "primary_energy_consumption, terawatt-hour", labelpadding = 5,
        tellheight = false, tellwidth = false, 
        #ticklabelsize = 12,
        width =  Relative(1.5 / 4), height =10,
        halign = 0.85, valign = :bottom, 
        vertical=false, flipaxis=false)
    Label(fig[1,2], "Global Energy Consumption 2018", fontsize=32,
        color=:white,
        halign = :left, valign = :top,
        tellheight = false, tellwidth = false,)

    barplot!(ax1, 20:-1:1, prim_ener;
        direction=:x, color= 1:20,
        #colorrange=(10_000, 40_000), 
        colormap = Reverse(:viridis)
        #colormap = cgrad(:Hiroshige, scale = exp10)[end:-1:1],#[:grey30, :gainsboro,:blue,:dodgerblue, :dodgerblue, :orange, :orangered, :firebrick, :yellow]
        )
    #ax1.yticks =(1:10, n10d[end:-1:1, :country])
    text!(ax1, string.(n10d[end:-1:1, :country]),
        position = tuple.(prim_ener[end:-1:1] .+200, 1:20), align = (:left, :center))

    #ax1.xtickformat = "{:s}"
    hideydecorations!(ax1, ticks=false)
    xlims!(ax1,0,47_000)

    barplot!(ax3, 1:9, total[psor];
        direction=:x, color=1:9,
        colormap = Reverse(:Hiroshige),
        )
    #ax3.yticks =(1:9, energySectors[psor])
    ax3.xtickformat = "{:s}"
    text!(ax3, energySectors[psor], position = tuple.(total[psor].+100, 1:9), align = (:left, :center))
    xlims!(ax3, 0,19_000)
    hideydecorations!(ax3, ticks=false)
    colsize!(fig.layout,1,Auto(0.3))
    colsize!(fig.layout,3,Auto(0.3))
    colgap!(fig.layout, 0)
    fig
end
