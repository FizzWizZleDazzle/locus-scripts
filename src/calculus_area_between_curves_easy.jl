# calculus - area_between_curves (easy)
# Generated: 2026-03-08T20:47:52.611649

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/area_between_curves")
    
    # Choose problem type
    prob_type = choice(1:3)
    
    if prob_type == 1
        # Type 1: Linear function above linear function (ELO 700-900)
        # f(x) = ax + b (upper), g(x) = cx + d (lower)
        a = randint(1, 5)
        b = randint(2, 8)
        c = randint(-3, 0)
        d = randint(-5, -1)
        
        f_expr = a*x + b
        g_expr = c*x + d
        
        # Intersection points
        x_left = randint(0, 3)
        x_right = randint(x_left + 2, x_left + 5)
        
        # Area = integral from x_left to x_right of (f - g) dx
        diff_expr = expand(f_expr - g_expr)
        integrand_a = a - c
        integrand_b = b - d
        
        # Integral of (integrand_a * x + integrand_b)
        area = integrand_a * (x_right^2 - x_left^2) // 2 + integrand_b * (x_right - x_left)
        
        problem(
            question = "Find the area between \\(f(x) = $(tex(f_expr))\\) and \\(g(x) = $(tex(g_expr))\\) from \\(x = $(x_left)\\) to \\(x = $(x_right)\\).",
            answer = area,
            difficulty = (700, 900),
            solution = steps(
                "Find the difference: \\(f(x) - g(x) = $(tex(diff_expr))\\)",
                "Set up integral: \\(A = \\int_{$(x_left)}^{$(x_right)} ($(tex(diff_expr))) \\, dx\\)",
                "Integrate: \\(A = \\left[\\frac{$(integrand_a)}{2}x^2 + $(integrand_b)x\\right]_{$(x_left)}^{$(x_right)}\\)",
                "Evaluate: \\(A = $(tex(area))\\)",
                sol("Answer", area)
            ),
            time = 90
        )
        
    elseif prob_type == 2
        # Type 2: Quadratic above linear (ELO 850-1050)
        # f(x) = -a(x-h)^2 + k (parabola opening down), g(x) = c (horizontal line)
        a_val = randint(1, 3)
        h = randint(-2, 2)
        k = randint(5, 10)
        c = randint(0, 3)
        
        # Find intersection points: -a(x-h)^2 + k = c
        # (x-h)^2 = (k-c)/a
        delta = k - c
        sqrt_term = isqrt(delta // a_val)
        x1 = h - sqrt_term
        x2 = h + sqrt_term
        
        f_expr = expand(-a_val*(x - h)^2 + k)
        g_expr = c
        
        # Area = integral of (-a(x-h)^2 + k - c) from x1 to x2
        # = integral of (-a(x-h)^2 + delta) from x1 to x2
        # By symmetry around h: 2 * integral from h to x2
        width = x2 - x1
        area = 2 * a_val * sqrt_term^3 // 3 + delta * width
        
        problem(
            question = "Find the area between \\(f(x) = $(tex(f_expr))\\) and \\(g(x) = $(c)\\) from \\(x = $(x1)\\) to \\(x = $(x2)\\).",
            answer = area,
            difficulty = (850, 1050),
            solution = steps(
                "Find the difference: \\(f(x) - g(x) = $(tex(expand(f_expr - c)))\\)",
                "Set up integral: \\(A = \\int_{$(x1)}^{$(x2)} ($(tex(expand(f_expr - c)))) \\, dx\\)",
                "Integrate and evaluate using the power rule",
                "By symmetry and calculation: \\(A = $(tex(area))\\)",
                sol("Answer", area)
            ),
            time = 120
        )
        
    else
        # Type 3: Simple polynomial curves (ELO 900-1200)
        # f(x) = x^2, g(x) = ax where a > 0, intersect at 0 and a
        a_val = randint(2, 6)
        
        f_expr = x^2
        g_expr = a_val * x
        
        x1 = 0
        x2 = a_val
        
        # Area = integral from 0 to a of (ax - x^2) dx
        # = [ax^2/2 - x^3/3] from 0 to a
        # = a*a^2/2 - a^3/3 = a^3/2 - a^3/3 = a^3/6
        area = a_val^3 // 6
        
        problem(
            question = "Find the area enclosed by \\(f(x) = $(tex(f_expr))\\) and \\(g(x) = $(tex(g_expr))\\).",
            answer = area,
            difficulty = (900, 1200),
            solution = steps(
                "Find intersection points by solving \\(x^2 = $(a_val)x\\)",
                "Intersection points: \\(x = 0\\) and \\(x = $(a_val)\\)",
                "The line is above the parabola on \\([0, $(a_val)]\\)",
                "Set up integral: \\(A = \\int_{0}^{$(a_val)} ($(tex(g_expr - f_expr))) \\, dx\\)",
                "Integrate: \\(A = \\left[\\frac{$(a_val)x^2}{2} - \\frac{x^3}{3}\\right]_{0}^{$(a_val)}\\)",
                "Evaluate: \\(A = \\frac{$(a_val^3)}{6}\\)",
                sol("Answer", area)
            ),
            time = 150
        )
    end
end