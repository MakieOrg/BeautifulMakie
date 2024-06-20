using GLMakie

f = Figure()
Axis(f[1, 1])

# vector of shapes
poly!(
    [Rect(i, j, 0.75, 0.5) for i in 1:5 for j in 1:3],
    color = :white,
    strokewidth = 2,
    strokecolor = 1:15,
    strokecolormap=:plasma,
)
f

