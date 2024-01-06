# ## Multiple Titles

# ![](multipleTitles.svg)

using CairoMakie
using Random
CairoMakie.activate!(type = "svg") #hide
# from this [post](https://discourse.julialang.org/t/how-to-make-a-plot-with-multiple-titles-and-labels-in-makie/89137)

Random.seed!(1234)

x = range(2007, 2035, length = 1000)

function randdata(n)
    data = cumsum(randn(1000))
    data .-= range(first(data), last(data), length = 1000)
    data .* 0.1
end
euro = randdata(1000)
japan = randdata(1000) .+ 1
uk = randdata(1000) .- 2
emerging = randdata(1000) .- 6

with_theme(theme_dark(), size = (650, 450)) do
    fig = Figure()
    ax = Axis(fig[1, 1], xgridvisible = false, ygridvisible = false, xticksvisible = false, alignmode = Outside(), xticks = 2007:4:2031, ytrimspine = true, 
        palette = (; color = [:deepskyblue, :firebrick3, :dodgerblue4, :goldenrod1]))

    hidespines!(ax, :b, :t, :r)
    hlines!(ax, 0, color = :grey90, linewidth = 1)

    for (label, data) in ["Euro" => euro, "Japan" => japan, "UK" => uk, "Emerging markets" => emerging]
        lines!(ax, x, data; label, linewidth = 2)
    end

    titlelayout = GridLayout(fig[0, 1], halign = :left, tellwidth = false)
    Label(titlelayout[1, 1], "Interest rate differentials", halign = :left, fontsize = 30, font="TeX Gyre Heros Bold Makie")
    Label(titlelayout[2, 1], "Differences in monetary policy are a key driver of the strong dollar.", halign = :left, fontsize = 20)
    Label(titlelayout[3, 1], "(versus US interest rate, percent)", halign = :left)
    rowgap!(titlelayout, 0)

    for (label, (year, y)) in ["Global\nfinancial\ncrisis" => (2008, 8), "Taper\ntantrum" => (2013, 8), "China\n2015\ncrisis" => (2015.4, 6), "Russia invasion\nof Ukraine" => (2022.1, 8)]
        lines!(ax, [year, year], [-10, y], color = :grey90, linestyle = :dash)
        text!(ax, year, y, text = label, align = (:left, :top), offset = (10, 0), fontsize = 14)
    end

    ylims!(ax, -11, 11)
    xlims!(ax, 2007, 2035)

    axislegend(position = (0.5, 1.05), orientation = :horizontal,
        framevisible = false)

    Label(fig[2, 1], """
    Sources: Bloomberg Finance L.P.; Haver Analytics; and IMF staff calculations.
    Notes: Differential is calculated as US overnight bank funding rate minus foreign
    inter-bank rate. The dots depict the forward paths for nominal interest rates.
    """, tellwidth = false, halign = :left, justification = :left)
    fig
end

save("multipleTitles.svg", current_figure()); # hide