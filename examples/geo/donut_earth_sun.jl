using GLMakie,  FileIO
using Downloads: download 
GLMakie.activate!() 

nasa = "https://eoimages.gsfc.nasa.gov/images/imagerecords/"
earth_link = nasa * "73000/73963/gebco_08_rev_bath_3600x1800_color.jpg"
earth = load(download(earth_link))
sun_link = "https://www.solarsystemscope.com/textures/download/2k_sun.jpg"
sun = load(download(sun_link))
n = 1024 ÷ 4 # 2048
U = LinRange(-pi, pi, 2n) 
V = LinRange(-pi, pi, n)
x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
z1 = [.5 * sin(v)                        for u in U, v in V]
x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
y2 = [.5 * sin(v)                        for u in U, v in V]
z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]

with_theme(theme_dark()) do  
    fig, ax, = surface(x1, y1, z1; 
        color = earth'[:,end:-1:1],
        shading = FastShading, 
        ambient = Vec3f(0.85, 0.85, 0.85), 
        backlight = 1.5f0,
        axis=(; 
            type=Axis3, 
            aspect = :data, 
            perspectiveness = 0.5, 
            azimuth = -1.56, 
            elevation = 0.58), 
        figure = (;
        size = (1200,800)))
    surface!(ax, x2, y2, z2; 
        color = sun'[:,end:-1:1],
        shading = FastShading,
        ambient = Vec3f(0.85, 0.85, 0.85), 
        backlight = 1.5f0)
    hidedecorations!(ax; grid=false)
    fig
end