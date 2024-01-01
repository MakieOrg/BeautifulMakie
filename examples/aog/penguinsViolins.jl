using CairoMakie, PalmerPenguins, DataFrames
using AlgebraOfGraphics
CairoMakie.activate!(type = "svg") #hide

function getPenguins()
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"
    penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    return penguins
end
let
    penguins = getPenguins()
    ## declare new plot attributes
    palette = (color=tuple.(["#FC7808", "#8C00EC", "#107A78"], 0.65),
        marker=[:circle, :utriangle, :rect])
    cycle = Cycle([:color, :marker], covary=true)

    p_len  = data(penguins) 
    p_len *= mapping(:flipper_length_mm => (t -> t / 10),
        :bill_length_mm => (t -> t / 10))
    p_len *= mapping(color=:species, marker=:species)

    bpl = data(penguins)
    bpl *= mapping(:species, :bill_length_mm => (t -> t / 10), color = :species)
    bpl *= visual(Violin)

    bplt = data(penguins)
    bplt *= mapping(:species, :flipper_length_mm => (t -> t / 10), color = :species)
    bplt *= visual(Violin, orientation = :horizontal)

    with_theme(theme_light(),size = (600,400), palette=palette, Scatter=(cycle=cycle,)) do
        fig = Figure()
        axs = [Axis(fig[2,1], xlabel = "flipper length (cm)", ylabel = "bill length (cm)"),
            Axis(fig[1,1]), Axis(fig[2,2])]
        dots = draw!(axs[1], p_len)
        draw!(axs[2], bplt)
        draw!(axs[3], bpl)
        ## getting the right layout aspect
        colsize!(fig.layout, 1, Auto(4.0))
        rowsize!(fig.layout, 1, Auto(1/3))
        colgap!(fig.layout,3)
        rowgap!(fig.layout, 3)
        linkxaxes!(axs[1], axs[2])
        linkyaxes!(axs[1], axs[3])
        hidedecorations!.(axs[2:3], grid=false)
        legend!(fig[1,2], dots)
        fig
    end
    save("penguinsViolins.svg", current_figure()); # hide
end

# ![](penguinsViolins.svg)