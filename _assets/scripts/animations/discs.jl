using GLMakie
GLMakie.activate!()
# http://juliaplots.org/MakieReferenceImages/gallery//record_video/index.html
f(t, v, s) = (sin(v + t) * s, cos(v + t) * s, (cos(v + t) + sin(v)) * s)
t = Observable(time())
pos1 = lift(t-> f.(t, range(0, stop = 2pi, length = 50), 1), t)
pos2 = lift(t-> f.(t * 2.0, range(0, stop = 2pi, length = 50), 1.5), t)
connectingLines = @lift(vcat([[$pos1[idx], $pos2[idx]] for idx in 1:length($pos1)]...))
color = @lift(1:length($pos1)).val
colorLines = @lift(1:length($connectingLines)).val
markersize = 0.05

limits = Rect3f(Vec3f(-1.5, -1.5, -3), Vec3f(3, 3, 6))
fig = Figure(resolution = (850,1200))
ax = LScene(fig[1,1]; limits = limits)
meshscatter!(ax, pos1; color, markersize)
#meshscatter!(ax, pos2; color, markersize)
#linesegments!(ax, connectingLines, color = colorLines,
#    linestyle = :dot)
fig

N = 700
record(fig, joinpath(@__DIR__, "output", "discs.mp4"), 1:N) do i
    t[] = time()
end
