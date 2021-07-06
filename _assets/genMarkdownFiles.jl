dir = @__DIR__

function genMarkdownFiles(scriptName::String)
    open(joinpath(dir, "$(splitext(scriptName)[1]).md"), "w") do outf
        redirect_stdout(outf) do
            toFile = """ 
            @def title = "$(scriptName)" 
            @def hascode = true 
            @def tags = ["syntax", "code"] 
            ## $(scriptName) 
            \\fig{/_assets/scripts/output/$(scriptName).png} 
            \\input{julia}{/_assets/scripts/output/$(scriptName).jl}
            ~~~
            <span style="color:#e53e00;"> <strong> Dependencies $(scriptName) </strong> </span>
            ~~~
            \\prettyshow{/_assets/scripts/$(scriptName)}
            """
            print(toFile)
        end
    end
end
genMarkdownFiles("testmdgen")