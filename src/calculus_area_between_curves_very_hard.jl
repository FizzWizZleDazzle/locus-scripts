# calculus - area_between_curves (very_hard)
# Generated: 2026-03-08T20:48:33.458806

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/area_between_curves")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition level: Area between curves with parameter optimization
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        k = randint(2, 5)
        
        f1 = a*x^2 + b
        f2 = k*x
        
        # Find intersection points
        intersect_eq = f1 - f2
        coeffs_intersect = [a, -k, b]
        
        discriminant = k^2 - 4*a*b
        
        if discriminant > 0 && a != 0
            x1 = (-(-k) - sqrt(discriminant)) / (2*a)
            x2 = (-(-k) + sqrt(discriminant)) / (2*a)
            
            if x1 > x2
                x1, x2 = x2, x1
            end
            
            # Area calculation
            integrand = abs(f2 - f1)
            
            # Integrate manually
            area_expr = expand((k - a*x)*x - b*x)
            antideriv = k*x^2/2 - a*x^3/3 - b*x
            
            area_val = substitute(antideriv, x => x2) - substitute(antideriv, x => x1)
            area_val = abs(area_val)
            
            problem(
                question="Let \\(f(x) = $(tex(f1))\\) and \\(g(x) = $(tex(f2))\\). Find the area of the region bounded by the graphs of \\(f\\) and \\(g\\). Express your answer as an exact value.",
                answer=area_val,
                difficulty=(2500, 2800),
                solution=steps(
                    sol("Given curves", "f(x) = $(tex(f1)), g(x) = $(tex(f2))"),
                    "Find intersection points by solving \\($(tex(f1)) = $(tex(f2))\\)",
                    sol("Intersection equation", tex(intersect_eq) * " = 0"),
                    "Solving gives \\(x = $(round(x1, digits=3))\\) and \\(x = $(round(x2, digits=3))\\)",
                    "Set up integral: \\(A = \\int_{$(round(x1, digits=3))}^{$(round(x2, digits=3))} |g(x) - f(x)| \\, dx\\)",
                    sol("Area", area_val)
                ),
                time=240
            )
        else
            # Fallback: polynomial enclosed region
            r1 = randint(-6, -1)
            r2 = randint(1, 6)
            
            f_upper = expand((x - r1)*(x - r2))
            f_lower = -2*x
            
            integrand = expand(f_upper - f_lower)
            
            # Compute area
            antideriv = x^3/3 - (r1 + r2)*x^2/2 + r1*r2*x + x^2
            area = substitute(antideriv, x => r2) - substitute(antideriv, x => r1)
            area = abs(area)
            
            problem(
                question="Find the area bounded by \\(y = $(tex(f_upper))\\) and \\(y = $(tex(f_lower))\\) between \\(x = $(r1)\\) and \\(x = $(r2)\\).",
                answer=area,
                difficulty=(2600, 2900),
                solution=steps(
                    sol("Upper curve", f_upper),
                    sol("Lower curve", f_lower),
                    "Set up integral: \\(A = \\int_{$(r1)}^{$(r2)} [($(tex(f_upper))) - ($(tex(f_lower)))] \\, dx\\)",
                    sol("Integrand", integrand),
                    "Evaluate the definite integral",
                    sol("Area", area)
                ),
                time=260
            )
        end
        
    elseif problem_type == 2
        # Olympiad level: Rotated region with optimization
        a = nonzero(1, 4)
        b = randint(1, 5)
        
        # Curves: y = a*sqrt(x) and y = b*x
        # Find intersection
        # a*sqrt(x) = b*x => a^2*x = b^2*x^2 => x(b^2*x - a^2) = 0
        # x = 0 or x = a^2/b^2
        
        x_intersect = a^2 // b^2
        
        # Area between curves
        # Integrate from 0 to x_intersect: (a*sqrt(x) - b*x) dx
        
        # Antiderivative: (2/3)*a*x^(3/2) - (b/2)*x^2
        area = (2//3)*a*(x_intersect)^(3//2) - (b//2)*x_intersect^2
        area = abs(area)
        
        # Simplify
        area = (2//3)*a*(a^2//b^2)^(3//2) - (b//2)*(a^2//b^2)^2
        area = (2//3)*a*(a^3//b^3) - (b//2)*(a^4//b^4)
        area = (2*a^4)//(3*b^3) - (b*a^4)//(2*b^4)
        area = (2*a^4)//(3*b^3) - (a^4)//(2*b^3)
        area = a^4*(4 - 3)//(6*b^3)
        area = a^4//(6*b^3)
        
        problem(
            question="Find the area of the region enclosed by \\(y = $(a)\\sqrt{x}\\) and \\(y = $(b)x\\). Express your answer as a simplified fraction.",
            answer=area,
            difficulty=(2700, 3100),
            solution=steps(
                "Find intersection: \\($(a)\\sqrt{x} = $(b)x\\)",
                "Square both sides: \\($(a^2)x = $(b^2)x^2\\)",
                "Solutions: \\(x = 0\\) and \\(x = \\frac{$(a^2)}{$(b^2)}\\)",
                "Set up integral: \\(A = \\int_0^{$(a^2)/$(b^2)} [$(a)\\sqrt{x} - $(b)x] \\, dx\\)",
                "Integrate: \\(A = \\left[\\frac{2}{3} \\cdot $(a) x^{3/2} - \\frac{$(b)}{2}x^2\\right]_0^{$(a^2)/$(b^2)}\\)",
                sol("Area", area)
            ),
            time=280
        )
        
    elseif problem_type == 3
        # Competition: Parametric or implicit region
        r1 = randint(2, 6)
        r2 = randint(1, r1-1)
        
        # Ellipse region: x^2/a^2 + y^2/b^2 = 1, first quadrant area
        a_sq = r1^2
        b_sq = r2^2
        
        # Area of full ellipse is pi*a*b, first quadrant is 1/4 of that
        area_exact = (pi * r1 * r2) // 4
        
        problem(
            question="Find the area of the region in the first quadrant bounded by the ellipse \\(\\frac{x^2}{$(a_sq)} + \\frac{y^2}{$(b_sq)} = 1\\) and the coordinate axes. Express your answer in terms of \\(\\pi\\).",
            answer=area_exact,
            difficulty=(2800, 3200),
            solution=steps(
                "The ellipse has semi-major axis \\(a = $(r1)\\) and semi-minor axis \\(b = $(r2)\\)",
                "The area of the full ellipse is \\(A_{\\text{ellipse}} = \\pi ab = $(r1*r2)\\pi\\)",
                "First quadrant contains \\(\\frac{1}{4}\\) of the ellipse",
                sol("Area in first quadrant", "\\frac{$(r1*r2)\\pi}{4}"),
                "Alternatively, integrate: \\(A = \\int_0^{$(r1)} $(r2)\\sqrt{1 - \\frac{x^2}{$(a_sq)}} \\, dx\\)"
            ),
            time=300
        )
        
    else
        # Olympiad: Area with absolute values and multiple regions
        a = nonzero(1, 3)
        h = randint(2, 5)
        k = randint(-4, 4)
        
        # Curves: y = a|x - h| + k and y = k - 2
        lower_y = k - 2
        
        # The V-shape intersects the horizontal line at two points
        # a|x - h| + k = k - 2
        # a|x - h| = -2
        # |x - h| = -2/a (only valid if a < 0, which we avoid)
        
        # Let's use different setup: y = -a|x - h| + k (inverted V) and y = k - height
        height = randint(3, 6)
        upper_vertex_y = k
        lower_line_y = k - height
        
        # -a|x - h| + k = k - height
        # -a|x - h| = -height
        # |x - h| = height/a
        
        x1 = h - height//a
        x2 = h + height//a
        
        width = 2*height//a
        area = (width * height) // 2
        
        problem(
            question="Find the area of the triangular region bounded by \\(y = -$(a)|x - $(h)| + $(k)\\) and \\(y = $(lower_line_y)\\).",
            answer=area,
            difficulty=(3000, 3400),
            solution=steps(
                "The function \\(y = -$(a)|x - $(h)| + $(k)\\) is an inverted V-shape with vertex at \\(($(h), $(k))\\)",
                "Find intersections with \\(y = $(lower_line_y)\\): \\(-$(a)|x - $(h)| + $(k) = $(lower_line_y)\\)",
                "Solve: \\(|x - $(h)| = $(height//a)\\), giving \\(x = $(h - height//a)\\) and \\(x = $(h + height//a)\\)",
                "The region is a triangle with base \\($(width)\\) and height \\($(height)\\)",
                sol("Area", "\\frac{1}{2} \\cdot $(width) \\cdot $(height) = $(area)")
            ),
            time=300
        )
    end
end