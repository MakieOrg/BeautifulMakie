# by Lazaro Alonso
# original post 
# https://nextjournal.com/lazarus/extracting-dominant-colours-from-pictures
using CairoMakie, Clustering, Colors, Random
using Images: load, RGB, channelview, permutedims
using Downloads: download
CairoMakie.activate!()
"""
getImg(; url = "", file = "")
"""
function getImg(; url = "", file = "")
    try
        out = file != "" ? RGB.(load(file)) : RGB.(load(download(url)))
        return out
    catch e
        out = [RGB{Float64}(rand(3)...) for i in 1:600, j in 1:400]
        return out
    end
end

function getColorPalette(image; ncolors = 5)
    img_CHWa = channelview(image)
    #img_CHW = permutedims(img_CHWa, (1,3,2))
    testmat = reshape(img_CHWa, (3, size(image)[1]*size(image)[2])) #input shape
    sol = kmeans(testmat, ncolors)
    csize = counts(sol) # get the cluster sizes
    colores = sol.centers # get the cluster centers, dominat colors
    indxc = sortperm(csize)
    colores, indxc
end
#url = "https://static.joandjudy.com/media/image/51/b1/13/joandjudy_wallpaper_2107_mobil.jpg"
url = "https://images.wallpaperscraft.com/image/man_paint_sky_129261_320x480.jpg"
path = "/Users/lalonso/Desktop/cecilia3.jpg"
img = getImg(; file = path) # ;url= url
# colores, indxc = getColorPalette(img; ncolors = ncolors)
# color = [RGB(colores[:,indxc[i]]...) for i in 1:ncolors]

function plotPalette(;img=img, marker = :diamond, ncolors = 8)
    Random.seed!(123)
    yshift = 0.04*size(img)[1]
    colores, indxc = getColorPalette(img; ncolors = ncolors)
    color = [RGB(colores[:,indxc[i]]...) for i in 1:ncolors]
    hexNames = [hex(color[i]) for i in 1:ncolors]

    xcolor = fill(1.1*size(img)[2], ncolors)
    ycolor = LinRange(yshift,size(img)[1]-yshift,ncolors)
    fig, ax, _= image(rotr90(img), figure = (resolution = (1.45size(img)[2], size(img)[1]),), 
        axis = (aspect = DataAspect(),))
    scatterlines!(ax, xcolor, ycolor, color = color, markercolor = color, marker = marker, #'■', 
        markersize = 0.1*size(img)[1], linewidth = 2)
    for i in 1:ncolors
        text!(ax, "\"#"*hexNames[i]*"\"", position = (1.07xcolor[i], ycolor[i]-5), 
            textsize = 0.025*size(img)[1])
    end
    text!(ax, "@cicifeb", position = (20, 20), textsize = 30)
    #scatter!(ax, [20], [20], marker = '📷', markersize = 30)
    xlims!(nothing, 1.45*size(img)[2])
    hidedecorations!(ax)
    hidespines!(ax)
    fig 
end
plotPalette()
#fig = with_theme(plotPalette, theme_minimal())