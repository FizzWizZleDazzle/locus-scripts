# precalculus - polar_coordinates (hard)
# Generated: 2026-03-08T20:33:26.176354

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = choice([
        :polar_to_cartesian_conversion,
        :cartesian_to_polar_conversion,
        :polar_curve_intersection,
        :polar_area_setup,
        :polar_distance,
    ])
    
    if problem_type == :polar_to_cartesian_conversion
        # Convert polar equation to Cartesian
        subtype = choice([:circle, :line, :parabola])
        
        if subtype == :circle
            a = nonzero(-8, 8)
            # r = 2a cos(θ) or r = 2a sin(θ)
            if choice([true, false])
                polar_eq = "r = $(2*a)\\cos(\\theta)"
                # x² + y² = 2ax  →  (x-a)² + y² = a²
                cart_eq = "(x - $(a))^2 + y^2 = $(a^2)"
                center = (a, 0)
                radius = abs(a)
            else
                polar_eq = "r = $(2*a)\\sin(\\theta)"
                # x² + y² = 2ay  →  x² + (y-a)² = a²
                cart_eq = "x^2 + (y - $(a))^2 = $(a^2)"
                center = (0, a)
                radius = abs(a)
            end
            
            problem(
                question="Convert the polar equation \\\$$(polar_eq)\\\$ to Cartesian form and identify the curve.",
                answer=cart_eq,
                difficulty=(1800, 2000),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "Multiply both sides by \\\$r\\\$: \\\$r^2 = $(2*a)r\\cos(\\theta)\\\$ or \\\$r^2 = $(2*a)r\\sin(\\theta)\\\$",
                    "Substitute \\\$r^2 = x^2 + y^2\\\$ and \\\$r\\cos(\\theta) = x\\\$ or \\\$r\\sin(\\theta) = y\\\$",
                    "Simplify: \\\$$(cart_eq)\\\$",
                    "This is a circle with center $(center) and radius $(radius)",
                ),
                time=180,
            )
            
        elseif subtype == :line
            m = nonzero(-5, 5)
            b = nonzero(-8, 8)
            # Line y = mx + b in polar: r sin(θ) = m r cos(θ) + b
            # r(sin(θ) - m cos(θ)) = b
            # r = b / (sin(θ) - m cos(θ))
            
            polar_eq = "r = \\frac{$(b)}{\\sin(\\theta) - $(m)\\cos(\\theta)}"
            cart_eq = "y = $(m)x + $(b)"
            
            problem(
                question="Convert the polar equation \\\$$(polar_eq)\\\$ to Cartesian form.",
                answer=cart_eq,
                difficulty=(1900, 2100),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "Multiply both sides: \\\$r\\sin(\\theta) - $(m)r\\cos(\\theta) = $(b)\\\$",
                    "Substitute \\\$x = r\\cos(\\theta)\\\$ and \\\$y = r\\sin(\\theta)\\\$",
                    "Result: \\\$y - $(m)x = $(b)\\\$",
                    sol("Answer", cart_eq),
                ),
                time=180,
            )
        else # parabola
            p = nonzero(-6, 6)
            # Parabola with focus at origin: r = p/(1 + cos(θ)) or similar
            orientation = choice([:right, :left, :up, :down])
            
            if orientation == :right
                polar_eq = "r = \\frac{$(abs(p))}{1 - \\cos(\\theta)}"
                cart_eq = "y^2 = $(4*abs(p))(x + $(abs(p)))"
            elseif orientation == :left
                polar_eq = "r = \\frac{$(abs(p))}{1 + \\cos(\\theta)}"
                cart_eq = "y^2 = $(-4*abs(p))(x - $(abs(p)))"
            elseif orientation == :up
                polar_eq = "r = \\frac{$(abs(p))}{1 - \\sin(\\theta)}"
                cart_eq = "x^2 = $(4*abs(p))(y + $(abs(p)))"
            else
                polar_eq = "r = \\frac{$(abs(p))}{1 + \\sin(\\theta)}"
                cart_eq = "x^2 = $(-4*abs(p))(y - $(abs(p)))"
            end
            
            problem(
                question="Convert the polar equation \\\$$(polar_eq)\\\$ to Cartesian form.",
                answer=cart_eq,
                difficulty=(2100, 2300),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "This is a conic section with eccentricity e = 1 (parabola)",
                    "Use \\\$r^2 = x^2 + y^2\\\$ and polar-to-Cartesian conversions",
                    "Multiply and substitute to eliminate \\\$r\\\$ and \\\$\\theta\\\$",
                    sol("Answer", cart_eq),
                ),
                time=240,
            )
        end
        
    elseif problem_type == :cartesian_to_polar_conversion
        # Convert Cartesian to polar
        a = nonzero(-10, 10)
        b = nonzero(-10, 10)
        
        conversion_type = choice([:vertical_line, :horizontal_line, :circle_origin])
        
        if conversion_type == :vertical_line
            cart_eq = "x = $(a)"
            polar_eq = "r\\cos(\\theta) = $(a)"
            simplified = "r = $(a)\\sec(\\theta)"
            
            problem(
                question="Convert the Cartesian equation \\\$$(cart_eq)\\\$ to polar form.",
                answer=simplified,
                difficulty=(1800, 1950),
                solution=steps(
                    "Given: \\\$$(cart_eq)\\\$",
                    "Substitute \\\$x = r\\cos(\\theta)\\\$",
                    sol("Result", polar_eq),
                    sol("Simplified", simplified),
                ),
                time=120,
            )
            
        elseif conversion_type == :horizontal_line
            cart_eq = "y = $(b)"
            polar_eq = "r\\sin(\\theta) = $(b)"
            simplified = "r = $(b)\\csc(\\theta)"
            
            problem(
                question="Convert the Cartesian equation \\\$$(cart_eq)\\\$ to polar form.",
                answer=simplified,
                difficulty=(1800, 1950),
                solution=steps(
                    "Given: \\\$$(cart_eq)\\\$",
                    "Substitute \\\$y = r\\sin(\\theta)\\\$",
                    sol("Result", polar_eq),
                    sol("Simplified", simplified),
                ),
                time=120,
            )
            
        else # circle through origin
            R = abs(nonzero(-12, 12))
            if choice([true, false])
                cart_eq = "x^2 + y^2 = $(R)x"
                polar_eq = "r = $(R)\\cos(\\theta)"
            else
                cart_eq = "x^2 + y^2 = $(R)y"
                polar_eq = "r = $(R)\\sin(\\theta)"
            end
            
            problem(
                question="Convert the Cartesian equation \\\$$(cart_eq)\\\$ to polar form.",
                answer=polar_eq,
                difficulty=(1850, 2000),
                solution=steps(
                    "Given: \\\$$(cart_eq)\\\$",
                    "Substitute \\\$r^2 = x^2 + y^2\\\$, \\\$x = r\\cos(\\theta)\\\$, \\\$y = r\\sin(\\theta)\\\$",
                    "Divide both sides by \\\$r\\\$ (valid for \\\$r \\neq 0\\\$)",
                    sol("Answer", polar_eq),
                ),
                time=150,
            )
        end
        
    elseif problem_type == :polar_curve_intersection
        # Find intersection points of two polar curves
        a = abs(nonzero(-8, 8))
        b = abs(nonzero(-8, 8))
        
        while a == b
            b = abs(nonzero(-8, 8))
        end
        
        # Two circles: r = a and r = b cos(θ)
        r1_eq = "r = $(a)"
        r2_eq = "r = $(2*b)\\cos(\\theta)"
        
        # Intersection: a = 2b cos(θ) → cos(θ) = a/(2b)
        if abs(a) <= abs(2*b)
            cos_val = a // (2*b)
            theta_val = "\\arccos($(cos_val))"
            num_points = 3  # (0,0) and two symmetric points
            
            problem(
                question="Find all intersection points of the polar curves \\\$$(r1_eq)\\\$ and \\\$$(r2_eq)\\\$. How many intersection points are there?",
                answer=num_points,
                difficulty=(2000, 2200),
                solution=steps(
                    "Given curves: \\\$$(r1_eq)\\\$ and \\\$$(r2_eq)\\\$",
                    "Set equal: \\\$$(a) = $(2*b)\\cos(\\theta)\\\$",
                    "Solve: \\\$\\cos(\\theta) = $(cos_val)\\\$",
                    "Also check pole: second curve passes through origin when \\\$\\theta = \\pi/2\\\$",
                    "Total intersection points: $(num_points) (including the pole)",
                ),
                time=240,
            )
        else
            problem(
                question="Find all intersection points of the polar curves \\\$$(r1_eq)\\\$ and \\\$$(r2_eq)\\\$. How many intersection points are there?",
                answer=1,
                difficulty=(2000, 2200),
                solution=steps(
                    "Given curves: \\\$$(r1_eq)\\\$ and \\\$$(r2_eq)\\\$",
                    "Set equal: \\\$$(a) = $(2*b)\\cos(\\theta)\\\$",
                    "This requires \\\$\\cos(\\theta) = $(a)/$(2*b) > 1\\\$, which is impossible",
                    "Check pole: second curve passes through origin at \\\$\\theta = \\pi/2\\\$",
                    "Only intersection point: the pole (origin)",
                ),
                time=240,
            )
        end
        
    elseif problem_type == :polar_area_setup
        # Set up integral for area enclosed by polar curve
        n = choice([3, 4, 5, 6, 8])
        a = abs(nonzero(-6, 6))
        
        curve_eq = "r = $(a)\\cos($(n)\\theta)"
        
        # Rose curve with n petals (if n odd) or 2n petals (if n even)
        num_petals = n % 2 == 0 ? 2*n : n
        area_one_petal = (a^2 * π) // (4 * n)
        total_area = (a^2 * π * num_petals) // (4 * n)
        
        problem(
            question="Find the total area enclosed by the rose curve \\\$$(curve_eq)\\\$.",
            answer=Float64(total_area),
            difficulty=(2100, 2300),
            solution=steps(
                "Given: \\\$$(curve_eq)\\\$",
                "This is a rose curve with $(num_petals) petals",
                "Area of one petal: \\\$A_{\\text{petal}} = \\frac{1}{2}\\int_{\\alpha}^{\\beta} r^2 \\, d\\theta\\\$",
                "For one petal: \\\$A_{\\text{petal}} = $(area_one_petal)\\\$",
                "Total area: \\\$A = $(num_petals) \\times $(area_one_petal) = $(total_area)\\\$",
            ),
            time=300,
        )
        
    elseif problem_type == :polar_distance
        # Distance between two polar points
        r1 = abs(randint(2, 12))
        r2 = abs(randint(2, 12))
        
        # Use nice angles
        angle_diff = choice([π//6, π//4, π//3, π//2, 2*π//3, 3*π//4, 5*π//6])
        
        # Distance formula: d² = r1² + r2² - 2r1·r2·cos(θ2 - θ1)
        dist_squared = r1^2 + r2^2 - 2*r1*r2*cos(Float64(angle_diff))
        dist = sqrt(dist_squared)
        
        angle_str = angle_diff == π//6 ? "\\frac{\\pi}{6}" :
                    angle_diff == π//4 ? "\\frac{\\pi}{4}" :
                    angle_diff == π//3 ? "\\frac{\\pi}{3}" :
                    angle_diff == π//2 ? "\\frac{\\pi}{2}" :
                    angle_diff == 2*π//3 ? "\\frac{2\\pi}{3}" :
                    angle_diff == 3*π//4 ? "\\frac{3\\pi}{4}" : "\\frac{5\\pi}{6}"
        
        problem(
            question="Find the distance between the points with polar coordinates \$($(r1), 0)\\\$ and \$($(r2), $(angle_str))\\\$.",
            answer=round(dist, digits=3),
            difficulty=(1900, 2100),
            solution=steps(
                "Given points: \$($(r1), 0)\\\$ and \$($(r2), $(angle_str))\\\$",
                "Use polar distance formula: \\\$d^2 = r_1^2 + r_2^2 - 2r_1 r_2 \\cos(\\theta_2 - \\theta_1)\\\$",
                "Substitute: \\\$d^2 = $(r1)^2 + $(r2)^2 - 2($(r1))($(r2))\\cos($(angle_str))\\\$",
                "Calculate: \\\$d^2 = $(round(dist_squared, digits=3))\\\$",
                sol("Answer", "d = $(round(dist, digits=3))"),
            ),
            time=180,
        )
        
    end
end
