# Ari Huttunen # HIDE
using Pkg; Pkg.add(["PalmerPenguins", "Colors", "Chain", "DataFrames"]) # HIDE
using CairoMakie, PalmerPenguins, Colors, Chain, DataFrames
CairoMakie.activate!() # HIDE
let
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
            markersize=20
        ),
        "Chinstrap" => (
            color=(chinstrapcolor,0.7),  
            strokecolor=chinstrapcolor,
            label="Chinstrap", 
            marker=:utriangle, 
            markersize=20
        ),
        "Gentoo" => (
            color=(gentoocolor,0.7), 
            strokecolor=gentoocolor,
            label="Gentoo", 
            marker=:rect, 
            markersize=20
        )
    )

	fig = Figure(resolution = (1000, 700))
	ax1 = fig[1, 1] = Axis(fig, 
		title = "Flipper and bill length",
		xlabel="Flipper length (mm)", 
		ylabel="Bill length (mm)")
	ax1.xticks = 160:10:240
	ax1.yticks = 30:5:60
	
	@chain penguins begin
		filter(:species => ==("Adelie"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm];
			style["Adelie"]...)
	end
	
	@chain penguins begin
		filter(:species => ==("Chinstrap"), _)
		scatter!(ax1, _[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			style["Chinstrap"]...)
	end
	
	@chain penguins begin
		filter(:species => ==("Gentoo"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			style["Gentoo"]...)
	end

	axislegend("Penguin species", position = :rb)

    save(joinpath(@__DIR__, "output", "penguinsDataSetWithChain.png"), fig)
end

using Pkg # HIDE
Pkg.status(["CairoMakie", "PalmerPenguins", "Colors", "Chain", "DataFrames"]) # HIDE
