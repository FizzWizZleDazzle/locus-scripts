# calculus - derivative_rules (hard)
# Generated: 2026-03-08T20:39:22.700237

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:8)
    
    if problem_type == 1
        # Chain rule with nested polynomial and trig
        inner_type = choice([:poly, :rational])
        if inner_type == :poly
            q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-10,10))
            inner = q.expr
        else
            num_q = rand_linear(x; a=(-5,5), b=(-8,8))
            den_q = rand_linear(x; a=(-5,5), b=(-8,8))
            inner = num_q.expr / den_q.expr
        end
        
        outer_func = choice([:sin, :cos, :exp, :ln])
        if outer_func == :sin
            f = sin(inner)
            f_prime = diff(f, x)
        elseif outer_func == :cos
            f = cos(inner)
            f_prime = diff(f, x)
        elseif outer_func == :exp
            f = exp(inner)
            f_prime = diff(f, x)
        else
            f = log(abs(inner))
            f_prime = diff(f, x)
        end
        
        f_prime_simplified = simplify(f_prime)
        
        problem(
            question="Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer=f_prime_simplified,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Given", f),
                "Apply chain rule: if \\(f(x) = g(h(x))\\), then \\(f'(x) = g'(h(x)) \\cdot h'(x)\\)",
                sol("\\frac{d}{dx}[$(tex(inner))]", diff(inner, x)),
                sol("Answer", f_prime_simplified)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Product rule with three factors
        f1 = rand_linear(x; a=(-6,6), b=(-10,10))
        f2 = rand_quadratic(x; a=(-4,4), b=(-7,7), c=(-12,12))
        
        trig_choice = choice([:sin, :cos, :tan])
        coeff = nonzero(-5, 5)
        if trig_choice == :sin
            f3_expr = sin(coeff * x)
        elseif trig_choice == :cos
            f3_expr = cos(coeff * x)
        else
            f3_expr = tan(coeff * x)
        end
        
        f = f1.expr * f2.expr * f3_expr
        f_prime = diff(f, x)
        f_prime_simplified = simplify(f_prime)
        
        problem(
            question="Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer=f_prime_simplified,
            difficulty=(1900, 2200),
            solution=steps(
                sol("Given", f),
                "Apply product rule for three factors: \\((uvw)' = u'vw + uv'w + uvw'\\)",
                sol("u", f1.expr),
                sol("v", f2.expr),
                sol("w", f3_expr),
                sol("Answer", f_prime_simplified)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Quotient rule with trig
        num_type = choice([:poly, :trig])
        den_type = choice([:poly, :trig])
        
        if num_type == :poly
            num = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-15,15)).expr
        else
            coeff = nonzero(-4, 4)
            num = sin(coeff * x)
        end
        
        if den_type == :poly
            den = rand_linear(x; a=(-6,6), b=(-12,12)).expr
        else
            coeff = nonzero(-4, 4)
            den = cos(coeff * x)
        end
        
        f = num / den
        f_prime = diff(f, x)
        f_prime_simplified = simplify(f_prime)
        
        problem(
            question="Find \\frac{d}{dx}\\left[$(tex(f))\\right]",
            answer=f_prime_simplified,
            difficulty=(1850, 2150),
            solution=steps(
                sol("Given", f),
                "Apply quotient rule: \\(\\left(\\frac{u}{v}\\right)' = \\frac{u'v - uv'}{v^2}\\)",
                sol("u", num),
                sol("v", den),
                sol("u'", diff(num, x)),
                sol("v'", diff(den, x)),
                sol("Answer", f_prime_simplified)
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Implicit differentiation with polynomial equation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-15, 15)
        d = nonzero(-4, 4)
        e = randint(-12, 12)
        
        # Equation: ax^2 + bxy + cy^2 = d*x + e*y
        lhs = a*x^2 + b*x*y + c*y^2
        rhs = d*x + e*y
        
        # Manually compute dy/dx
        # Differentiating: 2ax + by + bx(dy/dx) + 2cy(dy/dx) = d + e(dy/dx)
        # Solve for dy/dx: (bx + 2cy - e)(dy/dx) = d - 2ax - by
        # dy/dx = (d - 2ax - by) / (bx + 2cy - e)
        
        dydx_num = d - 2*a*x - b*y
        dydx_den = b*x + 2*c*y - e
        dydx = dydx_num / dydx_den
        
        problem(
            question="Given the equation \\($(tex(lhs)) = $(tex(rhs))\\), find \\(\\frac{dy}{dx}\\) using implicit differentiation.",
            answer=simplify(dydx),
            difficulty=(2000, 2300),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Differentiate both sides with respect to \\(x\\), treating \\(y\\) as a function of \\(x\\)",
                "Left side: \\($(tex(diff(lhs, x)))\\)",
                "Right side: \\($(tex(diff(rhs, x)))\\)",
                "Solve for \\(\\frac{dy}{dx}\\)",
                sol("\\frac{dy}{dx}", simplify(dydx))
            ),
            time=240
        )
        
    elseif problem_type == 5
        # Logarithmic differentiation
        base_func = rand_poly(x, 2; coeff=(-5,5)).expr
        exp_func = rand_linear(x; a=(-4,4), b=(-8,8)).expr
        
        f = base_func^exp_func
        
        # For y = u^v, ln(y) = v*ln(u), so y'/y = v'/ln(u) + v*u'/u
        # y' = y * (v'*ln(u) + v*u'/u)
        
        f_prime = diff(f, x)
        f_prime_simplified = simplify(f_prime)
        
        problem(
            question="Find \\(\\frac{d}{dx}\\left[($(tex(base_func)))^{$(tex(exp_func))}\\right]\\) using logarithmic differentiation.",
            answer=f_prime_simplified,
            difficulty=(2100, 2400),
            solution=steps(
                sol("y", f),
                "Take natural log of both sides: \\(\\ln(y) = ($(tex(exp_func)))\\ln($(tex(base_func)))\\)",
                "Differentiate implicitly with respect to \\(x\\)",
                "\\(\\frac{1}{y}\\frac{dy}{dx}\\) = derivative of right side",
                "Solve for \\(\\frac{dy}{dx}\\)",
                sol("Answer", f_prime_simplified)
            ),
            time=270
        )
        
    elseif problem_type == 6
        # Higher order derivative
        order = choice([3, 4])
        poly_deg = order + randint(1, 2)
        
        coeffs = [nonzero(-6, 6) for _ in 1:poly_deg+1]
        f = sum(coeffs[i] * x^(poly_deg - i + 1) for i in 1:poly_deg+1)
        
        deriv = f
        for _ in 1:order
            deriv = diff(deriv, x)
        end
        deriv_simplified = simplify(deriv)
        
        order_str = order == 3 ? "third" : "fourth"
        order_notation = order == 3 ? "f'''(x)" : "f^{(4)}(x)"
        
        problem(
            question="Find the $(order_str) derivative \\($(order_notation)\\) of \\(f(x) = $(tex(f))\\)",
            answer=deriv_simplified,
            difficulty=(1800, 2000),
            solution=steps(
                sol("f(x)", f),
                sol("f'(x)", simplify(diff(f, x))),
                sol("f''(x)", simplify(diff(diff(f, x), x))),
                order == 3 ? sol("f'''(x)", deriv_simplified) : "Continue differentiating...",
                order == 4 ? sol("f^{(4)}(x)", deriv_simplified) : ""
            ),
            time=180
        )
        
    elseif problem_type == 7
        # Chain rule with composition of three functions
        a = nonzero(-4, 4)
        b = randint(-10, 10)
        innermost = a*x + b
        
        middle_type = choice([:square, :cube, :sqrt])
        if middle_type == :square
            middle = innermost^2
        elseif middle_type == :cube
            middle = innermost^3
        else
            middle = sqrt(abs(innermost))
        end
        
        outer_type = choice([:sin, :cos, :exp])
        if outer_type == :sin
            f = sin(middle)
        elseif outer_type == :cos
            f = cos(middle)
        else
            f = exp(middle)
        end
        
        f_prime = diff(f, x)
        f_prime_simplified = simplify(f_prime)
        
        problem(
            question="Find \\(\\frac{d}{dx}\\left[$(tex(f))\\right]\\) using the chain rule.",
            answer=f_prime_simplified,
            difficulty=(2000, 2350),
            solution=steps(
                sol("Given", f),
                "This is a composition of three functions. Apply chain rule twice.",
                "Let \\(u = $(tex(innermost))\\), then \\(v = $(tex(middle))\\), then \\(y = $(tex(f))\\)",
                sol("\\frac{du}{dx}", diff(innermost, x)),
                sol("\\frac{dv}{du}", diff(middle, innermost)),
                "Apply chain rule: \\(\\frac{dy}{dx} = \\frac{dy}{dv} \\cdot \\frac{dv}{du} \\cdot \\frac{du}{dx}\\)",
                sol("Answer", f_prime_simplified)
            ),
            time=240
        )
        
    else
        # Related rates style derivative evaluation
        q = rand_quadratic(x; a=(-5,5), b=(-8,8), c=(-15,15))
        f = q.expr
        f_prime = diff(f, x)
        
        x_val = randint(-8, 8)
        f_prime_at_x = substitute(f_prime, x => x_val)
        
        problem(
            question="Given \\(f(x) = $(tex(f))\\), find \\(f'($(x_val))\\).",
            answer=f_prime_at_x,
            difficulty=(1800, 2000),
            solution=steps(
                sol("f(x)", f),
                "Find the derivative",
                sol("f'(x)", f_prime),
                "Evaluate at \\(x = $(x_val)\\)",
                sol("f'($(x_val))", f_prime_at_x)
            ),
            time=120
        )
    end
end