# precalculus - polar_curves (medium)
# Generated: 2026-03-08T20:34:17.590350

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ x y begin
    set_topic!("precalculus/polar_curves")
    
    problem_type = choice([
        :convert_polar_to_cartesian,
        :convert_cartesian_to_polar,
        :find_symmetry,
        :find_intersection_points,
        :tangent_line_polar,
        :area_polar_region,
    ])
    
    if problem_type == :convert_polar_to_cartesian
        # Convert polar equation to Cartesian
        curve_type = choice([:circle, :line, :rose])
        
        if curve_type == :circle
            a = nonzero(-8, 8)
            # r = a cos(θ) or r = a sin(θ)
            use_cos = choice([true, false])
            if use_cos
                polar_eq = "r = $(a)\\cos(\\theta)"
                # x² + y² = ax → (x - a/2)² + y² = (a/2)²
                cartesian = expand((x - a//2)^2 + y^2)
                cartesian_rhs = (a//2)^2
                cartesian_str = "\\left(x - \\frac{$(a)}{2}\\right)^2 + y^2 = \\frac{$(a^2)}{4}"
            else
                polar_eq = "r = $(a)\\sin(\\theta)"
                # x² + y² = ay → x² + (y - a/2)² = (a/2)²
                cartesian = expand(x^2 + (y - a//2)^2)
                cartesian_rhs = (a//2)^2
                cartesian_str = "x^2 + \\left(y - \\frac{$(a)}{2}\\right)^2 = \\frac{$(a^2)}{4}"
            end
            
            problem(
                question="Convert the polar equation \\\$$(polar_eq)\\\$ to Cartesian (rectangular) form.",
                answer=cartesian_str,
                difficulty=(1200, 1400),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "Multiply both sides by r: \\\$r^2 = $(a)r$(use_cos ? "\\cos(\\theta)" : "\\sin(\\theta)")\\\$",
                    "Use \\\$r^2 = x^2 + y^2\\\$ and \\\$$(use_cos ? "x = r\\cos(\\theta)" : "y = r\\sin(\\theta)")\\\$",
                    "Result: \\\$x^2 + y^2 = $(a)$(use_cos ? "x" : "y")\\\$",
                    "Complete the square: \\\$$(cartesian_str)\\\$"
                ),
                time=120,
            )
        elseif curve_type == :line
            m = nonzero(-5, 5)
            # θ = arctan(m) or r cos(θ - α) = d
            α_deg = randint(1, 8) * 15
            d = nonzero(-10, 10)
            polar_eq = "r = \\frac{$(d)}{\\cos(\\theta - $(α_deg)^\\circ)}"
            cartesian_str = "Line at distance $(abs(d)) from origin"
            
            problem(
                question="Convert the polar equation \\\$\\theta = \\arctan($(m))\\\$ to Cartesian form.",
                answer="y = $(m)x",
                difficulty=(1100, 1300),
                solution=steps(
                    "Given: \\\$\\theta = \\arctan($(m))\\\$",
                    "Take tangent of both sides: \\\$\\tan(\\theta) = $(m)\\\$",
                    "Use \\\$\\tan(\\theta) = \\frac{y}{x}\\\$",
                    "Result: \\\$\\frac{y}{x} = $(m)\\\$, so \\\$y = $(m)x\\\$"
                ),
                time=90,
            )
        else  # rose
            n = randint(2, 5)
            a = nonzero(-6, 6)
            use_cos = choice([true, false])
            polar_eq = "r = $(a)$(use_cos ? "\\cos" : "\\sin")($(n)\\theta)"
            
            problem(
                question="Identify the number of petals in the rose curve \\\$$(polar_eq)\\\$.",
                answer=n % 2 == 1 ? n : 2*n,
                difficulty=(1000, 1200),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "This is a rose curve with \\\$n = $(n)\\\$",
                    n % 2 == 1 ? "Since n is odd, the number of petals is n = $(n)" : "Since n is even, the number of petals is 2n = $(2*n)",
                    "Answer: $(n % 2 == 1 ? n : 2*n) petals"
                ),
                time=60,
            )
        end
        
    elseif problem_type == :convert_cartesian_to_polar
        # Convert Cartesian to polar
        conversion_type = choice([:line, :circle, :parabola])
        
        if conversion_type == :line
            m = nonzero(-4, 4)
            b = nonzero(-8, 8)
            # y = mx + b
            cartesian_eq = "y = $(m)x + $(b)"
            # r sin(θ) = m·r cos(θ) + b
            # r(sin(θ) - m cos(θ)) = b
            polar_ans = "r = \\frac{$(b)}{\\sin(\\theta) - $(m)\\cos(\\theta)}"
            
            problem(
                question="Convert the Cartesian equation \\\$$(cartesian_eq)\\\$ to polar form.",
                answer=polar_ans,
                difficulty=(1300, 1500),
                solution=steps(
                    "Given: \\\$y = $(m)x + $(b)\\\$",
                    "Substitute \\\$x = r\\cos(\\theta)\\\$ and \\\$y = r\\sin(\\theta)\\\$",
                    "\\\$r\\sin(\\theta) = $(m)r\\cos(\\theta) + $(b)\\\$",
                    "Factor: \\\$r(\\sin(\\theta) - $(m)\\cos(\\theta)) = $(b)\\\$",
                    "Result: \\\$$(polar_ans)\\\$"
                ),
                time=120,
            )
        elseif conversion_type == :circle
            h = randint(-6, 6)
            k = randint(-6, 6)
            radius = randint(2, 7)
            r_sq = radius^2
            # (x-h)² + (y-k)² = r²
            cartesian_eq = "\\left(x - $(h)\\right)^2 + \\left(y - $(k)\\right)^2 = $(r_sq)"
            
            problem(
                question="Convert \\\$$(cartesian_eq)\\\$ to polar form and simplify.",
                answer="r^2 - $(2*h)r\\cos(\\theta) - $(2*k)r\\sin(\\theta) = $(r_sq - h^2 - k^2)",
                difficulty=(1400, 1600),
                solution=steps(
                    "Given: \$(x - $(h))^2 + (y - $(k))^2 = $(r_sq)\\\$",
                    "Expand: \\\$x^2 - $(2*h)x + $(h^2) + y^2 - $(2*k)y + $(k^2) = $(r_sq)\\\$",
                    "Use \\\$x^2 + y^2 = r^2\\\$, \\\$x = r\\cos(\\theta)\\\$, \\\$y = r\\sin(\\theta)\\\$",
                    "\\\$r^2 - $(2*h)r\\cos(\\theta) - $(2*k)r\\sin(\\theta) + $(h^2 + k^2) = $(r_sq)\\\$",
                    "Simplify: \\\$r^2 - $(2*h)r\\cos(\\theta) - $(2*k)r\\sin(\\theta) = $(r_sq - h^2 - k^2)\\\$"
                ),
                time=180,
            )
        else  # parabola
            p = nonzero(-5, 5)
            # x² = 4py
            cartesian_eq = "x^2 = $(4*p)y"
            polar_ans = "r = \\frac{$(4*p)\\sin(\\theta)}{\\cos^2(\\theta)}"
            
            problem(
                question="Convert the parabola \\\$$(cartesian_eq)\\\$ to polar form.",
                answer=polar_ans,
                difficulty=(1500, 1700),
                solution=steps(
                    "Given: \\\$x^2 = $(4*p)y\\\$",
                    "Substitute \\\$x = r\\cos(\\theta)\\\$ and \\\$y = r\\sin(\\theta)\\\$",
                    "\\\$r^2\\cos^2(\\theta) = $(4*p)r\\sin(\\theta)\\\$",
                    "Divide by r (assuming \\\$r \\neq 0\\\$): \\\$r\\cos^2(\\theta) = $(4*p)\\sin(\\theta)\\\$",
                    "Result: \\\$$(polar_ans)\\\$"
                ),
                time=150,
            )
        end
        
    elseif problem_type == :find_symmetry
        # Test symmetry of polar curves
        a = nonzero(-6, 6)
        n = randint(2, 6)
        
        symmetry_type = choice([:x_axis, :y_axis, :origin, :rose])
        
        if symmetry_type == :x_axis
            # r = a cos(nθ) has x-axis symmetry when n is odd
            polar_eq = "r = $(a)\\cos(\\theta)"
            symmetries = ["polar axis (x-axis)"]
            
            problem(
                question="Determine all symmetries of the polar curve \\\$$(polar_eq)\\\$. Choose from: polar axis, line θ=π/2, or origin.",
                answer="polar axis",
                difficulty=(1200, 1400),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "Test polar axis: Replace θ with -θ: \\\$r = $(a)\\cos(-\\theta) = $(a)\\cos(\\theta)\\\$ ✓",
                    "Test θ=π/2: Replace θ with π-θ: \\\$r = $(a)\\cos(\\pi - \\theta) = -$(a)\\cos(\\theta)\\\$ ✗",
                    "Test origin: Replace r with -r: Not equivalent ✗",
                    "Answer: Symmetric about the polar axis"
                ),
                time=120,
            )
        elseif symmetry_type == :y_axis
            polar_eq = "r = $(a)\\sin(\\theta)"
            
            problem(
                question="Determine all symmetries of the polar curve \\\$$(polar_eq)\\\$.",
                answer="θ = π/2",
                difficulty=(1200, 1400),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "Test θ=π/2 line: Replace θ with π-θ: \\\$r = $(a)\\sin(\\pi - \\theta) = $(a)\\sin(\\theta)\\\$ ✓",
                    "Test polar axis: Replace θ with -θ: \\\$r = $(a)\\sin(-\\theta) = -$(a)\\sin(\\theta)\\\$ ✗",
                    "Test origin: Not equivalent ✗",
                    "Answer: Symmetric about the line θ = π/2"
                ),
                time=120,
            )
        elseif symmetry_type == :origin
            polar_eq = "r^2 = $(a^2)\\cos(2\\theta)"
            
            problem(
                question="Show that \\\$$(polar_eq)\\\$ has symmetry about the origin.",
                answer="Replace (r,θ) with (-r,θ+π) to verify origin symmetry",
                difficulty=(1400, 1600),
                solution=steps(
                    "Given: \\\$r^2 = $(a^2)\\cos(2\\theta)\\\$",
                    "For origin symmetry, replace (r, θ) with (-r, θ + π)",
                    "\$(-r)^2 = $(a^2)\\cos(2(\\theta + \\pi))\\\$",
                    "\\\$r^2 = $(a^2)\\cos(2\\theta + 2\\pi) = $(a^2)\\cos(2\\theta)\\\$ ✓",
                    "The curve has origin symmetry"
                ),
                time=150,
            )
        else  # rose
            n_petals = choice([3, 5])
            polar_eq = "r = $(a)\\sin($(n_petals)\\theta)"
            
            problem(
                question="How many lines of symmetry does the rose curve \\\$$(polar_eq)\\\$ have?",
                answer=n_petals,
                difficulty=(1300, 1500),
                solution=steps(
                    "Given: \\\$$(polar_eq)\\\$",
                    "This is a rose with n = $(n_petals) (odd)",
                    "An n-petal rose (n odd) has n lines of symmetry",
                    "Each line passes through a petal and the origin",
                    "Answer: $(n_petals) lines of symmetry"
                ),
                time=90,
            )
        end
        
    elseif problem_type == :find_intersection_points
        # Find intersection of two polar curves
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        
        # r = a and r = b cos(θ)
        polar1 = "r = $(abs(a))"
        polar2 = "r = $(2*abs(a))\\cos(\\theta)"
        
        # Intersection: |a| = 2|a| cos(θ) → cos(θ) = 1/2 → θ = π/3, 5π/3
        ans_points = "\\left($(abs(a)), \\frac{\\pi}{3}\\right) \\text{ and } \\left($(abs(a)), \\frac{5\\pi}{3}\\right)"
        
        problem(
            question="Find all intersection points of \\\$$(polar1)\\\$ and \\\$$(polar2)\\\$ for \\\$0 \\leq \\theta < 2\\pi\\\$.",
            answer=ans_points,
            difficulty=(1500, 1700),
            solution=steps(
                "Set the equations equal: \\\$$(abs(a)) = $(2*abs(a))\\cos(\\theta)\\\$",
                "Solve for θ: \\\$\\cos(\\theta) = \\frac{1}{2}\\\$",
                "Solutions in [0, 2π): \\\$\\theta = \\frac{\\pi}{3}, \\frac{5\\pi}{3}\\\$",
                "Check for origin (pole): Both curves pass through origin at different θ values",
                "Intersection points: \$($(abs(a)), \\pi/3)\\\$ and \$($(abs(a)), 5\\pi/3)\\\$, plus the pole"
            ),
            time=180,
        )
        
    elseif problem_type == :tangent_line_polar
        # Find slope of tangent line at a point
        a = nonzero(-6, 6)
        θ_val = choice([0, 45, 60, 90, 120, 135, 180])
        θ_rad = deg2rad(θ_val)

        r_val = a * cos(θ_rad)
        slope_num = -a * sin(θ_rad) * sin(θ_rad) + r_val * cos(θ_rad)
        slope_den = -a * sin(θ_rad) * cos(θ_rad) - r_val * sin(θ_rad)

        if abs(slope_den) < 1e-10
            ans_str = "undefined"
        else
            ans_val = round(slope_num / slope_den, digits=4)
            ans_str = string(ans_val)
        end

        problem(
            question="Find the slope of the tangent line to r = $(a)cos(theta) at theta = $(θ_val) degrees.",
            answer=ans_str,
            difficulty=(1600, 1800),
            solution=steps(
                "Use dy/dx formula for polar curves",
                "dr/dtheta = -$(a)*sin(theta)",
                sol("Answer", ans_str)
            ),
            time=180,
        )
    end
end
