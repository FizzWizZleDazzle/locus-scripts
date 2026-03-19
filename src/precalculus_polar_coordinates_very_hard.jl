# precalculus - polar_coordinates (very_hard)
# Generated: 2026-03-08T20:33:20.730130

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Hard polar curve intersection problem
        a = randint(2, 6)
        b = randint(2, 6)
        # Find intersection of r = a*sin(θ) and r = b*cos(θ)
        # Setting equal: a*sin(θ) = b*cos(θ) => tan(θ) = b/a
        θ_sol = atan(b, a)
        r_sol = a * sin(θ_sol)
        
        # Also intersect at origin
        solutions = Set([(0, 0), (r_sol, θ_sol)])
        
        problem(
            question="Find all points of intersection (in polar coordinates) of the curves \$r = $(a)\\sin\\theta\$ and \$r = $(b)\\cos\\theta\$. Give your answer as a set of ordered pairs \$(r, \\theta)\$ where \$0 \\leq \\theta < 2\\pi\$ and \$r \\geq 0\$. Express \$\\theta\$ as \$\\arctan(b/a)\$ in exact form.",
            answer=fmt_set(Set(["(0, 0)", "($(a*b)/sqrt($(a^2 + b^2)), arctan($(b)/$(a)))"])),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                "Given: \$r = $(a)\\sin\\theta\$ and \$r = $(b)\\cos\\theta\$",
                "Both curves pass through the origin at different values of \$\\theta\$",
                "For non-origin intersection: \$$(a)\\sin\\theta = $(b)\\cos\\theta\$",
                "Therefore \$\\tan\\theta = \\frac{$(b)}{$(a)}\$, so \$\\theta = \\arctan(\\frac{$(b)}{$(a)})\$",
                "Substituting back: \$r = $(a)\\sin(\\arctan(\\frac{$(b)}{$(a)})) = \\frac{$(a*b)}{\\sqrt{$(a^2 + b^2)}}\$",
                "Solutions: \$\\{(0, 0), (\\frac{$(a*b)}{\\sqrt{$(a^2 + b^2)}}, \\arctan(\\frac{$(b)}{$(a)}))\\}\$"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Area enclosed by polar curve with multiple petals
        n = rand([3, 5, 7])  # odd number for interesting symmetry
        a = randint(2, 5)
        # Area of r = a*sin(n*θ) with n petals
        # One petal area = (1/2)∫₀^(π/n) a²sin²(nθ)dθ = a²π/(4n)
        # Total area = n * a²π/(4n) = a²π/4
        area_num = a^2
        
        problem(
            question="Find the total area enclosed by all petals of the rose curve \$r = $(a)\\sin($(n)\\theta)\$.",
            answer="$(area_num)π/4",
            difficulty=(2600, 2900),
            solution=steps(
                "The curve \$r = $(a)\\sin($(n)\\theta)\$ has $(n) petals",
                "Area of one petal: \$A_1 = \\frac{1}{2}\\int_0^{\\pi/$(n)} ($(a)\\sin($(n)\\theta))^2 d\\theta\$",
                "Simplify: \$A_1 = \\frac{$(a^2)}{2}\\int_0^{\\pi/$(n)} \\sin^2($(n)\\theta) d\\theta\$",
                "Using \$\\sin^2(u) = \\frac{1 - \\cos(2u)}{2}\$: \$A_1 = \\frac{$(a^2)}{4}\\int_0^{\\pi/$(n)} (1 - \\cos($(2*n)\\theta)) d\\theta\$",
                "Evaluating: \$A_1 = \\frac{$(a^2)}{4} \\cdot \\frac{\\pi}{$(n)} = \\frac{$(a^2)\\pi}{$(4*n)}\$",
                "Total area: \$A = $(n) \\cdot \\frac{$(a^2)\\pi}{$(4*n)} = \\frac{$(area_num)\\pi}{4}\$"
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Complex polar equation solving
        a = randint(3, 8)
        b = randint(2, 5)
        # Solve r² = a²cos(2θ) for specific θ value
        θ_val = rand([30, 45, 60])  # degrees
        θ_rad_num = θ_val
        θ_rad_den = 180
        
        cos_2theta = cos(2 * θ_val * π / 180)
        r_squared = a^2 * cos_2theta
        
        if r_squared >= 0
            r_val = sqrt(r_squared)
            problem(
                question="For the lemniscate \$r^2 = $(a^2)\\cos(2\\theta)\$, find the value of \$r\$ when \$\\theta = $(θ_val)°\$. Express your answer in simplified radical form, or state that no real value exists.",
                answer=r_val,
                difficulty=(2400, 2700),
                solution=steps(
                    "Given: \$r^2 = $(a^2)\\cos(2\\theta)\$ at \$\\theta = $(θ_val)° = \\frac{$(θ_val)\\pi}{180}\$",
                    "Calculate: \$\\cos(2 \\cdot $(θ_val)°) = \\cos($(2*θ_val)°) = $(cos_2theta)\$",
                    "Therefore: \$r^2 = $(a^2) \\cdot $(cos_2theta) = $(r_squared)\$",
                    "Taking square root: \$r = \\sqrt{$(r_squared)}\$",
                    sol("Answer", r_val)
                ),
                time=240
            )
        else
            problem(
                question="For the lemniscate \$r^2 = $(a^2)\\cos(2\\theta)\$, find the value of \$r\$ when \$\\theta = $(θ_val)°\$. Express your answer in simplified radical form, or state that no real value exists.",
                answer="no real value",
                answer_type="text",
                difficulty=(2400, 2700),
                solution=steps(
                    "Given: \$r^2 = $(a^2)\\cos(2\\theta)\$ at \$\\theta = $(θ_val)° = \\frac{$(θ_val)\\pi}{180}\$",
                    "Calculate: \$\\cos(2 \\cdot $(θ_val)°) = \\cos($(2*θ_val)°) = $(cos_2theta)\$",
                    "Therefore: \$r^2 = $(a^2) \\cdot $(cos_2theta) = $(r_squared)\$",
                    "Since \$r^2 < 0\$, no real value of \$r\$ exists",
                    "Answer: no real value"
                ),
                time=240
            )
        end
        
    elseif problem_type == 4
        # Arc length in polar coordinates
        a = randint(2, 5)
        # Arc length of r = a*e^(θ) from 0 to π
        # L = ∫√(r² + (dr/dθ)²)dθ = ∫√(a²e^(2θ) + a²e^(2θ))dθ = a√2∫e^θ dθ
        # L = a√2[e^π - 1]
        
        problem(
            question="Find the arc length of the spiral \$r = $(a)e^\\theta\$ from \$\\theta = 0\$ to \$\\theta = \\pi\$.",
            answer="$(a)*sqrt(2)*(e^π - 1)",
            difficulty=(2700, 3100),
            solution=steps(
                "Arc length formula: \$L = \\int_0^\\pi \\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2} d\\theta\$",
                "Given \$r = $(a)e^\\theta\$, we have \$\\frac{dr}{d\\theta} = $(a)e^\\theta\$",
                "Therefore: \$\\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2} = \\sqrt{$(a^2)e^{2\\theta} + $(a^2)e^{2\\theta}} = $(a)\\sqrt{2}e^\\theta\$",
                "Integrate: \$L = \\int_0^\\pi $(a)\\sqrt{2}e^\\theta d\\theta = $(a)\\sqrt{2}[e^\\theta]_0^\\pi\$",
                "Evaluate: \$L = $(a)\\sqrt{2}(e^\\pi - e^0) = $(a)\\sqrt{2}(e^\\pi - 1)\$"
            ),
            time=300
        )
        
    else  # problem_type == 5
        # Distance between two points in polar coordinates
        r1 = randint(3, 10)
        r2 = randint(3, 10)
        θ_deg = rand([60, 90, 120])
        
        # Distance formula: d² = r1² + r2² - 2*r1*r2*cos(θ2 - θ1)
        # Use θ1 = 0, θ2 = θ_deg
        cos_theta = cos(θ_deg * π / 180)
        d_squared = r1^2 + r2^2 - 2*r1*r2*cos_theta
        d = sqrt(d_squared)
        
        problem(
            question="Find the distance between the points \$($(r1), 0)\$ and \$($(r2), $(θ_deg)°)\$ given in polar coordinates. Express your answer in simplified radical form.",
            answer=d,
            difficulty=(2500, 2800),
            solution=steps(
                "Distance formula in polar coordinates: \$d = \\sqrt{r_1^2 + r_2^2 - 2r_1r_2\\cos(\\theta_2 - \\theta_1)}\$",
                "Given: \$(r_1, \\theta_1) = ($(r1), 0)\$ and \$(r_2, \\theta_2) = ($(r2), $(θ_deg)°)\$",
                "Calculate: \$\\cos($(θ_deg)° - 0°) = \\cos($(θ_deg)°) = $(cos_theta)\$",
                "Substitute: \$d = \\sqrt{$(r1)^2 + $(r2)^2 - 2($(r1))($(r2))($(cos_theta))}\$",
                "Simplify: \$d = \\sqrt{$(r1^2) + $(r2^2) - $(2*r1*r2*cos_theta)} = \\sqrt{$(d_squared)}\$",
                sol("Answer", d)
            ),
            time=240
        )
    end
end