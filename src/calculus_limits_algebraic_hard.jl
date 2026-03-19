# calculus - limits_algebraic (hard)
# Generated: 2026-03-08T20:36:58.129923

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x h begin
    set_topic!("calculus/limits_algebraic")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Indeterminate form 0/0 requiring factoring
        # Target: 1800-2100
        r = nonzero(-12, 12)
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        
        numerator = expand(a * (x - r) * (x + b))
        denominator = x - r
        
        limit_value = a * (r + b)
        
        problem(
            question="Evaluate \\lim_{x \\to $(r)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=limit_value,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Given", "\\lim_{x \\to $(r)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Factor numerator: \$$(tex(a * (x - r) * (x + b)))\$",
                "Cancel common factor \$(x - $(r))\$",
                "Simplified: \$\\lim_{x \\to $(r)} $(tex(a * (x + b)))\$",
                "Substitute \$x = $(r)\$",
                sol("Answer", limit_value)
            ),
            time=150
        )
        
    elseif problem_type == 2
        # Rationalize conjugate - sqrt indeterminate form
        # Target: 1900-2300
        a = rand([1, 2, 4])
        c = randint(1, 20)
        
        # lim_{x->c} (sqrt(ax) - sqrt(ac)) / (x - c)
        # = lim_{x->c} (ax - ac) / [(x-c)(sqrt(ax) + sqrt(ac))]
        # = lim_{x->c} a(x-c) / [(x-c)(sqrt(ax) + sqrt(ac))]
        # = a / (2*sqrt(ac))
        
        limit_value_num = a
        limit_value_den = 2 * sqrt(a * c)
        
        if limit_value_den == round(limit_value_den)
            limit_value = limit_value_num // Int(limit_value_den)
        else
            limit_value = limit_value_num / limit_value_den
        end
        
        problem(
            question="Evaluate \\lim_{x \\to $(c)} \\frac{\\sqrt{$(a)x} - $(tex(sqrt(a*c)))}{x - $(c)}",
            answer=limit_value,
            difficulty=(1900, 2300),
            solution=steps(
                sol("Given", "\\lim_{x \\to $(c)} \\frac{\\sqrt{$(a)x} - $(tex(sqrt(a*c)))}{x - $(c)}"),
                "Multiply by conjugate: \$\\frac{\\sqrt{$(a)x} + $(tex(sqrt(a*c)))}{\\sqrt{$(a)x} + $(tex(sqrt(a*c)))}\$",
                "Numerator becomes: \$$(a)x - $(a*c) = $(a)(x - $(c))\$",
                "Cancel \$(x - $(c))\$ factor",
                "Simplified: \$\\lim_{x \\to $(c)} \\frac{$(a)}{\\sqrt{$(a)x} + $(tex(sqrt(a*c)))}\$",
                "Substitute \$x = $(c)\$",
                sol("Answer", limit_value)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Complex rational function - highest degree analysis
        # Target: 1850-2150
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        d = nonzero(-7, 7)
        
        numerator = a*x^2 + b*x + randint(-10, 10)
        denominator = c*x^2 + d*x + randint(-10, 10)
        
        limit_value = a // c
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=limit_value,
            difficulty=(1850, 2150),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Divide numerator and denominator by highest power \$x^2\$",
                "Leading coefficients: numerator has \$$(a)\$, denominator has \$$(c)\$",
                "Lower degree terms approach 0 as \$x \\to \\infty\$",
                sol("Answer", limit_value)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Difference of cubes or higher polynomial factoring
        # Target: 2000-2400
        r = nonzero(-8, 8)
        a = nonzero(-4, 4)
        
        # (x^3 - r^3)/(x - r) = x^2 + rx + r^2 at x=r
        numerator = x^3 - r^3
        denominator = x - r
        
        limit_value = r^2 + r*r + r^2
        limit_value = 3 * r^2
        
        problem(
            question="Evaluate \\lim_{x \\to $(r)} \\frac{x^3 - $(r^3)}{x - $(r)}",
            answer=limit_value,
            difficulty=(2000, 2400),
            solution=steps(
                sol("Given", "\\lim_{x \\to $(r)} \\frac{x^3 - $(r^3)}{x - $(r)}"),
                "Factor using difference of cubes: \$a^3 - b^3 = (a-b)(a^2 + ab + b^2)\$",
                "Numerator: \$(x - $(r))(x^2 + $(r)x + $(r^2))\$",
                "Cancel \$(x - $(r))\$ factor",
                "Evaluate: \$\\lim_{x \\to $(r)} (x^2 + $(r)x + $(r^2))\$",
                "Substitute \$x = $(r)\$: \$$(r^2) + $(r*r) + $(r^2) = $(limit_value)\$",
                sol("Answer", limit_value)
            ),
            time=200
        )
        
    else
        # Piecewise-motivated limit with algebraic simplification
        # Target: 2100-2500
        a = nonzero(-6, 6)
        b = nonzero(-10, 10)
        c = randint(1, 12)
        
        # |ax + b| / (ax + b) as x -> critical point from one side
        # Need ax + b = 0, so x = -b/a
        critical = -b // a
        
        if a > 0
            # From left: negative, limit = -1
            # From right: positive, limit = 1
            side = rand(["left", "right"])
            limit_value = side == "left" ? -1 : 1
            notation = side == "left" ? "^-" : "^+"
        else
            side = rand(["left", "right"])
            limit_value = side == "left" ? 1 : -1
            notation = side == "left" ? "^-" : "^+"
        end
        
        problem(
            question="Evaluate \\lim_{x \\to $(tex(critical))$(notation)} \\frac{|$(tex(a*x + b))|}{$(tex(a*x + b))}",
            answer=limit_value,
            difficulty=(2100, 2500),
            solution=steps(
                sol("Given", "\\lim_{x \\to $(tex(critical))$(notation)} \\frac{|$(tex(a*x + b))|}{$(tex(a*x + b))}"),
                "Note that \$$(tex(a*x + b)) = 0\$ when \$x = $(tex(critical))\$",
                "As \$x \\to $(tex(critical))$(notation)\$, the expression \$$(tex(a*x + b))\$ is $(side == "left" ? "negative" : "positive") (approaching from $(side))",
                "Therefore \$|$(tex(a*x + b))| = $(limit_value == 1 ? tex(a*x + b) : tex(-(a*x + b)))\$",
                "The ratio simplifies to \$$(limit_value)\$",
                sol("Answer", limit_value)
            ),
            time=180
        )
    end
end