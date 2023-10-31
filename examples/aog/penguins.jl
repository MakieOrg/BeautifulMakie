using CairoMakie, PalmerPenguins, DataFrames
using GLM: lm, @formula, predict
CairoMakie.activate!(type = "svg") #hide

function getPenguins()
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"
    penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    return penguins
end

function plotPenguins()
    penguins = getPenguins()
    palette = (color=tuple.(["#FC7808", "#8C00EC", "#107A78"], 0.65),
        marker=[:circle, :utriangle, :rect])
    cycle = Cycle([:color, :marker], covary=true)
    with_theme(theme_light(), palette=palette, Scatter=(cycle=cycle,)) do
        fig = Figure(resolution=(600, 400))
        ax = Axis(fig[1, 1], title="Flipper and bill length",
            xlabel="Flipper length (mm)", ylabel="Bill length (mm)")
        for penguin in ["Adelie", "Chinstrap", "Gentoo"]
            specie = filter(:species => ==(penguin), penguins)
            x = specie[!, :flipper_length_mm]
            y = specie[!, :bill_length_mm]
            linearModel = lm(@formula(Y ~ X), DataFrame(X=x, Y=y))
            ŷ = predict(linearModel)
            scatter!(ax, x, y; markersize=12, label=penguin)
            lines!(ax, x, ŷ; label=penguin, linewidth=4)
        end
        axislegend("Penguin species", position=:rb, bgcolor=(:grey90, 0.15),
            titlesize=12, labelsize=12, merge=true)
        return fig
    end
end
fig = plotPenguins()