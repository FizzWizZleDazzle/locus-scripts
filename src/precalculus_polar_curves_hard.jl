# precalculus - polar_curves (hard)
# Generated: 2026-03-08T20:34:14.278257

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_curves")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Area enclosed by polar curve r = a + b*cos(θ)
        a = randint(3, 8)
        b = randint(2, a-1)
        curve = a + b*cos(θ)
        
        # Area = (1/2)∫[0,2π] r² dθ
        r_squared = expand(curve^2)
        # ∫(a + b*cos(θ))² = ∫(a² + 2ab*cos(θ) + b²*cos²(θ))
        # = a²θ + 2ab*sin(θ) + b²(θ/2 + sin(2θ)/4)
        # From 0 to 2π: 2πa² + 0 + πb² = π(2a² + b²)
        area = rationalize(π * (2*a^2 + b^2) / 2)
        
        problem(
            question="Find the area enclosed by the polar curve \$r = $(tex(curve))\$ for \$0 \\leq \\theta \\leq 2\\pi\$.",
            answer=area,
            difficulty=(1850, 2100),
            solution=steps(
                sol("Given", "r = " * tex(curve)),
                "Area formula: \$A = \\frac{1}{2}\\int_0^{2\\pi} r^2 \\, d\\theta\$",
                sol("Set up", "A = \\frac{1}{2}\\int_0^{2\\pi} " * tex(r_squared) * " \\, d\\theta"),
                "Expand and integrate using \$\\int \\cos^2(\\theta) \\, d\\theta = \\frac{\\theta}{2} + \\frac{\\sin(2\\theta)}{4}\$",
                "Evaluate from 0 to \$2\\pi\$: \$\\frac{1}{2}[2\\pi a^2 + \\pi b^2] = \\pi(a^2 + \\frac{b^2}{2})\$",
                sol("Answer", area)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Intersection points of two polar curves
        a = randint(2, 6)
        b = randint(2, 6)
        # r = a*sin(θ) and r = b*cos(θ)
        
        # At intersection: a*sin(θ) = b*cos(θ) => tan(θ) = b/a
        # Also at origin where both can be 0
        
        tan_val = b // a
        theta_val = "\\arctan(" * string(b) * "/" * string(a) * ")"
        r_val = rationalize(a * b / sqrt(a^2 + b^2))
        
        problem(
            question="Find all intersection points (in polar coordinates) of \$r = $(a)\\sin(\\theta)\$ and \$r = $(b)\\cos(\\theta)\$ for \$0 \\leq \\theta < 2\\pi\$. Give your answer as a set of ordered pairs.",
            answer=fmt_set(Set(["(0, \\pi/2)", "($(tex(r_val)), $(theta_val))"])),
            difficulty=(1900, 2200),
            answer_type="set",
            solution=steps(
                "Set \$$(a)\\sin(\\theta) = $(b)\\cos(\\theta)\$",
                "Divide by \$\\cos(\\theta)\$: \$\\tan(\\theta) = \\frac{$(b)}{$(a)}\$, so \$\\theta = $(theta_val)\$",
                "At this angle, \$r = \\frac{$(a*b)}{\\sqrt{$(a^2 + b^2)}}\$",
                "Both curves pass through the origin at different angles: \$(0, \\pi/2)\$ for the first curve",
                sol("Answer", "Intersections at pole and at \$(\\frac{$(a*b)}{\\sqrt{$(a^2 + b^2)}}, $(theta_val))\$")
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Tangent line to polar curve at a point
        a = randint(2, 5)
        n = rand([2, 3, 4])
        theta_val = π // n
        
        # r = a*θ (Archimedean spiral) at θ = π/n
        r_at_theta = rationalize(a * theta_val)
        
        # dy/dx = (dr/dθ * sin(θ) + r*cos(θ)) / (dr/dθ * cos(θ) - r*sin(θ))
        # For r = aθ: dr/dθ = a
        
        problem(
            question="Find the slope of the tangent line to the polar curve \$r = $(a)\\theta\$ at \$\\theta = \\frac{\\pi}{$(n)}\$.",
            answer="symbolic",
            difficulty=(2000, 2300),
            solution=steps(
                sol("Given", "r = $(a)\\theta"),
                "At \$\\theta = \\frac{\\pi}{$(n)}\$: \$r = $(tex(r_at_theta))\$, \$\\frac{dr}{d\\theta} = $(a)\$",
                "Formula: \$\\frac{dy}{dx} = \\frac{\\frac{dr}{d\\theta}\\sin(\\theta) + r\\cos(\\theta)}{\\frac{dr}{d\\theta}\\cos(\\theta) - r\\sin(\\theta)}\$",
                "Substitute values and simplify",
                "The slope involves evaluating \$\\frac{$(a)\\sin(\\pi/$(n)) + $(tex(r_at_theta))\\cos(\\pi/$(n))}{$(a)\\cos(\\pi/$(n)) - $(tex(r_at_theta))\\sin(\\pi/$(n))}\$"
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Arc length of polar curve
        a = randint(2, 6)
        # r = a*e^θ from θ=0 to θ=ln(2)
        
        # L = ∫√(r² + (dr/dθ)²) dθ
        # r = ae^θ, dr/dθ = ae^θ
        # r² + (dr/dθ)² = 2a²e^(2θ)
        # L = ∫a*e^θ*√2 dθ from 0 to ln(2) = a√2[e^(ln(2)) - 1] = a√2
        
        arc_length = rationalize(a * sqrt(2))
        
        problem(
            question="Find the arc length of the polar curve \$r = $(a)e^{\\theta}\$ from \$\\theta = 0\$ to \$\\theta = \\ln(2)\$.",
            answer=arc_length,
            difficulty=(2100, 2400),
            solution=steps(
                sol("Given", "r = $(a)e^{\\theta}"),
                "Arc length formula: \$L = \\int_a^b \\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2} \\, d\\theta\$",
                sol("Compute", "\\frac{dr}{d\\theta} = $(a)e^{\\theta}"),
                "Then \$r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2 = $(a^2)e^{2\\theta} + $(a^2)e^{2\\theta} = $(2*a^2)e^{2\\theta}\$",
                "So \$L = \\int_0^{\\ln(2)} $(a)\\sqrt{2}e^{\\theta} \\, d\\theta = $(a)\\sqrt{2}[e^{\\ln(2)} - 1] = $(a)\\sqrt{2}\$",
                sol("Answer", arc_length)
            ),
            time=220
        )
        
    elseif problem_type == 5
        # Area between two polar curves
        a = randint(3, 7)
        b = randint(1, a-1)
        
        # Area between r = a and r = b from θ=0 to θ=π/2
        # A = (1/2)∫[a² - b²] dθ = (1/2)(a² - b²)(π/2)
        area = rationalize(π * (a^2 - b^2) / 4)
        
        problem(
            question="Find the area of the region that lies inside \$r = $(a)\$ and outside \$r = $(b)\$ for \$0 \\leq \\theta \\leq \\frac{\\pi}{2}\$.",
            answer=area,
            difficulty=(1800, 2050),
            solution=steps(
                "Area between curves: \$A = \\frac{1}{2}\\int_0^{\\pi/2} (r_{outer}^2 - r_{inner}^2) \\, d\\theta\$",
                sol("Set up", "A = \\frac{1}{2}\\int_0^{\\pi/2} ($(a^2) - $(b^2)) \\, d\\theta"),
                "Integrate: \$A = \\frac{1}{2}($(a^2 - b^2))\\theta \\Big|_0^{\\pi/2}\$",
                sol("Evaluate", "A = \\frac{1}{2}($(a^2 - b^2))\\cdot\\frac{\\pi}{2} = $(tex(area))")
            ),
            time=150
        )
        
    else
        # Symmetry and graphing - identify symmetry type
        n = rand([3, 4, 5, 6])
        
        # Rose curve r = a*cos(nθ)
        a = randint(2, 6)
        
        if n % 2 == 0
            petals = 2*n
        else
            petals = n
        end
        
        problem(
            question="The polar curve \$r = $(a)\\cos($(n)\\theta)\$ has what type of symmetry? (Answer with: polar_axis, line_theta_pi_2, or origin)",
            answer="polar_axis",
            difficulty=(1850, 2100),
            solution=steps(
                sol("Given", "r = $(a)\\cos($(n)\\theta)"),
                "Test symmetry about polar axis: replace \$\\theta\$ with \$-\\theta\$",
                "\$r = $(a)\\cos($(n)(-\\theta)) = $(a)\\cos($(n)\\theta)\$ (cosine is even)",
                "The curve is symmetric about the polar axis",
                "This is a rose curve with $(petals) petals"
            ),
            time=120
        )
    end
end