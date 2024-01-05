using Literate
using Pkg

get_example_path(p) = joinpath(@__DIR__,"..", "examples", p)
OUTPUT = joinpath(@__DIR__, "src", "examples")

folders = readdir(joinpath(@__DIR__, "..", "examples"))
setdiff!(folders, [".DS_Store"])
setdiff!(folders, ["rpr"])

function get_files(folders)
    srcsfiles = []
    for f in folders
        p = joinpath(@__DIR__,"..", "examples", f)
        if isdir(p)
            names = readdir(p)
            setdiff!(names, [".DS_Store",
                "world_energy.jl",
                "gapminder.jl", 
                "gott_azimuthal.jl",
                "submarine_cables.jl",
                ])
                
            fpaths  = "$(f)/" .* names
            srcsfiles = vcat(srcsfiles, fpaths...)
        else
            srcsfiles = vcat(srcsfiles, f)
        end
    end
    return srcsfiles
end

src_folders = get_files(folders)
srcsfiles = get_files(src_folders)

for p in srcsfiles
    Literate.markdown(get_example_path(p), joinpath(OUTPUT, dirname(p));
        documenter=true, credit=false)
end

# using Pkg

# ENV["MODERNGL_DEBUGGING"] = "true"; Pkg.build("ModernGL")
# using Literate, ProgressMeter
# using GLMakie 
# if !GLMakie.ModernGL.enable_opengl_debugging
#     # can't error, since we can't enable debugging for users
#     @warn("TESTING WITHOUT OPENGL DEBUGGING")
# end
# get_example_path(p) = joinpath(@__DIR__, "examples", p)
# OUTPUT = joinpath(@__DIR__, "src", "examples", "generated")

# folders = readdir(joinpath(@__DIR__, "examples"))
# setdiff!(folders, [".DS_Store"])
# #setdiff!(folders, ["bars"])
# setdiff!(folders, ["cheat_sheets", "aog"])

# #folders = ["aog"]

# function get_files()
#     srcsfiles = []
#     for f in folders
#         names = readdir(joinpath(@__DIR__, "examples", f))
#         setdiff!(names, [".DS_Store", "density_ridges.jl",
#             "world_energy.jl", "gapminder.jl", 
#             "vertical_feature_mask.jl",
#             "submarine_cables.jl",
#             "timeseries_proj.jl",
#             "boxplots_collection.jl",
#             "collection_violins.jl",
#             "earthquakes_proj.jl",
#             "rasters.jl",
#             "makie_contributors.jl"])
            
#         fpaths  = "$(f)/" .* names
#         srcsfiles = vcat(srcsfiles, fpaths...)
#     end
#     return srcsfiles
# end

# srcsfiles = get_files()

# mkdir("test-record")
# cd("test-record")
# using Makie
# @showprogress for p in srcsfiles
#     path = joinpath(@__DIR__, "examples", p)
#     println(p)
#     fig = Base.evalfile(path)
#     fig = Makie.current_figure()
#     name = splitext(basename(p))[1]
#     save(name * ".png", fig)
# end