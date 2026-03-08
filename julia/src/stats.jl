#= Statistics utilities for problem generation scripts =#

# ---------------------------------------------------------------------------
# Descriptive statistics
# ---------------------------------------------------------------------------

"""Mean of a numeric vector."""
stat_mean(data) = sum(data) / length(data)

"""Median of a numeric vector."""
function stat_median(data)
    s = sort(collect(data))
    n = length(s)
    if isodd(n)
        return s[(n + 1) ÷ 2]
    else
        mid = s[n ÷ 2] + s[n ÷ 2 + 1]
        return isinteger(mid / 2) ? Int(mid ÷ 2) : mid / 2
    end
end

"""Mode of a numeric vector (returns most frequent value; error if no unique mode)."""
function stat_mode(data)
    counts = Dict{Any,Int}()
    for v in data
        counts[v] = get(counts, v, 0) + 1
    end
    max_count = maximum(values(counts))
    modes = [k for (k, c) in counts if c == max_count]
    length(modes) == 1 || error("No unique mode — $(length(modes)) values tied")
    return modes[1]
end

"""Population variance."""
function stat_variance(data; population::Bool=true)
    m = stat_mean(data)
    ss = sum((x - m)^2 for x in data)
    return ss / (population ? length(data) : length(data) - 1)
end

"""Population standard deviation."""
stat_stdev(data; population::Bool=true) = sqrt(Float64(stat_variance(data; population)))

"""Quartiles Q1, Q2 (median), Q3."""
function stat_quartiles(data)
    s = sort(collect(data))
    n = length(s)
    q2 = stat_median(s)
    mid = n ÷ 2
    lower = isodd(n) ? s[1:mid] : s[1:mid]
    upper = isodd(n) ? s[mid+2:end] : s[mid+1:end]
    q1 = stat_median(lower)
    q3 = stat_median(upper)
    return (Q1=q1, Q2=q2, Q3=q3)
end

"""Interquartile range."""
function stat_iqr(data)
    q = stat_quartiles(data)
    return q.Q3 - q.Q1
end

"""Five-number summary: min, Q1, median, Q3, max."""
function stat_five_number(data)
    s = sort(collect(data))
    q = stat_quartiles(s)
    return (min=s[1], Q1=q.Q1, median=q.Q2, Q3=q.Q3, max=s[end])
end

"""Range of data."""
stat_range(data) = maximum(data) - minimum(data)

# ---------------------------------------------------------------------------
# Dataset generators
# ---------------------------------------------------------------------------

"""
Generate a dataset with a clean integer mean.
Reverse-engineers: picks (n-1) values, sets last value to force desired mean.
"""
function rand_dataset(; n::Int=8, mean_range::Tuple{Int,Int}=(10, 50), spread::Int=15)
    target_mean = randint(mean_range...)
    vals = [target_mean + randint(-spread, spread) for _ in 1:n-1]
    last_val = n * target_mean - sum(vals)
    push!(vals, last_val)
    shuffle!(vals)
    return vals
end

"""
Generate a dataset with a guaranteed unique mode.
"""
function rand_dataset_with_mode(; n::Int=10, value_range::Tuple{Int,Int}=(1, 20))
    mode_val = randint(value_range...)
    mode_count = max(3, n ÷ 3)
    vals = fill(mode_val, mode_count)
    remaining = n - mode_count
    others = Int[]
    for _ in 1:remaining
        v = randint(value_range...)
        while v == mode_val
            v = randint(value_range...)
        end
        push!(others, v)
    end
    # Ensure no other value appears mode_count or more times
    counts = Dict{Int,Int}()
    for v in others
        counts[v] = get(counts, v, 0) + 1
    end
    for (v, c) in counts
        while c >= mode_count
            idx = findfirst(==(v), others)
            others[idx] = randint(value_range...)
            while others[idx] == mode_val || others[idx] == v
                others[idx] = randint(value_range...)
            end
            c -= 1
        end
    end
    append!(vals, others)
    shuffle!(vals)
    return vals
end

# ---------------------------------------------------------------------------
# Combinatorics
# ---------------------------------------------------------------------------

"""Factorial."""
fact(n::Int) = factorial(n)

"""Combinations C(n, k)."""
comb(n::Int, k::Int) = binomial(n, k)

"""Permutations P(n, k) = n! / (n-k)!."""
perm(n::Int, k::Int) = factorial(n) ÷ factorial(n - k)

# ---------------------------------------------------------------------------
# Probability formatting
# ---------------------------------------------------------------------------

"""Format probability as a fraction string: num/den."""
fmt_prob(num, den) = "$(num)/$(den)"

"""Format probability as decimal string."""
fmt_prob_decimal(p; digits::Int=4) = string(round(Float64(p); digits))

