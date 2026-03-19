# calculus - area_between_curves (medium)
# Generated: 2026-03-08T20:48:03.877696

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/area_between_curves")
    
    # Choose problem type
    prob_type = choice([:linear_quadratic, :two_quadratics, :quadratic_cubic, :polynomial_shifted])
    
    if prob_type == :linear_quadratic
        # Linear and quadratic - clean intersection points
        r1 = randint(-8, 8)
        r2 = r1 + randint(2, 6)
        
        # Top function: parabola opening down through both points
        a_top = -randint(1, 3)
        # Use vertex form shifted to be between the roots
        h = (r1 + r2) / 2
        k = randint(3, 12)
        f_top = expand(a_top * (x - h)^2 + k)
        
        # Bottom function: line through both points
        y1 = substitute(f_top, x => r1)
        y2 = substitute(f_top, x => r2)
        m = (y2 - y1) // (r2 - r1)
        b = y1 - m * r1
        f_bottom = m * x + b
        
        # Calculate area
        integrand = expand(f_top - f_bottom)
        antideriv = simplify(integrate(integrand, x))
        area_val = substitute(antideriv, x => r2) - substitute(antideriv, x => r1)
        area_val = abs(area_val)
        
        problem(
            question="Find the area between the curves \$f(x) = $(tex(f_top))\$ and \$g(x) = $(tex(f_bottom))\$ from \$x = $(r1)\$ to \$x = $(r2)\$.",
            answer=area_val,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Top function", f_top),
                sol("Bottom function", f_bottom),
                sol("Set up integral", "A = \\int_{$(r1)}^{$(r2)} [$(tex(f_top)) - ($(tex(f_bottom)))] dx"),
                sol("Integrand", integrand),
                "Integrate and evaluate at bounds",
                sol("Area", area_val)
            ),
            time=180
        )
        
    elseif prob_type == :two_quadratics
        # Two parabolas with clean intersection
        r1 = randint(-6, 0)
        r2 = r1 + randint(4, 8)
        
        # Top: opens down
        a1 = -randint(1, 2)
        q1 = rand_factorable(x; a=(a1, a1), roots=(r1, r2))
        
        # Bottom: opens up, vertex below
        a2 = randint(1, 3)
        shift = -randint(5, 15)
        q2_base = rand_factorable(x; a=(a2, a2), roots=(r1, r2))
        q2 = expand(q2_base.expr + shift)
        
        integrand = expand(q1.expr - q2)
        antideriv = integrate(integrand, x)
        area_val = substitute(antideriv, x => r2) - substitute(antideriv, x => r1)
        area_val = abs(simplify(area_val))
        
        problem(
            question="Find the area of the region enclosed by \$y = $(tex(q1.expr))\$ and \$y = $(tex(q2))\$.",
            answer=area_val,
            difficulty=(1400, 1600),
            solution=steps(
                "Find intersection points by setting the functions equal",
                sol("Intersection points", "x = $(r1), x = $(r2)"),
                sol("Top function", q1.expr),
                sol("Bottom function", q2),
                sol("Set up integral", "A = \\int_{$(r1)}^{$(r2)} [($(tex(q1.expr))) - ($(tex(q2)))] dx"),
                "Integrate and evaluate",
                sol("Area", area_val)
            ),
            time=240
        )
        
    elseif prob_type == :quadratic_cubic
        # Quadratic and cubic with two intersection points
        r1 = randint(-5, 0)
        r2 = r1 + randint(3, 6)
        
        # Cubic through both points
        a_cub = choice([-1, 1])
        # Simple cubic: a(x - r1)(x - r2)(x - c) where c is between r1 and r2
        c = r1 + randint(1, r2 - r1 - 1)
        f_cubic = expand(a_cub * (x - r1) * (x - r2) * (x - c))
        
        # Quadratic through both points
        y1 = substitute(f_cubic, x => r1)
        y2 = substitute(f_cubic, x => r2)
        
        # Use vertex form for quadratic
        h = (r1 + r2) / 2
        a_quad = -a_cub * randint(2, 4)
        # Make it pass through (r1, y1)
        k = y1 - a_quad * (r1 - h)^2
        f_quad = expand(a_quad * (x - h)^2 + k)
        
        integrand = expand(f_cubic - f_quad)
        antideriv = integrate(integrand, x)
        area_val = substitute(antideriv, x => r2) - substitute(antideriv, x => r1)
        area_val = abs(simplify(area_val))
        
        problem(
            question="Find the area between \$f(x) = $(tex(f_cubic))\$ and \$g(x) = $(tex(f_quad))\$ between their intersection points.",
            answer=area_val,
            difficulty=(1500, 1700),
            solution=steps(
                "Solve for intersection points by setting \$f(x) = g(x)\$",
                sol("Intersection points", "x = $(r1), x = $(r2)"),
                "Determine which function is on top (check midpoint)",
                sol("Set up integral", "A = \\int_{$(r1)}^{$(r2)} |f(x) - g(x)| dx"),
                sol("Integrand", integrand),
                "Evaluate the definite integral",
                sol("Area", area_val)
            ),
            time=270
        )
        
    else  # polynomial_shifted
        # Simple polynomial minus a shifted version
        r1 = 0
        r2 = randint(3, 6)
        
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        c = randint(-10, 10)
        
        f1 = a * x^2 + b * x + c
        shift = randint(5, 20)
        f2 = expand(f1 - shift)
        
        integrand = simplify(f1 - f2)
        antideriv = integrate(integrand, x)
        area_val = substitute(antideriv, x => r2) - substitute(antideriv, x => r1)
        area_val = abs(area_val)
        
        problem(
            question="Find the area between \$y = $(tex(f1))\$ and \$y = $(tex(f2))\$ from \$x = $(r1)\$ to \$x = $(r2)\$.",
            answer=area_val,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Upper function", f1),
                sol("Lower function", f2),
                sol("Difference", integrand),
                sol("Set up integral", "A = \\int_{$(r1)}^{$(r2)} $(tex(integrand)) dx"),
                "Evaluate the integral",
                sol("Area", area_val)
            ),
            time=150
        )
    end
end