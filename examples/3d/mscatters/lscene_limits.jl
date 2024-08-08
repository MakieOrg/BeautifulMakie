# ## Sets limits on a LScene 

# ![](lscene_limits.png)

using GLMakie
using Random
Random.seed!(1618)
GLMakie.activate!()

fig = Figure()
ax = LScene(fig[1, 1], scenekw = (;
    limits=Rect3f(Vec3f(0,0,0),Vec3f(1.5, 1.5, 2.5)))
    )
meshscatter!(ax, rand(Point3f, 10); color = :orangered)
meshscatter!(ax, rand(Point3f, 10) .+ Point3f(0,0,1);
    color = :grey25, marker=Rect3f(Vec3f(-0.5), Vec3f(1)))
fig
save("lscene_limits.png", fig); # hide