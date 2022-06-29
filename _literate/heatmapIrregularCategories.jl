# Example by @walra356 (modified)
using CairoMakie, Random
CairoMakie.activate!() #HIDE
let
    Random.seed!(13)
    n= 5
    x = rand(n)                        # specify x steplength
    y = rand(n)                        # specify y steplength
    σ = rand(length(x), length(y))      # beware of dims
    # custom ticks
    function steps(x::Vector{T} where T<:Real)
        sum(x .< 0) == 0 || error("Error: $x - negative step length not allowed")
        (s = append!(eltype(x)[0],x); [Base.sum(s[1:i]) for i ∈ Base.eachindex(s)])
    end
    function stepcenters(x::Vector{T} where T<:Real)
        δ = x .* 0.5
        s = append!(eltype(x)[0],x)
        [Base.sum(s[1:i]) for i ∈ Base.eachindex(x)] .+ δ
    end
    stepedges(x::Vector{T} where T<:Real) = steps(x)

    # the actual plot
    theme = Theme(fontsize = 16, colormap = :gist_earth, resolution = (750,450))
    set_theme!(theme)

    attr1 = (xticks = (stepcenters(x),string.(1:n)),
        yticks = (stepcenters(y), string.(1:n)), xlabel = "cat", )
    attr2 = (xticks = (stepedges(x),string.(0:n)),
        yticks = (stepedges(y), string.(0:n)), xlabel="cat", )

    fig = Figure()
    ax1 = Axis(fig[1,1]; attr1...)
    ax2 = Axis(fig[1,2]; attr2...)
    heatmap!(ax1, steps(x), steps(y), σ)
    heatmap!(ax2, steps(x), steps(y), σ)
    ## display(fig)
    save(joinpath(@__DIR__, "output", "heatmapIrregularCategories.svg"), fig) # HIDE
    set_theme!()
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "Random"]) # HIDE
