# precalculus - unit_circle (competition)
# Generated: 2026-03-08T20:28:04.631079

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n k begin
    set_topic!("precalculus/unit_circle")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find all solutions to sin(nx) = k where k involves nested radicals
        n_val = rand(2:5)
        numerator_vals = [1, 2, 3, sqrt(2), sqrt(3), sqrt(5), sqrt(6)]
        denominator_vals = [2, 3, 4, 6, 8]
        k_val = choice(numerator_vals) // choice(denominator_vals)
        
        # Base angle
        base_angles = [π//6, π//4, π//3, π//2, 2π//3, 3π//4, 5π//6]
        θ_base = choice(base_angles)
        
        solutions = Set{Rational}()
        for m in 0:2*n_val-1
            θ = (θ_base + 2*m*π) // n_val
            if θ >= 0 && θ < 2π
                push!(solutions, θ)
            end
            θ_alt = (π - θ_base + 2*m*π) // n_val
            if θ_alt >= 0 && θ_alt < 2π
                push!(solutions, θ_alt)
            end
        end
        
        problem(
            question="Find all solutions \\( \\theta \\in [0, 2\\pi) \\) such that \\( \\sin($(n_val)\\theta) = $(tex(k_val)) \\). Express your answer as a set of exact values in radians.",
            answer=fmt_set(solutions),
            difficulty=(3500, 4000),
            answer_type="set",
            solution=steps(
                sol("Given equation", "sin($(n_val)θ) = $(tex(k_val))"),
                "The general solution to sin(u) = $(tex(k_val)) is u = $(tex(θ_base)) + 2πk or u = π - $(tex(θ_base)) + 2πk",
                "Setting u = $(n_val)θ and solving for θ in [0, 2π), we find $(length(solutions)) distinct solutions",
                "Solutions: $(fmt_set(solutions))"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Prove trigonometric identity involving products and sums on unit circle
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        problem(
            question="Prove that for any point \\( P = (\\cos\\theta, \\sin\\theta) \\) on the unit circle, if \\( Q = (\\cos(\\theta + \\alpha), \\sin(\\theta + \\alpha)) \\) is another point, then \\( \\overrightarrow{OP} \\cdot \\overrightarrow{OQ} = \\cos\\alpha \\) where \\( O \\) is the origin. Use this to derive the cosine addition formula.",
            answer="cos(α + β) = cos(α)cos(β) - sin(α)sin(β)",
            difficulty=(3800, 4200),
            answer_type="text",
            solution=steps(
                "The dot product \\( \\overrightarrow{OP} \\cdot \\overrightarrow{OQ} = \\cos\\theta\\cos(\\theta+\\alpha) + \\sin\\theta\\sin(\\theta+\\alpha) \\)",
                "By the geometric interpretation, \\( \\overrightarrow{OP} \\cdot \\overrightarrow{OQ} = |\\overrightarrow{OP}||\\overrightarrow{OQ}|\\cos\\alpha = 1 \\cdot 1 \\cdot \\cos\\alpha \\)",
                "Equating: \\( \\cos\\theta\\cos(\\theta+\\alpha) + \\sin\\theta\\sin(\\theta+\\alpha) = \\cos\\alpha \\)",
                "Let β = θ and replace θ+α with α+β to get: \\( \\cos\\alpha\\cos\\beta + \\sin\\alpha\\sin\\beta = \\cos(\\alpha-\\beta) \\)",
                "Replacing β with -β gives the cosine addition formula"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Complex number argument on unit circle
        m = randint(3, 12)
        k = randint(1, m-1)
        
        problem(
            question="Let \\( z_k = e^{2\\pi i k / $(m)} \\) for \\( k = 0, 1, \\ldots, $(m-1) \\) be the $(m)-th roots of unity on the unit circle. Prove that \\( \\sum_{k=0}^{$(m-1)} z_k = 0 \\) and compute \\( \\prod_{k=1}^{$(m-1)} (z_1 - z_k) \\).",
            answer=m,
            difficulty=(4000, 4500),
            solution=steps(
                "The $(m)-th roots of unity satisfy \\( z^{$(m)} - 1 = 0 \\)",
                "Factoring: \\( z^{$(m)} - 1 = (z-1)(z^{$(m-1)} + z^{$(m-2)} + \\cdots + z + 1) \\)",
                "Since \\( z_k \\) for \\( k=1,\\ldots,$(m-1) \\) are roots of \\( z^{$(m-1)} + \\cdots + 1 = 0 \\), we have \\( \\sum_{k=0}^{$(m-1)} z_k = 0 \\)",
                "For the product, \\( \\prod_{k=1}^{$(m-1)} (z_1 - z_k) = $(m) \\) by evaluating the derivative of \\( z^{$(m)} - 1 \\) at \\( z = z_1 \\)",
                sol("Answer", m)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Inscribed polygon on unit circle
        n_sides = choice([5, 7, 8, 9, 10, 12])
        
        problem(
            question="A regular $(n_sides)-gon is inscribed in the unit circle. Find the exact area of the polygon in terms of trigonometric functions, then determine how many such polygons can be inscribed with one vertex at \\( (1, 0) \\) such that no two polygons share the same vertex set.",
            answer=n_sides,
            difficulty=(3600, 4000),
            solution=steps(
                "Each vertex is at angle \\( \\frac{2\\pi k}{$(n_sides)} \\) for \\( k = 0, 1, \\ldots, $(n_sides-1) \\)",
                "The area of the regular $(n_sides)-gon is \\( A = \\frac{$(n_sides)}{2}\\sin\\left(\\frac{2\\pi}{$(n_sides)}\\right) \\)",
                "With one vertex fixed at (1,0), rotational freedom gives $(n_sides) distinct configurations",
                "However, the polygon is symmetric, so we count only distinct vertex sets",
                sol("Answer", n_sides)
            ),
            time=240
        )
        
    elseif problem_type == 5
        # Parametric curve intersections with unit circle
        a = nonzero(2, 6)
        b = nonzero(2, 6)
        
        num_intersections = 0
        if a == b
            num_intersections = 4
        else
            num_intersections = 8
        end
        
        problem(
            question="Find the number of intersection points between the unit circle \\( x^2 + y^2 = 1 \\) and the curve given by \\( x = \\cos($(a)t), y = \\sin($(b)t) \\) for \\( t \\in [0, 2\\pi) \\).",
            answer=num_intersections,
            difficulty=(3700, 4100),
            solution=steps(
                "Substitute into the unit circle equation: \\( \\cos^2($(a)t) + \\sin^2($(b)t) = 1 \\)",
                "This simplifies using \\( \\cos^2(u) = \\frac{1+\\cos(2u)}{2} \\) and \\( \\sin^2(v) = \\frac{1-\\cos(2v)}{2} \\)",
                "We get \\( \\cos($(2a)t) - \\cos($(2b)t) = 0 \\), so \\( \\cos($(2a)t) = \\cos($(2b)t) \\)",
                "This occurs when \\( $(2a)t = \\pm $(2b)t + 2\\pi k \\), giving multiple solutions in \\( [0, 2\\pi) \\)",
                sol("Number of intersections", num_intersections)
            ),
            time=270
        )
        
    else
        # Chebyshev polynomial on unit circle
        n_val = randint(4, 8)
        
        problem(
            question="Let \\( T_n(x) \\) be the Chebyshev polynomial of the first kind defined by \\( T_n(\\cos\\theta) = \\cos(n\\theta) \\). Prove that all roots of \\( T_{$(n_val)}(x) \\) lie in the interval \\( [-1, 1] \\) and find the exact value of \\( T_{$(n_val)}(1/2) \\).",
            answer=cos(n_val * acos(1//2)),
            difficulty=(4200, 4800),
            solution=steps(
                "By definition, \\( T_{$(n_val)}(\\cos\\theta) = \\cos($(n_val)\\theta) \\)",
                "Roots occur when \\( \\cos($(n_val)\\theta) = 0 \\), i.e., \\( $(n_val)\\theta = \\frac{\\pi}{2} + k\\pi \\)",
                "This gives \\( \\theta = \\frac{(2k+1)\\pi}{2 \\cdot $(n_val)} \\) for \\( k = 0, 1, \\ldots, $(n_val-1) \\)",
                "All such \\( \\cos\\theta \\) values lie in \\( [-1, 1] \\) since θ is real",
                "For \\( T_{$(n_val)}(1/2) \\): let \\( \\theta = \\arccos(1/2) = \\pi/3 \\), so \\( T_{$(n_val)}(1/2) = \\cos($(n_val)\\pi/3) \\)"
            ),
            time=300
        )
    end
end