# ## Isosurfaces

# ![](isosurfaces.png)

# by Ashton Bradley

using GLMakie
using Meshing, GeometryBasics
GLMakie.activate!()

function show_isosurface(f,h,ξ; color=(:dodgerblue,0.5), isoval=100)
  algo = MarchingCubes(; iso=isoval)

  s = [h(x,y,z) for x in ξ, y in ξ, z in ξ] .+ isoval
  # generate the mesh using marching cubes
  vts, fcs = isosurface(s, algo)
  # mc = GeometryBasics.Mesh(s, algo)
  return mesh(f, vts, map(v -> GeometryBasics.TriangleFace(v...), fcs); color,
      diffuse = Vec3f0(0.8),
      specular = Vec3f0(1.1),
      shininess = 30f0,
      backlight = 5f0,
      transparency=true,
      axis = (; show_axis = false)
      )
end

# ### Torus 

# isosurfaces for h(x,y,z)=0

torus(x,y,z; c=20, a=15) = ((hypot(x,y)-c)^2+z^2-a^2)

with_theme(theme_dark()) do
  ξ = -40:0.5:40

  f = Figure(size=(900, 900))
  show_isosurface(f[1,1], torus, ξ; color = (:orangered, 0.5))
  f
end

# ### Entzensberger star

estar(x,y,z) = 100*(x^2*y^2 + y^2*z^2 + x^2*z^2) - (1 - x^2 - y^2 - z^2)^3

with_theme(theme_dark()) do
  Xm = 1
  ξ = -Xm:0.01:Xm

  f = Figure(size=(900, 900))
  show_isosurface(f[1,1], estar, ξ);
  f
end

# ### Tetrahedron

tetra(x,y,z) = x^4 + 2*x^2*y^2 + 2*x^2*z^2 + y^4 + 2*y^2*z^2 + z^4 + 8*x*y*z - 10*x^2 - 10*y^2 - 10*z^2 + 20

with_theme(theme_dark()) do
  Xm = 10
  ξ = -Xm:0.05:Xm

  f = Figure(size=(900, 900))
  show_isosurface(f[1,1], tetra, ξ; color = (:gold, 0.35));
  f
end

# ### Decocube

deco(x,y,z; b=1,c=2.2,t=1.2) = ((x^2 + y^2 - c^2)^2 + (z - 1)^2*(z + 1)^2)*((y^2 + z^2 - c^2)^2 +
(x - 1)^2*(x + 1)^2)*((z^2 + x^2 - c^2)^2 + (y - 1)^2*(y + 1)^2) -
t*(1 + b*(x^2 + y^2 + z^2))

with_theme(theme_dark()) do
  Xm = 2.5
  ξ = -Xm:0.025:Xm

  f = Figure(size=(900, 900))
  show_isosurface(f[1,1], deco, ξ; color = (:silver, 0.65));
  f
end

# All together

with_theme(theme_dark()) do
  Xm = [1, 10, 2.5]

  ξ1 = -40:0.5:40  
  ξ2 = -Xm[1]:0.01:Xm[1]
  ξ3 = -Xm[2]:0.05:Xm[2]
  ξ4 = -Xm[3]:0.025:Xm[3]

  f = Figure(size=(600, 600))
  show_isosurface(f[1,1], torus, ξ1; color = (:orangered, 0.5))
  show_isosurface(f[1,2], estar, ξ2);
  show_isosurface(f[2,1], tetra, ξ3; color = (:gold, 0.35));
  show_isosurface(f[2,2], deco, ξ4; color = (:silver, 0.65));
  f
  save("isosurfaces.png", f)
end
