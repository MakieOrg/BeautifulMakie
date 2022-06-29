using CairoMakie
CairoMakie.activate!()

function Clifford(x::Float64, y::Float64, a::Float64, b::Float64, c::Float64, d::Float64)
    sin(a * y) + c * cos(a * x), sin(b * x) + d * cos(b * y)
end
function De_Jong(x::Float64, y::Float64, a::Float64, b::Float64, c::Float64, d::Float64)
    sin(a * y) - cos(b * x),sin(c * x) - cos(d * y)
end
function Svensson(x::Float64, y::Float64, a::Float64, b::Float64, c::Float64, d::Float64)
    d * sin(a * x) - sin(b * y), c * cos(a * x) + cos(b * y)
end
function Bedhead(x::Float64, y::Float64, a::Float64, b::Float64, c::Float64, d::Float64)
    sin(x*y/b)*y + cos(a*x-y), x + sin(y)/b
end
function Fractal_Dream(x::Float64, y::Float64, a::Float64, b::Float64, c::Float64, d::Float64)
    sin(y*b)+c*sin(x*b), sin(x*a) + d*sin(y*a)
end
function trajectory(fn, x0::Float64, y0::Float64, a::Float64, b::Float64, c::Float64, d::Float64, 
        dθ::Float64,  n::Int64)
    x, y, θ = zeros(n), zeros(n), 0.0
    x[1], y[1] = x0, y0
    for i = 1:n
        xd, yd = fn(x[i], y[i], a, b, c, d)
        @inbounds x[i+1], y[i+1] = xd*cos(θ), yd*cos(θ)
        θ += dθ
    end
    x, y
end
δθ = 0.001
n = 10000000
params = [-1.32, -1.65, 0.74, 1.81]
x, y = trajectory(Clifford, 0.1, 0.1, params..., δθ, n)
#scatter(x,y, markersize = 0.5, axis = (;aspect = DataAspect()))
using GR

setviewport(0.1, 0.95, 0.1, 0.95)
setwindow(-2, 2, -3, 3)
setcharheight(0.02)
#axes2d(0.5, 0.5, -2, 2, -2, 2, -0.005)
setcolormap(GR.COLORMAP_HOT)

img = shadepoints(x, y; dims = (1200, 1200), xform= 5)

updatews()