# calculus - continuity (easy)
# Generated: 2026-03-08T20:38:01.681258

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/continuity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic: Is a polynomial continuous everywhere?
        q = rand_quadratic(x; a=(-5,5), b=(-12,12), c=(-15,15))
        problem(
            question="Is the function \$f(x) = $(tex(q.expr))\$ continuous for all real numbers?",
            answer="Yes",
            difficulty=(700, 850),
            answer_type="text",
            solution=steps(
                sol("Given", q.expr),
                "Polynomials are continuous everywhere",
                sol("Answer", "Yes, continuous for all real x")
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Find value that makes piecewise function continuous
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        x0 = randint(-5, 5)
        
        # At x = x0, we need: a*x0 + b = k
        k = a * x0 + b
        
        problem(
            question="For what value of \$k\$ is the function continuous at \$x = $(x0)\$?\n\$\$f(x) = \\begin{cases} $(tex(a*x + b)) & x < $(x0) \\\\ k & x = $(x0) \\\\ $(tex(a*x + b)) & x > $(x0) \\end{cases}\$\$",
            answer=k,
            difficulty=(850, 1000),
            solution=steps(
                "For continuity at \$x = $(x0)\$, we need \$\\lim_{x \\to $(x0)} f(x) = f($(x0))\$",
                sol("\\lim_{x \\to $(x0)} ($(tex(a*x + b)))", a*x0 + b),
                sol("Therefore k", k)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Where is a rational function discontinuous?
        r = nonzero(-8, 8)
        numer = rand_linear(x; a=(-6,6), b=(-10,10))
        denom_expr = expand((x - r))
        
        problem(
            question="At what value of \$x\$ is \$f(x) = \\frac{$(tex(numer.expr))}{$(tex(denom_expr))}\$ discontinuous?",
            answer=r,
            difficulty=(750, 900),
            solution=steps(
                sol("Given", numer.expr / denom_expr),
                "Function is discontinuous where denominator equals zero",
                sol("Set denominator to zero", denom_expr ~ 0),
                sol("Answer", r)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Check continuity at a point for piecewise function
        x0 = randint(-6, 6)
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        c = randint(-20, 20)
        
        # Left limit: a*x0 + b
        # Right value at x0: c
        left_val = a * x0 + b
        
        is_continuous = (left_val == c)
        answer = is_continuous ? "Yes" : "No"
        
        problem(
            question="Is \$f(x) = \\begin{cases} $(tex(a*x + b)) & x \\leq $(x0) \\\\ $(c) & x > $(x0) \\end{cases}\$ continuous at \$x = $(x0)\$?",
            answer=answer,
            difficulty=(900, 1050),
            answer_type="text",
            solution=steps(
                "Check if \$\\lim_{x \\to $(x0)^-} f(x) = f($(x0))\$",
                sol("\\lim_{x \\to $(x0)^-} f(x)", left_val),
                sol("f($(x0))", left_val),
                is_continuous ? "Limits match, function is continuous" : "Limits do not match (right side = $(c)), function is discontinuous",
                sol("Answer", answer)
            ),
            time=75
        )
        
    else
        # Find where rational function is continuous (all reals except discontinuities)
        r1 = nonzero(-9, 9)
        r2 = nonzero(-9, 9)
        while r2 == r1
            r2 = nonzero(-9, 9)
        end
        
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        numer = rand_linear(x; a=(-5,5), b=(-8,8))
        denom_expr = expand((x - r1) * (x - r2))
        
        # Answer: all reals except r1 and r2
        intervals = []
        push!(intervals, fmt_interval(-Inf, r1, true, false))
        push!(intervals, fmt_interval(r1, r2, false, false))
        push!(intervals, fmt_interval(r2, Inf, false, true))
        answer = join(intervals, " ∪ ")
        
        problem(
            question="On what intervals is \$f(x) = \\frac{$(tex(numer.expr))}{$(tex(denom_expr))}\$ continuous?",
            answer=answer,
            difficulty=(1000, 1200),
            answer_type="text",
            solution=steps(
                sol("Given", numer.expr / denom_expr),
                "Find where denominator is zero: \$$(tex(denom_expr)) = 0\$",
                "Discontinuities at \$x = $(r1)\$ and \$x = $(r2)\$",
                sol("Continuous on", answer)
            ),
            time=120
        )
    end
end