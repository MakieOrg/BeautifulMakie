# ## The speed of light in the solar system

# ```@raw html
# <video src="./travellingSolarSystem.mp4" controls="controls" autoplay="autoplay"></video>
# ```

using GLMakie
GLMakie.activate!()
GLMakie.closeall() # hide

## https://www.jpl.nasa.gov/edu/pdfs/scaless_reference.pdf
## 1au = 149597870700 # meters
distances = [0, 0.39, 0.72, 1, 1.52, 5.2, 9.54, 19.2, 30.06] * 149597870700 # meters
speed = 299792458 # meters / second
diameters = [696340 * 2, 4879, 12104, 12756, 6792, 142984, 120536, 51118, 49528] # km
colors = ["snow4", "navajowhite", "lightskyblue", "orangered", "olive",
    "burlywood", "cyan3", "dodgerblue"]
names = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

point = Observable(Point2f(0, 0))
tail = Observable(Point2f[(0, 0)])
ms = Observable(20.0)
tempo = Observable(0.0)
msP = diameters / maximum(diameters) * 545

with_theme(theme_dark()) do
    fig = Figure(; size=(900, 400))
    axS = Axis(fig[1, 1])
    axP = Axis(fig[1, 2]; title = "The speed of light in the solar system", titlesize = 14)
    scatter!(axS, [-3.9], [0]; markersize = msP[1], color = :white)
    scatter!(axP, distances[2:end], fill(0, length(distances[2:end]));
        markersize = msP[2:end], color = colors)
    colsize!(fig.layout, 1, Auto(0.1))
    colgap!(fig.layout, 0)
    hidedecorations!.([axP, axS])
    hidespines!.([axP, axS])
    xlims!(axS, -1, 1)
    ylims!(axS, -1, 1)
    Label(fig[1, 2, Top()], "so fast! 😃", fontsize = 16, halign=1)
    Label(fig[1, 2, Top()], "so slow 😢", fontsize = 16, halign=0.0)
    Label(fig[1,1:2, Bottom()], rich("Visualization by ",
        rich("Lazaro Alonso", color=:dodgerblue)),
        color = :white, halign=1)
    text!(axP, names, position = tuple.(distances[2:end], [1, -1, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5]))
    stem!(axP, distances[2:end], [1, -1, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5]; color = colors,
        stemcolor = colors, trunkcolor = :white, trunklinestyle = :dashdotdot,
        trunkwidth = 1, stemwidth = 0.85, markersize = 8)

    for i = 1:5
        lines!(axP, @lift(length($tail) < 5 ? $tail : $tail[end:-1:end-Int64(round(0.01 * i * length($tail)))]);
            linewidth = 4 - i * 0.7, color = (:white, 1 - 0.1 * i))
    end
    scatter!(axP, point; color = (:white, 0.85), markersize = 15, marker = '▶')
    text!(axP, @lift("$($tempo) hours"), position = point; color = :gold,
        align = (:center, :bottom))
    fig
    record(fig, "travellingSolarSystem.mp4", framerate = 48) do io
        for frame in LinRange(0.001, distances[end] + distances[5], 1000)
            new_point = Point2f(frame, 0.0)
            push!(tail[], new_point)
            point[] = new_point
            tempo[] = round((frame / speed) / 60 / 60, digits = 2)
            tail[] = tail[]
            xlims!(axP, 0, frame + frame * 0.08)
            recordframe!(io)
        end
    end
end