


```julia
using CairoMakie, SpecialFunctions

p(s, β) = (β + 1)*a(β) * s^β * exp(-a(β)*s^(β+1))
a(β) = gamma(((β + 2)/(β + 1))^(β + 1))
s = LinRange(0,3,30)
colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]

fig = Figure(size = (600,400))
ax = Axis(fig[1,1]; palette = (; color = colors))
for β in [0,1], step in [:pre, :center, :post]
    stairs!(s, p.(s, β); linestyle = :solid, step = step, label = "$(β), :$(step)")
end
lines!(s, p.(s, 1), color = :grey30)
lines!(s, p.(s, 0), color = :grey10)
text!(L"p(s)=(\beta+1)a_{\beta}\,s^{\beta}\exp(-a_{\beta}s^{\beta+1})",
    position = (0.7, 0.95), color = :black)
text!(L"a_{\beta} = \Gamma[(\beta+2)/(\beta+1)]^{\beta + 1}",
    position = (1.7, 0.25), color = :black)
axislegend("β, step", position = :rt);
fig
```


```
┌ Warning: Keyword argument `bgcolor` is deprecated, use `backgroundcolor` instead.
└ @ Makie ~/.julia/packages/Makie/Qvk4f/src/makielayout/blocks/legend.jl:22
```


![](stairs.svg)

