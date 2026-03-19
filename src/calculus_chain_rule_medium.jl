# calculus - chain_rule (medium)
# Generated: 2026-03-08T20:39:51.922144

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/chain_rule")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Polynomial composition: (ax+b)^n
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        n = randint(3, 7)
        inner = a*x + b
        f = inner^n
        
        # Derivative using chain rule
        df = diff(f, x)
        
        problem(
            question="Find \\frac{dy}{dx} if \\(y = $(tex(f))\\)",
            answer=df,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", f),
                "Apply chain rule: \\frac{d}{dx}[u^{$n}] = $n u^{$(n-1)} \\cdot \\frac{du}{dx} where \\(u = $(tex(inner))\\)",
                sol("\\frac{du}{dx}", diff(inner, x)),
                sol("Answer", df)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Polynomial inside polynomial: (ax^2 + bx + c)^n
        q = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-10,10))
        n = randint(2, 5)
        f = q.expr^n
        df = diff(f, x)
        
        problem(
            question="Differentiate \\(f(x) = $(tex(f))\\)",
            answer=df,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", f),
                "Let \\(u = $(tex(q.expr))\\), then \\(f(x) = u^{$n}\\)",
                sol("\\frac{du}{dx}", diff(q.expr, x)),
                "Apply chain rule: \\frac{df}{dx} = $n u^{$(n-1)} \\cdot \\frac{du}{dx}",
                sol("Answer", df)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Nested composition: (ax^2 + b)^n + c
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = randint(-15, 15)
        n = randint(3, 6)
        inner = a*x^2 + b
        f = inner^n + c
        df = diff(f, x)
        
        problem(
            question="Find \\(\\frac{d}{dx}\\left[$(tex(f))\\right]\\)",
            answer=df,
            difficulty=(1250, 1450),
            solution=steps(
                sol("Given", f),
                "The constant $c has derivative 0",
                "For \\(($(tex(inner)))^{$n}\\), use chain rule with \\(u = $(tex(inner))\\)",
                sol("\\frac{du}{dx}", diff(inner, x)),
                sol("Answer", df)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Product requiring chain rule: x^m * (ax+b)^n
        m = randint(2, 5)
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        n = randint(2, 5)
        inner = a*x + b
        f = x^m * inner^n
        df = diff(f, x)
        
        problem(
            question="Differentiate \\(g(x) = $(tex(f))\\) using product and chain rules",
            answer=df,
            difficulty=(1400, 1650),
            solution=steps(
                sol("Given", f),
                "Use product rule: \\frac{d}{dx}[u \\cdot v] = u'v + uv' where \\(u = x^{$m}\\) and \\(v = ($(tex(inner)))^{$n}\\)",
                "\\(u' = $(m)x^{$(m-1)}\\)",
                "For \\(v'\\), use chain rule: \\(v' = $n($(tex(inner)))^{$(n-1)} \\cdot $(a)\\)",
                sol("Answer", df)
            ),
            time=150
        )
        
    else
        # Triple composition: ((ax+b)^m)^n
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        m = randint(2, 4)
        n = randint(2, 3)
        inner = a*x + b
        middle = inner^m
        f = middle^n
        df = diff(f, x)
        
        problem(
            question="Find \\(\\frac{dy}{dx}\\) if \\(y = $(tex(f))\\)",
            answer=df,
            difficulty=(1450, 1750),
            solution=steps(
                sol("Given", f),
                "Simplify: \\(y = ($(tex(inner)))^{$(m*n)}\\)",
                "Apply chain rule with \\(u = $(tex(inner))\\)",
                sol("\\frac{du}{dx}", diff(inner, x)),
                "\\(\\frac{dy}{dx} = $(m*n)u^{$(m*n-1)} \\cdot \\frac{du}{dx}\\)",
                sol("Answer", df)
            ),
            time=140
        )
    end
end