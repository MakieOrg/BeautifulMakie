# by Lazaro Alonso 
# used like a set that contains beta skeletons in : # hide
# Geometrical and spectral study of β-skeleton graphs # hide
# L. Alonso, J. A. Méndez-Bermúdez, and Ernesto Estrada # hide 
# Phys. Rev. E 100, 062309 – Published 19 December 2019 # hide

using CairoMakie, Random
using GR: delaunay
using Makie.GeometryBasics: Polygon
CairoMakie.activate!() # hide

let
    Random.seed!(123)
    function pointsDelaunay(nodes::Int64)
        points = rand(nodes, 2)
        n, tri = delaunay(points[:,1], points[:,2])
        return (n, tri, points)
    end
    n, tri, points = pointsDelaunay(2000)
    # vector of polygons
    polys = [Polygon([Point2f0(points[tri[k,:],:][i,:]) for i in 1:3]) 
        for k in 1:size(tri)[1]]

    #poly(points, tri, strokewidth = 1) # also works, but just one color    
    poly(polys, color=rand(size(tri)[1]), strokewidth = 0.5, 
        colormap = :linear_worb_100_25_c53_n256, 
        figure = (;resolution=(800,800), fontsize = 22), 
        axis = (;aspect = DataAspect(), title = "Delaunay triangulation"))
    limits!(0,1,0,1)
    current_figure()
    save(joinpath(@__DIR__, "output", "delaunayTriangulation.png"), current_figure(), px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["CairoMakie", "GR", "Makie", "Random"]) # HIDE