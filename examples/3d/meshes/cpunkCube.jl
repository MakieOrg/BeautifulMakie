using GLMakie, FileIO
using GeometryBasics
using Downloads
import Cascadia: Selector
import Gumbo: parsehtml
import HTTP
GLMakie.activate!()
GLMakie.closeall() # close any open screen

# ## Download images from twitter
lucy = Downloads.download("https://pbs.twimg.com/media/FbbZqWTXkAA8KTo?format=jpg&name=large")
lucy = load(lucy)
lucy = lucy[1:1000,1:1000]

david = Downloads.download("https://pbs.twimg.com/media/FdGmKklXEAAkdG1?format=jpg&name=large")
david = load(david)
david = david[1:1000,1:1000]

faraday = Downloads.download("https://pbs.twimg.com/media/Fdq1ev-X0AM-tXv?format=jpg&name=large")
faraday = load(faraday)
faraday = faraday[1:1000,1:1000]

lucydavid = Downloads.download("https://pbs.twimg.com/media/FdAs55qXoAAyG9l?format=jpg&name=large")
lucydavid = load(lucydavid)

luda = Downloads.download("https://pbs.twimg.com/media/Fcs-pGSX0AIdzWs?format=jpg&name=large") 
luda = load(luda)
luda = luda[201-40:1240,end:-1:1]

poster = Downloads.download("https://pbs.twimg.com/media/FZFjXDAWIAE-vAT?format=jpg&name=large")
poster = load(poster)
poster = poster[1+80:1080+80,end:-1:1]

# ## Set images into the right (your) order
imgs = [rotr90(lucydavid), lucy, rotl90(david), 
    rotr90(faraday), rotr90(rotr90(poster)), rotr90(rotr90(luda))]

fig = Figure(figure_padding=0, size =(600*4,400*4))
axs = [Axis(fig[i,j], aspect=1) for i in 1:2 for j in 1:3]
[heatmap!(axs[i], imgs[i]) for i in 1:6]
hidedecorations!.(axs)
hidespines!.(axs)
colgap!(fig.layout,0)
rowgap!(fig.layout,0)
imgcpunk = Makie.colorbuffer(fig)

# ## Do the meshed cube
function meshcube(o=Vec3f(0), sizexyz = Vec3f(1))
    uvs = map(v -> v ./ (3, 2), Vec2f[
    (0, 0), (0, 1), (1, 1), (1, 0),
    (1, 0), (1, 1), (2, 1), (2, 0),
    (2, 0), (2, 1), (3, 1), (3, 0),
    (0, 1), (0, 2), (1, 2), (1, 1),
    (1, 1), (1, 2), (2, 2), (2, 1),
    (2, 1), (2, 2), (3, 2), (3, 1),
    ])
    m = normal_mesh(Rect3f(Vec3f(-0.5) .+ o, sizexyz))
    m = GeometryBasics.Mesh(meta(coordinates(m);
        uv = uvs, normals = normals(m)), faces(m))
end

m = meshcube();
# ## Get stats
function getstats()
    r = HTTP.get("https://myanimelist.net/anime/42310/Cyberpunk__Edgerunners/stats")
    h = parsehtml(String(r.body))
    helm_table = eachmatch(Selector(".score-stats"), h.root)

    htxt = helm_table[1].children[1]
    rating = Float32[]
    votes = Float32[]
    for child in htxt.children
        ele = eachmatch(Selector("td"), child)
        echild = ele[1].children
        push!(rating, parse(Float32, echild[1].text))
        ediv = ele[2].children[1]
        push!(votes, parse(Float32, split(ediv.children[2][2][1].text)[1][2:end]))
        #parse(Float32, strip(split(ediv.children[2][1].text, "%")[1]))
    end
    return (rating, votes)
end

# ## Plot all together

cmap_cpunk = ["#5479B8", "#CD38D1", "#8295A6", "#9EA4A4","#03B0F5",
    "#2BDB52", "#BACBCF", "#F1F016", "#EEF9E4", "#FAF4FD"]

rating, votes = getstats()
percent = round.(votes/sum(votes)*100, digits=1)

with_theme(theme_black()) do
    fig = Figure(size= (1200,700), fontsize = 24)
    ax1 = LScene(fig[1,1], show_axis=false)
    ax2 = Axis(fig[1,2]; xlabel = "Rating score")
    mesh!(ax1, m; color = imgcpunk, interpolate=false)
    barplot!(ax2, rating, votes; color =reverse(cmap_cpunk))
    text!(ax2, string.(percent).*"%", position = Point2f.(rating, votes),
        align = (:center, :bottom))
    text!(ax2, "Total votes: $(sum(votes))", color=cmap_cpunk[8],
        position = (1, 3maximum(votes)/4), fontsize= 28)
    hideydecorations!(ax2; grid=false)
    hidespines!(ax2, :l, :t, :r)
    ax2.xticks = 1:10
    Label(fig[2,1], "Source: https://www.cyberpunk.net/en/edgerunners\nImages: https://twitter.com/edgerunners", 
        fontsize = 14, tellwidth=false, halign=:left, color = cmap_cpunk[9])
    Label(fig[2,2], "Stats: https://myanimelist.net/anime/42310/Cyberpunk__Edgerunners/stats", 
        fontsize = 14, tellwidth=false, halign=:right, color = cmap_cpunk[9])
    colgap!(fig.layout,1)
    fig
end
