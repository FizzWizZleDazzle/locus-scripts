# calculus - chain_rule (very_hard)
# Generated: 2026-03-08T20:40:14.498093

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t u begin
    set_topic!("calculus/chain_rule")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Nested composition with polynomial and trig - AMC/AIME level
        inner_power = randint(3, 7)
        outer_power = randint(3, 6)
        a = nonzero(-8, 12)
        b = nonzero(-15, 15)
        
        inner = a*x^inner_power + b
        f = (sin(inner))^outer_power
        
        # Apply chain rule multiple times
        df_inner = diff(inner, x)
        df = outer_power * (sin(inner))^(outer_power - 1) * cos(inner) * df_inner
        df_simplified = simplify(df)
        
        problem(
            question = "Let \$f(x) = $(tex(f))\$. Find \$f'(x)\$.",
            answer = df_simplified,
            difficulty = (2500, 2800),
            solution = steps(
                sol("Given", f),
                "Let \$u = $(tex(inner))\$, so \$f(x) = (\\sin(u))^{$(outer_power)}\$",
                sol("Chain rule (outer)", "$(outer_power)(\\sin(u))^{$(outer_power-1)} \\cdot \\cos(u) \\cdot \\frac{du}{dx}"),
                sol("\\frac{du}{dx}", df_inner),
                sol("f'(x)", df_simplified)
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # Implicit differentiation with multiple chain rules - USAMO style
        m = randint(3, 6)
        n = randint(3, 6)
        k = nonzero(-12, 12)
        c = nonzero(-20, 20)
        
        # Equation: sin^m(xy) + cos^n(x^2 + y^2) = k
        @variables y
        lhs = (sin(x*y))^m + (cos(x^2 + y^2))^n
        
        # Implicit differentiation
        # d/dx[sin^m(xy)] = m*sin^(m-1)(xy)*cos(xy)*(y + x*dy/dx)
        # d/dx[cos^n(x^2+y^2)] = n*cos^(n-1)(x^2+y^2)*(-sin(x^2+y^2))*(2x + 2y*dy/dx)
        
        question_text = "Given the implicit equation \$$(tex(lhs)) = $(k)\$, find \$\\frac{dy}{dx}\$ at a point where the equation holds."
        
        # The derivative dy/dx in terms of x and y
        answer_text = "\\frac{dy}{dx} = -\\frac{$(m)\\sin^{$(m-1)}(xy)\\cos(xy)\\cdot y - $(n)\\cos^{$(n-1)}(x^2+y^2)\\sin(x^2+y^2)\\cdot 2x}{$(m)\\sin^{$(m-1)}(xy)\\cos(xy)\\cdot x - $(n)\\cos^{$(n-1)}(x^2+y^2)\\sin(x^2+y^2)\\cdot 2y}"
        
        problem(
            question = question_text,
            answer = answer_text,
            difficulty = (3200, 3500),
            solution = steps(
                sol("Implicit equation", "$(tex(lhs)) = $(k)"),
                "Differentiate both sides with respect to \$x\$:",
                sol("LHS derivative", "$(m)\\sin^{$(m-1)}(xy)\\cos(xy)(y + x\\frac{dy}{dx}) - $(n)\\cos^{$(n-1)}(x^2+y^2)\\sin(x^2+y^2)(2x + 2y\\frac{dy}{dx}) = 0"),
                "Collect terms with \$\\frac{dy}{dx}\$:",
                sol("Final answer", answer_text)
            ),
            time = 300,
            grading_mode = "expression"
        )
        
    elseif problem_type == 3
        # Exponential composition with nested functions - Competition level
        a = nonzero(-5, 8)
        b = nonzero(-10, 10)
        c = nonzero(2, 7)
        inner_exp = randint(2, 5)
        
        inner_func = a*x^inner_exp + b
        outer_base = c
        f = outer_base^(sin(inner_func))
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question = "Find \$\\frac{d}{dx}\\left[$(tex(f))\\right]\$.",
            answer = df_simplified,
            difficulty = (2600, 2900),
            solution = steps(
                sol("Given", f),
                "Let \$u = \\sin($(tex(inner_func)))\$, so \$f(x) = $(c)^u\$",
                sol("Chain rule", "$(c)^u \\ln($(c)) \\cdot \\frac{du}{dx}"),
                sol("\\frac{du}{dx}", "\\cos($(tex(inner_func))) \\cdot $(tex(diff(inner_func, x)))"),
                sol("f'(x)", df_simplified)
            ),
            time = 270
        )
        
    elseif problem_type == 4
        # Product rule with multiple chain rules - Olympiad difficulty
        m = randint(3, 6)
        n = randint(3, 6)
        p = randint(2, 5)
        a = nonzero(-7, 7)
        b = nonzero(-12, 12)
        
        g1 = (cos(a*x + b))^m
        g2 = (sin(x^p))^n
        f = g1 * g2
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question = "Compute \$\\frac{d}{dx}\\left[$(tex(f))\\right]\$.",
            answer = df_simplified,
            difficulty = (2800, 3200),
            solution = steps(
                sol("Given", f),
                "Apply product rule: \$(uv)' = u'v + uv'\$",
                sol("u", g1),
                sol("u'", simplify(diff(g1, x))),
                sol("v", g2),
                sol("v'", simplify(diff(g2, x))),
                sol("f'(x)", df_simplified)
            ),
            time = 300
        )
        
    else
        # Triple composition - deep chain rule
        a = nonzero(-6, 6)
        b = nonzero(-10, 10)
        inner_pow = randint(3, 5)
        mid_pow = randint(2, 4)
        outer_pow = randint(2, 4)
        
        innermost = a*x^inner_pow + b
        middle = (tan(innermost))^mid_pow
        f = (middle)^outer_pow
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question = "Let \$f(x) = \\left[(\\tan($(tex(innermost))))^{$(mid_pow)}\\right]^{$(outer_pow)}\$. Find \$f'(x)\$.",
            answer = df_simplified,
            difficulty = (3000, 3400),
            solution = steps(
                sol("Given", f),
                "Let \$w = $(tex(innermost))\$, \$u = (\\tan(w))^{$(mid_pow)}\$, \$f = u^{$(outer_pow)}\$",
                sol("\\frac{df}{du}", "$(outer_pow)u^{$(outer_pow-1)}"),
                sol("\\frac{du}{dw}", "$(mid_pow)(\\tan(w))^{$(mid_pow-1)} \\sec^2(w)"),
                sol("\\frac{dw}{dx}", diff(innermost, x)),
                "Apply chain rule: \$\\frac{df}{dx} = \\frac{df}{du} \\cdot \\frac{du}{dw} \\cdot \\frac{dw}{dx}\$",
                sol("f'(x)", df_simplified)
            ),
            time = 300
        )
    end
end