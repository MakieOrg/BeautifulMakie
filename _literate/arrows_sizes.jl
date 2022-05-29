md"""
## Arrows, different sizes
"""

## by Lazaro Alonso
## https://github.com/JuliaPlots/Makie.jl/issues/356
using CairoMakie
CairoMakie.activate!() # HIDE
let
    ## display(fig)
    ## save(joinpath(@OUTPUT, "arrows.svg"), fig) # HIDE
end;
# \fig{arrows.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE