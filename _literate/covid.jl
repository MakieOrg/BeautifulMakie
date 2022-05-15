using GLMakie, Downloads
using ColorSchemes
using CSV, DataFrames, GeoInterface
using GeoJSON
using GeoMakie
#  WHO COVID-19 Dashboard. Geneva: World Health Organization, 2020. Available online: https://covid19.who.int/
newCases = Downloads.download("https://covid19.who.int/WHO-COVID-19-global-data.csv")
newd = DataFrame(CSV.File(newCases))
gdf = groupby(newd, :Country)
countries = keys(gdf)
#gdf[("Afghanistan",)]
fcountry = gdf[keys(gdf)[5]]
cx = fcountry[!, [:Date_reported, :New_cases]]
scatter(cx[!, :New_cases])
#issorted(fcountry[!, [:Date_reported, :New_cases]], by = x -> x == :Date_reported)
names(fcountry)
file = "./_assets/data/countries.geojson"
worldCountries = GeoJSON.read(read(file))
feat = GeoInterface.features(worldCountries)
n = length(feat)
polynames = []
for i in 1:n
    push!(polynames, feat[i].properties["ADMIN"])
end

gdfcode = groupby(newd, :Country_code)
codes = keys(gdfcode)

polycodes = []
for i in 1:n
    push!(polycodes, feat[i].properties["ISO_A3"])
end

c = 0
for (idx, k) in enumerate(countries)
    if k[:Country] in polynames || sum(occursin.(codes[idx][:Country_code], polycodes)) == 1
        c += 1
    else
        println(k[:Country])
    end
end
#path = "https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv"
#pathfile = Downloads.download(path)
# https://gist.github.com/cpl/3dc2d19137588d9ae202d67233715478
codescsv = DataFrame(CSV.File("./_assets/data/all.csv"))
names(codescsv)
a2 = codescsv[!, "alpha-2"]
a3 = codescsv[!, "alpha-3"]
polycodes

c = 0
for (idx, k) in enumerate(codes)
    if k[:Country_code] in a2 #polycodes
        c += 1
    else
        println(k[:Country_code])
    end
end

gdfcode = groupby(newd, :Country_code)
codes = keys(gdfcode)

fcountry = gdfcode[keys(codes)[1]]
cx = fcountry[!, [:Date_reported, :New_cases]]
m = length(cx.Date_reported)
colorcode = -1*rand(n, m)
for (idx, k) in enumerate(codes)
    fcountry = gdfcode[keys(codes)[idx]]
    cx = fcountry[!, [:Date_reported, :New_cases]]
    if k[:Country_code] in a2 #polycodes
        a2toa3 = findall(x -> x == k[:Country_code], a2)[1]
        println(k[:Country_code])
        if a3[a2toa3] in polycodes
            nidx = findall(x -> x == a3[a2toa3], polycodes)[1]
            colorcode[nidx, :] = cx[!, :New_cases]
        end
    end
end
time = Observable(1)
fig, ax, pltobj = poly(worldCountries, color = @lift(colorcode[:, $time]),
    colorrange = (0, 2e3), lowclip = :black,
    colormap = Reverse(:Hiroshige), strokecolor = :black,
    strokewidth = 0.1, figure = (; resolution = (1200,800)))

record(fig, "covid.mp4") do io
    for i in 2:700
        time[] = i
        recordframe!(io)  # record a new frame
    end
end