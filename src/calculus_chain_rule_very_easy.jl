# calculus - chain_rule (very_easy)
# Generated: 2026-03-08T20:39:31.223820

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/chain_rule")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify outer and inner functions (conceptual, foundational)
        # ELO: 200-400
        outer_type = choice(["polynomial", "exponential", "trig"])
        
        if outer_type == "polynomial"
            n = randint(2, 4)
            inner = rand_linear(x; a=(-5,5), b=(-5,5))
            expr = inner.expr^n
            outer_latex = "u^{$n}"
            inner_latex = tex(inner.expr)
        elseif outer_type == "exponential"
            base = choice([2, 3, 5])
            inner = rand_linear(x; a=(-3,3), b=(-5,5))
            expr = base^(inner.expr)
            outer_latex = "$(base)^u"
            inner_latex = tex(inner.expr)
        else  # trig
            inner = rand_linear(x; a=(-3,3), b=(-5,5))
            trig_fn = choice(["sin", "cos"])
            if trig_fn == "sin"
                expr = sin(inner.expr)
                outer_latex = "\\sin(u)"
            else
                expr = cos(inner.expr)
                outer_latex = "\\cos(u)"
            end
            inner_latex = tex(inner.expr)
        end
        
        question = "For the function \$f(x) = $(tex(expr))\$, identify the outer function and inner function for the chain rule. Enter your answer as: outer function, inner function"
        answer = "$outer_latex, $inner_latex"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(200, 400),
            answer_type="expression",
            solution=steps(
                sol("Given function", expr),
                "The chain rule states that if \$f(x) = g(h(x))\$, then \$f'(x) = g'(h(x)) \\cdot h'(x)\$",
                "Outer function: \$$outer_latex\$",
                sol("Inner function", inner_latex)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Simple chain rule with power of linear function
        # ELO: 400-600
        n = randint(2, 5)
        inner = rand_linear(x; a=(-8,8), b=(-12,12))
        expr = inner.expr^n
        
        # Derivative
        inner_deriv = diff(inner.expr, x)
        df = diff(expr, x)
        
        question = "Find the derivative: \$\\frac{d}{dx}\\left[$(tex(expr))\\right]\$"
        answer = df
        
        problem(
            question=question,
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", expr),
                "Using the chain rule: \$\\frac{d}{dx}[u^{$n}] = $(n)u^{$(n-1)} \\cdot \\frac{du}{dx}\$",
                "Here \$u = $(tex(inner.expr))\$, so \$\\frac{du}{dx} = $(tex(inner_deriv))\$",
                sol("Answer", df)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Type 3: Chain rule with square root (foundational practice)
        # ELO: 500-700
        inner = rand_quadratic(x; a=(-3,3), b=(-8,8), c=(1,20))
        # Ensure discriminant is positive for real values
        if inner.b^2 - 4*inner.a*inner.c < 0
            inner = rand_linear(x; a=(1,8), b=(1,20))
        end
        
        expr = sqrt(inner.expr)
        df = diff(expr, x)
        
        question = "Find the derivative: \$\\frac{d}{dx}\\left[\\sqrt{$(tex(inner.expr))}\\right]\$"
        answer = df
        
        problem(
            question=question,
            answer=answer,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", expr),
                "Rewrite as: \$($(tex(inner.expr)))^{1/2}\$",
                "Using chain rule: \$\\frac{d}{dx}[u^{1/2}] = \\frac{1}{2}u^{-1/2} \\cdot \\frac{du}{dx}\$",
                "Where \$u = $(tex(inner.expr))\$ and \$\\frac{du}{dx} = $(tex(diff(inner.expr, x)))\$",
                sol("Answer", df)
            ),
            time=120
        )
        
    else
        # Type 4: Evaluate derivative at a point (elementary computation)
        # ELO: 600-700
        n = randint(2, 4)
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        inner_expr = a*x + b
        expr = inner_expr^n
        
        x_val = randint(-3, 3)
        df = diff(expr, x)
        df_at_x = substitute(df, x => x_val)
        
        question = "Find \$f'($(x_val))\$ if \$f(x) = $(tex(expr))\$"
        answer = df_at_x
        
        problem(
            question=question,
            answer=answer,
            difficulty=(600, 700),
            solution=steps(
                sol("Given", expr),
                "Find the derivative using chain rule: \$f'(x) = $(tex(df))\$",
                "Substitute \$x = $(x_val)\$: \$f'($(x_val)) = $(tex(df_at_x))\$",
                sol("Answer", df_at_x)
            ),
            time=90
        )
    end
end