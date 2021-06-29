using GLMakie, DifferentialEquations, ParameterizedFunctions
GLMakie.activate!()
let
  g = @ode_def begin
    dx = σ*(y - x)
    dy = x*(ρ - z) - y
    dz = x*y - β*z
  end σ ρ β
  u0 = [1.0; 0.0; 0.0]
  tspan = (0.0, 80.0)
  p = [10.0,28.0,8/3]
  prob = ODEProblem(g, u0, tspan, p)
  sol = solve(prob, Tsit5(), saveat = 0.005)
  x, y, z = sol[1,:], sol[2,:], sol[3,:]
  tempo = sol.t
  fig = Figure(resolution=(1000,600), fontsize = 20)
  ax = Axis3(fig, aspect = (1,1,0.5), azimuth = -0.3π, elevation = π/9)
  pltobj = lines!(ax, x,y,z, color = tempo, overdraw = false)
  cbar = Colorbar(fig, pltobj, label = "time", width = 15, ticksize=15,
                  tickalign = 1, height = Relative(0.5))
  fig[1,1] = ax
  fig[1,2] = cbar
  fig
  save(joinpath(@__DIR__, "output", "lorenzAttractor.png"), fig, px_per_unit = 2.0) # HIDE
end
using Pkg # HIDE
Pkg.status(["GLMakie", "DifferentialEquations", "ParameterizedFunctions"]) # HIDE
