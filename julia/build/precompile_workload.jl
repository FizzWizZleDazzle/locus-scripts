# Precompile workload for PackageCompiler sysimage.
# Exercises hot paths so they're AOT-compiled into sysimage.so.

using Symbolics
using Latexify
using JSON
using Random

# Symbolics operations
@variables x y
e1 = x^3 + 2x^2 - x + 1
Symbolics.derivative(e1, x)
expand((x + 1)^2)
expand((x + y)^3)
simplify(x + x)
Symbolics.substitute(e1, Dict(x => 2))
string(e1)

# Latexify
latexify(x^2 + 3x - 1)

# JSON
JSON.json(Dict("a" => 1, "b" => "hello", "c" => [1, 2, 3]))
JSON.json(Dict{String,Any}(
    "question_latex" => "\\frac{d}{dx}[x^3]",
    "answer_key" => "3*x^2",
    "difficulty" => 1200,
))

# Random
rand(1:10)
rand([1, 2, 3, 4, 5])

# ProblemUtils helpers
push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))
include(joinpath(@__DIR__, "..", "src", "ProblemUtils.jl"))
using .ProblemUtils

rand_linear(x)
rand_quadratic(x)
rand_factorable(x)
rand_poly(x, 3)
sol("test", x^2)

println("Precompile workload complete")
