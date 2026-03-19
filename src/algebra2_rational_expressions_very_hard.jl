# algebra2 - rational_expressions (very_hard)
# Generated: 2026-03-08T20:15:46.699750

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/rational_expressions")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: Solve rational equation with multiple solutions requiring careful analysis
        # ELO 2500-3000
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        r3 = nonzero(-8, 8)
        while r3 == r1 || r3 == r2
            r3 = nonzero(-8, 8)
        end
        
        k = nonzero(-5, 5)
        
        # Construct: k/(x-r1) + k/(x-r2) = 1/(x-r3)
        # This requires finding common denominator and solving resulting quadratic
        
        lhs = k//(x - r1) + k//(x - r2)
        rhs = 1//(x - r3)
        
        # Multiply through by (x-r1)(x-r2)(x-r3)
        # k(x-r2)(x-r3) + k(x-r1)(x-r3) = (x-r1)(x-r2)
        
        left_expanded = expand(k*(x-r2)*(x-r3) + k*(x-r1)*(x-r3))
        right_expanded = expand((x-r1)*(x-r2))
        
        eq = left_expanded ~ right_expanded
        sols = solve(eq, x)
        
        # Filter out extraneous solutions (denominators = 0)
        sols_arr = sols isa AbstractArray ? sols : [sols]
        valid_sols = filter(s -> s != r1 && s != r2 && s != r3, sols_arr)
        
        ans = fmt_set(Set(valid_sols))
        
        problem(
            question="Solve for \\(x\\): \\[\\frac{$(k)}{x - $(r1)} + \\frac{$(k)}{x - $(r2)} = \\frac{1}{x - $(r3)}\\]",
            answer=ans,
            difficulty=(2500, 3000),
            answer_type="set",
            solution=steps(
                "Multiply both sides by \\((x - $(r1))(x - $(r2))(x - $(r3))\\)",
                sol("Expanded equation", eq),
                "Solve the resulting quadratic equation",
                "Check for extraneous solutions (values that make denominators zero)",
                sol("Valid solutions", ans)
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Olympiad-level: Simplify complex nested rational expression
        # ELO 3000-3500
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        # Construct: (1 + a/(x+b)) / (1 - c/(x+b))
        # Simplifies to: (x + b + a) / (x + b - c)
        
        numerator_inner = 1 + a//(x + b)
        denominator_inner = 1 - c//(x + b)
        
        expr = numerator_inner // denominator_inner
        
        simplified = (x + b + a) // (x + b - c)
        
        problem(
            question="Simplify the rational expression: \\[\\frac{1 + \\frac{$(a)}{x + $(b)}}{1 - \\frac{$(c)}{x + $(b)}}\\]",
            answer=simplified,
            difficulty=(3000, 3500),
            solution=steps(
                sol("Given", "\\frac{1 + \\frac{$(a)}{x + $(b)}}{1 - \\frac{$(c)}{x + $(b)}}"),
                "Multiply numerator and denominator by \\(x + $(b)\\)",
                sol("Numerator becomes", x + b + a),
                sol("Denominator becomes", x + b - c),
                sol("Simplified form", simplified)
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Competition: Find all x where rational expression equals specific value
        # ELO 2600-3200
        p = nonzero(-7, 7)
        q = nonzero(-7, 7)
        r = nonzero(-7, 7)
        target = nonzero(-4, 4)
        
        # (x^2 + px + q) / (x - r) = target
        # x^2 + px + q = target(x - r)
        # x^2 + px + q = target*x - target*r
        # x^2 + (p - target)x + (q + target*r) = 0
        
        expr_num = x^2 + p*x + q
        expr_den = x - r
        expr = expr_num // expr_den
        
        eq = expr ~ target
        
        # Solve: x^2 + px + q = target*x - target*r
        final_eq = x^2 + (p - target)*x + (q + target*r) ~ 0
        
        sols = solve(final_eq, x)
        
        # Filter out x = r (makes denominator zero)
        valid_sols = filter(s -> s != r, sols)
        
        ans = fmt_set(Set(valid_sols))
        
        problem(
            question="Find all values of \\(x\\) such that \\[\\frac{x^2 + $(p)x + $(q)}{x - $(r)} = $(target)\\]",
            answer=ans,
            difficulty=(2600, 3200),
            answer_type="set",
            solution=steps(
                "Multiply both sides by \\(x - $(r)\\)",
                sol("Equation becomes", "x^2 + $(p)x + $(q) = $(target)(x - $(r))"),
                sol("Expand and simplify", final_eq),
                "Solve the quadratic equation",
                "Verify solutions don't make denominator zero",
                sol("Answer", ans)
            ),
            time=270,
            calculator="none"
        )
        
    else
        # Olympiad: Partial fraction decomposition with challenging coefficients
        # ELO 3200-3500
        r1 = nonzero(-9, 9)
        r2 = nonzero(-9, 9)
        while r2 == r1
            r2 = nonzero(-9, 9)
        end
        
        A = nonzero(-8, 8)
        B = nonzero(-8, 8)
        
        # Given A/(x-r1) + B/(x-r2), find the combined form
        # Then ask to decompose it back
        
        combined_num = expand(A*(x - r2) + B*(x - r1))
        combined_den = expand((x - r1)*(x - r2))
        
        expr = combined_num // combined_den
        
        # Answer is A/(x-r1) + B/(x-r2)
        ans_str = "\\frac{$(A)}{x - $(r1)} + \\frac{$(B)}{x - $(r2)}"
        
        problem(
            question="Decompose into partial fractions: \\[\\frac{$(tex(combined_num))}{$(tex(combined_den))}\\]",
            answer=ans_str,
            difficulty=(3200, 3500),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\frac{$(tex(combined_num))}{$(tex(combined_den))}"),
                "Factor denominator: \\((x - $(r1))(x - $(r2))\\)",
                "Set up partial fractions: \\(\\frac{A}{x - $(r1)} + \\frac{B}{x - $(r2)}\\)",
                "Multiply through and equate coefficients",
                "Solve for A and B: \\(A = $(A), B = $(B)\\)",
                sol("Answer", ans_str)
            ),
            time=300,
            calculator="none"
        )
    end
end