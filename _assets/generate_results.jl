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

# output
using Glob
files = glob("./scripts/*.jl")
for f in files #[30:end]
    println("Generating output for "*f[11:end])
    genplain(f[11:end])
end
