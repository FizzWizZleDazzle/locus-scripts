# calculus - u_substitution (hard)
# Generated: 2026-03-08T20:45:44.694342

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: ∫ f'(x) * [f(x)]^n dx where f(x) is polynomial
        n = choice([2, 3, 4, 5, 6])
        inner = rand_linear(x; a=(-8, 8), b=(-15, 15))
        a_inner = inner.a
        
        # Build integrand: a_inner * (inner.expr)^n
        integrand = a_inner * (inner.expr)^n
        
        # Answer: (inner.expr)^(n+1) / (n+1) + C
        antideriv = (inner.expr)^(n+1) / (n+1)
        
        problem(
            question = "Evaluate \\\$\\displaystyle \\int $(tex(integrand)) \\, dx\\\$",
            answer = antideriv,
            difficulty = (1800, 2000),
            solution = steps(
                sol("Given", integrand),
                "Let \\\$u = $(tex(inner.expr))\\\$, then \\\$du = $(tex(a_inner)) \\, dx\\\$",
                "The integral becomes \\\$\\int u^{$n} \\, du = \\frac{u^{$(n+1)}}{$(n+1)} + C\\\$",
                "Substituting back: " * sol(antideriv),
            ),
            time = 120,
        )
        
    elseif problem_type == 2
        # Type 2: ∫ x^m * (ax^n + b)^p dx where substitution works cleanly
        p = choice([3, 4, 5])
        n = choice([2, 3])
        m = n - 1  # Makes x^m dx = (1/n) du
        
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        inner_expr = a * x^n + b
        integrand = x^m * inner_expr^p
        
        # u = a*x^n + b, du = n*a*x^(n-1) dx, so x^(n-1) dx = du/(n*a)
        antideriv = inner_expr^(p+1) / ((p+1) * n * a)
        
        problem(
            question = "Evaluate \\\$\\displaystyle \\int $(tex(integrand)) \\, dx\\\$",
            answer = antideriv,
            difficulty = (1900, 2100),
            solution = steps(
                sol("Given", integrand),
                "Let \\\$u = $(tex(inner_expr))\\\$, then \\\$du = $(tex(n * a * x^(n-1))) \\, dx\\\$",
                "So \\\$$(tex(x^m)) \\, dx = \\frac{1}{$(n*a)} \\, du\\\$",
                "The integral becomes \\\$\\frac{1}{$(n*a)} \\int u^{$p} \\, du = \\frac{u^{$(p+1)}}{$(n*a*(p+1))} + C\\\$",
                sol("Answer", antideriv),
            ),
            time = 180,
        )
        
    elseif problem_type == 3
        # Type 3: ∫ (ax+b)^n / (cx+d) dx where clever substitution needed
        # Actually do ∫ (ax+b)^n dx with n negative (rational function)
        n = choice([-2, -3, -4])
        inner = rand_linear(x; a=(-7, 7), b=(-15, 15))
        a_inner = inner.a
        
        integrand = (inner.expr)^n
        
        if n == -1
            antideriv = simplify(log(abs(inner.expr)) / a_inner)
        else
            antideriv = simplify((inner.expr)^(n+1) / ((n+1) * a_inner))
        end
        
        problem(
            question = "Evaluate \\\$\\displaystyle \\int $(tex(integrand)) \\, dx\\\$",
            answer = antideriv,
            difficulty = (1850, 2050),
            solution = steps(
                sol("Given", integrand),
                "Let \\\$u = $(tex(inner.expr))\\\$, then \\\$du = $(tex(a_inner)) \\, dx\\\$",
                n == -1 ? "The integral becomes \\\$\\frac{1}{$a_inner} \\int \\frac{1}{u} \\, du = \\frac{\\ln|u|}{$a_inner} + C\\\$" : "The integral becomes \\\$\\frac{1}{$a_inner} \\int u^{$n} \\, du = \\frac{u^{$(n+1)}}{$(a_inner*(n+1))} + C\\\$",
                sol("Answer", antideriv),
            ),
            time = 150,
        )
        
    elseif problem_type == 4
        # Type 4: ∫ polynomial / sqrt(linear) dx
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        coef = nonzero(-10, 10)
        
        inner_expr = a * x + b
        integrand = coef * x / sqrt(inner_expr)
        
        # u = ax + b, x = (u - b)/a, dx = du/a
        # ∫ coef * (u-b)/a * u^(-1/2) * (1/a) du = (coef/a^2) ∫ (u^(1/2) - b*u^(-1/2)) du
        # = (coef/a^2) * [2u^(3/2)/3 - 2b*u^(1/2)] = (2*coef/a^2) * [u^(3/2)/3 - b*u^(1/2)]
        
        antideriv = simplify((2*coef/(a^2)) * (inner_expr^(3//2) / 3 - b * sqrt(inner_expr)))
        
        problem(
            question = "Evaluate \\\$\\displaystyle \\int $(tex(integrand)) \\, dx\\\$",
            answer = antideriv,
            difficulty = (2000, 2200),
            solution = steps(
                sol("Given", integrand),
                "Let \\\$u = $(tex(inner_expr))\\\$, then \\\$x = \\frac{u - $b}{$a}\\\$ and \\\$dx = \\frac{1}{$a} \\, du\\\$",
                "Substitute to get \\\$\\frac{$coef}{$a} \\int \\frac{u - $b}{$a \\sqrt{u}} \\, du\\\$",
                "Simplify and integrate term by term",
                sol("Answer", antideriv),
            ),
            time = 240,
        )
        
    else
        # Type 5: Challenging composition with quadratic inside
        p = choice([2, 3, 4])
        quad = rand_quadratic(x; a=(-4, 4), b=(-8, 8), c=(-10, 10))
        a_quad = quad.a
        b_quad = quad.b
        
        # ∫ (2ax + b) * [ax^2 + bx + c]^p dx
        derivative_inner = 2 * a_quad * x + b_quad
        integrand = derivative_inner * (quad.expr)^p
        
        antideriv = (quad.expr)^(p+1) / (p+1)
        
        problem(
            question = "Evaluate \\\$\\displaystyle \\int $(tex(integrand)) \\, dx\\\$",
            answer = antideriv,
            difficulty = (2100, 2400),
            solution = steps(
                sol("Given", integrand),
                "Notice that \\\$$(tex(derivative_inner))\\\$ is the derivative of \\\$$(tex(quad.expr))\\\$",
                "Let \\\$u = $(tex(quad.expr))\\\$, then \\\$du = $(tex(derivative_inner)) \\, dx\\\$",
                "The integral becomes \\\$\\int u^{$p} \\, du = \\frac{u^{$(p+1)}}{$(p+1)} + C\\\$",
                sol("Answer", antideriv),
            ),
            time = 180,
        )
    end
end