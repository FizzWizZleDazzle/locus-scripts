# precalculus - inverse_functions (easy)
# Generated: 2026-03-08T20:24:58.897735

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find inverse of linear function
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        f = a*x + b
        
        # Inverse: solve y = ax + b for x
        # x = (y - b)/a
        inv_a = 1//a
        inv_b = -b//a
        f_inv = inv_a*x + inv_b
        
        problem(
            question="Find the inverse function of \\\$f(x) = $(tex(f))\\\$",
            answer=f_inv,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "f(x) = " * tex(f)),
                "Let y = $(tex(f)), then solve for x in terms of y",
                sol("Inverse", "f^{-1}(x) = " * tex(f_inv))
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Verify two functions are inverses by composition
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        f = a*x + b
        g = (x - b)//a
        
        # f(g(x)) = a*((x-b)/a) + b = x
        comp1 = simplify(substitute(f, x => g))
        comp2 = simplify(substitute(g, x => f))
        
        problem(
            question="Verify that \\\$f(x) = $(tex(f))\\\$ and \\\$g(x) = $(tex(g))\\\$ are inverse functions by showing \\\$f(g(x)) = x\\\$",
            answer=x,
            difficulty=(800, 1000),
            solution=steps(
                sol("Compute f(g(x))", "f(g(x)) = " * tex(substitute(f, x => g))),
                "Simplify the expression",
                sol("Result", tex(comp1) * " = x, so they are inverses")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Find value of inverse function at a point
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        
        # f(x) = ax + b, so f^{-1}(x) = (x - b)/a
        y_val = randint(-20, 20)
        ans = (y_val - b)//a
        
        problem(
            question="If \\\$f(x) = $(tex(a*x + b))\\\$, find \\\$f^{-1}($(y_val))\\\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "f(x) = " * tex(a*x + b)),
                "Find inverse: solve y = $(tex(a*x + b)) for x to get f^{-1}(x) = " * tex((x - b)//a),
                sol("Evaluate", "f^{-1}($(y_val)) = " * tex(ans))
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Find domain of inverse function (range of original)
        # Using f(x) = sqrt(x - a) + b, domain [a, ∞), range [b, ∞)
        a = randint(-10, 10)
        b = randint(-8, 8)
        
        ans = fmt_interval(b, Inf, true, true)
        
        problem(
            question="Find the domain of \\\$f^{-1}(x)\\\$ if \\\$f(x) = \\sqrt{x - $(a)} + $(b)\\\$ with domain \\\$[$(a), \\infty)\\\$",
            answer=ans,
            answer_type="interval",
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", "f(x) = \\sqrt{x - $(a)} + $(b)"),
                "Domain of f^{-1} equals range of f",
                "Since sqrt gives values ≥ 0, range of f is [$(b), ∞)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Composition with inverse: f^{-1}(f(a))
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        x_val = randint(-15, 15)
        
        problem(
            question="If \\\$f(x) = $(tex(a*x + b))\\\$, find \\\$f^{-1}(f($(x_val)))\\\$",
            answer=x_val,
            difficulty=(800, 1000),
            solution=steps(
                sol("Property", "f^{-1}(f(x)) = x for all x in domain of f"),
                "This is the definition of inverse functions",
                sol("Answer", "f^{-1}(f($(x_val))) = $(x_val)")
            ),
            time=60
        )
        
    else
        # Find inverse of rational function (x + a)/(x + b)
        a = randint(-10, 10)
        b = nonzero(-10, 10)
        while b == a
            b = nonzero(-10, 10)
        end
        
        # f(x) = (x + a)/(x + b)
        # y = (x + a)/(x + b)
        # y(x + b) = x + a
        # xy + by = x + a
        # xy - x = a - by
        # x(y - 1) = a - by
        # x = (a - by)/(y - 1) = (-by + a)/(y - 1)
        
        f_inv_num = -b*x + a
        f_inv_den = x - 1
        
        problem(
            question="Find the inverse of \\\$f(x) = \\frac{x + $(a)}{x + $(b)}\\\$",
            answer="\\frac{" * tex(f_inv_num) * "}{" * tex(f_inv_den) * "}",
            difficulty=(1000, 1200),
            solution=steps(
                sol("Set up", "y = \\frac{x + $(a)}{x + $(b)}"),
                "Solve for x: multiply both sides by (x + $(b)), then isolate x",
                "x(y - 1) = $(a) - $(b)y",
                sol("Inverse", "f^{-1}(x) = \\frac{$(tex(f_inv_num))}{$(tex(f_inv_den))}")
            ),
            time=150
        )
    end
end