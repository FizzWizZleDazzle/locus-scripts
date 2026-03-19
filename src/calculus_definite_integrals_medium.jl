# calculus - definite_integrals (medium)
# Generated: 2026-03-08T20:47:06.612344

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Polynomial integral (1200-1400)
        q = rand_quadratic(x; a=(-8,8), b=(-15,15), c=(-20,20))
        a_lim = randint(-10, 5)
        b_lim = a_lim + randint(3, 12)
        
        antideriv = simplify(expand(q.a * x^3 // 3 + q.b * x^2 // 2 + q.c * x))
        upper_val = substitute(antideriv, x => b_lim)
        lower_val = substitute(antideriv, x => a_lim)
        ans = upper_val - lower_val
        
        problem(
            question="Evaluate \\\$\\int_{$(a_lim)}^{$(b_lim)} ($(tex(q.expr))) \\, dx\\\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given integral", "\\int_{$(a_lim)}^{$(b_lim)} ($(tex(q.expr))) \\, dx"),
                sol("Antiderivative", antideriv),
                "Evaluate from $(a_lim) to $(b_lim): \\\$[$(tex(antideriv))]_{$(a_lim)}^{$(b_lim)}\\\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Power rule with fractional exponents (1300-1500)
        n = choice([3, 4, 5])
        coeff = nonzero(-8, 8)
        a_lim = randint(1, 8)
        b_lim = a_lim + randint(8, 20)
        
        expr = coeff * x^(1//n)
        antideriv = coeff * n * x^((n+1)//n) // (n + 1)
        antideriv_simplified = simplify(antideriv)
        
        upper_val = substitute(antideriv_simplified, x => b_lim)
        lower_val = substitute(antideriv_simplified, x => a_lim)
        ans = upper_val - lower_val
        
        problem(
            question="Evaluate \\\$\\int_{$(a_lim)}^{$(b_lim)} $(tex(expr)) \\, dx\\\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given integral", "\\int_{$(a_lim)}^{$(b_lim)} $(tex(expr)) \\, dx"),
                "Use power rule: \\\$\\int x^{1/$(n)} dx = \\frac{$(n)}{$(n+1)} x^{$(n+1)/$(n)}\\\$",
                sol("Antiderivative", antideriv_simplified),
                "Evaluate: \\\$[$(tex(antideriv_simplified))]_{$(a_lim)}^{$(b_lim)}\\\$",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Definite integral requiring u-substitution setup (1400-1600)
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        power = randint(2, 5)
        a_lim = randint(-8, 3)
        b_lim = a_lim + randint(4, 10)
        
        inner = a * x + b
        expr = expand(inner^power * a)
        antideriv = simplify(expand((a*x + b)^(power + 1) // (power + 1)))
        
        upper_val = substitute(antideriv, x => b_lim)
        lower_val = substitute(antideriv, x => a_lim)
        ans = upper_val - lower_val
        
        problem(
            question="Evaluate \\\$\\int_{$(a_lim)}^{$(b_lim)} $(tex(expr)) \\, dx\\\$",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given integral", "\\int_{$(a_lim)}^{$(b_lim)} $(tex(expr)) \\, dx"),
                "Use substitution \\\$u = $(tex(inner))\\\$, \\\$du = $(a) dx\\\$",
                sol("Antiderivative", antideriv),
                "Evaluate: \\\$[$(tex(antideriv))]_{$(a_lim)}^{$(b_lim)}\\\$",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Area between curve and x-axis (1500-1700)
        r1 = randint(-8, -1)
        r2 = randint(2, 10)
        a = choice([-1, 1])
        
        expr = expand(a * (x - r1) * (x - r2))
        antideriv = simplify(expand(a * x^3 // 3 - a*(r1 + r2) * x^2 // 2 + a*r1*r2 * x))
        
        upper_val = substitute(antideriv, x => r2)
        lower_val = substitute(antideriv, x => r1)
        area = abs(upper_val - lower_val)
        
        problem(
            question="Find the area between the curve \\\$y = $(tex(expr))\\\$ and the x-axis from \\\$x = $(r1)\\\$ to \\\$x = $(r2)\\\$.",
            answer=area,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given function", expr),
                "The curve crosses the x-axis at \\\$x = $(r1)\\\$ and \\\$x = $(r2)\\\$",
                sol("Area", "\\left|\\int_{$(r1)}^{$(r2)} $(tex(expr)) \\, dx\\right|"),
                sol("Antiderivative", antideriv),
                "Evaluate and take absolute value",
                sol("Answer", area)
            ),
            time=210
        )
        
    else
        # Net change with velocity function (1600-1800)
        q = rand_quadratic(x; a=(-6,6), b=(-12,12), c=(-15,15))
        t_start = 0
        t_end = randint(4, 10)
        
        position_expr = simplify(expand(q.a * x^3 // 3 + q.b * x^2 // 2 + q.c * x))
        upper_val = substitute(position_expr, x => t_end)
        lower_val = substitute(position_expr, x => t_start)
        displacement = upper_val - lower_val
        
        problem(
            question="A particle moves along a line with velocity \\\$v(t) = $(tex(q.expr))\\\$ m/s. Find the displacement of the particle from \\\$t = $(t_start)\\\$ to \\\$t = $(t_end)\\\$ seconds.",
            answer=displacement,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Velocity function", "v(t) = $(tex(q.expr))"),
                "Displacement = \\\$\\int_{$(t_start)}^{$(t_end)} v(t) \\, dt\\\$",
                sol("Position function", "s(t) = $(tex(position_expr))"),
                "Evaluate: \\\$s($(t_end)) - s($(t_start))\\\$",
                sol("Displacement", "$(displacement) meters")
            ),
            time=180
        )
    end
end