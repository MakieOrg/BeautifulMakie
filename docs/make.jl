using DocumenterVitepress # ] add https://github.com/LuxDL/DocumenterVitepress.jl.git
using Documenter
include("theme_light_dark.jl")
set_theme!(merge(theme_latexfonts(), theme_light_dark()))

# ENV["RASTERDATASOURCES_PATH"] = "/Users/lalonso/data/"

makedocs(; sitename="BeautifulMakie", authors="Lazaro Alonso",
    clean=true,
    checkdocs=:all,
    format=DocumenterVitepress.MarkdownVitepress(),
    draft=false,
    source="src", build=joinpath(@__DIR__, "docs_site/")
    )