# calculus - area_between_curves (hard)
# Generated: 2026-03-08T20:48:14.593119

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/area_between_curves")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Two polynomials with multiple intersection points
        r1 = randint(-8, -2)
        r2 = randint(2, 8)
        a1 = choice([-2, -1, 1, 2])
        a2 = -a1 + choice([-1, 1])
        
        f1 = expand(a1 * (x - r1) * (x - r2))
        f2 = expand(a2 * (x - r1) * (x - r2))
        
        # Area between curves
        integrand = expand(f1 - f2)
        antideriv = simplify(substitute(diff(integrand^2 / (2*(a1-a2)), x), x => x))
        
        upper_val = substitute(antideriv, x => r2)
        lower_val = substitute(antideriv, x => r1)
        area_expr = abs((a1 - a2) * (r2 - r1)^3 / 6)
        
        problem(
            question="Find the area of the region bounded by \\(f(x) = $(tex(f1))\\) and \\(g(x) = $(tex(f2))\\) between their intersection points.",
            answer=area_expr,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Functions", "f(x) = $(tex(f1)), g(x) = $(tex(f2))"),
                "Find intersection points by solving \\(f(x) = g(x)\\): roots are \\(x = $r1\\) and \\(x = $r2\\)",
                "Set up integral: \\(A = \\int_{$r1}^{$r2} |f(x) - g(x)| \\, dx = \\int_{$r1}^{$r2} |$(tex(integrand))| \\, dx\\)",
                "Evaluate: \\(A = $(tex(area_expr))\\)",
                sol("Answer", area_expr)
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Quadratic and linear with vertical line bounds
        a = choice([-3, -2, -1, 1, 2, 3])
        h = randint(-6, 6)
        k = randint(5, 20)
        parabola = expand(a * (x - h)^2 + k)
        
        m = randint(-8, 8)
        b = k + randint(-5, 5)
        line = m * x + b
        
        x1 = randint(h - 8, h - 2)
        x2 = randint(h + 2, h + 8)
        
        # Calculate which is on top
        val_para_mid = substitute(parabola, x => (x1 + x2)/2)
        val_line_mid = substitute(line, x => (x1 + x2)/2)
        
        if a < 0
            # Parabola opens down, likely on top
            integrand = expand(parabola - line)
        else
            # Parabola opens up, likely on bottom
            integrand = expand(line - parabola)
        end
        
        # Symbolically integrate
        antideriv = expand(a * x^3 / 3 - a*h*x^2 + (a*h^2 + k - m)*x - b*x)
        area_val = abs(substitute(antideriv, x => x2) - substitute(antideriv, x => x1))
        
        problem(
            question="Find the area between \\(y = $(tex(parabola))\\) and \\(y = $(tex(line))\\) from \\(x = $x1\\) to \\(x = $x2\\).",
            answer=area_val,
            difficulty=(1900, 2200),
            solution=steps(
                sol("Curves", "y = $(tex(parabola)), y = $(tex(line))"),
                "Determine which function is on top over \\([$x1, $x2]\\)",
                "Set up: \\(A = \\int_{$x1}^{$x2} |$(tex(integrand))| \\, dx\\)",
                "Integrate and evaluate at bounds",
                sol("Answer", area_val)
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Two curves requiring finding intersection points algebraically
        a = choice([1, 2, 4])
        b = randint(10, 30)
        
        curve1 = b - a * x^2
        curve2 = a * x^2
        
        # Intersection: b - ax^2 = ax^2 => 2ax^2 = b => x = ±sqrt(b/(2a))
        x_int = sqrt(b // (2*a))
        
        integrand = expand(curve1 - curve2)
        # Integral of (b - 2ax^2) from -x_int to x_int
        area_expr = 2 * (b * x_int - 2*a*x_int^3/3)
        area_val = simplify(area_expr)
        
        problem(
            question="Find the area enclosed by \\(y = $(tex(curve1))\\) and \\(y = $(tex(curve2))\\).",
            answer=area_val,
            difficulty=(2000, 2300),
            solution=steps(
                sol("Curves", "y = $(tex(curve1)), y = $(tex(curve2))"),
                "Solve for intersections: \\($(tex(curve1)) = $(tex(curve2))\\) gives \\(x = \\pm$(tex(x_int))\\)",
                "By symmetry: \\(A = 2\\int_0^{$(tex(x_int))} ($(tex(curve1)) - $(tex(curve2))) \\, dx\\)",
                "Evaluate: \\(A = 2\\int_0^{$(tex(x_int))} $(tex(integrand)) \\, dx = $(tex(area_val))\\)",
                sol("Answer", area_val)
            ),
            time=270,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Region between cubic and quadratic
        r = randint(-5, 5)
        a_cub = choice([-1, 1])
        a_quad = choice([2, 3, 4])
        
        cubic = a_cub * (x - r)^3 + randint(-10, 10)
        quadratic = expand(-a_quad * (x - r)^2 + randint(5, 15))
        
        x1 = r + randint(-6, -2)
        x2 = r + randint(2, 6)
        
        integrand = expand(quadratic - cubic)
        
        # Compute symbolic area
        anti = expand(-a_quad*(x-r)^3/3 - a_cub*(x-r)^4/4)
        area_val = abs(substitute(anti, x => x2) - substitute(anti, x => x1))
        
        problem(
            question="Compute the area between \\(f(x) = $(tex(cubic))\\) and \\(g(x) = $(tex(quadratic))\\) on the interval \\([$x1, $x2]\\).",
            answer=area_val,
            difficulty=(1900, 2250),
            solution=steps(
                sol("Given", "f(x) = $(tex(cubic)), g(x) = $(tex(quadratic))"),
                "Determine the upper function on \\([$x1, $x2]\\)",
                "Set up: \\(A = \\int_{$x1}^{$x2} |g(x) - f(x)| \\, dx\\)",
                "Evaluate the definite integral",
                sol("Answer", area_val)
            ),
            time=240,
            calculator="scientific"
        )
        
    else
        # Challenging: area between y = sin-like or more complex setup
        # Simplify to polynomial case with tricky bounds
        a = choice([1, 2, 3])
        b = choice([4, 5, 6])
        
        f1 = a * x^2
        f2 = b * x
        
        # Intersection: ax^2 = bx => x(ax - b) = 0 => x = 0, b/a
        x_upper = b // a
        
        integrand = expand(f2 - f1)
        # Integral of (bx - ax^2) from 0 to b/a
        area_val = b^3 / (6 * a^2)
        
        problem(
            question="Find the area of the region bounded by \\(y = $(tex(f1))\\), \\(y = $(tex(f2))\\), and the y-axis.",
            answer=area_val,
            difficulty=(1850, 2150),
            solution=steps(
                sol("Curves", "y = $(tex(f1)), y = $(tex(f2))"),
                "Find intersections: \\($(tex(f1)) = $(tex(f2))\\) yields \\(x = 0\\) and \\(x = $(tex(x_upper))\\)",
                "Set up: \\(A = \\int_0^{$(tex(x_upper))} ($(tex(f2)) - $(tex(f1))) \\, dx\\)",
                "Evaluate: \\(A = \\left[\\frac{b x^2}{2} - \\frac{a x^3}{3}\\right]_0^{$(tex(x_upper))} = $(tex(area_val))\\)",
                sol("Answer", area_val)
            ),
            time=210,
            calculator="scientific"
        )
    end
end