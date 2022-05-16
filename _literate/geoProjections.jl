md"""
## GeoMakie, Projections test
"""
## by Lazaro Alonso
using GLMakie, GeoMakie
GLMakie.activate!()
let
    projections = ["+proj=adams_hemi", "+proj=adams_ws1", "+proj=adams_ws2",
        "+proj=aea +lat_1=29.5 +lat_2=42.5", "+proj=aeqd", "+proj=airy", "+proj=aitoff",
        "+proj=apian", "+proj=august", "+proj=bacon", "+proj=bertin1953", "+proj=bipc +ns",
        "+proj=boggs", "+proj=bonne +lat_1=10", "+proj=cass", "+proj=cea",
        "+proj=chamb +lat_1=10 +lon_1=30 +lon_2=40", "+proj=collg", "+proj=comill",
        "+proj=crast", "+proj=denoy", "+proj=eck1", "+proj=eck2", "+proj=eck3",
        "+proj=eck4", "+proj=eck5", "+proj=eck6", "+proj=eqc", "+proj=eqdc +lat_1=55 +lat_2=60",
        "+proj=eqearth", "+proj=euler +lat_1=67 +lat_2=75", "+proj=fahey", "+proj=fouc", "+proj=fouc_s",
        "+proj=gall", "+proj=geos +h=35785831.0 +lon_0=-60 +sweep=y", "+proj=gins8", "+proj=gn_sinu +m=2 +n=3",
        "+proj=goode", "+proj=guyou", "+proj=hammer", "+proj=hatano",
        "+proj=igh", "+proj=igh_o +lon_0=-160", "+proj=imw_p +lat_1=30 +lat_2=-40", "+proj=isea",
        "+proj=kav5", "+proj=kav7", "+proj=laea", "+proj=lagrng", "+proj=larr", "+proj=lask",
        "+proj=lcca +lat_0=35", "+proj=leac", "+proj=loxim",
        "+proj=lsat +ellps=GRS80 +lat_1=-60 +lat_2=60 +lsat=2 +path=2", "+proj=mbt_s", "+proj=mbt_fps",
        "+proj=mbtfpp", "+proj=mbtfpq", "+proj=mbtfps", "+proj=merc", "+proj=mill", "+proj=misrsom +path=1",
        "+proj=moll", "+proj=murd1 +lat_1=30 +lat_2=50",
        "+proj=murd3 +lat_1=30 +lat_2=50", "+proj=natearth", "+proj=natearth2",
        "+proj=nell", "+proj=nell_h", "+proj=nicol",
        "+proj=ob_tran +o_proj=mill +o_lon_p=40 +o_lat_p=50 +lon_0=60", "+proj=ocea", "+proj=oea +m=1 +n=2",
        "+proj=omerc +lat_1=45 +lat_2=55", "+proj=ortel", "+proj=ortho", "+proj=patterson", "+proj=poly",
        "+proj=putp1", "+proj=putp2", "+proj=putp3", "+proj=putp3p", "+proj=putp4p", "+proj=putp5",
        "+proj=putp5p", "+proj=putp6", "+proj=putp6p", "+proj=qua_aut", "+proj=robin", "+proj=rouss",
        "+proj=rpoly", "+proj=sinu", "+proj=times", "+proj=tissot +lat_1=60 +lat_2=65", "+proj=tmerc",
        "+proj=tobmerc", "+proj=tpeqd +lat_1=60 +lat_2=65", "+proj=urm5 +n=0.9 +alpha=2 +q=4",
        "+proj=urmfps +n=0.5", "+proj=vandg", "+proj=vandg2", "+proj=vandg3", "+proj=vandg4",
        "+proj=vitk1 +lat_1=45 +lat_2=55", "+proj=wag1", "+proj=wag2", "+proj=wag3", "+proj=wag4",
        "+proj=wag5", "+proj=wag6", "+proj=wag7", "+proj=webmerc +datum=WGS84", "+proj=weren",
        "+proj=wink1", "+proj=wink2", "+proj=wintri"]

    fig = Figure(resolution=(1200, 9000))
    k = 2
    for i in 1:39, j in 1:3
        try
            ga = GeoAxis(fig[i, j]; dest=projections[k],
                title=projections[k], coastlines=true)
            hidedecorations!(ga)
        catch ex
        end
        k += 1
    end
    fig
    save(joinpath(@OUTPUT, "geoProjections.png"), fig) # HIDE
end;
# \fig{geoProjections.png}

md"""
#### Dependencies
"""
using Pkg # HIDE
Pkg.status(["GeoMakie", "GLMakie"]) # HIDE