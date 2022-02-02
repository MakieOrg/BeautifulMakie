function Clifford(x, y, a, b, c, d)
    sin(a * y) + c * cos(a * x), sin(b * x) + d * cos(b * y)
end
function De_Jong(x, y, a, b, c, d)
    sin(a * y) - cos(b * x), sin(c * x) - cos(d * y)
end
function Svensson(x, y, a, b, c, d)
    d * sin(a * x) - sin(b * y), c * cos(a * x) + cos(b * y)
end
function Bedhead(x, y, a, b, c, d)
    sin(x * y / b) * y + cos(a * x - y), x + sin(y) / b
end

function Fractal_Dream(x, y, a, b, c, d)
    sin(y * b) + c * sin(x * b), sin(x * a) + d * sin(y * a)
end
function trajectory(fn, x0, y0, a, b, c, d; n = 1000)
    x, y = zeros(n), zeros(n)
    x[1], y[1] = x0, y0
    for i = 1:n
        @inbounds x[i+1], y[i+1] = fn(x[i], y[i], a, b, c, d)
    end
    x, y
end