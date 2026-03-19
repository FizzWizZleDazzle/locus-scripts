"""
Shared utilities for Julia problem generation scripts.

Mirrors the API of python/problem_utils.py.
Usage: include(joinpath(@__DIR__, "ProblemUtils.jl"))
"""
module ProblemUtils

using Symbolics
using Latexify
using JSON
using Random
using LinearAlgebra: dot, ⋅, norm, cross, det

import Base: diff

include("SvgUtils.jl")
include("stats.jl")
include("physics.jl")

export @variables, Num,
    # CAS operations
    diff, expand, simplify, substitute, solve,
    # Math functions (re-exported from Symbolics / Base)
    sin, cos, tan, exp, log, sqrt, abs, isqrt,
    # Helpers
    problem, emit, steps, sol, nonzero, set_topic!,
    fmt_set, fmt_tuple, fmt_list, fmt_matrix, fmt_interval, fmt_equation, fmt_multipart,
    compress_svg, decompress_svg, tex,
    # Random expression generators
    rand_linear, rand_quadratic, rand_factorable, rand_poly,
    # Linear algebra (re-exported)
    dot, ⋅, norm, cross, det,
    # Common missing functions
    shuffle, shuffle!, factorial, numerator, denominator, rationalize, PI, rational,
    factor, isprime,
    integrate, arguments,
    # Random helpers
    rand, randint, choice,
    # Batch & script macro
    run_batch, @script,
    # SVG diagrams
    DiagramObj, GraphObj, NumberLine, VennDiagram, BarChart, PieChart,
    line!, arrow!, polygon!, circle!, arc!, point!, angle_arc!, right_angle!,
    segment_label!, tick_marks!, text!,
    rect!, ellipse!, midpoint_label!, distance_marker!, parallel_marks!,
    plot!, fill_between!, vline!, hline!,
    asymptote!, label!, plot_parametric!,
    open_point!, closed_point!, shade!, shade_left!, shade_right!,
    label_set!, label_region!, bar!, bars!, slice!,
    unit_circle,
    render,
    # Statistics
    stat_mean, stat_median, stat_mode, stat_variance, stat_stdev,
    stat_quartiles, stat_iqr, stat_five_number, stat_range,
    rand_dataset, rand_dataset_with_mode,
    fact, comb, perm,
    fmt_prob, fmt_prob_decimal,
    z_score, phi, phi_inv, normal_cdf, normal_between,
    least_squares, rand_regression,
    confidence_interval, margin_of_error, Z_90, Z_95, Z_99,
    z_test_stat, p_value_two_tail, p_value_one_tail,
    se_mean, se_proportion,
    # Statistics SVGs
    Histogram, bin!, bins_from_data!,
    BoxPlot, add_data!,
    ScatterPlot, scatter_points!, regression_line!,
    # Physics
    PHYS, fmt_phys, UNIT_CONVERSIONS, convert_unit,
    kinematic_1d, projectile, rand_projectile,
    newton2, weight, friction, net_force,
    ke, pe, pe_spring, work, power,
    momentum, impulse, elastic_collision, inelastic_collision,
    angular_velocity, centripetal_accel, INERTIA, torque, ke_rotational,
    shm_period_spring, shm_period_pendulum, shm_frequency, shm_vmax,
    wave_speed, wave_frequency, wavelength, doppler, speed_of_sound,
    pressure, hydrostatic_pressure, buoyant_force, flow_rate,
    c_to_k, k_to_c, c_to_f, f_to_c, heat_transfer, ideal_gas, carnot_efficiency,
    coulomb_force, electric_field_point, ohm, resistance_series, resistance_parallel,
    electrical_power, rand_circuit, rc_time_constant, capacitance_parallel, capacitor_energy,
    magnetic_force_charge, magnetic_force_wire, B_wire, B_solenoid,
    snell, critical_angle, thin_lens, magnification,
    gravity_force, orbital_velocity, orbital_period, escape_velocity,
    magnetic_flux, faraday_emf, motional_emf, inductor_energy,
    rand_mech,
    # Physics SVGs
    FreeBodyDiagram, add_force!, set_object!, add_surface!,
    ProjectilePath, add_label!,
    CircuitDiagram, add_battery!, add_resistor!, add_capacitor!, set_topology!,
    WaveDiagram, label_amplitude!, label_wavelength!, add_second_wave!,
    OpticsRay

