using CairoMakie, LaTeXStrings, SpecialFunctions
let 
    x = 0:0.05:4π
    fig = Figure(resolution = (600,400), font = "CMU Serif") # probably you need to install this font in your system 
    ax = Axis(fig, xlabel = L"x", ylabel = L"J_{\nu}(x)", ylabelsize = 22, 
        xlabelsize= 22, xgridstyle=:dash, ygridstyle=:dash, xtickalign = 1, 
        xticksize=10, ytickalign=1, yticksize=10,  xlabelpadding = -10)
    x = 0:0.1:15
    for ν in 0:6
        lines!(ax, x, besselj.(ν, x), label = latexstring("J_{$(ν)}(x)"))
    end
    axislegend(; nbanks = 3, framecolor = (:grey,0.5))
    fig[1,1] = ax
    #save("filename.png", fig, px_per_unit = 2.0) 
    save(joinpath(@__DIR__, "output", "besselFunctions.png"), fig, px_per_unit = 2.0) # HIDE 
    display(fig)
end
using Pkg # HIDE 
Pkg.status() # HIDE 