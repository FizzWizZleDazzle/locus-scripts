# precalculus - polar_curves (easy)
# Generated: 2026-03-08T20:33:51.984062

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_curves")
    
    prob_type = choice(1:5)
    
    if prob_type == 1
        # Convert simple polar point to Cartesian
        r_val = randint(2, 12)
        θ_val = choice([0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π, 7π/6, 5π/4, 4π/3, 3π/2, 5π/3, 7π/4, 11π/6])
        
        x_ans = r_val * cos(θ_val)
        y_ans = r_val * sin(θ_val)
        
        θ_display = if θ_val == 0
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
        elseif θ_val == 5π/3
            "\\frac{5\\pi}{3}"
        elseif θ_val == 7π/6
            "\\frac{7\\pi}{6}"
        elseif θ_val == 5π/4
            "\\frac{5\\pi}{4}"
        elseif θ_val == 7π/4
            "\\frac{7\\pi}{4}"
        else
            "\\frac{11\\pi}{6}"
        end
        
        problem(
            question="Convert the polar point \\(($(r_val), $(θ_display))\\) to Cartesian coordinates.",
            answer=fmt_tuple([x_ans, y_ans]),
            difficulty=(700, 850),
            answer_type="point",
            solution=steps(
                "Use the conversion formulas: \$x = r\\cos(\\theta)\$ and \$y = r\\sin(\\theta)\$",
                "\$x = $(r_val)\\cos($(θ_display)) = $(x_ans)\$",
                "\$y = $(r_val)\\sin($(θ_display)) = $(y_ans)\$",
                "Answer: \$($(x_ans), $(y_ans))\$"
            ),
            time=90,
        )
        
    elseif prob_type == 2
        # Convert Cartesian point to polar (positive r)
        x_val = choice([-6, -4, -3, -2, -1, 1, 2, 3, 4, 6])
        y_val = choice([-6, -4, -3, -2, -1, 1, 2, 3, 4, 6])
        
        r_ans = sqrt(x_val^2 + y_val^2)
        θ_ans = atan(y_val, x_val)
        if θ_ans < 0
            θ_ans += 2π
        end
        
        problem(
            question="Convert the Cartesian point \\(($(x_val), $(y_val))\\) to polar coordinates \\((r, \\theta)\\) where \\(r > 0\\) and \\(0 \\le \\theta < 2\\pi\\). Express \\(\\theta\\) in radians.",
            answer=fmt_tuple([r_ans, θ_ans]),
            difficulty=(850, 1000),
            answer_type="point",
            solution=steps(
                "Use \$r = \\sqrt{x^2 + y^2}\$ and \$\\theta = \\arctan(y/x)\$ (adjusted for quadrant)",
                "\$r = \\sqrt{$(x_val)^2 + $(y_val)^2} = \\sqrt{$(x_val^2 + y_val^2)} = $(r_ans)\$",
                "\$\\theta = \\arctan($(y_val)/$(x_val)) = $(θ_ans)\$ radians",
                "Answer: \$($(r_ans), $(θ_ans))\$"
            ),
            calculator="scientific",
            time=120,
        )
        
    elseif prob_type == 3
        # Identify polar curve type
        curve_choice = choice(1:4)
        
        if curve_choice == 1
            a = randint(2, 8)
            equation = "r = $(a)"
            answer = "circle centered at origin with radius $(a)"
            curve_type = "Circle"
        elseif curve_choice == 2
            a = randint(2, 8)
            equation = "r = $(a)\\cos(\\theta)"
            answer = "circle"
            curve_type = "Circle (shifted)"
        elseif curve_choice == 3
            a = randint(2, 8)
            n = choice([3, 4, 5, 6])
            equation = "r = $(a)\\sin($(n)\\theta)"
            answer = "rose curve with $(n) petals"
            curve_type = "Rose"
        else
            a = randint(2, 8)
            equation = "r = $(a) + $(a)\\cos(\\theta)"
            answer = "cardioid"
            curve_type = "Cardioid"
        end
        
        problem(
            question="Identify the type of curve represented by the polar equation \$$(equation)\$.",
            answer=answer,
            difficulty=(750, 900),
            answer_type="text",
            solution=steps(
                "Given: \$$(equation)\$",
                "Recognize the standard form",
                "This is a $(curve_type)",
                "Answer: $(answer)"
            ),
            time=60,
        )
        
    elseif prob_type == 4
        # Find r at specific θ
        a = randint(2, 8)
        form_choice = choice(1:3)
        
        if form_choice == 1
            θ_val = choice([0, π/4, π/2, 3π/4, π])
            θ_display = θ_val == 0 ? "0" : θ_val == π ? "\\pi" : θ_val == π/2 ? "\\frac{\\pi}{2}" : θ_val == π/4 ? "\\frac{\\pi}{4}" : "\\frac{3\\pi}{4}"
            r_ans = a + a*cos(θ_val)
            equation = "r = $(a) + $(a)\\cos(\\theta)"
        elseif form_choice == 2
            θ_val = choice([0, π/6, π/4, π/3, π/2])
            θ_display = θ_val == 0 ? "0" : θ_val == π/2 ? "\\frac{\\pi}{2}" : θ_val == π/3 ? "\\frac{\\pi}{3}" : θ_val == π/4 ? "\\frac{\\pi}{4}" : "\\frac{\\pi}{6}"
            r_ans = a*cos(θ_val)
            equation = "r = $(a)\\cos(\\theta)"
        else
            θ_val = choice([0, π/6, π/4, π/3, π/2])
            θ_display = θ_val == 0 ? "0" : θ_val == π/2 ? "\\frac{\\pi}{2}" : θ_val == π/3 ? "\\frac{\\pi}{3}" : θ_val == π/4 ? "\\frac{\\pi}{4}" : "\\frac{\\pi}{6}"
            r_ans = a*sin(θ_val)
            equation = "r = $(a)\\sin(\\theta)"
        end
        
        problem(
            question="Find the value of \\(r\\) when \\(\\theta = $(θ_display)\\) for the polar curve \$$(equation)\$.",
            answer=r_ans,
            difficulty=(700, 850),
            solution=steps(
                "Given: \$$(equation)\$",
                "Substitute \$\\theta = $(θ_display)\$",
                "Calculate the value",
                sol("Answer", r_ans)
            ),
            time=75,
        )
        
    else
        # Convert polar equation to Cartesian
        eq_choice = choice(1:3)
        
        if eq_choice == 1
            a = randint(2, 10)
            polar_eq = "r = $(a)"
            cartesian_eq = "x^2 + y^2 = $(a^2)"
            answer = cartesian_eq
        elseif eq_choice == 2
            a = randint(2, 8)
            polar_eq = "r = $(a)\\cos(\\theta)"
            cartesian_eq = "x^2 + y^2 = $(a)x"
            answer = cartesian_eq
        else
            a = randint(2, 8)
            polar_eq = "r = $(a)\\sin(\\theta)"
            cartesian_eq = "x^2 + y^2 = $(a)y"
            answer = cartesian_eq
        end
        
        problem(
            question="Convert the polar equation \$$(polar_eq)\$ to Cartesian form.",
            answer=answer,
            difficulty=(900, 1100),
            answer_type="equation",
            solution=steps(
                "Given: \$$(polar_eq)\$",
                "Use \$r^2 = x^2 + y^2\$, \$x = r\\cos(\\theta)\$, \$y = r\\sin(\\theta)\$",
                "Multiply through and substitute",
                "Answer: \$$(cartesian_eq)\$"
            ),
            time=120,
        )
    end
end