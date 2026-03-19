# differential_equations - laplace_transforms (easy)
# Generated: 2026-03-08T20:56:23.091497

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script s t begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Basic Laplace transform of polynomial
        degree = choice(1:3)
        if degree == 1
            a = nonzero(-8, 8)
            b = randint(-15, 15)
            f_expr = a*t + b
            # L{at + b} = a/s^2 + b/s
            laplace_expr = a/s^2 + b/s
            
            problem(
                question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
                answer=laplace_expr,
                difficulty=(700, 900),
                solution=steps(
                    sol("Given", f_expr),
                    "Use linearity: \$\\mathcal{L}\\{at + b\\} = a\\mathcal{L}\\{t\\} + b\\mathcal{L}\\{1\\}\$",
                    "Apply formulas: \$\\mathcal{L}\\{t\\} = \\frac{1}{s^2}\$, \$\\mathcal{L}\\{1\\} = \\frac{1}{s}\$",
                    sol("Answer", laplace_expr)
                ),
                time=90,
                calculator="none"
            )
        elseif degree == 2
            a = nonzero(-5, 5)
            b = nonzero(-8, 8)
            c = randint(-12, 12)
            f_expr = a*t^2 + b*t + c
            # L{at^2 + bt + c} = 2a/s^3 + b/s^2 + c/s
            laplace_expr = 2*a/s^3 + b/s^2 + c/s
            
            problem(
                question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
                answer=laplace_expr,
                difficulty=(800, 1000),
                solution=steps(
                    sol("Given", f_expr),
                    "Use linearity and apply formulas: \$\\mathcal{L}\\{t^2\\} = \\frac{2}{s^3}\$, \$\\mathcal{L}\\{t\\} = \\frac{1}{s^2}\$, \$\\mathcal{L}\\{1\\} = \\frac{1}{s}\$",
                    sol("\\mathcal{L}\\{f(t)\\}", laplace_expr)
                ),
                time=120,
                calculator="none"
            )
        else
            a = nonzero(-4, 4)
            f_expr = a*t^3
            # L{at^3} = 6a/s^4
            laplace_expr = 6*a/s^4
            
            problem(
                question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
                answer=laplace_expr,
                difficulty=(750, 950),
                solution=steps(
                    sol("Given", f_expr),
                    "Use formula: \$\\mathcal{L}\\{t^n\\} = \\frac{n!}{s^{n+1}}\$ with \$n=3\$",
                    "Calculate: \$\\mathcal{L}\\{t^3\\} = \\frac{6}{s^4}\$",
                    sol("Answer", laplace_expr)
                ),
                time=90,
                calculator="none"
            )
        end
        
    elseif problem_type == 2
        # Laplace transform of exponential
        a = nonzero(-6, 6)
        k = nonzero(-5, 5)
        f_expr = a * exp(k*t)
        # L{a*e^(kt)} = a/(s-k)
        laplace_expr = a/(s - k)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_expr,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", f_expr),
                "Use formula: \$\\mathcal{L}\\{e^{at}\\} = \\frac{1}{s-a}\$",
                "Apply with \$a = $(k)\$",
                sol("\\mathcal{L}\\{f(t)\\}", laplace_expr)
            ),
            time=75,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Inverse Laplace transform - simple fraction
        a = nonzero(-10, 10)
        k = nonzero(-5, 5)
        if choice([true, false])
            # a/(s-k) -> a*e^(kt)
            laplace_expr = a/(s - k)
            f_expr = a * exp(k*t)
            formula_text = "Use: \$\\mathcal{L}^{-1}\\left\\{\\frac{1}{s-a}\\right\\} = e^{at}\$"
        else
            # a/s^n -> a*t^(n-1)/(n-1)!
            n = choice(2:4)
            laplace_expr = a/s^n
            if n == 2
                f_expr = a*t
                factorial_text = ""
            elseif n == 3
                f_expr = a*t^2/2
                factorial_text = " and \$2! = 2\$"
            else
                f_expr = a*t^3/6
                factorial_text = " and \$3! = 6\$"
            end
            formula_text = "Use: \$\\mathcal{L}^{-1}\\left\\{\\frac{1}{s^n}\\right\\} = \\frac{t^{n-1}}{(n-1)!}\$ with \$n=$(n)\$" * factorial_text
        end
        
        problem(
            question="Find the inverse Laplace transform of \$F(s) = $(tex(laplace_expr))\$",
            answer=f_expr,
            difficulty=(750, 1000),
            solution=steps(
                sol("Given", laplace_expr),
                formula_text,
                sol("f(t)", f_expr)
            ),
            time=90,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Linear combination
        a = nonzero(-8, 8)
        b = nonzero(-10, 10)
        k = nonzero(-5, 5)
        f_expr = a*exp(k*t) + b
        # L{a*e^(kt) + b} = a/(s-k) + b/s
        laplace_expr = a/(s - k) + b/s
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_expr,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", f_expr),
                "Apply linearity: \$\\mathcal{L}\\{f + g\\} = \\mathcal{L}\\{f\\} + \\mathcal{L}\\{g\\}\$",
                "Use \$\\mathcal{L}\\{e^{at}\\} = \\frac{1}{s-a}\$ and \$\\mathcal{L}\\{1\\} = \\frac{1}{s}\$",
                sol("\\mathcal{L}\\{f(t)\\}", laplace_expr)
            ),
            time=120,
            calculator="none"
        )
        
    else
        # Polynomial + exponential
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        k = nonzero(-4, 4)
        f_expr = a*t + b*exp(k*t)
        # L{at + b*e^(kt)} = a/s^2 + b/(s-k)
        laplace_expr = a/s^2 + b/(s - k)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_expr,
            difficulty=(950, 1200),
            solution=steps(
                sol("Given", f_expr),
                "Apply linearity of Laplace transform",
                "Use \$\\mathcal{L}\\{t\\} = \\frac{1}{s^2}\$ and \$\\mathcal{L}\\{e^{at}\\} = \\frac{1}{s-a}\$",
                sol("\\mathcal{L}\\{f(t)\\}", laplace_expr)
            ),
            time=150,
            calculator="none"
        )
    end
end