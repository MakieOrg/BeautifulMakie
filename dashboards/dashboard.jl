using WGLMakie, JSServe
WGLMakie.activate!()
open("dashboard.html", "w") do io
    println(io, """
        <div>
    """)
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), scatter(1:4))
    show(io, MIME"text/html"(), surface(rand(4, 4)))
    # or anything else from JSServe, or that can be displayed as html:
    show(io, MIME"text/html"(), JSServe.Slider(1:3))
    println(io, """
        </div>
    """)
end
