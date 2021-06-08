# Parent file to run all scripts which may generate
# some output that you want to display on the website.
# this can be used as a tester to check that all the code
# on your website runs properly.

dir = @__DIR__

"""
    genplain(s)

Small helper function to run some code and redirect the output (stdout) to a file.
"""
function genplain(s::String)
    open(joinpath(dir, "scripts/output", "$(splitext(s)[1]).out"), "w") do outf
        redirect_stdout(outf) do
            include(joinpath(dir, "scripts", s))
        end
    end
end

#genplain("ContourOverHeatmap.jl")
genplain("surfWireContour.jl")
#genplain("Fig2Lines.jl")
#genplain("irisDataSet.jl")
#genplain("revolutionSurf.jl")
#genplain("revolutionSurf2.jl")
#genplain("KleinBottle.jl")
#genplain("wireTori.jl")
#genplain("wireSurfToris.jl")
#genplain("tesseralSphericalH.jl")
#genplain("RGBcube.jl")
#genplain("line3D.jl")
#genplain("surface1Color.jl")
#genplain("surfaceComplexF.jl")
#genplain("contourQubit.jl")
genplain("BlueMarbel.jl")
genplain("moon.jl")
#genplain("landSea.jl")
#genplain("temPrecESDL.jl")
#genplain("contour1.jl")
#genplain("ContourComplexF.jl")
#genplain("complexPolyaField.jl")
#genplain("themeBlack.jl")

#genplain("topoLinesFuji.jl")

#genplain("gppBeer2010.jl")
#genplain("topography.jl")
#genplain("topographySphere.jl")
# output
#using Glob
#files = glob("./scripts/*.jl")
#for f in files #[30:end]
#    println("Generating output for "*f)
#    genplain(dir*f[2:end])
#end
