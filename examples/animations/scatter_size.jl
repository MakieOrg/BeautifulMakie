# ## Animate markersize growth

# ```@raw html
# <video src="./animScatters.mp4" controls="controls" autoplay="autoplay"></video>
# ```

using GLMakie, Random
GLMakie.activate!()
GLMakie.closeall() # hide

Random.seed!(123)
npts = 100
initms = 8 * rand(npts)
with_theme(theme_dark()) do
    msize = Observable(initms) # this is the variable that will change
    ## first frame, initial plot
    fig, ax = scatter(2 * rand(npts), rand(npts), markersize = msize,
        color = initms, colormap = (:Greek, 0.75), strokewidth = 0.5,
        strokecolor = :white,
        figure = (size = (1200, 800), fontsize = 22),
        axis = (xlabel = "x", ylabel = "y",))
    limits!(ax, 0, 2, 0, 1)
    ## the animation is done by updating the Observable values
    ## change assets->(your folder) to make it work in your local env
    record(fig, "animScatters.mp4",
        framerate = 24, profile = "main") do io
        for i in 1:0.1:8
            msize[] = i * initms
            recordframe!(io)  # record a new frame
        end
    end
    nothing # hide
end