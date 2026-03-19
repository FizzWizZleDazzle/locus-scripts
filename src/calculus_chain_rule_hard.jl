# calculus - chain_rule (hard)
# Generated: 2026-03-08T20:40:00.483007

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t u begin
    set_topic!("calculus/chain_rule")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Polynomial composition with chain rule
        outer_pow = randint(3, 6)
        q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-8,8))
        inner = q.expr
        f = inner^outer_pow
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        x_val = nonzero(-3, 3)
        answer = substitute(df_simplified, x => x_val)
        
        problem(
            question="Let \$f(x) = ($(tex(inner)))^{$(outer_pow)}\$. Find \$f'($(x_val))\$.",
            answer=answer,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", f),
                "Apply chain rule: \$\\frac{d}{dx}[u^{$(outer_pow)}] = $(outer_pow)u^{$(outer_pow-1)} \\cdot u'\$ where \$u = $(tex(inner))\$",
                sol("u' =", diff(inner, x)),
                sol("f'(x) =", df_simplified),
                "Evaluate at \$x = $(x_val)\$",
                sol("f'($(x_val)) =", answer)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Nested composition f(g(h(x)))
        a1 = nonzero(-5, 5)
        b1 = randint(-10, 10)
        innermost = a1*x + b1
        
        a2 = nonzero(2, 5)
        middle = innermost^a2
        
        outer_pow = randint(2, 4)
        f = middle^outer_pow
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question="Find \$\\frac{d}{dx}\\left[($(tex(innermost)))^{$(a2)}\\right]^{$(outer_pow)}\$",
            answer=df_simplified,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", f),
                "Let \$u = $(tex(innermost))\$, then \$v = u^{$(a2)}\$, so \$f = v^{$(outer_pow)}\$",
                "By chain rule: \$\\frac{df}{dx} = \\frac{df}{dv} \\cdot \\frac{dv}{du} \\cdot \\frac{du}{dx}\$",
                sol("\\frac{df}{dv} =", outer_pow * middle^(outer_pow-1)),
                sol("\\frac{dv}{du} =", a2 * innermost^(a2-1)),
                sol("\\frac{du}{dx} =", a1),
                sol("Answer", df_simplified)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Product rule combined with chain rule
        q1 = rand_quadratic(x; a=(-3,3), b=(-6,6), c=(-6,6))
        pow1 = randint(2, 4)
        term1 = q1.expr^pow1
        
        q2 = rand_linear(x; a=(-5,5), b=(-8,8))
        pow2 = randint(3, 5)
        term2 = q2.expr^pow2
        
        f = term1 * term2
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question="Find \$\\frac{d}{dx}\\left[($(tex(q1.expr)))^{$(pow1)} \\cdot ($(tex(q2.expr)))^{$(pow2)}\\right]\$",
            answer=df_simplified,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", f),
                "Apply product rule: \$(uv)' = u'v + uv'\$",
                "Let \$u = ($(tex(q1.expr)))^{$(pow1)}\$ and \$v = ($(tex(q2.expr)))^{$(pow2)}\$",
                sol("u' =", simplify(diff(term1, x))),
                sol("v' =", simplify(diff(term2, x))),
                "Combine using product rule",
                sol("Answer", df_simplified)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Quotient rule with chain rule
        q_num = rand_quadratic(x; a=(-3,3), b=(-7,7), c=(-7,7))
        pow_num = randint(2, 3)
        numerator = q_num.expr^pow_num
        
        q_den = rand_linear(x; a=(-4,4), b=(-6,6))
        pow_den = randint(2, 4)
        denominator = q_den.expr^pow_den
        
        f = numerator / denominator
        df = diff(f, x)
        df_simplified = simplify(df)
        
        problem(
            question="Find \$\\frac{d}{dx}\\left[\\frac{($(tex(q_num.expr)))^{$(pow_num)}}{($(tex(q_den.expr)))^{$(pow_den)}}\\right]\$",
            answer=df_simplified,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", f),
                "Apply quotient rule: \$\\left(\\frac{u}{v}\\right)' = \\frac{u'v - uv'}{v^2}\$",
                "Let \$u = ($(tex(q_num.expr)))^{$(pow_num)}\$ and \$v = ($(tex(q_den.expr)))^{$(pow_den)}\$",
                sol("u' =", simplify(diff(numerator, x))),
                sol("v' =", simplify(diff(denominator, x))),
                "Apply quotient rule and simplify",
                sol("Answer", df_simplified)
            ),
            time=300
        )
        
    else
        # Complex chain rule with high powers
        a = nonzero(-4, 4)
        b = randint(-12, 12)
        c = randint(-12, 12)
        inner_poly = a*x^2 + b*x + c
        
        middle_pow = randint(3, 5)
        middle = inner_poly^middle_pow
        
        outer_pow = randint(2, 3)
        f = middle^outer_pow
        
        df = diff(f, x)
        df_simplified = simplify(df)
        
        x_val = choice([-2, -1, 0, 1, 2])
        answer_val = substitute(df_simplified, x => x_val)
        
        problem(
            question="Let \$g(x) = \\left[($(tex(inner_poly)))^{$(middle_pow)}\\right]^{$(outer_pow)}\$. Evaluate \$g'($(x_val))\$.",
            answer=answer_val,
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", f),
                "Apply chain rule twice: outer derivative times middle derivative times inner derivative",
                "Outer: \$$(outer_pow) \\cdot \\text{(middle)}^{$(outer_pow-1)}\$",
                "Middle: \$$(middle_pow) \\cdot ($(tex(inner_poly)))^{$(middle_pow-1)}\$",
                "Inner: \$$(tex(diff(inner_poly, x)))\$",
                sol("g'(x) =", df_simplified),
                "Substitute \$x = $(x_val)\$",
                sol("g'($(x_val)) =", answer_val)
            ),
            time=300
        )
    end
end