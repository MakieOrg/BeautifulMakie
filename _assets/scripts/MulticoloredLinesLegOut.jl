# by lazarusA # HIDE
# using GLMakie # HIDE
using CairoMakie, ColorSchemes
let
    xs = 0:0.01:1
    p = -10:1:10
    p= filter(x->x != 0,collect(p))
    ys = zeros(length(xs), length(p))
    for (indx,i) in enumerate(p)
        if i <= -1
            ys[:,indx]= xs .^(1/abs(i))
        elseif i>= 1
            ys[:,indx]= xs .^i
        end
    end
    cbarPal = :thermal
    cmap = get(colorschemes[cbarPal], LinRange(0,1,length(p)))

    fig = Figure(resolution = (700, 450), font =:sans, fontsize = 18)
    ax = Axis(fig, aspect = 1, xlabel = "x", ylabel = "xᵖ")
    lins = [lines!(xs, ys[:,v], color = cmap[v]) for v in 1:length(p)]
    leg = Legend(fig, lins, string.(p), "p", nbanks = 2, labelsize = 12,
     valign = :center)
    fig[1, 1] = ax
    fig[1, 2] = leg
    #save("MulticoloredLinesLegOut.png", fig, px_per_unit = 2)
    save(joinpath(@__DIR__, "output", "MulticoloredLinesLegOut.png"), fig, px_per_unit = 2) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "ColorSchemes"]) # HIDE
