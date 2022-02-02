
md"""
## Polygons: Delaunay Triangulation
"""
## by Lazaro Alonso
## used like a set that contains beta skeletons in : # hide
## Geometrical and spectral study of β-skeleton graphs # hide
## L. Alonso, J. A. Méndez-Bermúdez, and Ernesto Estrada # hide 
## Phys. Rev. E 100, 062309 – Published 19 December 2019 # hide

using CairoMakie, Random, ColorSchemes
using GR: delaunay
using Makie.GeometryBasics: Polygon
CairoMakie.activate!() # hide

let
    Random.seed!(123)
    function pointsDelaunay(nodes::Int64)
        points = rand(nodes, 2)
        n, tri = delaunay(points[:, 1], points[:, 2])
        return (n, tri, points)
    end
    n, tri, points = pointsDelaunay(1200)
    ## vector of polygons
    polys = [Polygon([Point2f(points[tri[k, :], :][i, :]) for i in 1:3])
             for k in 1:size(tri)[1]]
    ## poly(points, tri, strokewidth = 1) # also works, but just one color
    set_theme!(theme_light())
    poly(polys, color = rand(size(tri)[1]), strokewidth = 0.5, colormap = :Hiroshige,
        figure = (; resolution = (800, 800), fontsize = 22),
        axis = (; aspect = DataAspect(), title = "Delaunay triangulation"))
    ## display(current_figure())
    save(joinpath(@OUTPUT, "delaunayTriangulation.svg"), current_figure()) # HIDE
    set_theme!()
end;
# \fig{delaunayTriangulation.svg}

using Pkg # HIDE
md"""
#### Dependencies
"""
Pkg.status(["CairoMakie", "GR", "Makie", "Random"]) # HIDE