# by Lazaro Alonso
using CairoMakie
CairoMakie.activate!() # HIDE
let
        x = y = -2:0.005:2
        f(z) = 1 / (z * (z^2 - z - 1 - 3im))
        fvals = [f(u + 1im * v) for u in x, v in y]
        fvalues = abs.(fvals)
        fargs = angle.(fvals)
        polya(x, y) = Point2f(real(f(x + 1im * y)), -imag(f(x + 1im * y)))

        fig = Figure(resolution = (900, 400))
        axs = [Axis(fig[1, i], aspect = 1) for i in 1:2]
        cmap = :roma
        streamplot!(axs[1], polya, -2 .. 2, -2 .. 2, colormap = (:black, :red),
                gridsize = (40, 40), arrow_size = 6, linewidth = 1)
        pltobj2 = heatmap!(axs[2], x, y, fargs, colorrange = (-π, π), colormap = cmap)
        streamplot!(axs[2], polya, -2 .. 2, -2 .. 2, colormap = (:black, :black),
                gridsize = (40, 40), arrow_size = 6, linewidth = 1)
        Colorbar(fig[1, 3], pltobj2, ticks = ([-π, -π / 2, 0, π / 2, π],
                [L"-\pi", L"-\pi/2", L"0", L"\pi/2", L"\pi"]))
        limits!(axs[1], -2, 2, -2, 2)
        limits!(axs[2], -2, 2, -2, 2)
        colsize!(fig.layout, 1, Aspect(1, 1.0))
        colsize!(fig.layout, 2, Aspect(1, 1.0))
        display(fig)
        save(joinpath(@__DIR__, "output", "complexPolyaField.svg"), fig) # HIDE
end

using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
