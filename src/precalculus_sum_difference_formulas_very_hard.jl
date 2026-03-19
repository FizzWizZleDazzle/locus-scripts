# precalculus - sum_difference_formulas (very_hard)
# Generated: 2026-03-08T20:30:28.898423

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/sum_difference_formulas")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Prove a challenging identity using sum/difference formulas
        # ELO: 2500-3000
        angle_pair = choice([
            (x, y, "\\sin(x+y)\\sin(x-y)", "\\sin^2(x) - \\sin^2(y)"),
            (x, y, "\\cos(x+y)\\cos(x-y)", "\\cos^2(x) - \\sin^2(y)"),
            (x, y, "\\sin(x+y)\\cos(x-y) + \\cos(x+y)\\sin(x-y)", "\\sin(2x)"),
            (x, y, "\\tan(x+y) - \\tan(x-y)", "\\frac{2\\tan(y)(1-\\tan^2(x))}{1-\\tan^2(x)\\tan^2(y)}"),
        ])
        
        lhs_tex = angle_pair[3]
        rhs_tex = angle_pair[4]
        
        problem(
            question="Prove the identity: \$$(lhs_tex) = $(rhs_tex)\$",
            answer=rhs_tex,
            difficulty=(2500, 3000),
            solution=steps(
                "Start with LHS: \$$(lhs_tex)\$",
                "Apply sum and difference formulas: \$\\sin(A \\pm B) = \\sin A \\cos B \\pm \\cos A \\sin B\$ and \$\\cos(A \\pm B) = \\cos A \\cos B \\mp \\sin A \\sin B\$",
                "Expand and simplify using product formulas",
                "Apply Pythagorean identities where needed",
                "Combine like terms to obtain RHS: \$$(rhs_tex)\$"
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Exact value computation requiring multiple formula applications
        # ELO: 2600-3200
        base_angles = [15, 75, 105, 165, 195, 255, 285, 345]
        angle_deg = choice(base_angles)
        
        trig_func = choice(["\\sin", "\\cos", "\\tan"])
        
        # Construct exact answer based on known values
        exact_answers = Dict(
            15 => ("\\sin", "\\frac{\\sqrt{6}-\\sqrt{2}}{4}"),
            15 => ("\\cos", "\\frac{\\sqrt{6}+\\sqrt{2}}{4}"),
            15 => ("\\tan", "2-\\sqrt{3}"),
            75 => ("\\sin", "\\frac{\\sqrt{6}+\\sqrt{2}}{4}"),
            75 => ("\\cos", "\\frac{\\sqrt{6}-\\sqrt{2}}{4}"),
            75 => ("\\tan", "2+\\sqrt{3}"),
            105 => ("\\sin", "\\frac{\\sqrt{6}+\\sqrt{2}}{4}"),
            105 => ("\\cos", "-\\frac{\\sqrt{6}-\\sqrt{2}}{4}"),
            165 => ("\\sin", "\\frac{\\sqrt{6}-\\sqrt{2}}{4}"),
            165 => ("\\cos", "-\\frac{\\sqrt{6}+\\sqrt{2}}{4}"),
        )
        
        decomp = choice([
            (15, "45° - 30°"),
            (75, "45° + 30°"),
            (105, "60° + 45°"),
            (165, "120° + 45°"),
        ])
        
        angle_deg = decomp[1]
        decomp_str = decomp[2]
        
        problem(
            question="Find the exact value of \$$(trig_func)($(angle_deg)°)\$ using sum or difference formulas.",
            answer="\\frac{\\sqrt{6}-\\sqrt{2}}{4}",
            difficulty=(2600, 3200),
            solution=steps(
                "Write \$$(angle_deg)°\$ as a sum or difference of special angles: \$$(decomp_str)\$",
                "Apply the $(trig_func) sum/difference formula",
                "Substitute known exact values for \$30°, 45°, 60°\$ angles",
                "Simplify radicals and fractions",
                "Final exact form (rationalized)"
            ),
            time=240,
        )
        
    elseif problem_type == 3
        # System involving sum formulas with constraints
        # ELO: 2800-3400
        
        k = randint(2, 5)
        m = randint(2, 5)
        
        problem(
            question="Let \$\\alpha\$ and \$\\beta\$ be acute angles such that \$\\sin(\\alpha) = \\frac{$(k)}{$(k+1)}\$ and \$\\cos(\\beta) = \\frac{$(m)}{$(m+2)}\$. Find the exact value of \$\\sin(\\alpha + \\beta)\$.",
            answer="\\frac{$(k*m + k + 1)}{$(((k+1)*(m+2))))}",
            difficulty=(2800, 3400),
            solution=steps(
                "Given: \$\\sin(\\alpha) = \\frac{$(k)}{$(k+1)}\$ and \$\\cos(\\beta) = \\frac{$(m)}{$(m+2)}\$",
                "Use Pythagorean identity to find \$\\cos(\\alpha) = \\sqrt{1 - \\sin^2(\\alpha)} = \\frac{\\sqrt{2$(k)+1}}{$(k+1)}\$",
                "Similarly find \$\\sin(\\beta) = \\sqrt{1 - \\cos^2(\\beta)} = \\frac{\\sqrt{$(4*m+4)}}{$(m+2)}\$",
                "Apply formula: \$\\sin(\\alpha + \\beta) = \\sin(\\alpha)\\cos(\\beta) + \\cos(\\alpha)\\sin(\\beta)\$",
                "Substitute and simplify to obtain exact value"
            ),
            time=280,
        )
        
    elseif problem_type == 4
        # Olympiad-style: find all solutions using sum formulas
        # ELO: 3000-3500
        
        n = randint(2, 4)
        
        problem(
            question="Find all solutions \$x \\in [0, 2\\pi)\$ to the equation \$\\sin($(n)x) + \\sin(x) = 0\$.",
            answer="\\{0, \\frac{\\pi}{$(n+1)}, \\frac{2\\pi}{$(n+1)}, \\ldots\\}",
            difficulty=(3000, 3500),
            solution=steps(
                "Apply sum-to-product formula: \$\\sin A + \\sin B = 2\\sin\\left(\\frac{A+B}{2}\\right)\\cos\\left(\\frac{A-B}{2}\\right)\$",
                "Rewrite as \$2\\sin\\left(\\frac{$(n+1)x}{2}\\right)\\cos\\left(\\frac{$(n-1)x}{2}\\right) = 0\$",
                "Set each factor to zero: \$\\sin\\left(\\frac{$(n+1)x}{2}\\right) = 0\$ or \$\\cos\\left(\\frac{$(n-1)x}{2}\\right) = 0\$",
                "Solve each equation in \$[0, 2\\pi)\$",
                "Combine solutions and eliminate duplicates"
            ),
            time=300,
        )
        
    else
        # Competition problem: verify identity with parameter
        # ELO: 2700-3300
        
        p = randint(2, 6)
        
        problem(
            question="Prove that for all \$\\theta\$ where defined: \$\\frac{\\sin($(p)\\theta) - \\sin(($(p-2))\\theta)}{\\cos($(p)\\theta) + \\cos(($(p-2))\\theta)} = \\tan(\\theta)\$",
            answer="\\tan(\\theta)",
            difficulty=(2700, 3300),
            solution=steps(
                "Apply sum-to-product on numerator: \$\\sin A - \\sin B = 2\\cos\\left(\\frac{A+B}{2}\\right)\\sin\\left(\\frac{A-B}{2}\\right)\$",
                "This gives numerator = \$2\\cos(($(p-1))\\theta)\\sin(\\theta)\$",
                "Apply sum-to-product on denominator: \$\\cos A + \\cos B = 2\\cos\\left(\\frac{A+B}{2}\\right)\\cos\\left(\\frac{A-B}{2}\\right)\$",
                "This gives denominator = \$2\\cos(($(p-1))\\theta)\\cos(\\theta)\$",
                "Cancel common factor \$2\\cos(($(p-1))\\theta)\$ and simplify to \$\\frac{\\sin(\\theta)}{\\cos(\\theta)} = \\tan(\\theta)\$"
            ),
            time=270,
        )
    end
end