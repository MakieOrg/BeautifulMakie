using GLMakie, AlgebraOfGraphics, Dates
using Downloads, JSON, DataFrames, ColorSchemes, Colors
using FileIO, CSV
GLMakie.activate!()

# getting data
basepath = "https://raw.githubusercontent.com/vega/vega-datasets/master/data/"
gapminder = Downloads.download(basepath*"gapminder-health-income.csv");

#gapminder = JSON.parse(String(read(gapminder)), inttype=Float64);
df = DataFrame(CSV.File(gapminder));

# selecting and plotting
colors = cgrad(:cividis, size(df,1), categorical=true)
p = data(df) *
    mapping(:income, :health, color = :country =>(t -> string(t)), 
        markersize =:population => (t-> 8 + 70t/maximum(df.population))) * 
    visual(Scatter)
draw(p, axis=(xscale=log10,), palettes=(color=colors,))

save("gapminder.png", current_figure()); # hide

# ![](gapminder.png)