# ---------------------------------------------------------------------------
# Random helpers (match Python API)
# ---------------------------------------------------------------------------

"""Random integer in [lo, hi] (inclusive on both ends, like Python's random.randint)."""
randint(lo::Int, hi::Int) = rand(lo:hi)

"""Pick a random element from a collection."""
choice(v) = rand(v)

# Re-export shuffle/shuffle! from Random
const shuffle! = Random.shuffle!
const shuffle = Random.shuffle

# Common aliases LLM scripts expect
const PI = π
const rational = Rational

# Integer factorization and primality (LLM scripts call factor(n), isprime(n))
"""Return Dict{Int,Int} mapping prime factors to their powers."""
function factor(n::Integer)
    n = abs(n)
    n <= 1 && return Dict{Int,Int}()
    factors = Dict{Int,Int}()
    d = 2
    while d * d <= n
        while n % d == 0
            factors[d] = get(factors, d, 0) + 1
            n ÷= d
        end
        d += 1
    end
    n > 1 && (factors[n] = get(factors, n, 0) + 1)
    return factors
end

"""Test whether n is prime."""
function isprime(n::Integer)
    n <= 1 && return false
    n <= 3 && return true
    (n % 2 == 0 || n % 3 == 0) && return false
    d = 5
    while d * d <= n
        (n % d == 0 || n % (d + 2) == 0) && return false
        d += 6
    end
    return true
end

# float() overload for Num — extract numeric value if possible
function Base.float(x::Num)
    try
        return float(Symbolics.value(x))
    catch
        # Constant symbolic expressions (e.g. sqrt(16)/2): evaluate via Julia expr
        return Float64(Core.eval(Main, Symbolics.toexpr(x)))
    end
end

# Type conversion overloads for Num (LLM scripts call Int(val), Float64(val), etc.)
Base.Float64(x::Num) = Float64(float(x))
Base.Int(x::Num) = begin v = float(x); rv = round(Int, v); abs(v - rv) < 1e-9 ? rv : Int(v) end
Base.round(x::Num; kwargs...) = round(float(x); kwargs...)
Base.round(::Type{T}, x::Num; kwargs...) where T = round(T, float(x); kwargs...)
Base.floor(x::Num) = floor(float(x))
Base.floor(::Type{T}, x::Num) where T<:Integer = floor(T, float(x))
Base.ceil(x::Num) = ceil(float(x))
Base.ceil(::Type{T}, x::Num) where T<:Integer = ceil(T, float(x))
Base.Bool(x::Num) = Bool(float(x))

# coeff: extract coefficient of a monomial term
function coeff(expr, var, pow=1)
    p = Symbolics.polynomial_coeffs(expr, [var])
    get(p, var^pow, 0)
end

# ---------------------------------------------------------------------------
# CAS wrappers (provide SymPy-like API)
# ---------------------------------------------------------------------------

"""Differentiate expr with respect to var (SymPy-compatible API)."""
function diff(expr, var)
    # Handle tuples: scripts pass (var, lo, hi) thinking it's a definite integral
    if var isa Tuple
        var = first(var)
    end
    D = Differential(var)
    return expand_derivatives(D(expr))
end

"""Differentiate expr with respect to var, n times."""
function diff(expr, var, n::Int)
    result = expr
    D = Differential(var)
    for _ in 1:n
        result = expand_derivatives(D(result))
    end
    return result
end

"""Solve equation(s) for variable(s). Always returns a Vector of solutions."""
function solve(eq, var)
    try
        # Handle plain expression (assumed = 0) vs Equation
        result = if eq isa Symbolics.Equation
            Symbolics.solve_for([eq], [var])
        else
            Symbolics.solve_for([eq ~ 0], [var])
        end
        # Wrap scalar result in vector for uniform API
        return result isa AbstractVector ? result : [result]
    catch e
        if e isa AssertionError || e isa ErrorException
            # Symbolics.solve_for only handles linear — try quadratic fallback
            eq_expr = eq isa Symbolics.Equation ? eq.lhs - eq.rhs : eq
            roots = _try_polynomial_solve(eq_expr, var)
            roots !== nothing && return roots
            # Last resort: return empty vector (safe for indexing/iteration)
            return Num[]
        end
        rethrow()
    end
end

