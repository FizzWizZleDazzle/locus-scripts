# precalculus - polar_coordinates (easy)
# Generated: 2026-03-08T20:33:01.931066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Convert polar to rectangular
        r_val = randint(2, 12)
        θ_vals = [0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π, 7π/6, 5π/4, 4π/3, 3π/2, 5π/3, 7π/4, 11π/6]
        θ_val = choice(θ_vals)
        
        x_ans = r_val * cos(θ_val)
        y_ans = r_val * sin(θ_val)
        
        # Simplify to exact values
        x_rounded = round(x_ans, digits=10)
        y_rounded = round(y_ans, digits=10)
        
        θ_str = if θ_val == 0
            "0"
        elseif θ_val == π
            "\\pi"
        elseif θ_val == π/2
            "\\frac{\\pi}{2}"
        elseif θ_val == 3π/2
            "\\frac{3\\pi}{2}"
        elseif θ_val == π/3
            "\\frac{\\pi}{3}"
        elseif θ_val == π/4
            "\\frac{\\pi}{4}"
        elseif θ_val == π/6
            "\\frac{\\pi}{6}"
        elseif θ_val == 2π/3
            "\\frac{2\\pi}{3}"
        elseif θ_val == 3π/4
            "\\frac{3\\pi}{4}"
        elseif θ_val == 5π/6
            "\\frac{5\\pi}{6}"
        elseif θ_val == 4π/3
            "\\frac{4\\pi}{3}"
        elseif θ_val == 5π/4
            "\\frac{5\\pi}{4}"
        elseif θ_val == 7π/6
            "\\frac{7\\pi}{6}"
        elseif θ_val == 5π/3
            "\\frac{5\\pi}{3}"
        elseif θ_val == 7π/4
            "\\frac{7\\pi}{4}"
        else
            "\\frac{11\\pi}{6}"
        end
        
        problem(
            question="Convert the polar coordinates \\(($(r_val), $(θ_str))\\) to rectangular coordinates \\((x, y)\\).",
            answer=fmt_tuple([x_rounded, y_rounded]),
            difficulty=(700, 900),
            answer_type="tuple",
            solution=steps(
                "Given: \\(r = $(r_val), \\theta = $(θ_str)\\)",
                "Use \\(x = r\\cos(\\theta)\\) and \\(y = r\\sin(\\theta)\\)",
                "\\(x = $(r_val)\\cos($(θ_str)) = $(x_rounded)\\)",
                "\\(y = $(r_val)\\sin($(θ_str)) = $(y_rounded)\\)",
                sol("Answer", fmt_tuple([x_rounded, y_rounded]))
            ),
            time=90,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Convert rectangular to polar (r > 0)
        x_val = nonzero(-10, 10)
        y_val = nonzero(-10, 10)
        
        r_ans = sqrt(x_val^2 + y_val^2)
        θ_ans = atan(y_val, x_val)
        if θ_ans < 0
            θ_ans += 2π
        end
        
        r_rounded = round(r_ans, digits=4)
        θ_rounded = round(θ_ans, digits=4)
        
        problem(
            question="Convert the rectangular coordinates \\(($(x_val), $(y_val))\\) to polar coordinates \\((r, \\theta)\\) where \\(r > 0\\) and \\(0 \\leq \\theta < 2\\pi\\).",
            answer=fmt_tuple([r_rounded, θ_rounded]),
            difficulty=(800, 1000),
            answer_type="tuple",
            solution=steps(
                "Given: \\(x = $(x_val), y = $(y_val)\\)",
                "Calculate \\(r = \\sqrt{x^2 + y^2} = \\sqrt{$(x_val^2) + $(y_val^2)} = $(r_rounded)\\)",
                "Calculate \\(\\theta = \\arctan\\left(\\frac{y}{x}\\right)\\) with quadrant adjustment",
                "\\(\\theta \\approx $(θ_rounded)\\) radians",
                sol("Answer", fmt_tuple([r_rounded, θ_rounded]))
            ),
            time=120,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Distance between two polar points
        r1 = randint(2, 10)
        r2 = randint(2, 10)
        θ_angles = [0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, π]
        θ1 = choice(θ_angles)
        θ2 = choice(θ_angles)
        while θ1 == θ2
            θ2 = choice(θ_angles)
        end
        
        dist = sqrt(r1^2 + r2^2 - 2*r1*r2*cos(θ2 - θ1))
        dist_rounded = round(dist, digits=4)
        
        θ1_str = θ1 == 0 ? "0" : θ1 == π ? "\\pi" : θ1 == π/2 ? "\\frac{\\pi}{2}" : θ1 == π/3 ? "\\frac{\\pi}{3}" : θ1 == π/4 ? "\\frac{\\pi}{4}" : θ1 == π/6 ? "\\frac{\\pi}{6}" : θ1 == 2π/3 ? "\\frac{2\\pi}{3}" : "\\frac{3\\pi}{4}"
        θ2_str = θ2 == 0 ? "0" : θ2 == π ? "\\pi" : θ2 == π/2 ? "\\frac{\\pi}{2}" : θ2 == π/3 ? "\\frac{\\pi}{3}" : θ2 == π/4 ? "\\frac{\\pi}{4}" : θ2 == π/6 ? "\\frac{\\pi}{6}" : θ2 == 2π/3 ? "\\frac{2\\pi}{3}" : "\\frac{3\\pi}{4}"
        
        problem(
            question="Find the distance between the two points with polar coordinates \\(($(r1), $(θ1_str))\\) and \\(($(r2), $(θ2_str))\\).",
            answer=dist_rounded,
            difficulty=(900, 1100),
            solution=steps(
                "Use the polar distance formula: \\(d = \\sqrt{r_1^2 + r_2^2 - 2r_1r_2\\cos(\\theta_2 - \\theta_1)}\\)",
                "Substitute: \\(d = \\sqrt{$(r1)^2 + $(r2)^2 - 2($(r1))($(r2))\\cos($(θ2_str) - $(θ1_str))}\\)",
                "Calculate: \\(\\cos($(θ2_str) - $(θ1_str)) = $(round(cos(θ2 - θ1), digits=4))\\)",
                "\\(d = \\sqrt{$(r1^2) + $(r2^2) - $(round(2*r1*r2*cos(θ2 - θ1), digits=4))}\\)",
                sol("Answer", dist_rounded)
            ),
            time=150,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Convert polar equation to rectangular
        eq_type = choice(1:3)
        
        if eq_type == 1
            # r = k (circle centered at origin)
            k = randint(2, 15)
            problem(
                question="Convert the polar equation \\(r = $(k)\\) to rectangular form.",
                answer="x^2+y^2=$(k^2)",
                difficulty=(700, 900),
                solution=steps(
                    "Given: \\(r = $(k)\\)",
                    "Use \\(r^2 = x^2 + y^2\\)",
                    "Square both sides: \\(r^2 = $(k^2)\\)",
                    sol("Answer", "x^2 + y^2 = $(k^2)")
                ),
                time=60
            )
        elseif eq_type == 2
            # θ = k (line through origin)
            θ_vals_simple = [0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π]
            θ_val = choice(θ_vals_simple)
            
            θ_str = θ_val == 0 ? "0" : θ_val == π ? "\\pi" : θ_val == π/2 ? "\\frac{\\pi}{2}" : θ_val == π/3 ? "\\frac{\\pi}{3}" : θ_val == π/4 ? "\\frac{\\pi}{4}" : θ_val == π/6 ? "\\frac{\\pi}{6}" : θ_val == 2π/3 ? "\\frac{2\\pi}{3}" : θ_val == 3π/4 ? "\\frac{3\\pi}{4}" : "\\frac{5\\pi}{6}"
            
            if θ_val == 0
                ans = "y=0"
            elseif θ_val == π
                ans = "y=0"
            elseif θ_val == π/2
                ans = "x=0"
            else
                m = tan(θ_val)
                m_rounded = round(m, digits=4)
                ans = "y=$(m_rounded)x"
            end
            
            problem(
                question="Convert the polar equation \\(\\theta = $(θ_str)\\) to rectangular form.",
                answer=ans,
                difficulty=(800, 1000),
                solution=steps(
                    "Given: \\(\\theta = $(θ_str)\\)",
                    "Use \\(\\tan(\\theta) = \\frac{y}{x}\\)",
                    "\\(\\tan($(θ_str)) = \\frac{y}{x}\\)",
                    sol("Answer", ans)
                ),
                time=90,
                calculator="scientific"
            )
        else
            # r = a cos(θ) or r = a sin(θ)
            a = nonzero(-8, 8)
            is_cos = choice([true, false])
            
            if is_cos
                # r = a cos(θ) => x^2 + y^2 = ax => (x-a/2)^2 + y^2 = (a/2)^2
                problem(
                    question="Convert the polar equation \\(r = $(a)\\cos(\\theta)\\) to rectangular form.",
                    answer="x^2+y^2=$(a)x",
                    difficulty=(900, 1100),
                    solution=steps(
                        "Given: \\(r = $(a)\\cos(\\theta)\\)",
                        "Multiply both sides by \\(r\\): \\(r^2 = $(a)r\\cos(\\theta)\\)",
                        "Use \\(r^2 = x^2 + y^2\\) and \\(x = r\\cos(\\theta)\\)",
                        sol("Answer", "x^2 + y^2 = $(a)x")
                    ),
                    time=90
                )
            else
                # r = a sin(θ) => x^2 + y^2 = ay
                problem(
                    question="Convert the polar equation \\(r = $(a)\\sin(\\theta)\\) to rectangular form.",
                    answer="x^2+y^2=$(a)y",
                    difficulty=(900, 1100),
                    solution=steps(
                        "Given: \\(r = $(a)\\sin(\\theta)\\)",
                        "Multiply both sides by \\(r\\): \\(r^2 = $(a)r\\sin(\\theta)\\)",
                        "Use \\(r^2 = x^2 + y^2\\) and \\(y = r\\sin(\\theta)\\)",
                        sol("Answer", "x^2 + y^2 = $(a)y")
                    ),
                    time=90
                )
            end
        end
        
    else
        # Plot a point in polar coordinates (conceptual)
        r_val = randint(1, 8)
        θ_vals = [π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π, 7π/6, 5π/4, 4π/3, 3π/2, 5π/3, 7π/4, 11π/6]
        θ_val = choice(θ_vals)
        
        x_coord = r_val * cos(θ_val)
        y_coord = r_val * sin(θ_val)
        
        x_rounded = round(x_coord, digits=4)
        y_rounded = round(y_coord, digits=4)
        
        θ_str = θ_val == π/6 ? "\\frac{\\pi}{6}" : θ_val == π/4 ? "\\frac{\\pi}{4}" : θ_val == π/3 ? "\\frac{\\pi}{3}" : θ_val == π/2 ? "\\frac{\\pi}{2}" : θ_val == 2π/3 ? "\\frac{2\\pi}{3}" : θ_val == 3π/4 ? "\\frac{3\\pi}{4}" : θ_val == 5π/6 ? "\\frac{5\\pi}{6}" : θ_val == π ? "\\pi" : θ_val == 7π/6 ? "\\frac{7\\pi}{6}" : θ_val == 5π/4 ? "\\frac{5\\pi}{4}" : θ_val == 4π/3 ? "\\frac{4\\pi}{3}" : θ_val == 3π/2 ? "\\frac{3\\pi}{2}" : θ_val == 5π/3 ? "\\frac{5\\pi}{3}" : θ_val == 7π/4 ? "\\frac{7\\pi}{4}" : "\\frac{11\\pi}{6}"
        
        problem(
            question="What are the rectangular coordinates of the point with polar coordinates \\(($(r_val), $(θ_str))\\)?",
            answer=fmt_tuple([x_rounded, y_rounded]),
            difficulty=(700, 900),
            answer_type="tuple",
            solution=steps(
                "Use x = r*cos(theta) and y = r*sin(theta) to convert",
                sol("Answer", fmt_tuple([x_rounded, y_rounded]))
            ),
            time=90
        )
    end
end
