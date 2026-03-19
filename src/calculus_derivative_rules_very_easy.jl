# calculus - derivative_rules (very_easy)
# Generated: 2026-03-08T20:38:37.831424

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Constant function derivative (ELO 100-300)
        c = randint(-50, 50)
        question_text = "Find the derivative of \$f(x) = $(c)\$"
        ans = 0
        diff_range = (100, 300)
        sol_text = steps(
            sol("Given", c),
            "The derivative of any constant is zero",
            sol("Answer", ans)
        )
        
    elseif problem_type == 2
        # Power rule on monomial (ELO 200-500)
        coef = nonzero(-15, 15)
        n = randint(2, 8)
        f = coef * x^n
        df = diff(f, x)
        question_text = "Find \$\\frac{d}{dx}[$(tex(f))]\$"
        ans = df
        diff_range = (200, 500)
        sol_text = steps(
            sol("Given", f),
            "Apply the power rule: \$\\frac{d}{dx}[x^n] = nx^{n-1}\$",
            sol("Answer", df)
        )
        
    elseif problem_type == 3
        # Linear function derivative (ELO 300-600)
        q = rand_linear(x; a=(-20, 20), b=(-30, 30))
        df = diff(q.expr, x)
        question_text = "Find the derivative of \$f(x) = $(tex(q.expr))\$"
        ans = df
        diff_range = (300, 600)
        sol_text = steps(
            sol("Given", q.expr),
            "Apply power rule to each term",
            "The derivative of \$x\$ is 1, the derivative of a constant is 0",
            sol("Answer", df)
        )
        
    elseif problem_type == 4
        # Quadratic derivative (ELO 400-700)
        q = rand_quadratic(x; a=(-12, 12), b=(-20, 20), c=(-30, 30))
        df = diff(q.expr, x)
        question_text = "Find \$f'(x)\$ if \$f(x) = $(tex(q.expr))\$"
        ans = df
        diff_range = (400, 700)
        sol_text = steps(
            sol("Given", q.expr),
            "Apply the power rule to each term",
            "\$\\frac{d}{dx}[$(q.a)x^2] = $(2*q.a)x\$, \$\\frac{d}{dx}[$(q.b)x] = $(q.b)\$, \$\\frac{d}{dx}[$(q.c)] = 0\$",
            sol("Answer", df)
        )
        
    elseif problem_type == 5
        # Sum of power functions (ELO 400-650)
        c1 = nonzero(-10, 10)
        c2 = nonzero(-10, 10)
        n1 = randint(3, 7)
        n2 = randint(2, 6)
        while n2 == n1
            n2 = randint(2, 6)
        end
        f = c1 * x^n1 + c2 * x^n2
        df = diff(f, x)
        question_text = "Differentiate \$y = $(tex(f))\$"
        ans = df
        diff_range = (400, 650)
        sol_text = steps(
            sol("Given", f),
            "Apply the power rule to each term separately",
            sol("Answer", df)
        )
        
    else
        # Polynomial derivative (ELO 500-700)
        p = rand_poly(x, 3; coeff=(-8, 8))
        df = diff(p.expr, x)
        question_text = "Find \$\\frac{dy}{dx}\$ for \$y = $(tex(p.expr))\$"
        ans = df
        diff_range = (500, 700)
        sol_text = steps(
            sol("Given", p.expr),
            "Use the power rule on each term: \$\\frac{d}{dx}[x^n] = nx^{n-1}\$",
            "Sum the derivatives of each term",
            sol("Answer", df)
        )
    end
    
    problem(
        question=question_text,
        answer=ans,
        difficulty=diff_range,
        solution=sol_text,
        time=60,
        calculator="none"
    )
end