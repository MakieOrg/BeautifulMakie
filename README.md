# BeautifulMakie
Gallery with easy to copy and paste examples, go to

https://lazarusa.github.io/BeautifulMakie/

Contributions are welcome as pull requests. Scripts with the following structure are encouraged.
```
# author # HIDE
using CairoMakie
CairoMakie.activate!() # HIDE
let
  ...your code ...
  save(joinpath(@__DIR__, "output", "filename.png"), figure)
end

using Pkg # HIDE
Pkg.status(["CairoMakie"]) # HIDE
```
