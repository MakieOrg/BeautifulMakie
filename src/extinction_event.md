
[Original version](https://sos.noaa.gov/catalog/datasets/tsunami-asteroid-impact-66-million-years-ago/)

Take a look also at the [paper](https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2021AV000627)

Download files `MOST_timestep_output_*part1-part6` from 
[here](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/GWOFIO)

then use `cat` to put them togheter, i.e.,

```
cat "5028699" "5028694" "5028697" "5028700" "5028695" "5028696" > "MOST"
```

Because the file is too big, the output for the following script is generated locally:

```julia
using GLMakie
using NCDatasets
using GLMakie.GeometryBasics
using Dates

function SphereTess(; o=Point3f(0), r=1, tess=128)
    return uv_normal_mesh(Tesselation(Sphere(o, r), tess))
end

ds = Dataset("MOST")
tempo = ds["TIME"][:]
indx = Observable(1)
ds1 = @lift(replace(ds["HA"][:,:,$indx]/100, missing=>NaN)')

with_theme(theme_dark()) do
    fig = Figure(resolution= (900,900))
    ax = LScene(fig[1,1], show_axis=false)
    obj = mesh!(ax, SphereTess();
        color = ds1,
        colorrange = (-1, 1),
        colormap = :seaborn_icefire_gradient,
        nan_color =:snow4,
        transparency=false,
        highclip = :gold,
        lowclip = :aliceblue,
        )
    sl = Slider(fig[1, 2], range = 1:576, startvalue = 150, horizontal = false)
    Colorbar(fig[1,3], obj, highclip = :yellow, lowclip = :white,
        label = "Wave Amplitude [m]")
    connect!(indx, sl.value)
    Label(fig[1, 1, Bottom()], "Data: Johnson, Brandon Charles, 2022\nReplication Data for: The Chicxulub Impact Produced a Powerful Global Tsunami\nHarvard Dataverse, V1.",
        justification = :left, fontsize = 14,
        halign = :left, color = :grey90)
    Label(fig[1,1, Top()],
        rich("Visualization by Lazaro Alonso\n", color = :silver,
            rich("using Makie", color=:white)),
        fontsize = 18, halign = :left)
    Label(fig[1,1, Top()],
        @lift(rich("Day: $(day(tempo[$indx])) Hour: $(hour(tempo[$indx])), $(Minute(tempo[$indx]))",
            color = :silver)),
        fontsize = 18, halign = :right)
    rotate!(ax.scene, 1.5)
    zoom!(ax.scene, cameracontrols(ax.scene), 0.65)
    fig
end
```
![](/extinction_event.png)