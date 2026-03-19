# calculus - derivative_rules (easy)
# Generated: 2026-03-08T20:38:49.726156

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Power rule with simple polynomial
        n = randint(2, 5)
        a = nonzero(-8, 8)
        expr = a * x^n
        deriv = diff(expr, x)
        
        problem(
            question="Find the derivative: \\( \\frac{d}{dx}\\left[$(tex(expr))\\right] \\)",
            answer=deriv,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", expr),
                "Apply the power rule: \\( \\frac{d}{dx}[x^n] = nx^{n-1} \\)",
                sol("Answer", deriv)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Derivative of polynomial (quadratic or cubic)
        if rand(Bool)
            q = rand_quadratic(x; a=(-6,6), b=(-10,10), c=(-15,15))
            deriv = diff(q.expr, x)
        else
            a = nonzero(-4, 4)
            b = randint(-8, 8)
            c = randint(-12, 12)
            d = randint(-15, 15)
            expr = a*x^3 + b*x^2 + c*x + d
            deriv = diff(expr, x)
            q = (expr=expr,)
        end
        
        problem(
            question="Find \\( f'(x) \\) if \\( f(x) = $(tex(q.expr)) \\)",
            answer=deriv,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", q.expr),
                "Apply the power rule to each term",
                sol("f'(x)", deriv)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Product rule
        f1 = rand_linear(x; a=(-5,5), b=(-8,8))
        f2 = rand_linear(x; a=(-5,5), b=(-8,8))
        expr = f1.expr * f2.expr
        deriv = diff(expr, x)
        deriv_simplified = simplify(deriv)
        
        problem(
            question="Find the derivative of \\( f(x) = ($(tex(f1.expr)))($(tex(f2.expr))) \\)",
            answer=deriv_simplified,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", expr),
                "Apply the product rule: \\( (uv)' = u'v + uv' \\)",
                "where \\( u = $(tex(f1.expr)) \\) and \\( v = $(tex(f2.expr)) \\)",
                sol("Answer", deriv_simplified)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Quotient rule (simple)
        num = rand_linear(x; a=(-6,6), b=(-10,10))
        denom_a = nonzero(-4, 4)
        denom_b = nonzero(-8, 8)
        denom_expr = denom_a*x + denom_b
        expr = num.expr / denom_expr
        deriv = diff(expr, x)
        deriv_simplified = simplify(deriv)
        
        problem(
            question="Find \\( \\frac{d}{dx}\\left[\\frac{$(tex(num.expr))}{$(tex(denom_expr))}\\right] \\)",
            answer=deriv_simplified,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", expr),
                "Apply the quotient rule: \\( \\left(\\frac{u}{v}\\right)' = \\frac{u'v - uv'}{v^2} \\)",
                "where \\( u = $(tex(num.expr)) \\) and \\( v = $(tex(denom_expr)) \\)",
                sol("Answer", deriv_simplified)
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Chain rule with polynomial inside
        inner = rand_linear(x; a=(-5,5), b=(-8,8))
        outer_exp = randint(2, 4)
        expr = inner.expr^outer_exp
        deriv = diff(expr, x)
        deriv_simplified = simplify(deriv)
        
        problem(
            question="Find the derivative: \\( \\frac{d}{dx}\\left[($(tex(inner.expr)))^{$(outer_exp)}\\right] \\)",
            answer=deriv_simplified,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", expr),
                "Apply the chain rule: \\( \\frac{d}{dx}[f(g(x))] = f'(g(x)) \\cdot g'(x) \\)",
                "Let \\( u = $(tex(inner.expr)) \\), then \\( \\frac{du}{dx} = $(tex(diff(inner.expr, x))) \\)",
                sol("Answer", deriv_simplified)
            ),
            time=100
        )
        
    else
        # Evaluate derivative at a point
        q = rand_quadratic(x; a=(-5,5), b=(-8,8), c=(-10,10))
        deriv = diff(q.expr, x)
        x_val = randint(-5, 5)
        ans = substitute(deriv, x => x_val)
        
        problem(
            question="If \\( f(x) = $(tex(q.expr)) \\), find \\( f'($(x_val)) \\)",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", q.expr),
                sol("f'(x)", deriv),
                "Evaluate at \\( x = $(x_val) \\)",
                sol("f'($(x_val))", ans)
            ),
            time=90
        )
    end
end