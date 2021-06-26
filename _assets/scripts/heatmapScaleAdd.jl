# by @walra356
using CairoMakie
CairoMakie.activate!() #HIDE
let
    supertitle = "adding physical scale to exposure heatmap of camera chip"
  # define transformation from pixel coordinates to physical coordinates
    edges(p,Δx,x0) = collect(p .* Δx) .-(x0+0.5Δx)
  # parameters camera chip (pixel coordinates)
    dimX = 40; dimY = 30                        # pixel dimensions camera chip
    (px, py) = (1:dimX, 1:dimY)                 # pixel positions
    (ix, iy) = (10, 3)                          # selected pixel
  # physical coordinates
    (Δx, Δy) = (4.0, 5,0)                       # pixel lattice periods (μm)
    (Ox, Oy) = (0.0, 0.0)                           # manual offset (μm)
    (x, y) = (edges(px,Δx,Ox), edges(py,Δy,Oy)) # pixel positions (μm)
  # create exposure matrix σ (model alternative for measurement file)
    valmax = 500.0                              # maximum value exposure matrix
    exposure(i, j , ix, iy, wx, wy) = 0.9valmax *
                        (exp(-(((i-ix)/wx)^2 + ((Δy/Δx)*(j-iy)/wy)^2)) + 0.1)
    σ = round.(Int, [exposure(i, j, ix, iy, 6, 6) for i=1:dimX, j=1:dimY])
    σ = σ[px,py]                                # exposure matrix
    footnote = "Origin of coordinate system was shifted by ($Ox μm, $Oy μm)
                w.r.t. left-bottom edge of camera chip
                \nPixel lattice periods: (Δx = $Δx μm, Δy = $Δy μm);
                pixel position of light spot: (ix, y0) = ($(ix), $(iy))"

  # start actual plot
    theme = Theme(fontsize = 12, colormap = :gist_earth, resolution = (750,500))
    set_theme!(theme)
    fig = Figure()
  # specify attributes
    fsize = fig.scene.attributes.fontsize.val
    fres = fig.scene.attributes.resolution.val[1]
    attr = (xlabelsize = 6fsize/5, ylabelsize = 6fsize/5, titlesize = 7fsize/5,
            xautolimitmargin = (0,0), yautolimitmargin = (0,0), )
    attr1 = (attr..., title = "raw data",
            xticks = [px[1], ix, px[end]] , yticks = [py[1], iy, py[end]] ,
            xlabel = "x (pixel)", ylabel = "y (pixel)",
            aspect = (Δx * size(σ,1))/(Δy * size(σ,2)), )
    attr2 = (attr..., title = "physical scale",
            xticks = [x[1]-Δx/2, x[ix], 100, x[end]+Δx/2] ,
            yticks = [y[1]-Δy/2, y[iy], 100, y[end]+Δy/2],
            xlabel = "x (μm)", ylabel = "y (μm)",
            aspect = (Δx * size(σ,1))/(Δy * size(σ,2)), )
    attr4 = (label = "exposure (counts)", ticksize=6fsize/5, tickalign = 1,
            width = 15, height = Relative(0.98), ) # tweaked
  # create axes, add contents
    ax1 = Axis(fig; attr1...)
    ax2 = Axis(fig; attr2...)
    hm1 = heatmap!(ax1, px, py, σ)
    hm2 = heatmap!(ax2, x, y, σ)
    ax4 = Colorbar(fig, hm1; attr4...)
    axn = Label(fig, text = footnote, textsize = 6fsize/5)
    axt = Label(fig, text = supertitle, textsize = 2fsize)
  # create layout and show figure
    fig[1,1] = ax1
    fig[1,2] = ax2
    fig[1,3] = ax4
    fig[2,:] = axn
    fig[0,:] = axt
    fig
    save(joinpath(@__DIR__, "output", "heatmapScaleAdd.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
