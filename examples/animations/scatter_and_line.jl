# ## Animate line and point: Projectile motion

# ```@raw html
# <video src="./scatterAndLine.mp4" controls="controls" autoplay="autoplay"></video>
# ```

using GLMakie
GLMakie.activate!()
GLMakie.closeall() # hide

## let's define some trajectory equations:
x(t; v₀ = 270, θ = 60) = v₀ * t * cos(θ * π / 180)
y(t; v₀ = 270, θ = 60, g = 9.8) = v₀ * t * sin(θ * π / 180) - g * t^2 / 2

## Define a point function 
loc_point(t) = Point2f(x(t), y(t))
## and a time span to calculate some coordinates
t = 0:0.5:50
## initial point
traj = Observable(loc_point.(t[1:2]))
lead_point = Observable(loc_point(t[2]))

## first frame, initial plot
fig = Figure(; size = (600,400))
ax = Axis(fig[1,1]; xlabel = "x", ylabel = "y")
lines!(ax, traj; color = :grey45, linewidth = 2)
scatter!(lead_point; color = :orangered, markersize = 15)
fig
## the animation is done by updating the Observables
record(fig, "scatterAndLine.mp4") do io
    for t_i in t[3:end]
        push!(traj[], loc_point(t_i)) # add new point to trajectory
        lead_point[] = loc_point(t_i) # update leading point
        ax.title = "t = $(t_i)"
        autolimits!(ax)
        ylims!(ax, -1000, 3000)
        traj[] = traj[] #  trigger all updates for the new frame
        recordframe!(io)  # record a new frame
    end
end
