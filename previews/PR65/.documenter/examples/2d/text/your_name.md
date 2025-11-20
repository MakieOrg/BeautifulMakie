


## text: rich text {#text:-rich-text}


![](your_name.svg)


```julia
using GLMakie
using CairoMakie
CairoMakie.activate!(type = "svg")
#GLMakie.activate!()

fig = Figure(figure_padding= 0, size = (320, 48),
    backgroundcolor=:transparent,
    fontsize = 48)
ax = Axis(fig[1,1], backgroundcolor=:transparent)
text!(ax, [0], [0],
    text= rich(rich("Your", font="Bold"), " Name", font =:regular),
    align = (:center, :center), color = :white)
hidedecorations!(ax)
hidespines!(ax)
fig
```


```ansi
[33m[1m┌ [22m[39m[33m[1mWarning: [22m[39mCould not find font Bold, using TeX Gyre Heros Makie
[33m[1m└ [22m[39m[90m@ Makie ~/.julia/packages/Makie/HyJrI/src/conversions.jl:1456[39m
```

