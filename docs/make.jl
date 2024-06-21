using DocumenterVitepress
using Documenter
include("theme_light_dark.jl")
set_theme!(merge(theme_latexfonts(), theme_light_dark()))

# ENV["RASTERDATASOURCES_PATH"] = "/Users/lalonso/data/"
# ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

makedocs(; sitename="BeautifulMakie", authors="Lazaro Alonso",
    clean=true,
    checkdocs=:all,
    format=DocumenterVitepress.MarkdownVitepress(;
        repo = "github.com/MakieOrg/BeautifulMakie"),
        draft = false,
        source = "src",
        build = "build",
    )

deploydocs(; 
    repo = "github.com/MakieOrg/BeautifulMakie", # this must be the full URL!
    target = "build", # this is where Vitepress stores its output
    branch = "gh-pages",
    devbranch = "main",
    push_preview = true
)