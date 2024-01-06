# Beautiful Makie 

[beautiful.makie.org](https://beautiful.makie.org)

Web page with basic examples showing how to use makie in julia.

Some guidance on how to dev this locally:

```shell
npm install -D vitest
```
or 
```shell
npm i
```
if a package*.json file is provided. Also you will need vitepress

```shell
npm add -D vitepress
```

## Generating files
> For this you should have [julia](https://julialang.org/downloads/) installed in your computer.

Then `cd` into the `docs` folder and `activate` and `instantiate` the `env` there:

```julia
julia>]
```
```julia
pkg> activate .
```
```julia
pkg> instantiate
```
then do

```julia
julia> include("gen_mds.jl")
```
and 
```julia
julia> include("make.jl")
```
these step will generate all files needed in order to build the site, you could serve/build/preview it by doing

```shell
BeautifualMakie $ npm run docs:dev
```

```shell
BeautifualMakie $ npm run docs:build
```
and

```shell
BeautifualMakie $ npm run docs:preview
```
