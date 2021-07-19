# by Lazaro Alonso 
using CairoMakie, LaTeXStrings, SpecialFunctions
CairoMakie.activate!() # HIDE 
let 
    cycle = Cycle([:color, :linestyle, :marker], covary = true)    
    set_theme!(Lines = (cycle = cycle,), Scatter = (cycle = cycle,))
    #set_theme!()
    fig = Figure(resolution = (600,400), font = "CMU Serif") # probably you need to install this font in your system 
    ax = Axis(fig, xlabel = L"x", ylabel = L"Y_{\nu}(x)", ylabelsize = 22, 
        xlabelsize= 22, xgridstyle=:dash, ygridstyle=:dash, xtickalign = 1, 
        xticksize=10, ytickalign=1, yticksize=10,  xlabelpadding = -10)
    x = 0.1:0.1:15
    for ν in 0:4
        lines!(ax, x, bessely.(ν, x), label = latexstring("Y_{$(ν)}(x)"), linewidth = 2)
        #scatter!(ax, x, bessely.(ν, x), label = latexstring("Y_{$(ν)}(x)"), linewidth = 2)
    end
    axislegend(; position = :rb, nbanks = 2, framecolor = (:grey,0.5))
    ylims!(-1.8,0.7)
    #xlims!(0.1,nothing)
    fig[1,1] = ax
    #save("filename.png", fig, px_per_unit = 2.0) 
    save(joinpath(@__DIR__, "output", "besselSecondKind.png"), fig, px_per_unit = 2.0) # HIDE 
    display(fig)
end
using Pkg # HIDE 
Pkg.status() # HIDE 