# ---------------------------------------------------------------------------
# Normal distribution
# ---------------------------------------------------------------------------

"""Z-score: (x - mu) / sigma."""
z_score(x, mu, sigma) = (x - mu) / sigma

"""
Standard normal CDF approximation (Abramowitz-Stegun).
Accurate to ~1.5e-7 for all z.
"""
function phi(z::Real)
    z = Float64(z)
    if z < 0
        return 1.0 - phi(-z)
    end
    # Constants from Abramowitz & Stegun 26.2.17
    b0 = 0.2316419
    b1 = 0.319381530
    b2 = -0.356563782
    b3 = 1.781477937
    b4 = -1.821255978
    b5 = 1.330274429
    t = 1.0 / (1.0 + b0 * z)
    pdf = exp(-0.5 * z^2) / sqrt(2π)
    poly = t * (b1 + t * (b2 + t * (b3 + t * (b4 + t * b5))))
    return 1.0 - pdf * poly
end

"""
Inverse standard normal CDF approximation (rational approximation).
Returns z such that Phi(z) ≈ p.
"""
function phi_inv(p::Real)
    p = Float64(p)
    (0 < p < 1) || error("p must be in (0, 1), got $p")
    if p < 0.5
        return -phi_inv(1.0 - p)
    end
    # Rational approximation for upper tail
    t = sqrt(-2.0 * log(1.0 - p))
    c0, c1, c2 = 2.515517, 0.802853, 0.010328
    d1, d2, d3 = 1.432788, 0.189269, 0.001308
    return t - (c0 + c1 * t + c2 * t^2) / (1.0 + d1 * t + d2 * t^2 + d3 * t^3)
end

"""P(X ≤ x) for X ~ N(mu, sigma²)."""
normal_cdf(x, mu, sigma) = phi(z_score(x, mu, sigma))

"""P(a ≤ X ≤ b) for X ~ N(mu, sigma²)."""
normal_between(a, b, mu, sigma) = phi(z_score(b, mu, sigma)) - phi(z_score(a, mu, sigma))

# ---------------------------------------------------------------------------
# Linear regression
# ---------------------------------------------------------------------------

"""
Least-squares linear regression: y = a + bx.
Returns (a=intercept, b=slope, r=correlation coefficient).
"""
function least_squares(xs, ys)
    n = length(xs)
    n == length(ys) || error("xs and ys must have same length")
    xf = Float64.(xs)
    yf = Float64.(ys)
    mx = sum(xf) / n
    my = sum(yf) / n
    sxx = sum((x - mx)^2 for x in xf)
    syy = sum((y - my)^2 for y in yf)
    sxy = sum((xf[i] - mx) * (yf[i] - my) for i in 1:n)
    b = sxy / sxx
    a = my - b * mx
    r = sxy / sqrt(sxx * syy)
    return (a=round(a; digits=4), b=round(b; digits=4), r=round(r; digits=4))
end

"""
Generate paired (xs, ys) data with known approximate slope and controllable noise.
"""
function rand_regression(; n::Int=8, slope_range::Tuple=(-3, 3), noise::Float64=2.0)
    slope = nonzero(slope_range...)
    intercept = randint(-10, 10)
    xs = sort([randint(1, 20) for _ in 1:n])
    ys = [slope * x + intercept + round(Int, randn() * noise) for x in xs]
    return (xs=xs, ys=ys)
end

# ---------------------------------------------------------------------------
# Confidence intervals
# ---------------------------------------------------------------------------

const Z_90 = 1.645
const Z_95 = 1.960
const Z_99 = 2.576

"""Margin of error for a z-interval."""
margin_of_error(sigma, n, z_star) = z_star * sigma / sqrt(n)

"""Confidence interval: (lower, upper)."""
function confidence_interval(x_bar, sigma, n, z_star)
    me = margin_of_error(sigma, n, z_star)
    return (lower=round(x_bar - me; digits=4), upper=round(x_bar + me; digits=4))
end

# ---------------------------------------------------------------------------
# Hypothesis testing
# ---------------------------------------------------------------------------

"""Z test statistic for a one-sample z-test."""
z_test_stat(x_bar, mu_0, sigma, n) = (x_bar - mu_0) / (sigma / sqrt(n))

"""Two-tailed p-value from z statistic."""
p_value_two_tail(z) = 2.0 * (1.0 - phi(abs(z)))

"""One-tailed p-value from z statistic (upper tail)."""
p_value_one_tail(z) = 1.0 - phi(z)

# ---------------------------------------------------------------------------
# Sampling
# ---------------------------------------------------------------------------

"""Standard error of the mean."""
se_mean(sigma, n) = sigma / sqrt(n)

"""Standard error of a proportion."""
se_proportion(p, n) = sqrt(p * (1 - p) / n)
