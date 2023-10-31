using DocumenterVitepress
using Documenter
include("theme_light_dark.jl")
set_theme!(merge(theme_latexfonts(), theme_light_dark()))

ENV["RASTERDATASOURCES_PATH"] = "/Users/lalonso/data/"

makedocs(; sitename="BeautifulMakie",
    authors="Lazaro Alonso",
    clean=true,
    doctest=false,
    strict=[
            #:doctest,
            :linkcheck,
            #:parse_error,
            :example_block,
            # Other available options are
            # :autodocs_block, :cross_references, :docs_block, :eval_block, :example_block,
            # :footnote, :meta_block, :missing_docs, :setup_block
        ], 
        #checkdocs=:all,
        format=DocumenterVitepress.MarkdownVitepress(),
        draft=false,
        source="src",
        build=joinpath(@__DIR__, "docs")
        )
