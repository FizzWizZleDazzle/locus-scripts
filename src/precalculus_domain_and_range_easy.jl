# precalculus - domain_and_range (easy)
# Generated: 2026-03-08T20:23:15.160113

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/domain_and_range")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Linear function - domain all reals
        q = rand_linear(x; a=(-8,8), b=(-15,15))
        domain_ans = fmt_interval(-Inf, Inf, true, true)
        
        problem(
            question="Find the domain of \$f(x) = $(tex(q.expr))\$",
            answer=domain_ans,
            difficulty=(700, 850),
            answer_type="interval",
            solution=steps(
                sol("Given", q.expr),
                "Linear functions are defined for all real numbers",
                "Domain: \$(-\\infty, \\infty)\$"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Rational function - exclude one point
        root = randint(-12, 12)
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        numerator = a*x + b
        denominator = x - root
        
        domain_ans = fmt_interval(-Inf, Inf, true, true, exclude=[root])
        
        problem(
            question="Find the domain of \$f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer=domain_ans,
            difficulty=(800, 950),
            answer_type="interval",
            solution=steps(
                sol("Function", numerator / denominator),
                "Denominator cannot be zero: \$$(tex(denominator)) \\neq 0\$",
                "Therefore \$x \\neq $(root)\$",
                "Domain: \$(-\\infty, $(root)) \\cup ($(root), \\infty)\$"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Square root - need non-negative argument
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        inside = a*x + b
        bound = -b // a
        
        if a > 0
            domain_ans = fmt_interval(bound, Inf, true, true)
            ineq = "\\geq"
        else
            domain_ans = fmt_interval(-Inf, bound, true, true)
            ineq = "\\leq"
        end
        
        problem(
            question="Find the domain of \$f(x) = \\sqrt{$(tex(inside))}\$",
            answer=domain_ans,
            difficulty=(850, 1000),
            answer_type="interval",
            solution=steps(
                sol("Function", sqrt(inside)),
                "The expression under the square root must be non-negative",
                "Solve: \$$(tex(inside)) \\geq 0\$",
                sol("Domain", domain_ans)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Quadratic range (parabola opens up or down)
        q = rand_quadratic(x; a=(-5,5), b=(-12,12), c=(-20,20))
        vertex_x = -q.b // (2*q.a)
        vertex_y = simplify(substitute(q.expr, x => vertex_x))
        
        if q.a > 0
            range_ans = fmt_interval(vertex_y, Inf, true, true)
            opens = "upward"
        else
            range_ans = fmt_interval(-Inf, vertex_y, true, true)
            opens = "downward"
        end
        
        problem(
            question="Find the range of \$f(x) = $(tex(q.expr))\$",
            answer=range_ans,
            difficulty=(900, 1100),
            answer_type="interval",
            solution=steps(
                sol("Given", q.expr),
                "Parabola opens $(opens) with vertex at \$x = $(tex(vertex_x))\$",
                "Vertex y-coordinate: \$y = $(tex(vertex_y))\$",
                sol("Range", range_ans)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Absolute value - always non-negative range
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        k = randint(-10, 10)
        inside = a*x + b
        
        # |ax+b| + k has range [k, ∞) if k ≥ 0, [k, ∞) regardless
        range_ans = fmt_interval(k, Inf, true, true)
        
        problem(
            question="Find the range of \$f(x) = |$(tex(inside))| + $(k)\$",
            answer=range_ans,
            difficulty=(850, 1050),
            answer_type="interval",
            solution=steps(
                sol("Function", abs(inside) + k),
                "Absolute value is always non-negative: \$|$(tex(inside))| \\geq 0\$",
                "Minimum value occurs when \$|$(tex(inside))| = 0\$",
                sol("Range", range_ans)
            ),
            time=75
        )
        
    else
        # Rational with quadratic denominator - exclude two points
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        while r2 == r1
            r2 = randint(-10, 10)
        end
        
        denominator = expand((x - r1) * (x - r2))
        numerator_a = nonzero(-5, 5)
        numerator_b = randint(-12, 12)
        numerator = numerator_a * x + numerator_b
        
        domain_ans = fmt_interval(-Inf, Inf, true, true, exclude=sort([r1, r2]))
        
        problem(
            question="Find the domain of \$f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer=domain_ans,
            difficulty=(950, 1200),
            answer_type="interval",
            solution=steps(
                sol("Function", numerator / denominator),
                "Set denominator equal to zero and solve",
                "Factor: \$$(tex(denominator)) = $(tex((x - r1)*(x - r2))) = 0\$",
                "Excluded values: \$x = $(r1), $(r2)\$",
                sol("Domain", domain_ans)
            ),
            time=90
        )
    end
end