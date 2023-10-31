using Literate

get_example_path(p) = joinpath(@__DIR__, "examples", p)
OUTPUT = joinpath(@__DIR__, "src", "examples", "generated")

folders = readdir(joinpath(@__DIR__, "examples"))
setdiff!(folders, [".DS_Store"])
#setdiff!(folders, ["bars"])
setdiff!(folders, ["cheat_sheets"])

#folders = ["lines","scatters"]

function get_files()
    srcsfiles = []
    for f in folders
        names = readdir(joinpath(@__DIR__, "examples", f))
        setdiff!(names, [".DS_Store", "density_ridges.jl",
            "world_energy.jl", "gapminder.jl", 
            "vertical_feature_mask.jl",
            "submarine_cables.jl",
            "timeseries_proj.jl",
            "boxplots_collection.jl",
            "collection_violins.jl",
            "makie_contributors.jl"])
            
        fpaths  = "$(f)/" .* names
        srcsfiles = vcat(srcsfiles, fpaths...)
    end
    return srcsfiles
end

srcsfiles = get_files()

for p in srcsfiles
    Literate.markdown(get_example_path(p), joinpath(OUTPUT, dirname(p));
        documenter=true, credit=false)
end