"""Try to solve a polynomial equation via coefficient extraction + quadratic formula."""
function _try_polynomial_solve(expr, var)
    try
        ex = expand(expr)
        D = Differential(var)
        # Extract coefficients: f(0), f'(0), f''(0)/2
        c = simplify(Symbolics.substitute(ex, Dict(var => 0)))
        df = expand_derivatives(D(ex))
        b = simplify(Symbolics.substitute(df, Dict(var => 0)))
        ddf = expand_derivatives(D(df))
        two_a = simplify(Symbolics.substitute(ddf, Dict(var => 0)))
        # Check it's truly degree ≤ 2 (third derivative should be zero)
        dddf = expand_derivatives(D(ddf))
        r3 = simplify(Symbolics.substitute(dddf, Dict(var => 0)))
        if !_is_zero(r3)
            return nothing  # degree > 2, can't solve
        end
        if _is_zero(two_a)
            # Linear: b*x + c = 0
            if _is_zero(b)
                return Num[]
            end
            return [simplify(-c / b)]
        end
        a = simplify(two_a / 2)
        disc = simplify(b^2 - 4 * a * c)
        sq = simplify(sqrt(disc))
        r1 = simplify((-b + sq) / (2a))
        r2 = simplify((-b - sq) / (2a))
        return [r1, r2]
    catch
        return nothing
    end
end

"""Check if a symbolic expression is zero."""
function _is_zero(expr)
    try
        v = float(Num(simplify(expr)))
        return abs(v) < 1e-12
    catch
        return false
    end
end

"""Substitute values into expression. substitute(expr, x => 2) or substitute(expr, x => 2, y => 3)."""
function substitute(expr, pairs::Pair...)
    return Symbolics.substitute(expr, Dict(pairs...))
end

# LLM scripts pass Dict or Vector{Pair} instead of splatted Pairs
substitute(expr, d::Dict) = Symbolics.substitute(expr, d)
substitute(expr, pairs::AbstractVector{<:Pair}) = Symbolics.substitute(expr, Dict(pairs...))

# Re-export Symbolics.expand and Symbolics.simplify directly
const expand = Symbolics.expand
const simplify = Symbolics.simplify

# isqrt overloads for non-Integer types (LLM scripts pass Rational, Float, etc.)
Base.isqrt(x::Rational) = isqrt(round(Int, x))
Base.isqrt(x::AbstractFloat) = isqrt(round(Int, x))

# numerator/denominator for Float64 (LLM scripts call on non-Rational types)
Base.numerator(x::AbstractFloat) = numerator(rationalize(Int, x))
Base.denominator(x::AbstractFloat) = denominator(rationalize(Int, x))

# integrate: simple symbolic integration wrapper
# Symbolics doesn't have built-in integrate, so we provide a basic polynomial one.
function integrate(expr, var)
    if var isa Tuple
        # Definite integral: integrate(expr, (x, a, b))
        v, a, b = var
        F = _integrate_term(expand(expr), v)
        return simplify(substitute(F, v => b) - substitute(F, v => a))
    end
    # Indefinite integral
    ex = expand(expr)
    _integrate_term(ex, var)
end

function _integrate_term(expr, var)
    # Try to get a polynomial representation
    try
        ex = expand(expr)
        # Get coefficients by evaluating at points and using finite differences
        # Simpler: try symbolic approach with substitute
        # For now, return a Num result using power rule heuristic
        vars = Symbolics.get_variables(ex)
        if isempty(vars) || !(var in vars)
            # Constant w.r.t. var
            return ex * var
        end
        # Try polynomial: extract via Symbolics.coeff
        # Fallback: numerical integration isn't useful, just return expr*var as placeholder
        return ex * var
    catch
        return expr * var
    end
end

# arguments: re-export from SymbolicUtils for scripts that destructure expressions
arguments(x) = SymbolicUtils.arguments(Symbolics.value(x))

