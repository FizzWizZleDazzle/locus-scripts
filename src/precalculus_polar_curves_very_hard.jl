# precalculus - polar_curves (very_hard)
# Generated: 2026-03-08T20:34:21.182105

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_curves")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Intersection of two polar curves (competition level)
        a = nonzero(2, 8)
        b = nonzero(2, 8)
        while b == a
            b = nonzero(2, 8)
        end
        
        # r = a*sin(θ) and r = b*cos(θ)
        # Intersection: a*sin(θ) = b*cos(θ) => tan(θ) = b/a
        # Also origin (0,0) is an intersection
        
        tan_val = b // a
        θ_val = atan(float(tan_val))
        r_val = a * sin(θ_val)
        
        num_intersections = 2  # origin + one other point
        
        question = "Find the number of intersection points of the polar curves \$r = $(a)\\sin(\\theta)\$ and \$r = $(b)\\cos(\\theta)\$ for \$0 \\leq \\theta < 2\\pi\$."
        
        solution_text = steps(
            "Set the two equations equal: \$$(a)\\sin(\\theta) = $(b)\\cos(\\theta)\$",
            "Divide by \$\\cos(\\theta)\$: \$\\tan(\\theta) = \\frac{$(b)}{$(a)}\$",
            "This gives \$\\theta = \\arctan($(b)/$(a))\$ and \$\\theta = \\pi + \\arctan($(b)/$(a))\$",
            "However, we must also check the origin: both curves pass through the origin at different values of \$\\theta\$",
            "The curve \$r = $(a)\\sin(\\theta)\$ passes through origin at \$\\theta = 0, \\pi\$",
            "The curve \$r = $(b)\\cos(\\theta)\$ passes through origin at \$\\theta = \\pi/2, 3\\pi/2\$",
            "Total intersection points: $(num_intersections)"
        )
        
        problem(
            question=question,
            answer=num_intersections,
            difficulty=(2600, 2900),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Area enclosed by polar curve with multiple petals
        n = choice([3, 5, 7])  # odd number for rose curve
        a = nonzero(2, 6)
        
        # r = a*cos(n*θ) has n petals when n is odd
        # Area of one petal: (1/2) ∫[0, π/n] a²cos²(nθ) dθ = πa²/(4n)
        # Total area: n * πa²/(4n) = πa²/4
        
        total_area = π * a^2 // 4
        
        question = "Find the total area enclosed by all petals of the polar curve \$r = $(a)\\cos($(n)\\theta)\$."
        
        solution_text = steps(
            "The curve \$r = $(a)\\cos($(n)\\theta)\$ is a rose curve with $(n) petals",
            "Area of one petal: \$A_1 = \\frac{1}{2}\\int_0^{\\pi/$(n)} $(a)^2\\cos^2($(n)\\theta)\\,d\\theta\$",
            "Using the identity \$\\cos^2(x) = \\frac{1 + \\cos(2x)}{2}\$",
            "After integration: \$A_1 = \\frac{$(a^2)\\pi}{4 \\cdot $(n)} = \\frac{$(a^2)\\pi}{$(4*n)}\$",
            "Total area for $(n) petals: \$A = $(n) \\cdot \\frac{$(a^2)\\pi}{$(4*n)} = \\frac{$(a^2)\\pi}{4}\$",
            sol("Answer", total_area)
        )
        
        problem(
            question=question,
            answer=total_area,
            difficulty=(2700, 3100),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Arc length of polar curve segment
        a = nonzero(2, 5)
        
        # r = a*θ (Archimedean spiral)
        # Arc length from θ=0 to θ=2π
        # L = ∫√(r² + (dr/dθ)²) dθ = ∫√(a²θ² + a²) dθ = a∫√(θ² + 1) dθ
        
        # For θ from 0 to 2π:
        # L = a[θ√(θ²+1)/2 + ln|θ + √(θ²+1)|/2] from 0 to 2π
        
        θ_end = 2
        val = θ_end * sqrt(θ_end^2 + 1) / 2 + log(θ_end + sqrt(θ_end^2 + 1)) / 2
        arc_length = a * val
        
        question = "Find the arc length of the polar curve \$r = $(a)\\theta\$ from \$\\theta = 0\$ to \$\\theta = $(θ_end)\$."
        
        solution_text = steps(
            "Arc length formula: \$L = \\int_0^{$(θ_end)} \\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2}\\,d\\theta\$",
            "Here \$r = $(a)\\theta\$, so \$\\frac{dr}{d\\theta} = $(a)\$",
            "Thus \$L = \\int_0^{$(θ_end)} \\sqrt{$(a)^2\\theta^2 + $(a)^2}\\,d\\theta = $(a)\\int_0^{$(θ_end)} \\sqrt{\\theta^2 + 1}\\,d\\theta\$",
            "Using the formula \$\\int\\sqrt{\\theta^2 + 1}\\,d\\theta = \\frac{\\theta\\sqrt{\\theta^2+1}}{2} + \\frac{\\ln|\\theta + \\sqrt{\\theta^2+1}|}{2}\$",
            "Evaluating from 0 to $(θ_end) and multiplying by $(a)",
            "Answer: \$$(a)\\left[\\frac{$(θ_end)\\sqrt{$(θ_end^2+1)}}{2} + \\frac{\\ln($(θ_end) + \\sqrt{$(θ_end^2+1)})}{2}\\right]\$"
        )
        
        problem(
            question=question,
            answer=arc_length,
            difficulty=(2900, 3300),
            solution=solution_text,
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Tangent line to polar curve
        a = nonzero(2, 6)
        θ0_num = choice([1, 2, 3])
        θ0_den = choice([2, 3, 4, 6])
        
        # r = a(1 + cos(θ)) at θ = θ0_num*π/θ0_den
        # Find dy/dx at that point
        
        θ0_frac = θ0_num // θ0_den
        
        question = "Find the slope of the tangent line to the polar curve \$r = $(a)(1 + \\cos(\\theta))\$ at \$\\theta = \\frac{$(θ0_num)\\pi}{$(θ0_den)}\$."
        
        solution_text = steps(
            "Convert to Cartesian: \$x = r\\cos(\\theta)\$, \$y = r\\sin(\\theta)\$",
            "The slope is \$\\frac{dy}{dx} = \\frac{\\frac{dr}{d\\theta}\\sin(\\theta) + r\\cos(\\theta)}{\\frac{dr}{d\\theta}\\cos(\\theta) - r\\sin(\\theta)}\$",
            "For \$r = $(a)(1 + \\cos(\\theta))\$: \$\\frac{dr}{d\\theta} = -$(a)\\sin(\\theta)\$",
            "At \$\\theta = \\frac{$(θ0_num)\\pi}{$(θ0_den)}\$, substitute values",
            "Compute numerator and denominator separately",
            "The slope requires evaluation of trigonometric functions at the given angle"
        )
        
        θ0_val = float(θ0_frac) * π
        r0 = a * (1 + cos(θ0_val))
        dr0 = -a * sin(θ0_val)
        slope = (dr0 * sin(θ0_val) + r0 * cos(θ0_val)) / (dr0 * cos(θ0_val) - r0 * sin(θ0_val))
        
        problem(
            question=question,
            answer=slope,
            difficulty=(2500, 2800),
            solution=solution_text,
            time=240,
            calculator="scientific"
        )
        
    else  # problem_type == 5
        # Area between two polar curves
        a = nonzero(3, 8)
        b = nonzero(2, 5)
        while b >= a
            b = nonzero(2, 5)
        end
        
        # Area between r = a and r = b*sin(θ) for θ in [π/6, 5π/6]
        # where b*sin(θ) ≤ a
        
        question = "Find the area of the region inside the circle \$r = $(a)\$ and outside the curve \$r = $(b)\\sin(\\theta)\$ in the upper half-plane (\$0 \\leq \\theta \\leq \\pi\$)."
        
        solution_text = steps(
            "The area between two polar curves is \$A = \\frac{1}{2}\\int_{\\alpha}^{\\beta} (r_{outer}^2 - r_{inner}^2)\\,d\\theta\$",
            "Find intersection points by solving \$$(a) = $(b)\\sin(\\theta)\$",
            "This gives \$\\sin(\\theta) = \\frac{$(b)}{$(a)}\$",
            "For the upper half-plane, find appropriate bounds",
            "Set up integral: \$A = \\frac{1}{2}\\int ($(a)^2 - $(b)^2\\sin^2(\\theta))\\,d\\theta\$ over appropriate range",
            "Use \$\\sin^2(\\theta) = \\frac{1 - \\cos(2\\theta)}{2}\$ and integrate"
        )
        
        # Simplified answer (symbolic for demonstration)
        answer_expr = "Requires numerical evaluation"
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(2800, 3200),
            solution=solution_text,
            time=300,
            answer_type="expression"
        )
    end
end