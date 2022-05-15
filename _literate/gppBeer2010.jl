md"""
## GPP Beer 2010, NetCDF file
"""
## by Lazaro Alonso
using CairoMakie, NCDatasets
CairoMakie.activate!() # HIDE
let
    dataset = Dataset("./_assets/data/GPPdata_Beer_etal_2010_Science.nc")
    lon = dataset["lon"]
    lat = dataset["lat"]
    data = dataset["gpp"][:, :]

    fig = Figure(resolution=(1250, 700), fontsize=25)
    ax = Axis(fig[1, 1], xlabel="lon", ylabel="lat", xticksize=15, yticksize=15,
        xgridstyle=:dash, ygridstyle=:dash,)
    pltobj = heatmap!(ax, lon, lat, replace(data, -9999 => NaN), colormap=:Spectral_11)
    Colorbar(fig[1, 2], pltobj, label="gpp", ticklabelsize=25, tickalign=1)
    ax.xticks = -180:60:180
    ax.yticks = -90:30:90
    ax.xtickformat = "{:d}ᵒ"
    ax.ytickformat = "{:d}ᵒ"
    hidespines!(ax, :t, :r)
    fig
    save(joinpath(@OUTPUT, "gppBeer2010.png"), fig) # HIDE
end;
# \fig{gppBeer2010.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["CairoMakie", "NCDatasets"]) # HIDE
