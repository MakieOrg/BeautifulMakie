using CairoMakie
CairoMakie.activate!(type = "svg") #hide
x = 0:0.05:4π
fig = Figure(size = (600, 400), fonts = (; regular= "CMU Serif")) ## probably you need to install this font in your system
ax = Axis(fig[1, 1], xlabel = L"x", ylabel = L"f (x)", ylabelsize = 22,
    xlabelsize = 22, xgridstyle = :dash, ygridstyle = :dash, xtickalign = 1,
    xticksize = 10, ytickalign = 1, yticksize = 10, xlabelpadding = -10)
lines!(x, x -> sin(3x) / (cos(x) + 2) / x; label = L"\frac{\sin(3x)}{x(\cos(x) + 2)}")
lines!(x, x -> cos(x) / x; label = L"\cos(x)/x")
lines!(x, x -> exp(-x); label = L"e^{-x}")
ylims!(-0.6, 1.05)
xlims!(-0.5, 12)
axislegend(L"f(x)"; position = :rt, backgroundcolor = (:grey90, 0.25));

save("line_latex.svg", fig); # hide

# ![](line_latex.svg)