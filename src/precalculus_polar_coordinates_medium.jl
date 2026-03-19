# precalculus - polar_coordinates (medium)
# Generated: 2026-03-08T20:33:00.060866

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Convert polar to rectangular coordinates
        r_val = randint(2, 12)
        θ_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330])
        θ_rad = θ_deg * π / 180
        
        x_val = r_val * cos(θ_rad)
        y_val = r_val * sin(θ_rad)
        
        # Simplify to exact values
        x_exact = rationalize(x_val, tol=1e-10)
        y_exact = rationalize(y_val, tol=1e-10)
        
        problem(
            question="Convert the polar coordinates \$\\left($(r_val), $(θ_deg)^\\circ\\right)\$ to rectangular coordinates. Give your answer as an ordered pair \$(x, y)\$ in exact form.",
            answer=fmt_tuple([x_exact, y_exact]),
            difficulty=(1200, 1400),
            answer_type="tuple",
            solution=steps(
                "Given polar coordinates: \$(r, \\theta) = ($(r_val), $(θ_deg)^\\circ)\$",
                "Use conversion formulas: \$x = r\\cos\\theta\$ and \$y = r\\sin\\theta\$",
                sol("x", "$(r_val)\\cos($(θ_deg)^\\circ) = $(tex(x_exact))"),
                sol("y", "$(r_val)\\sin($(θ_deg)^\\circ) = $(tex(y_exact))"),
                "Rectangular coordinates: \$($(tex(x_exact)), $(tex(y_exact)))\$"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Convert rectangular to polar coordinates (r > 0)
        angle_deg = choice([30, 45, 60, 120, 135, 150, 210, 225, 240, 300, 315, 330])
        angle_rad = angle_deg * π / 180
        r_val = randint(3, 10)
        
        x_val = rationalize(r_val * cos(angle_rad), tol=1e-10)
        y_val = rationalize(r_val * sin(angle_rad), tol=1e-10)
        
        problem(
            question="Convert the rectangular coordinates \$($(tex(x_val)), $(tex(y_val)))\$ to polar coordinates \$(r, \\theta)\$ where \$r > 0\$ and \$0 \\leq \\theta < 2\\pi\$. Express \$\\theta\$ in radians in exact form.",
            answer=fmt_tuple([r_val, angle_rad]),
            difficulty=(1300, 1500),
            answer_type="tuple",
            solution=steps(
                "Given rectangular coordinates: \$(x, y) = ($(tex(x_val)), $(tex(y_val)))\$",
                sol("r", "\\sqrt{x^2 + y^2} = \\sqrt{($(tex(x_val)))^2 + ($(tex(y_val)))^2} = $(r_val)"),
                "Use \$\\tan\\theta = \\frac{y}{x}\$ and check the quadrant",
                sol("\\theta", "\\frac{$(angle_deg)\\pi}{180} = $(tex(angle_rad))"),
                "Polar coordinates: \$($(r_val), $(tex(angle_rad)))\$"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Convert polar equation to rectangular
        eq_type = rand(1:3)
        
        if eq_type == 1
            # r = a (circle centered at origin)
            a = randint(3, 15)
            problem(
                question="Convert the polar equation \$r = $(a)\$ to rectangular form.",
                answer="x^2 + y^2 = $(a^2)",
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", "r = $(a)"),
                    "Square both sides: \$r^2 = $(a^2)\$",
                    "Use \$r^2 = x^2 + y^2\$",
                    sol("Answer", "x^2 + y^2 = $(a^2)")
                ),
                time=90
            )
        elseif eq_type == 2
            # θ = constant (line through origin)
            θ_deg = choice([30, 45, 60, 120, 135, 150])
            m = rationalize(tan(θ_deg * π / 180), tol=1e-10)
            problem(
                question="Convert the polar equation \$\\theta = $(θ_deg)^\\circ\$ to rectangular form.",
                answer="y = $(tex(m))x",
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", "\\theta = $(θ_deg)^\\circ"),
                    "Use \$\\tan\\theta = \\frac{y}{x}\$",
                    sol("\\tan($(θ_deg)^\\circ)", "$(tex(m))"),
                    sol("Answer", "y = $(tex(m))x")
                ),
                time=90
            )
        else
            # r = a cos(θ) (circle)
            a = randint(2, 10) * 2
            h = a // 2
            problem(
                question="Convert the polar equation \$r = $(a)\\cos\\theta\$ to rectangular form.",
                answer="(x - $(tex(h)))^2 + y^2 = $(tex(h^2))",
                difficulty=(1500, 1700),
                solution=steps(
                    sol("Given", "r = $(a)\\cos\\theta"),
                    "Multiply both sides by \$r\$: \$r^2 = $(a)r\\cos\\theta\$",
                    "Use \$r^2 = x^2 + y^2\$ and \$r\\cos\\theta = x\$",
                    "\$x^2 + y^2 = $(a)x\$",
                    "Complete the square: \$x^2 - $(a)x + y^2 = 0\$",
                    sol("Answer", "(x - $(tex(h)))^2 + y^2 = $(tex(h^2))")
                ),
                time=150
            )
        end
        
    elseif problem_type == 4
        # Convert rectangular equation to polar
        eq_type = rand(1:2)
        
        if eq_type == 1
            # x = a (vertical line)
            a = nonzero(-10, 10)
            problem(
                question="Convert the rectangular equation \$x = $(a)\$ to polar form.",
                answer="r = $(a)/cos(θ)",
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", "x = $(a)"),
                    "Use \$x = r\\cos\\theta\$",
                    sol("r\\cos\\theta", "$(a)"),
                    sol("Answer", "r = \\frac{$(a)}{\\cos\\theta}")
                ),
                time=90
            )
        else
            # x^2 + y^2 = a^2 (circle)
            a = randint(2, 12)
            problem(
                question="Convert the rectangular equation \$x^2 + y^2 = $(a^2)\$ to polar form.",
                answer="r = $(a)",
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", "x^2 + y^2 = $(a^2)"),
                    "Use \$r^2 = x^2 + y^2\$",
                    sol("r^2", "$(a^2)"),
                    sol("Answer", "r = $(a)")
                ),
                time=75
            )
        end
        
    else
        # Distance between two polar points
        r1 = randint(3, 10)
        r2 = randint(3, 10)
        θ1_deg = choice([0, 30, 45, 60, 90])
        θ2_deg = choice([120, 135, 150, 180, 210, 240, 270])
        
        θ1_rad = θ1_deg * π / 180
        θ2_rad = θ2_deg * π / 180
        
        # Distance formula: d^2 = r1^2 + r2^2 - 2*r1*r2*cos(θ2 - θ1)
        d_squared = r1^2 + r2^2 - 2*r1*r2*cos(θ2_rad - θ1_rad)
        d = sqrt(d_squared)
        d_exact = rationalize(d, tol=1e-10)
        
        problem(
            question="Find the distance between the points with polar coordinates \$($(r1), $(θ1_deg)^\\circ)\$ and \$($(r2), $(θ2_deg)^\\circ)\$. Give an exact answer.",
            answer=d_exact,
            difficulty=(1500, 1700),
            solution=steps(
                "Given points: \$(r_1, \\theta_1) = ($(r1), $(θ1_deg)^\\circ)\$ and \$(r_2, \\theta_2) = ($(r2), $(θ2_deg)^\\circ)\$",
                "Use distance formula: \$d = \\sqrt{r_1^2 + r_2^2 - 2r_1r_2\\cos(\\theta_2 - \\theta_1)}\$",
                sol("d^2", "$(r1)^2 + $(r2)^2 - 2($(r1))($(r2))\\cos($(θ2_deg - θ1_deg)^\\circ)"),
                sol("d^2", "$(tex(d_squared))"),
                sol("d", "$(tex(d_exact))")
            ),
            time=150
        )
    end
end