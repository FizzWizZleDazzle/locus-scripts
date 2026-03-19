# calculus - derivative_rules (medium)
# Generated: 2026-03-08T20:39:08.699284

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:8)
    
    if problem_type == 1
        # Power rule with polynomial (1200-1400)
        q = rand_poly(x, rand(3:5); coeff=(-8, 8))
        df = diff(q.expr, x)
        problem(
            question="Find the derivative: \\(\\frac{d}{dx}\\left[$(tex(q.expr))\\right]\\)",
            answer=df,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", q.expr),
                "Apply the power rule to each term: \\(\\frac{d}{dx}[x^n] = nx^{n-1}\\)",
                sol("Answer", df)
            ),
            time=90
        )
    
    elseif problem_type == 2
        # Product rule (1400-1600)
        f = rand_linear(x; a=(-6, 6), b=(-10, 10))
        g = rand_quadratic(x; a=(-4, 4), b=(-8, 8), c=(-12, 12))
        product = expand(f.expr * g.expr)
        df = diff(f.expr, x)
        dg = diff(g.expr, x)
        result = expand(df * g.expr + f.expr * dg)
        problem(
            question="Find the derivative using the product rule: \\(\\frac{d}{dx}\\left[($(tex(f.expr)))($(tex(g.expr)))\\right]\\)",
            answer=result,
            difficulty=(1400, 1600),
            solution=steps(
                "Given: \\(f(x) = $(tex(f.expr))\\) and \\(g(x) = $(tex(g.expr))\\)",
                "Product rule: \\((fg)' = f'g + fg'\\)",
                sol("f'(x)", df),
                sol("g'(x)", dg),
                "Substitute: \\(($(tex(df)))($(tex(g.expr))) + ($(tex(f.expr)))($(tex(dg)))\\)",
                sol("Answer", result)
            ),
            time=180
        )
    
    elseif problem_type == 3
        # Quotient rule (1500-1700)
        numerator = rand_quadratic(x; a=(-5, 5), b=(-10, 10), c=(-15, 15))
        denom = rand_linear(x; a=(-6, 6), b=(-12, 12))
        dn = diff(numerator.expr, x)
        dd = diff(denom.expr, x)
        result = simplify((dn * denom.expr - numerator.expr * dd) / (denom.expr^2))
        problem(
            question="Find the derivative using the quotient rule: \\(\\frac{d}{dx}\\left[\\frac{$(tex(numerator.expr))}{$(tex(denom.expr))}\\right]\\)",
            answer=result,
            difficulty=(1500, 1700),
            solution=steps(
                "Given: \\(f(x) = $(tex(numerator.expr))\\) and \\(g(x) = $(tex(denom.expr))\\)",
                "Quotient rule: \\(\\left(\\frac{f}{g}\\right)' = \\frac{f'g - fg'}{g^2}\\)",
                sol("f'(x)", dn),
                sol("g'(x)", dd),
                "Substitute: \\(\\frac{($(tex(dn)))($(tex(denom.expr))) - ($(tex(numerator.expr)))($(tex(dd)))}{($(tex(denom.expr)))^2}\\)",
                sol("Simplified", result)
            ),
            time=240
        )
    
    elseif problem_type == 4
        # Chain rule with polynomial inside (1300-1500)
        inner = rand_linear(x; a=(-8, 8), b=(-15, 15))
        n = rand(3:6)
        outer_expr = inner.expr^n
        result = simplify(n * inner.expr^(n-1) * diff(inner.expr, x))
        problem(
            question="Find the derivative using the chain rule: \\(\\frac{d}{dx}\\left[($(tex(inner.expr)))^{$(n)}\\right]\\)",
            answer=result,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", outer_expr),
                "Chain rule: \\(\\frac{d}{dx}[u^n] = nu^{n-1}\\cdot\\frac{du}{dx}\\) where \\(u = $(tex(inner.expr))\\)",
                sol("\\frac{du}{dx}", diff(inner.expr, x)),
                "Apply: \\($(n)($(tex(inner.expr)))^{$(n-1)} \\cdot $(tex(diff(inner.expr, x)))\\)",
                sol("Answer", result)
            ),
            time=150
        )
    
    elseif problem_type == 5
        # Product and chain rule combined (1600-1800)
        f = rand_linear(x; a=(-5, 5), b=(-10, 10))
        inner = rand_quadratic(x; a=(-4, 4), b=(-7, 7), c=(-10, 10))
        n = rand(2:4)
        g_expr = inner.expr^n
        df = diff(f.expr, x)
        dg = simplify(n * inner.expr^(n-1) * diff(inner.expr, x))
        result = simplify(df * g_expr + f.expr * dg)
        problem(
            question="Find the derivative: \\(\\frac{d}{dx}\\left[($(tex(f.expr)))($(tex(inner.expr)))^{$(n)}\\right]\\)",
            answer=result,
            difficulty=(1600, 1800),
            solution=steps(
                "Let \\(f(x) = $(tex(f.expr))\\) and \\(g(x) = ($(tex(inner.expr)))^{$(n)}\\)",
                "Product rule: \\((fg)' = f'g + fg'\\)",
                sol("f'(x)", df),
                "For \\(g'(x)\\), use chain rule:",
                sol("g'(x)", dg),
                "Combine: \\(($(tex(df)))($(tex(g_expr))) + ($(tex(f.expr)))($(tex(dg)))\\)",
                sol("Answer", result)
            ),
            time=240
        )
    
    elseif problem_type == 6
        # Derivative at a point (1200-1400)
        q = rand_quadratic(x; a=(-6, 6), b=(-10, 10), c=(-15, 15))
        point = randint(-8, 8)
        df = diff(q.expr, x)
        answer = substitute(df, x => point)
        problem(
            question="Find the derivative of \\(f(x) = $(tex(q.expr))\\) at \\(x = $(point)\\)",
            answer=answer,
            difficulty=(1200, 1400),
            solution=steps(
                sol("f(x)", q.expr),
                "Apply power rule:",
                sol("f'(x)", df),
                "Evaluate at \\(x = $(point)\\):",
                sol("f'($(point))", answer)
            ),
            time=120
        )
    
    elseif problem_type == 7
        # Higher order derivative (1400-1600)
        q = rand_poly(x, 4; coeff=(-6, 6))
        df1 = diff(q.expr, x)
        df2 = diff(df1, x)
        problem(
            question="Find the second derivative: \\(\\frac{d^2}{dx^2}\\left[$(tex(q.expr))\\right]\\)",
            answer=df2,
            difficulty=(1400, 1600),
            solution=steps(
                sol("f(x)", q.expr),
                "First derivative:",
                sol("f'(x)", df1),
                "Second derivative:",
                sol("f''(x)", df2)
            ),
            time=150
        )
    
    else
        # Chain rule with quotient (1700-1800)
        num = rand_linear(x; a=(-6, 6), b=(-12, 12))
        denom = rand_linear(x; a=(-5, 5), b=(-10, 10))
        n = rand(2:4)
        quotient = num.expr / denom.expr
        outer = quotient^n
        dn = diff(num.expr, x)
        dd = diff(denom.expr, x)
        inner_deriv = simplify((dn * denom.expr - num.expr * dd) / (denom.expr^2))
        result = simplify(n * quotient^(n-1) * inner_deriv)
        problem(
            question="Find the derivative: \\(\\frac{d}{dx}\\left[\\left(\\frac{$(tex(num.expr))}{$(tex(denom.expr))}\\right)^{$(n)}\\right]\\)",
            answer=result,
            difficulty=(1700, 1800),
            solution=steps(
                "Let \\(u = \\frac{$(tex(num.expr))}{$(tex(denom.expr))}\\)",
                "Chain rule: \\(\\frac{d}{dx}[u^{$(n)}] = $(n)u^{$(n-1)}\\cdot\\frac{du}{dx}\\)",
                "Use quotient rule for \\(\\frac{du}{dx}\\):",
                sol("\\frac{du}{dx}", inner_deriv),
                "Substitute back:",
                sol("Answer", result)
            ),
            time=300
        )
    end
end