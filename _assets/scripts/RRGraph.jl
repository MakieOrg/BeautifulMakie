# by Lazaro Alonso
# port of the original code used in:
# L Alonso, et. al. Weighted random-geometric and random-rectangular graphs: spectral 
# and eigenfunction properties of the adjacency matrix, Journal of Complex Networks, Volume 6, Issue 5,
# October 2018, Pages 753–766, https://doi.org/10.1093/comnet/cnx053

# using CairoMakie # HIDE
using LinearAlgebra, Random, CairoMakie
CairoMakie.activate!()
function RRGAdjacencyM(;lengthBase = 1, radius = 0.1, nodes = 500, rseed = 123)
    Random.seed!(rseed)
    xy = rand(nodes, 2)
    x = lengthBase .* xy[:,1]
    y = xy[:,2] ./ lengthBase
    matrixAdjDiag = Diagonal(√2 * randn(nodes))
    matrixAdj = zeros(nodes, nodes)
    for point in 1:nodes-1
        distance = sqrt.((x[point + 1:end] .- x[point]).^2 .+ (y[point + 1:end] .- y[point]).^2)
        dindx = findall(distance .<= radius) .+ point
        if length(dindx) > 0
            rnd = randn(length(dindx))
            matrixAdj[point, dindx] = rnd
            matrixAdj[dindx, point] = rnd
        end
    end
    return (matrixAdj .+ matrixAdjDiag, x, y)
end
adjacencyM, x, y = RRGAdjacencyM()

function getGraphEdges(adjMatrix, x, y)
    xyos = []
    weights = [] 
    for i in 1:length(x), j in i+1:length(x)
        if adjMatrix[i,j] != 0.0
            push!(xyos, [x[i], y[i]])
            push!(xyos, [x[j], y[j]])
            push!(weights, adjMatrix[i,j])
            push!(weights, adjMatrix[i,j])
        end
    end
    return (Point2f0.(xyos), Float32.(weights))
end

function plotGraph(adjacencyM, x, y)
    cmap = (:Spectral_11, 0.75)
    adjmin = minimum(adjacencyM)
    adjmax = maximum(adjacencyM)
    diagValues = diag(adjacencyM)
    segm, weights = getGraphEdges(adjacencyM, x, y)
    
    fig, ax, pltobj = linesegments(segm, color = weights, colormap = cmap, 
        linewidth = abs.(weights)/2, colorrange = (adjmin, adjmax), 
        figure = (;resolution = (500,400)), axis = (;aspect = DataAspect()))
    scatter!(ax, x, y, color = diagValues, markersize = 3*abs.(diagValues),
        colormap = cmap)
    limits!(ax, -0.02,1.02,-0.02,1.02)
    Colorbar(fig[1,2], pltobj, label = "weights")
    fig
end
#plotGraph(adjacencyM, x, y)
rrgraph = with_theme(theme_black()) do
    plotGraph(adjacencyM, x, y)
end
save(joinpath(@__DIR__, "output", "RRGraph.png"), rrgraph, px_per_unit = 2.0) # HIDE
using Pkg # HIDE
Pkg.status(["CairoMakie", "LinearAlgebra", "Random"]) # HIDE