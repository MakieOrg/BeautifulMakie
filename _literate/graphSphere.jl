using LinearAlgebra: ⋅, norm, ×
using HTTP, CSV, DataFrames

"""
    gcinterp(p1, p2, dθ)

Compute list of points on a great circle interpolation assuming a spherical earth model.

### Input Arguments

- `p1`, `p2`:  Iterables of length 2 containing the longitude λ and lattitude L 
               in degrees of the initial and terminal points of the desired arc.

- `dθ`: The desired angular increment in degrees for point spacing along 
        the interpolated great circle arc.

### Return Value
A vector of ordered pairs `(λᵢ, Lᵢ)` (longitudes and lattitudes in degrees) of
points on the great circle path joining `p1` and `p2`.  The arc length spacing of the
points will be equal to or slightly less than `dθ`.
"""
function gcinterp(p1, p2, dθ)
    λ₁, L₁  = float.(p1[1:2])
    λ₂, L₂  = float.(p2[1:2])
    rg1 = ll2rect(λ₁, L₁)
    rg2 = ll2rect(λ₂, L₂)
    ct0 = rg1 ⋅ rg2
    st0 = norm(rg1 × rg2)
    rg1 /= st0
    rg2 /= st0
    θ0 = atand(st0,ct0) # great circle arc length
    n = 1+ceil(Int, θ0/dθ)
    points = [(λ₁,L₁) for _ in 1:n]
    for (i,θ) in enumerate(range(0, θ0, length=n))
        rvec = rg1 * sind(θ0-θ) + rg2 * sind(θ)
        points[i] = rect2ll(rvec)
    end
    points[1] = p1[1], p1[2] # Eliminate rounding errors
    points[n] = p2[1], p2[2]
    points
end

"""
    ll2rect(λ, L)

Convert longitude `λ` and lattitude `L` (both in degreees) to a 3-vector of rectangular coordinates.
"""
function ll2rect(λ, L)
    sinλ, cosλ = sincosd(λ)
    sinL, cosL = sincosd(L)
    [cosL * cosλ, cosL * sinλ, sinL]
end

"""
    rect2ll(rvec)

Convert rectangular coordinates (a 3-vector of unit length) to a (longitude,lattitude) tuple.
Angular units on output are degrees.
"""
function rect2ll(rvec)
    λ = atand(rvec[2], rvec[1])
    L = asind(rvec[3])
    (λ, L)
end

url = "https://raw.githubusercontent.com/alstat/Julia-Data-Query/master/data-raw/flights.csv"
flights = CSV.read(data, DataFrame)
flights[!,:airports]