md"""
## Lorenz Attractor Animation
"""
## by Lazaro Alonso
## see discussion:
## https://discourse.julialang.org/t/lorenz-attractor-with-makie/63712/3
using GLMakie, DifferentialEquations, ParameterizedFunctions
GLMakie.activate!() # HIDE
let
    g = @ode_def begin
        dx = σ * (y - x)
        dy = x * (ρ - z) - y
        dz = x * y - β * z
    end σ ρ β
    u0 = [1.0; 0.0; 0.0]
    tspan = (0.0, 30.0)
    p = [10.0, 28.0, 8 / 3]
    prob = ODEProblem(g, u0, tspan, p)
    sol = solve(prob, Tsit5(), saveat = 0.01)
    tempo = sol.t
    ## x, y, z = sol[1,:], sol[2,:], sol[3,:]
    ## the plot/animation
    with_theme(theme_dark()) do
        fig = Figure(resolution = (1200, 800), fontsize = 22)
        ax = Axis3(fig[2, 1], aspect = :data, azimuth = -0.3π, elevation = π / 9,
            perspectiviness = 0.5)
        ## let's start with some points, so that the plot is not empty
        points = Observable([Point3f(sol[:, 1]), Point3f(sol[:, 2])])
        color = Observable(tempo[1:2])   # color value is also updated
        attr = (color = color, transparency = true, colormap = :Hiroshige)
        pltobj = lines!(ax, points; attr..., overdraw = false)
        scatter!(ax, map(x -> x[end], points); markersize = 0.04, color = :white,
            markerspace = SceneSpace)
        Colorbar(fig[1, 1], pltobj, label = "time", height = 15,
            vertical = false, ticksize = 15, tickalign = 1, width = Relative(0.5))
        ## the animation is done by updating the Observables
        path = joinpath(@__DIR__, "output", "lorenzAttractorAnim.mp4")
        record(fig, path, enumerate(tempo[3:end]), framerate = 24 * 8) do (i, t)
            xyz = Point3f(sol[:, i+2])
            push!(points[], xyz)
            push!(color[], t)
            notify(points)
            notify(color)
            autolimits!(ax)
        end
    end
end;
# \video{/assets/animations/lorenzAttractorAnim/code/output/lorenzAttractorAnim.mp4}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GLMakie", "DifferentialEquations", "ParameterizedFunctions"]) # HIDE
