## by Lazaro Alonso
using GLMakie, Random
GLMakie.activate!()
let
    Random.seed!(123)
    npts = 100
    initms = 8 * rand(npts)
    msize = Observable(initms) # this is the variable that will change
    with_theme(theme_dark()) do
        ## first frame, initial plot
        fig, ax = scatter(2 * rand(npts), rand(npts), markersize = msize,
            color = initms, colormap = (:Greek, 0.75), strokewidth = 0.5,
            strokecolor = :white,
            figure = (resolution = (1200, 800), fontsize = 22),
            axis = (xlabel = "x", ylabel = "y",))
        limits!(ax, 0, 2, 0, 1)
        ## the animation is done by updating the Observable values
        ## change @OUTPUT -> @__DIR__ to make it work in your local env
        record(fig, joinpath(@__DIR__, "output", "animScatters.mp4"),
            framerate = 24, profile = "main") do io
            for i in 1:0.1:8
                msize[] = i * initms
                recordframe!(io)  # record a new frame
            end
        end
    end
end;

using Pkg # HIDE
Pkg.status("GLMakie") # HIDE
