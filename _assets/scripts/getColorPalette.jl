# by Lazaro Alonso
# original post 
# https://nextjournal.com/lazarus/extracting-dominant-colours-from-pictures
using CairoMakie, Clustering, Colors, Random
using Images: load, RGB, channelview, permutedims
using Downloads: download
CairoMakie.activate!()
#let 
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
    #https://commons.wikimedia.org/wiki/Category:Ceyx_erithaca?uselang=de
    #url = "https://upload.wikimedia.org/wikipedia/commons/b/b8/Oriental_dwarf_kingfisher.jpg"
    url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Oriental_dwarf_kingfisher_a_Jewel_of_India%27s_Rainforests_07.jpg/1280px-Oriental_dwarf_kingfisher_a_Jewel_of_India%27s_Rainforests_07.jpg?uselang=de"
    #path = "/path/file/file.jpg"
    img = getImg(; url = url) # ;url= url, file = file
    #img = img[150:end-40,250:end-40]
    #img = img[550:end-560,1200:end-1400]
    img = img[150:end-100,300:end-350]
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
        xlims!(nothing, 1.45*size(img)[2])
        hidedecorations!(ax)
        hidespines!(ax)
        fig 
    end
    fig = plotPalette()
    # fig = with_theme(plotPalette, theme_black())
    save(joinpath(@__DIR__, "output", "getColorPalette.png"), fig, px_per_unit = 2.0) # HIDE
#end
# output image under License 
# CC BY-SA 4.0
# https://creativecommons.org/licenses/by-sa/4.0/
# due to:
# https://commons.wikimedia.org/wiki/Category:Ceyx_erithaca?uselang=de#/media/File:Oriental_dwarf_kingfisher_a_Jewel_of_India's_Rainforests_07.jpg
