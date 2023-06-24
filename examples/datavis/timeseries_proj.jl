using MarketData, DataFrames
using AlgebraOfGraphics, GLMakie, GeoMakie
using Statistics
plt = data(cl)*mapping(:timestamp, :Close)*visual(Lines)

with_theme(theme_ggplot2(), resolution = (600,400)) do
    plt |> draw
end

function tolats(x)
    
end
df = DataFrame(cl)
df[!, :tolon] .= collect(range(-180,180, length=length(cl)))
#df[!, :newvals] .= 