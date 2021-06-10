# BeautifulMakie
Gallery with easy to copy and paste examples, go to

https://lazarusa.github.io/BeautifulMakie/

Contributions are welcome as pull requests. Scripts with the following structure are encouraged.
```
# author # HIDE
using Pkg # HIDE
Pkg.activate(@__DIR__) # HIDE # this should be your new folder named `filename`
Pkg.add(["Makie","CairoMakie"]) # HIDE # and the packages that you might need.
using CairoMakie
CairoMakie.activate!() # HIDE
# HIDE # please also create a new folder inside called `output`
let
  ...your code ...
  save(joinpath(@__DIR__, "output", "filename.png"), figure)
end

Pkg.status() # HIDE
Pkg.activate() # HIDE
```
Now, test that your env and script works as expected running `generate_result.jl`
which contains the function `genplain` where you need modified the call to the
function `genplain` as `genplain("filename.jl")`. This file also lives in
your folder `filename`.

Now do a pull request with your folder into the repo in `/_assets/scripts/`.

Things should look like in here
https://github.com/lazarusA/BeautifulMakie/tree/main/_assets/scripts/penguinsDataSetWithChain

You can create the script `generate_result.jl` with the following lines.
```
dir = @__DIR__

"""
    genplain(s)

Small helper function to run some code and redirect the output (stdout) to a file.
"""
function genplain(s::String)
    open(joinpath(dir, "output", "$(splitext(s)[1]).out"), "w") do outf
        redirect_stdout(outf) do
            include(joinpath(dir, s))
        end
    end
end

genplain("filename.jl")
```
