using GLMakie, Random
using ColorSchemes
Random.seed!(123)
size = 100
fig = Figure(resolution = (800, 800))
ax = Axis(fig[1, 1], aspect = 1)
lines!.(ax, [Circle(Point(size * rand(2)...), rand()) for _ in 1:50])
#limits!(ax, 0,1,0,1)
fig

initrs = rand()
posx = rand()
vals = zeros(1000, 3)
c = 2
for j in 0:1:9
    initrs = rand()/(j+1)
    posx = rand()
    initposy = j
    vals[1, :] = [posx, initposy, initrs]
    for i in 2:100
        newr = rand() / (j + 1)
        posx = posx + initrs + newr
        if posx < 10 + newr
            vals[c, :] = [posx, initposy, newr]
            initrs = newr
            c += 1
        else
            break
        end
    end
end
colors = categorical_colors(:Hiroshige)
fig = Figure(resolution = (800, 800))
ax = Axis(fig[1, 1], aspect = DataAspect())
for i in 1:500
    poly!(ax, Circle(Point(vals[i, 1:2]...), vals[i, 3]), color = colors[rand(1:40)])
end
#limits!(ax, 0,1,0,1)
fig