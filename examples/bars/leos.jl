using Pkg; Pkg.activate("./docs")
using GLMakie, DataFrames, DataFramesMeta
using FileIO

names = ["Gisele Bundchen", "Bar Refaeli", "Blake Lively", "Erin Heatherton",
    "Toni Garrn", "Kelly Rohrbach", "Nina Agdal", "Camila Morrone"]
leo = load(joinpath(@__DIR__, "images/leonardo_dicaprio.png"))

y_xticks = 1998:2022
ys_xticks = string.(1998:2022)
yd_xticks = ["'"*t[3:4] for t in ys_xticks]
age_leo = 24 .+ collect(1:length(y_xticks)) .- 1

age_gf = [18:23, 20:25, 23, 22, 20:21,25, 24:25, 20:25]
years = [1998:2003, 2004:2009, 2010, 2011, 2012:2013, 2014, 2015:2016, 2017:2022]


fig = Figure()
ax = Axis(fig[1,1:9])
scatterlines!(ax, y_xticks, age_leo; markercolor = :transparent, 
    strokewidth=1, markersize = 8, color = :red,
    strokecolor =:red, linestyle = :dot)
barplot!.(years, age_gf)
[text!(string.(age_gf[i]), position = Point2f.(years[i], age_gf[i]),
    align = (:center, :bottom), textsize = 12) for i in eachindex(age_gf)]
text!(string.(age_leo), position = Point2f.(y_xticks, age_leo .+0.5), 
    align = (:center, :bottom), textsize = 12)
ylims!(15,nothing)
ax.xticks = (y_xticks, yd_xticks)
aximgs = [Axis(fig[2,i], aspect = 1) for i in 1:9]
hidedecorations!.(aximgs)
hidespines!.(aximgs)
image!(aximgs[1], rotr90(leo))
rowsize!(fig.layout, 2, Auto(0.25))
p = Makie.project(ax.scene, Point2f(1998, 0)) + ax.scene.px_area[].origin - Vec2f(0, 40)
ps = [p, p - Vec2f(0, 20), p - Vec2f(30, 20), p - Vec2f(30, 60)]
lines!(fig.scene, ps)
fig

fig = Figure()
ax = Axis(fig[1, 1:9])
barplot!(ax, rand(10))
ylims!(ax, 0, nothing)
aximgs = [Axis(fig[2,i], aspect = 1) for i in 1:9]
rowsize!(fig.layout, 2, Auto(0.25))
#Box(fig[2, 1], visible = true, height = 80)
#Box(fig[2, 2], visible = true, height = 80)

# Let the layouting figure itself out. Otherwise react to 
# ax.scene.camera.projectionview and as.scene.px_area updates

display(fig)
hidedecorations!.(aximgs)

p = Makie.project(ax.scene, Point2f(1, 0)) + ax.scene.px_area[].origin - Vec2f(0, 10)
ps = [p, p - Vec2f(0, 20), p - Vec2f(30, 20), p - Vec2f(30, 45)]
lines!(fig.scene, ps)
#hidespines!.(aximgs)
img = rand(RGBf, 80, 80)
image!(ax2, img)
fig