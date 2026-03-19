# calculus - chain_rule (easy)
# Generated: 2026-03-08T20:39:43.346538

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/chain_rule")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple chain rule: (ax + b)^n
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        n = rand(2:6)
        inner = a*x + b
        f = inner^n
        df = diff(f, x)
        
        problem(
            question = "Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer = df,
            difficulty = (700, 900),
            solution = steps(
                sol("Given", f),
                "Apply chain rule: \\frac{d}{dx}[u^{$(n)}] = $(n)u^{$(n-1)} \\cdot \\frac{du}{dx}",
                "Inner function: \$u = $(tex(inner))\$, so \$\\frac{du}{dx} = $(a)\$",
                sol("Answer", df)
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # Chain rule with quadratic inside: (ax^2 + bx + c)^n
        q = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-12,12))
        n = rand(2:4)
        f = q.expr^n
        df = simplify(diff(f, x))
        
        problem(
            question = "Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer = df,
            difficulty = (900, 1100),
            solution = steps(
                sol("Given", f),
                "Apply chain rule: \\frac{d}{dx}[u^{$(n)}] = $(n)u^{$(n-1)} \\cdot \\frac{du}{dx}",
                "Inner function: \$u = $(tex(q.expr))\$, so \$\\frac{du}{dx} = $(tex(diff(q.expr, x)))\$",
                "Multiply: \$$(n)($(tex(q.expr)))^{$(n-1)} \\cdot ($(tex(diff(q.expr, x))))\$",
                sol("Answer", df)
            ),
            time = 120
        )
        
    elseif problem_type == 3
        # Nested linear functions: (a(bx + c) + d)^n
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(-10, 10)
        d = randint(-10, 10)
        n = rand(2:5)
        inner = a*(b*x + c) + d
        f = inner^n
        df = simplify(diff(f, x))
        
        problem(
            question = "Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer = df,
            difficulty = (800, 1000),
            solution = steps(
                sol("Given", f),
                "Simplify inner function: \$$(tex(inner)) = $(tex(expand(inner)))\$",
                "Apply chain rule with \$\\frac{du}{dx} = $(a*b)\$",
                sol("Answer", df)
            ),
            time = 100
        )
        
    elseif problem_type == 4
        # Product with chain rule: x^m * (ax + b)^n
        m = rand(1:4)
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        n = rand(2:4)
        inner = a*x + b
        f = x^m * inner^n
        df = simplify(diff(f, x))
        
        problem(
            question = "Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer = df,
            difficulty = (1000, 1200),
            solution = steps(
                sol("Given", f),
                "Apply product rule: \$\\frac{d}{dx}[uv] = u'v + uv'\$",
                "First term: \$\\frac{d}{dx}[x^{$(m)}] \\cdot ($(tex(inner)))^{$(n)} = $(m)x^{$(m-1)} \\cdot ($(tex(inner)))^{$(n)}\$",
                "Second term: \$x^{$(m)} \\cdot \\frac{d}{dx}[($(tex(inner)))^{$(n)}] = x^{$(m)} \\cdot $(n)($(tex(inner)))^{$(n-1)} \\cdot $(a)\$",
                "Combine and simplify",
                sol("Answer", df)
            ),
            time = 150
        )
        
    else
        # Chain rule with coefficient: k*(ax^2 + bx + c)^n
        k = nonzero(-8, 8)
        q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-10,10))
        n = rand(2:5)
        f = k * q.expr^n
        df = simplify(diff(f, x))
        
        problem(
            question = "Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer = df,
            difficulty = (950, 1150),
            solution = steps(
                sol("Given", f),
                "Factor out constant: \$$(k) \\cdot \\frac{d}{dx}[($(tex(q.expr)))^{$(n)}]\$",
                "Apply chain rule to \$($(tex(q.expr)))^{$(n)}\$",
                "Inner derivative: \$\\frac{d}{dx}[$(tex(q.expr))] = $(tex(diff(q.expr, x)))\$",
                "Result: \$$(k) \\cdot $(n)($(tex(q.expr)))^{$(n-1)} \\cdot ($(tex(diff(q.expr, x))))\$",
                sol("Answer", df)
            ),
            time = 130
        )
    end
end