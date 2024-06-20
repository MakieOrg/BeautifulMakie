# ## heatmap: scale-detail

# ![](heatmapScaleDetail.png)

# by @walra356

using CairoMakie
CairoMakie.activate!() # hide

supertitle = "viewing heatmap detail under conservation of physical scale"
# define transformation from pixel coordinates to physical coordinates
edges(p, Δx, x0) = collect(p .* Δx) .- (x0 + 0.5Δx)
# parameters camera chip (pixel coordinates)
dimX = 512
dimY = 512                       # pixel dimensions
(px, py) = (1:dimX, 1:dimY)                  # pixel positions
(sx, sy) = (100:150, 380:420)                # idem for submatrix
(ix, iy) = (125, 400)                        # selected pixel
# physical coordinates
(Δx, Δy) = (4.0, 5, 0)                       # pixel lattice periods (μm)
(Ox, Oy) = (0.0, 0.0) # manual offset (μm)
(x, y) = (edges(px, Δx, Ox), edges(py, Δy, Oy)) # pixel positions (μm)
(u, v) = (edges(sx, Δx, Ox), edges(sy, Δy, Oy))  # idem for submatrix
# create exposure matrix σ (model alternative for measurement file)
valmax = 500.0                              # maximum value exposure matrix
exposure(i, j, ix, iy, wx, wy) = 0.9valmax *
                                  (exp(-(((i - ix) / wx)^2 + ((Δy / Δx) * (j - iy) / wy)^2)) + 0.1)
σ = round.(Int, [exposure(i, j, ix, iy, 6, 6) for i = 1:dimX, j = 1:dimY])
σ1 = σ[px, py] # raw matrix
σ2 = σ[sx, sy] # submatrix
footnote = "Origin of coordinate system was shifted by ($Ox μm, $Oy μm)
            w.r.t. left-bottom edge of camera chip
            \nPixel lattice periods: (Δx = $Δx μm, Δy = $Δy μm);
            pixel position of light spot: (ix, y0) = ($(ix), $(iy))"

# start actual plot
theme = Theme(fontsize = 12, colormap = :gist_earth, ; size = (750, 500))
set_theme!(theme)
fig = Figure()
# collect attributes
fsize = fig.scene.theme.fontsize.val
attr = (xlabelsize = 6fsize / 5, ylabelsize = 6fsize / 5, titlesize = 7fsize / 5,
  xautolimitmargin = (0, 0), yautolimitmargin = (0, 0),)
attr1 = (attr..., title = "raw data",
  xticks = [px[1], ix, px[end]], yticks = [py[1], iy, py[end]],
  xlabel = "x (pixel)", ylabel = "y (pixel)",
  aspect = (Δx * size(σ1, 1)) / (Δy * size(σ1, 2)),)
attr2 = (attr..., title = "physical scale",
  xticks = [x[1] - Δx / 2, x[ix], x[end] + Δx / 2],
  yticks = [y[1] - Δy / 2, y[iy], y[end] + Δy / 2],
  xlabel = "x (μm)", ylabel = "y (μm)",
  aspect = (Δx * size(σ1, 1)) / (Δy * size(σ1, 2)),)
attr3 = (attr..., title = "physical detail",
  xticks = [u[1] - Δx / 2, u[1+ix-sx[1]], u[end] + Δx / 2],
  yticks = [v[1] - Δy / 2, v[1+iy-sy[1]], v[end] + Δy / 2],
  xlabel = "x (μm)", ylabel = "y (μm)",
  aspect = (Δx * size(σ2, 1)) / (Δy * size(σ2, 2)),)
attrc = (label = "exposure (counts)", ticksize = 6fsize / 5, tickalign = 1,
  width = 15, height = Relative(0.54),) # tweaked
# create axes and add contents
ax1 = Axis(fig; attr1...)
ax2 = Axis(fig; attr2...)
ax3 = Axis(fig; attr3...)
hm1 = heatmap!(ax1, px, py, σ1)
hm2 = heatmap!(ax2, x, y, σ1)
hm3 = heatmap!(ax3, u, v, σ2)
axc = Colorbar(fig, hm1; attrc...)
axn = Label(fig, text = footnote, fontsize = 6fsize / 5) # footnote
axt = Label(fig, text = supertitle, fontsize = 2fsize) # supertitle
# create layout and show figure
fig[1, 1] = ax1
fig[1, 2] = ax2
fig[1, 3] = ax3
fig[1, 4] = axc
fig[2, :] = axn
fig[0, :] = axt
fig
save("heatmapScaleDetail.png", fig); # hide
