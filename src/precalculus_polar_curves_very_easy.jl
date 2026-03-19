# precalculus - polar_curves (very_easy)
# Generated: 2026-03-08T20:33:30.797873

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_curves")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Convert simple polar point to Cartesian (ELO 300-500)
        r_val = randint(2, 8)
        θ_vals = [0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π]
        θ_labels = ["0", "\\frac{\\pi}{6}", "\\frac{\\pi}{4}", "\\frac{\\pi}{3}", "\\frac{\\pi}{2}", "\\frac{\\frac{2\\pi}{3}}", "\\frac{3\\pi}{4}", "\\frac{5\\pi}{6}", "\\pi"]
        idx = rand(1:length(θ_vals))
        θ_val = θ_vals[idx]
        θ_label = θ_labels[idx]
        
        x_val = r_val * cos(θ_val)
        y_val = r_val * sin(θ_val)
        
        x_ans = round(x_val, digits=3)
        y_ans = round(y_val, digits=3)
        
        problem(
            question="Convert the polar point \\(($(r_val), $(θ_label))\\) to Cartesian coordinates \\((x, y)\\). Round to 3 decimal places if necessary.",
            answer=fmt_tuple([x_ans, y_ans]),
            difficulty=(300, 500),
            answer_type="tuple",
            solution=steps(
                "Given polar coordinates: \\((r, \\theta) = ($(r_val), $(θ_label))\\)",
                "Use formulas: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\)",
                "\\(x = $(r_val)\\cos($(θ_label)) = $(x_ans)\\)",
                "\\(y = $(r_val)\\sin($(θ_label)) = $(y_ans)\\)",
                sol("Answer", (x_ans, y_ans))
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Identify the shape of a polar curve (ELO 400-600)
        shapes = [
            ("r = $(randint(2,9))", "circle"),
            ("r = $(randint(2,8))\\cos\\theta", "circle"),
            ("r = $(randint(2,8))\\sin\\theta", "circle"),
            ("\\theta = \\frac{\\pi}{$(rand([2,3,4,6]))}", "line")
        ]
        
        shape_data = choice(shapes)
        eq = shape_data[1]
        ans = shape_data[2]
        
        problem(
            question="What type of curve does the polar equation \\($(eq)\\) represent?",
            answer=ans,
            difficulty=(400, 600),
            answer_type="text",
            solution=steps(
                "Given polar equation: \\($(eq)\\)",
                "Analyze the form of the equation",
                ans == "circle" ? "This is the equation of a circle in polar coordinates" : "This is the equation of a line through the origin",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Find r-value at specific angle (ELO 200-400)
        a = randint(3, 12)
        θ_vals = [0, π/2, π, 3π/2]
        θ_labels = ["0", "\\frac{\\pi}{2}", "\\pi", "\\frac{3\\pi}{2}"]
        idx = rand(1:4)
        θ_val = θ_vals[idx]
        θ_label = θ_labels[idx]
        
        curve_type = rand(1:2)
        if curve_type == 1
            # r = a + b*cos(θ)
            b = randint(2, 8)
            r_ans = a + b * cos(θ_val)
            eq = "r = $(a) + $(b)\\cos\\theta"
        else
            # r = a + b*sin(θ)
            b = randint(2, 8)
            r_ans = a + b * sin(θ_val)
            eq = "r = $(a) + $(b)\\sin\\theta"
        end
        
        problem(
            question="For the polar curve \\($(eq)\\), find the value of \\(r\\) when \\(\\theta = $(θ_label)\\).",
            answer=r_ans,
            difficulty=(200, 400),
            solution=steps(
                "Given: \\($(eq)\\)",
                "Substitute \\(\\theta = $(θ_label)\\)",
                "Calculate the trigonometric value",
                sol("Answer", r_ans)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Convert Cartesian point to polar (simple cases, ELO 400-650)
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180]
        angle_deg = choice(angles)
        angle_rad = angle_deg * π / 180
        
        r_val = randint(3, 10)
        x_val = round(r_val * cos(angle_rad), digits=3)
        y_val = round(r_val * sin(angle_rad), digits=3)
        
        # For cleaner display
        if abs(x_val - round(x_val)) < 0.001
            x_val = round(Int, x_val)
        end
        if abs(y_val - round(y_val)) < 0.001
            y_val = round(Int, y_val)
        end
        
        problem(
            question="Convert the Cartesian point \\(($(x_val), $(y_val))\\) to polar coordinates \\((r, \\theta)\\) where \\(r > 0\\) and \\(0 \\leq \\theta < 2\\pi\\). Express \\(r\\) as a positive number.",
            answer=fmt_tuple([r_val, angle_rad]),
            difficulty=(400, 650),
            answer_type="tuple",
            solution=steps(
                "Given Cartesian coordinates: \\(($(x_val), $(y_val))\\)",
                "Use formulas: \\(r = \\sqrt{x^2 + y^2}\\), \\(\\theta = \\arctan(y/x)\\)",
                "\\(r = \\sqrt{$(x_val)^2 + $(y_val)^2} = $(r_val)\\)",
                "\\(\\theta = $(angle_rad)\\) radians",
                sol("Answer", (r_val, angle_rad))
            ),
            time=120
        )
        
    else
        # Determine if point is on polar curve (ELO 300-550)
        a = randint(4, 12)
        test_angle = choice([0, π/4, π/2, 3π/4, π])
        test_angle_labels = ["0", "\\frac{\\pi}{4}", "\\frac{\\pi}{2}", "\\frac{3\\pi}{4}", "\\pi"]
        angle_label = test_angle_labels[findfirst(==(test_angle), [0, π/4, π/2, 3π/4, π])]
        
        # Create r = a equation
        is_on = rand([true, false])
        if is_on
            test_r = a
        else
            test_r = a + randint(2, 5)
        end
        
        ans = is_on ? "yes" : "no"
        
        problem(
            question="Is the point \\(($(test_r), $(angle_label))\\) on the polar curve \\(r = $(a)\\)? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(300, 550),
            answer_type="text",
            solution=steps(
                "Given polar curve: \\(r = $(a)\\)",
                "Test point: \\(($(test_r), $(angle_label))\\)",
                "For the point to be on the curve, its \\(r\\)-coordinate must equal $(a)",
                "Since \\($(test_r) $(is_on ? "=" : "\\neq") $(a)\\), the point is $(is_on ? "" : "not ")on the curve",
                sol("Answer", ans)
            ),
            time=75
        )
    end
end