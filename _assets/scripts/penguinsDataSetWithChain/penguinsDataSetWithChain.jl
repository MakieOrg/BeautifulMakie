# Ari Huttunen # HIDE
using Pkg # HIDE
Pkg.activate(@__DIR__) # HIDE # ?confused about global dir or relative dir, this works for now running from the dir.
Pkg.add(["Makie","CairoMakie","PalmerPenguins", "Colors", "Chain", "DataFrames", "GLM"]) # HIDE
using CairoMakie, PalmerPenguins, Colors, Chain, DataFrames
CairoMakie.activate!() # HIDE
let
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true" # Don't ask if the datasets should be downloaded
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    set_theme!(Theme(
        Axis = (
            leftspinevisible = false,
            rightspinevisible = false,
            bottomspinevisible = false,
            topspinevisible = false,
            xticksvisible = false,
            yticksvisible = false,
        ),
    ))

    # These colors were taken from https://allisonhorst.github.io/palmerpenguins/
	adeliecolor = colorant"#FC7808"
	chinstrapcolor = colorant"#8C00EC"
	gentoocolor = colorant"#107A78"
	(adeliecolor, chinstrapcolor, gentoocolor)

    style = Dict(
        "Adelie" => (
            color=(adeliecolor,0.7),
            strokecolor=adeliecolor,
            label="Adelie",
            marker=:circle,
            markersize=20,
			linewidth = 5
        ),
        "Chinstrap" => (
            color=(chinstrapcolor,0.7),
            strokecolor=chinstrapcolor,
            label="Chinstrap",
            marker=:utriangle,
            markersize=20,
			linewidth = 5
        ),
        "Gentoo" => (
            color=(gentoocolor,0.7),
            strokecolor=gentoocolor,
            label="Gentoo",
            marker=:rect,
            markersize=20,
			linewidth = 5
        )
    )

	fig = Figure(resolution = (1000, 700))
	ax1 = fig[1, 1] = Axis(fig, title = "Flipper and bill length",
		xlabel="Flipper length (mm)", ylabel="Bill length (mm)")
	ax1.xticks = 160:10:240
	ax1.yticks = 30:5:60

	specie = @chain penguins begin
		filter(:species => ==("Adelie"), _)
	end
	X = specie[!,:flipper_length_mm]
	Y = specie[!,:bill_length_mm]
	scatter!(ax1, X, Y; style["Adelie"]...)
	ols = lm(@formula(Y ~ X), DataFrame(X=X, Y=Y))
	y = predict(ols)
	lines!(ax1, X, y; style["Adelie"]...)

	chinstrap = @chain penguins begin
		filter(:species => ==("Chinstrap"), _)
	end
	X = chinstrap[!,:flipper_length_mm]
	Y = chinstrap[!,:bill_length_mm]
	scatter!(ax1, X,Y; style["Chinstrap"]...)
	ols = lm(@formula(Y ~ X), DataFrame(X=X, Y=Y))
	y = predict(ols)
	lines!(ax1, X, y; style["Chinstrap"]...)

	gentoo = @chain penguins begin
		filter(:species => ==("Gentoo"), _)
	end
	X = gentoo[!,:flipper_length_mm]
	Y = gentoo[!,:bill_length_mm]
	scatter!(ax1,X, Y; style["Gentoo"]...)
	ols = lm(@formula(Y ~ X), DataFrame(X=X, Y=Y))
	y = predict(ols)
	lines!(ax1, X, y; style["Gentoo"]...)
	axislegend("Penguin species", position = :rb)

    save(joinpath(@__DIR__, "output", "penguinsDataSetWithChain.png"), fig)
end

using Pkg # HIDE
Pkg.status() # HIDE
Pkg.activate() # HIDE
