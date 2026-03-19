# precalculus - domain_and_range (very_easy)
# Generated: 2026-03-08T20:23:04.835987

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/domain_and_range")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple polynomial - domain is all reals
        q = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-10,10))
        problem(
            question="What is the domain of \$f(x) = $(tex(q.expr))\$?",
            answer=fmt_interval(-Inf, Inf, true, true),
            difficulty=(200, 400),
            answer_type="interval",
            solution=steps(
                sol("Given", q.expr),
                "Polynomials are defined for all real numbers",
                sol("Domain", fmt_interval(-Inf, Inf, true, true))
            ),
            time=30
        )
    elseif problem_type == 2
        # Simple linear function - domain is all reals
        lin = rand_linear(x; a=(-8,8), b=(-15,15))
        problem(
            question="What is the domain of \$g(x) = $(tex(lin.expr))\$?",
            answer=fmt_interval(-Inf, Inf, true, true),
            difficulty=(150, 350),
            answer_type="interval",
            solution=steps(
                sol("Given", lin.expr),
                "Linear functions are defined for all real numbers",
                sol("Domain", fmt_interval(-Inf, Inf, true, true))
            ),
            time=30
        )
    elseif problem_type == 3
        # Simple rational function with one restriction
        root = nonzero(-12, 12)
        numerator_a = nonzero(-5, 5)
        numerator_b = randint(-10, 10)
        numer = numerator_a * x + numerator_b
        denom = x - root
        problem(
            question="What is the domain of \$h(x) = \\frac{$(tex(numer))}{$(tex(denom))}\$?",
            answer=fmt_set(Set([-Inf, root, Inf])),
            difficulty=(400, 600),
            answer_type="union_intervals",
            solution=steps(
                sol("Given", numer / denom),
                "The denominator cannot equal zero: \$$(tex(denom)) \\neq 0\$",
                "Therefore \$x \\neq $(root)\$",
                sol("Domain", "All real numbers except \$x = $(root)\$")
            ),
            time=60
        )
    elseif problem_type == 4
        # Square root function - domain where expression >= 0
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        inside = a * x + b
        bound = -b // a
        if a > 0
            ans = fmt_interval(bound, Inf, false, true)
            ineq_str = "\\geq"
        else
            ans = fmt_interval(-Inf, bound, true, false)
            ineq_str = "\\leq"
        end
        problem(
            question="What is the domain of \$f(x) = \\sqrt{$(tex(inside))}\$?",
            answer=ans,
            difficulty=(500, 700),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\sqrt{$(tex(inside))}"),
                "The expression under the square root must be non-negative: \$$(tex(inside)) \\geq 0\$",
                "Solving: \$x $(ineq_str) $(bound)\$",
                sol("Domain", ans)
            ),
            time=90
        )
    elseif problem_type == 5
        # Constant function - domain is all reals
        c = randint(-20, 20)
        problem(
            question="What is the domain of \$f(x) = $(c)\$?",
            answer=fmt_interval(-Inf, Inf, true, true),
            difficulty=(100, 300),
            answer_type="interval",
            solution=steps(
                sol("Given", "f(x) = $(c)"),
                "Constant functions are defined for all real numbers",
                sol("Domain", fmt_interval(-Inf, Inf, true, true))
            ),
            time=30
        )
    else
        # Range of a linear function - all reals
        lin = rand_linear(x; a=(-8,8), b=(-15,15))
        problem(
            question="What is the range of \$f(x) = $(tex(lin.expr))\$?",
            answer=fmt_interval(-Inf, Inf, true, true),
            difficulty=(300, 500),
            answer_type="interval",
            solution=steps(
                sol("Given", lin.expr),
                "Linear functions with non-zero slope can output any real number",
                sol("Range", fmt_interval(-Inf, Inf, true, true))
            ),
            time=45
        )
    end
end