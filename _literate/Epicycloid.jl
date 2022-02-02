md"""
## Epicycloid
"""

## by Lazaro Alonso
using CairoMakie
CairoMakie.activate!()
let
    function EpicycloidLines()
        ecycl_x(r, k, θ) = r * (k .+ 1) .* cos.(θ) .- r * cos.((k .+ 1) .* θ)
        ecycl_y(r, k, θ) = r * (k .+ 1) .* sin.(θ) .- r * sin.((k .+ 1) .* θ)
        θ = LinRange(0, 6.2π, 1000)
        tronLegacy = ["#FF410DFF", "#6EE2FFFF", "#F7C530FF", "#95CC5EFF",
            "#D0DFE6FF", "#F79D1EFF", "#748AA6FF"]

        fig = Figure(resolution = (600, 400), font = :sans)
        ax = Axis(fig[1, 1], aspect = 1, title = "Epicycloid",
            xlabel = "x(θ) = r(k+1)cos(θ) -rcos((k+1)θ)",
            ylabel = "y(θ) = r(k+1)cos(θ) -rcos((k+1)θ)")
        [lines!(ecycl_x(2k, k, θ), ecycl_y(2k, k, θ), linewidth = 1.5, label = "$(k)",
            color = tronLegacy[indx]) for (indx, k) in enumerate(2:0.5:5)]
        Legend(fig[1, 2], ax, "k , r = 2k")
        colsize!(fig.layout, 1, Aspect(1, 1.0))
        fig
    end
    fig = with_theme(EpicycloidLines, theme_black())
    save(joinpath(@OUTPUT, "Epicycloid.svg"), fig) # HIDE
    ## display(fig)
end;
# \fig{Epicycloid.svg}
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status("CairoMakie") # HIDE
