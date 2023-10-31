using MarketData, DataFrames
using AlgebraOfGraphics, CairoMakie
using Statistics
CairoMakie.activate!(type = "svg") #hide

# ## Close Price

plt = data(cl)*mapping(:timestamp, :Close)*visual(Lines)

with_theme(theme_ggplot2(), resolution = (600,400)) do
    plt |> draw
end
save("market_data.svg", current_figure()); # hide

# ![](market_data.svg)


# ## Prices

labels = [:Open, :High, :Low, :Close]
plt = data(ohlc)
plt *= mapping(:timestamp, labels .=> "value", color =dims(1)=>renamer(labels) => "series ") 

with_theme(theme_light(), resolution = (600,400)) do
    plt * visual(Lines) |> draw
end

# ## StockChart

df = DataFrame(ohlc)
pltd = data(df[200:280,:])
plt = pltd * mapping(:timestamp, :Open => "StockChart")
plt *= mapping(fillto=:Close, color = (:Open, :Close) => isless => "Open<Close")
plt *= visual(BarPlot)

with_theme(theme_dark(), resolution = (800,500)) do
    draw(plt, palettes =(; color = [:deepskyblue, :firebrick3]))
end