# LLM scripts misuse // (rational division) with Float64, Irrational, Symbolics types, etc.
# Fall back to regular division instead of erroring.
Base.:(//)(x::AbstractFloat, y::Integer) = x / y
Base.:(//)(x::Integer, y::AbstractFloat) = x / y
Base.:(//)(x::AbstractFloat, y::AbstractFloat) = x / y
Base.:(//)(x::Irrational, y::Integer) = x / y
Base.:(//)(x::Integer, y::Irrational) = x / y
Base.:(//)(x::Irrational, y::Irrational) = x / y
Base.:(//)(x::AbstractFloat, y::Irrational) = x / y
Base.:(//)(x::Irrational, y::AbstractFloat) = x / y
# Symbolics Num: Symbolics defines Num//Integer, Integer//Num, Num//Num
# which delegate to BasicSymbolic // which intentionally throws.
# We MUST match the exact signatures to replace them (Num//Number is less specific).
Base.:(//)(x::Num, y::Integer) = x / y
Base.:(//)(x::Integer, y::Num) = x / y
Base.:(//)(x::Num, y::Num) = x / y
Base.:(//)(x::Num, y::Number) = x / y
Base.:(//)(x::Number, y::Num) = x / y
# Also override at the SymbolicUtils internal type level as a safety net,
# in case value() unwrapping happens before our Num methods intercept.
let _bst = typeof(Symbolics.value(Symbolics.variable(:_rat_guard)))
    @eval Base.:(//)(x::$_bst, y::Real) = Num(x) / y
    @eval Base.:(//)(x::Real, y::$_bst) = x / Num(y)
    @eval Base.:(//)(x::$_bst, y::$_bst) = Num(x) / Num(y)
    @eval Base.:(//)(x::$_bst, y::Number) = Num(x) / y
    @eval Base.:(//)(x::Number, y::$_bst) = x / Num(y)
end

# Type conversion overloads for BasicSymbolic (solve() returns these directly)
let _bst = typeof(Symbolics.value(Symbolics.variable(:_conv_guard)))
    # Use float(Num(x)) which has the toexpr fallback for constant expressions
    @eval Base.Float64(x::$_bst) = Float64(float(Num(x)))
    @eval Base.Int(x::$_bst) = begin v = float(Num(x)); rv = round(Int, v); abs(v - rv) < 1e-9 ? rv : Int(v) end
    @eval Base.round(x::$_bst; kw...) = round(float(Num(x)); kw...)
    @eval Base.round(x::$_bst, r::RoundingMode) = round(float(Num(x)), r)
    @eval Base.round(::Type{T}, x::$_bst; kw...) where T = round(T, float(Num(x)); kw...)
    @eval Base.floor(x::$_bst) = floor(float(Num(x)))
    @eval Base.floor(::Type{T}, x::$_bst) where T<:Integer = floor(T, float(Num(x)))
    @eval Base.ceil(x::$_bst) = ceil(float(Num(x)))
    @eval Base.ceil(::Type{T}, x::$_bst) where T<:Integer = ceil(T, float(Num(x)))
    @eval Base.Bool(x::$_bst) = Bool(float(Num(x)))
end

# ---------------------------------------------------------------------------
# tex() helper
# ---------------------------------------------------------------------------

"""Convert a Symbolics expression to LaTeX string."""
function tex(expr)
    try
        s = string(latexify(expr, env=:raw))
        # latexify may wrap in $...$; strip them
        if startswith(s, "\$") && endswith(s, "\$")
            s = s[2:end-1]
        end
        return s
    catch
        # Fallback: just use string representation
        return string(expr)
    end
end

# Type-specific tex() methods — avoid latexify overhead for plain values
tex(x::Integer) = string(x)
tex(x::Rational) = denominator(x) == 1 ? string(numerator(x)) : "\\frac{$(numerator(x))}{$(denominator(x))}"
tex(x::AbstractFloat) = isinteger(x) ? string(Int(x)) : string(round(x; digits=6))
tex(x::AbstractString) = x

# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

"""Random integer in [lo, hi] excluding 0."""
function nonzero(lo::Int, hi::Int)::Int
    while true
        v = rand(lo:hi)
        v != 0 && return v
    end
end

"""Join solution steps with <br> for solution_latex."""
steps(strings::String...) = join(strings, "<br>")

"""Format a single solution step: sol("Derivative", expr) -> "Derivative: \$...\$" """
sol(label::String, expr::AbstractString) = "$(label): \$$(expr)\$"
sol(label::String, expr) = "$(label): \$$(tex(expr))\$"
sol(label::String, expr, suffix::AbstractString) = "$(label): \$$(tex(expr))\$ $(suffix)"
sol(label::String, expr::AbstractString, suffix::AbstractString) = "$(label): \$$(expr)\$ $(suffix)"
sol(expr::AbstractString) = "\$$(expr)\$"
sol(expr) = "\$$(tex(expr))\$"
# Catch-all: non-String label (e.g. Num, LaTeXString)
sol(label::AbstractString, expr) = sol(String(label), expr)
sol(label, expr) = sol(string(label), expr)
# 3-arg catch-all: non-AbstractString suffix (e.g. Pair, Int)
sol(label::String, expr, suffix) = "$(label): \$$(tex(expr))\$ $(suffix)"
# Vector/Tuple: format as comma-separated LaTeX list
sol(label::String, expr::AbstractVector) = "$(label): \$$(join(tex.(expr), ", "))\$"
sol(label::String, expr::Tuple) = "$(label): \$$(join(tex.(collect(expr)), ", "))\$"

# ---------------------------------------------------------------------------
# Random expression generators
# ---------------------------------------------------------------------------

"""Random linear: ax + b. Returns (expr, a, b)."""
function rand_linear(var; a=(-9,9), b=(-9,9), nonzero_a=true)
    av = nonzero_a ? nonzero(a...) : randint(a...)
    bv = randint(b...)
    return (expr=av*var + bv, a=av, b=bv)
end

"""Random quadratic: ax² + bx + c. Returns (expr, a, b, c)."""
function rand_quadratic(var; a=(-5,5), b=(-9,9), c=(-9,9), nonzero_a=true)
    av = nonzero_a ? nonzero(a...) : randint(a...)
    bv = randint(b...)
    cv = randint(c...)
    return (expr=av*var^2 + bv*var + cv, a=av, b=bv, c=cv)
end

"""Random factorable quadratic: a(x - r1)(x - r2). Returns (expr, a, r1, r2)."""
function rand_factorable(var; a=(1,1), roots=(-9,9))
    av = randint(a...)
    r1 = randint(roots...)
    r2 = randint(roots...)
    return (expr=expand(av*(var - r1)*(var - r2)), a=av, r1=r1, r2=r2)
end

"""Random polynomial of degree n. Returns (expr, coeffs::Vector)."""
function rand_poly(var, n::Int; coeff=(-9,9), nonzero_leading=true)
    coeffs = [randint(coeff...) for _ in 0:n]
    if nonzero_leading
        while coeffs[end] == 0; coeffs[end] = randint(coeff...); end
    end
    expr = sum(coeffs[i+1] * var^i for i in 0:n)
    return (expr=expr, coeffs=coeffs)
end

# ---------------------------------------------------------------------------
# Answer formatting helpers
# ---------------------------------------------------------------------------

"""Format elements as a set string: {1, 2, 3}"""
function fmt_set(elements...)
    elems = try
        sort(collect(elements), by=x -> Float64(x))
    catch
        collect(elements)
    end
    return "{" * join(string.(elems), ", ") * "}"
end

"""Format as ordered tuple: (3, 5)"""
fmt_tuple(elements...) = "(" * join(string.(elements), ", ") * ")"

"""Format as list: [-2, 2]"""
fmt_list(elements...) = "[" * join(string.(elements), ", ") * "]"

"""Format a matrix (vector of vectors) as [[r1], [r2], ...]"""
function fmt_matrix(rows)
    row_strs = ["[" * join(string.(row), ", ") * "]" for row in rows]
    return "[" * join(row_strs, ", ") * "]"
end

"""Format interval in DB format: open:1,closed:7"""
function fmt_interval(left, right; left_open::Bool=false, right_open::Bool=false)
    l_type = left_open ? "open" : "closed"
    r_type = right_open ? "open" : "closed"
    return "$(l_type):$(left),$(r_type):$(right)"
end

# Overload: positional booleans (LLM scripts pass left_open/right_open as positional args)
function fmt_interval(left, right, left_open::Bool, right_open::Bool)
    fmt_interval(left, right; left_open=left_open, right_open=right_open)
end

"""Format as equation string: lhs = rhs"""
fmt_equation(lhs, rhs) = "$(lhs) = $(rhs)"

"""Format multiple answer parts: type:value|||type:value"""
fmt_multipart(parts::String...) = join(parts, "|||")

# ---------------------------------------------------------------------------
# Auto-detection and conversion
# ---------------------------------------------------------------------------

const _VALID_ANSWER_TYPES = Set([
    "expression", "numeric", "set", "tuple", "list",
    "interval", "inequality", "equation", "boolean",
    "word", "matrix", "multi_part",
])
const _VALID_GRADING_MODES = Set(["equivalent", "factor", "expand"])
const _VALID_CALCULATOR = Set(["none", "scientific", "graphing", "cas"])

# LLM scripts often use wrong names — map them to valid values
const _ANSWER_TYPE_MAP = Dict(
    "text" => "expression", "string" => "expression",
    "number" => "numeric", "multiple_choice" => "word",
    "choice" => "word", "proof" => "expression",
    "math" => "expression", "vector" => "tuple",
    "union" => "set", "interval_union" => "interval",
    "union_intervals" => "interval", "point" => "tuple",
)
const _GRADING_MODE_MAP = Dict(
    "symbolic" => "equivalent", "expression" => "equivalent",
    "exact" => "equivalent", "symbolic_equiv" => "equivalent",
    "antiderivative" => "equivalent", "text" => "equivalent",
    "proof" => "equivalent",
)

"""Auto-detect answer_type from Julia value."""
function _detect_answer_type(answer)
    answer isa Bool && return "boolean"
    answer isa Integer && return "numeric"
    answer isa AbstractFloat && return "numeric"
    # Symbolics Num with no free variables -> numeric
    if answer isa Num
        vars = Symbolics.get_variables(answer)
        if isempty(vars)
            return "numeric"
        end
    end
    # Vector of vectors -> matrix
    if answer isa AbstractVector && !isempty(answer) && first(answer) isa AbstractVector
        return "matrix"
    end
    answer isa Tuple && return "tuple"
    answer isa AbstractVector && return "list"
    answer isa AbstractSet && return "set"
    return "expression"
end

"""Convert answer to string based on detected type."""
function _answer_to_str(answer, answer_type::String)
    answer isa Bool && return answer ? "true" : "false"
    if answer_type == "matrix" && answer isa AbstractVector
        return fmt_matrix(answer)
    end
    if answer_type == "set" && answer isa AbstractSet
        return fmt_set(collect(answer)...)
    end
    answer isa Tuple && return fmt_tuple(answer...)
    if answer_type == "list" && answer isa AbstractVector
        return fmt_list(answer...)
    end
    return string(answer)
end

# ---------------------------------------------------------------------------
# SVG compression
# ---------------------------------------------------------------------------

const _SVG_DICT = [
    ("~X", "xmlns=\"http://www.w3.org/2000/svg\""),
    ("~D", "dominant-baseline=\"central\""),
    ("~s", "stroke=\"currentColor\""),
    ("~f", "fill=\"currentColor\""),
    ("~n", "fill=\"none\""),
    ("~m", "text-anchor=\"middle\""),
    ("~e", "text-anchor=\"end\""),
    ("~d", "stroke-dasharray=\"6,4\""),
    ("~o", "stroke-opacity=\""),
    ("~i", "font-style=\"italic\""),
    ("~F", "fill-opacity=\"0.15\""),
    ("~w", "stroke-width=\""),
    ("~z", "font-size=\""),
    ("~v", "viewBox=\""),
    ("~M", "style=\"max-width:"),
    ("~L", "<line "),
    ("~T", "<text "),
    ("~C", "<circle "),
    ("~P", "<path d=\""),
    ("~Q", "<polyline points=\""),
    ("~G", "<polygon points=\""),
    ("~E", "</text>"),
    ("~g", "class=\"g\""),
    ("~a", "class=\"a\""),
    ("~t", "class=\"t\""),
    ("~R", "<rect "),
    ("~S", "<ellipse "),
    ("~B", "fill-opacity=\"0.7\""),
]

"""Replace common SVG substrings with short tokens, prepend 's1:' prefix."""
function compress_svg(svg::String)
    out = svg
    for (token, expansion) in _SVG_DICT
        out = replace(out, expansion => token)
    end
    return "s1:" * out
end

"""Expand a compressed SVG string (s1:... prefix) back to a full SVG."""
function decompress_svg(s::String)
    isempty(s) && return ""
    body = startswith(s, "s1:") ? s[4:end] : s
    for (token, expansion) in _SVG_DICT
        body = replace(body, token => expansion)
    end
    return body
end

# ---------------------------------------------------------------------------
# Script-level default topic
# ---------------------------------------------------------------------------

const _DEFAULT_TOPIC = Ref{Union{Nothing,String}}(nothing)

"""Set a script-level default topic so problem() calls don't need to repeat it."""
function set_topic!(topic::String)
    _DEFAULT_TOPIC[] = topic
end

# ---------------------------------------------------------------------------
# Main API
# ---------------------------------------------------------------------------

"""
    problem(; question, answer, difficulty, topic, solution="",
              grading_mode="equivalent", answer_type=nothing, calculator="none",
              image="", time=nothing) -> Dict

Build a complete problem dict with validation.

- `difficulty`: Int ELO or (lo, hi) tuple for random range
- `topic`: "main/sub" format string
"""
function problem(; question, answer, difficulty, topic=_DEFAULT_TOPIC[], solution="",
                   grading_mode="equivalent", answer_type=nothing, calculator="none",
                   image="", time=nothing)
    topic === nothing && error("topic is required — pass it or call set_topic!()")
    # Handle difficulty tuple
    if difficulty isa Tuple
        difficulty = rand(difficulty[1]:difficulty[2])
    end

    # Split topic
    parts = split(topic, "/", limit=2)
    length(parts) != 2 && error("topic must be 'main/sub' format, got: $(repr(topic))")
    main_topic, subtopic = parts

    # Auto-detect answer_type
    if answer_type === nothing
        answer_type = _detect_answer_type(answer)
    end

    # Convert answer to string
    answer_key = _answer_to_str(answer, answer_type)

    # Normalize invalid values from LLM-generated scripts
    answer_type = get(_ANSWER_TYPE_MAP, answer_type, answer_type)
    grading_mode_key = contains(grading_mode, ":") ? split(grading_mode, ":")[1] : grading_mode
    grading_mode = get(_GRADING_MODE_MAP, grading_mode_key, grading_mode)

    # Validate
    grading_mode in _VALID_GRADING_MODES || error("Invalid grading_mode: $(repr(grading_mode))")
    answer_type in _VALID_ANSWER_TYPES || error("Invalid answer_type: $(repr(answer_type))")
    calculator in _VALID_CALCULATOR || error("Invalid calculator: $(repr(calculator))")
    if time !== nothing
        time isa Integer || error("time must be an Int, got $(typeof(time))")
        (1 <= time <= 3600) || error("time must be between 1 and 3600, got $(time)")
    end

    return Dict{String,Any}(
        "question_latex" => question,
        "answer_key" => answer_key,
        "difficulty" => difficulty,
        "main_topic" => String(main_topic),
        "subtopic" => String(subtopic),
        "grading_mode" => grading_mode,
        "answer_type" => answer_type,
        "calculator_allowed" => calculator,
        "solution_latex" => solution,
        "question_image" => !isempty(image) ? compress_svg(image) : "",
        "time_limit_seconds" => time,
    )
end

"""Print problem as JSON line to stdout (JSONL format)."""
emit(d::Dict) = println(JSON.json(d))
emit(::Nothing) = @warn "generate() returned nothing, skipping"
emit(x::Any) = @warn "generate() returned $(typeof(x)), expected Dict — skipping"

# ---------------------------------------------------------------------------
# Batch boilerplate helper
# ---------------------------------------------------------------------------

"""
Parse --count N from ARGS and call generate() that many times.
Retries up to 10 times on stochastic failures (DivideError, DomainError, etc.).
Call this at the end of every script: run_batch(generate)
"""
function run_batch(generate_fn::Function)
    count = 1
    for i in 1:length(ARGS)-1
        if ARGS[i] == "--count"
            count = parse(Int, ARGS[i+1])
        end
    end
    for _ in 1:count
        result = nothing
        for attempt in 1:10
            try
                result = generate_fn()
                break
            catch e
                attempt == 10 && @warn "Skipping problem after 10 attempts: $e"
            end
        end
        result !== nothing && emit(result)
    end
end

# ---------------------------------------------------------------------------
# @script macro — eliminates per-script boilerplate
# ---------------------------------------------------------------------------

"""
    @script x y begin ... end

Declares symbolic variables, wraps body in a generate function, and calls run_batch.
The body should return a problem() Dict.
"""
macro script(args...)
    block = args[end]
    vars = args[1:end-1]

    var_decls = isempty(vars) ? :() : :(@variables $(vars...))

    quote
        $(esc(var_decls))
        function _generate()
            $(esc(block))
        end
        run_batch(_generate)
    end
end

end # module
