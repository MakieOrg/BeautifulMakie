# ## single 3d line

# ![](line3d.png)

using GLMakie
GLMakie.activate!() 
GLMakie.closeall() # close any open screen

t = 0:0.1:15
lines(sin.(t), cos.(t), t/4; color = t/4, linewidth = 4,
    colormap = :plasma)
    
save("line3d.png", current_figure()); # hide