md"""
## Gravity Animation
"""
## by Lazaro Alonso
using GLMakie, FileIO
GLMakie.activate!()
## See following links for references:
## https://twitter.com/AnsonBiggs/status/1444823816031510529/photo/1
## https://github.com/JuliaAnimators/Javis.jl/blob/master/examples/gravities.jl
let
    diameters = Dict(
        "Mercury" => 4879,
        "Venus" => 12104,
        "Earth" => 12756,
        "Moon" => 3475,
        "Mars" => 6792,
        "Jupiter" => 142984,
        "Saturn" => 120536,
        "Uranus" => 51118,
        "Neptune" => 49528,
        "Pluto" => 2370)
    struct Body
        position::Int
        name::String
        gravity::Real
        color::String
        radius::Real
    end
    Body(pos, name, grav, color) = Body(pos, name, grav, color, log(diameters[name]) * 2)
    bodies = [
        Body(1, "Mercury", 3.7, "snow4")
        Body(2, "Venus", 8.9, "navajowhite")
        Body(3, "Earth", 9.8, "lightskyblue")
        Body(4, "Moon", 1.6, "gainsboro")
        Body(5, "Mars", 3.7, "orangered")
        Body(6, "Jupiter", 23.1, "olive")
        Body(7, "Saturn", 9, "burlywood")
        Body(8, "Uranus", 8.7, "cyan3")
        Body(9, "Neptune", 11, "dodgerblue")
        Body(10, "Pluto", 0.7, "rosybrown4")
    ]
    framerate = 30
    height = 1000 # meters

    frames = let
        ## Get planet with slowest acceleration
        slowest = [p.gravity for p in bodies] |> minimum
        ## Kinematic equation to determine seconds to fall from height
        time = 2 * height / slowest |> sqrt
        ## Calculate total frames and add a few seconds at the end to display final result
        ceil(Int, time * framerate) + framerate * 5
    end

    textsize = 28
    f = Observable(1)
    set_theme!(theme_black())
    fig = Figure(resolution = (2400, 1600))
    axs = [Axis(fig[i, j]) for j in 1:11, i in 1:3]
    pathBodies = "./_assets/scripts/bodies/"
    for (idx, body) in enumerate(bodies)
        ## Kinematic equations to calculate how many frames each planet will be active
        t_final = 2 * height / body.gravity |> sqrt
        v_final = body.gravity * t_final
        frame_final = ceil(Int, t_final * framerate)
        ## Calculate time of current frame for kinematic math
        time = @lift($f / framerate)
        ## Calculate planets current position
        body_y = @lift(height - 0.5 * body.gravity * $time^2)
        sec = @lift($body_y <= 0 ? round(t_final, digits = 1) : round($time, digits = 1))
        velocity = @lift($body_y <= 0 ? round(v_final, digits = 1) : round(body.gravity * $time, digits = 1))
        body_y = @lift($body_y <= 0 ? 0 : $body_y)

        ## Set planet's position 
        scatter!(axs[idx+1, 2], @lift(Point2f(1, $body_y)), color = body.color, markersize = 25)
        text!(axs[idx+1, 1], @lift(string($sec, "s")),
            position = Point2f(1, 1),
            textsize = textsize, color = @lift($body_y <= 0 ? "orange" : "grey90"),
            align = (:center, :center))
        text!(axs[idx+1, 1],
            @lift(string($velocity, "m/s")),
            position = Point2f(1, 0), textsize = textsize,
            color = @lift($body_y <= 0 ? "orange" : "grey90"),
            align = (:center, :center))

        ylims!(axs[idx+1, 2], -15, height + 15)

        bname = pathBodies * body.name * ".png"
        img = rotr90(load(bname))
        image!(axs[idx+1, 3], img)
        mx = maximum(size(img))
        mn = minimum(size(img))
        limits!(axs[idx+1, 3], -50, mx, -50, mx)
        scatter!(axs[idx+1, 3], Point2f(mx ÷ 2, mx ÷ 2 - 50), color = :transparent,
            strokecolor = body.color, markersize = 170, strokewidth = @lift($body_y <= 0 ? 2 : 0))
        ## Set text that is static during entire planet translation
        text!(axs[idx+1, 1], body.name, position = Point2f(1, 3),
            textsize = textsize, align = (:center, :center))
        text!(axs[idx+1, 1], string(body.gravity, "m/s²"),
            position = Point2f(1, 2), textsize = textsize,
            align = (:center, :center))
        limits!(axs[idx+1, 1], 0, 3, -0.5, 3.5)
    end
    ylims!(axs[1, 2], -15, height + 15)
    text!(axs[1, 2], "1 Km", position = Point2f(0, 1000),
        textsize = textsize, align = (:left, :center))
    text!(axs[1, 2], "0 Km", position = Point2f(0, 0),
        textsize = textsize, align = (:left, :center))

    text!(axs[1, 1], "Body:", position = Point2f(0, 3),
        textsize = textsize, align = (:left, :center))
    text!(axs[1, 1], "Acceleration:", position = Point2f(0, 2),
        textsize = textsize, align = (:left, :center))
    text!(axs[1, 1], "Time:", position = Point2f(0, 1),
        textsize = textsize, align = (:left, :center))
    text!(axs[1, 1], "Velocity:", position = Point2f(0, 0),
        textsize = textsize, align = (:left, :center))
    limits!(axs[1, 1], 0, 3, -0.5, 3.5)

    [hidedecorations!(axs[idx, k]) for idx in 1:11, k in 1:3]
    [hidespines!(axs[idx, k]) for idx in 1:11, k in 1:3]

    Label(fig[0, :], "Falling Bodies in the Solar System",
        tellwidth = false, textsize = 70, color = :grey50)
    Label(fig[end+1, :], "Twitter: @LazarusAlon", color = :white,
        tellwidth = false, textsize = 30, halign = :right,
        font = "noto-sands-bold")
    Label(fig[1, :], "using Makie", color = "#f7c530",
        tellwidth = false, textsize = 60, halign = :left,
        font = "noto-sands-bold")
    rowgap!(fig.layout, 0)
    colgap!(fig.layout, 0)
    rowsize!(fig.layout, 2, Auto(0.2))
    rowsize!(fig.layout, 4, Auto(0.2))
    fig

    record(fig, joinpath(@OUTPUT, "gravities.mp4"), framerate = 2 * framerate) do io
        for i in 1:frames
            f[] = i
            recordframe!(io)  # record a new frame
        end
    end
end;

# \video{/assets/animations/gravities/code/output/gravities.mp4}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie", "FileIO"]) # HIDE

