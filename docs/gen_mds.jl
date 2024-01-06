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
                "density_ridges.jl",
                "penguins.jl",
                "penguins3d.jl",
                "penguinsAoG.jl",
                "penguinsBoxes.jl",
                "penguinsViolins.jl",
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