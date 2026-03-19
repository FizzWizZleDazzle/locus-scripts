# algebra2 - radical_equations (easy)
# Generated: 2026-03-08T20:17:57.316911

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple sqrt(ax + b) = c
        ans = randint(0, 15)
        a = nonzero(2, 8)
        inside = a * ans + randint(-10, 10)
        b = inside - a * x
        c = randint(2, 12)
        
        # sqrt(ax + b) = c means ax + b = c^2
        target = c^2
        ans_val = (target - b) // a
        
        lhs = sqrt(a*x + b)
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(c)\$",
            answer=ans_val,
            difficulty=(700, 850),
            solution=steps(
                sol("Given", lhs ~ c),
                "Square both sides: \$$(tex(a*x + b)) = $(c^2)\$",
                "Solve for x: \$x = $(ans_val)\$",
                "Check: \$\\sqrt{$(substitute(a*x + b, x => ans_val))} = $(c)\$ ✓"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # sqrt(x + a) = x + b where solution exists
        a = randint(5, 20)
        b = randint(-5, 2)
        # For sqrt(x + a) = x + b, squaring gives x + a = x^2 + 2bx + b^2
        # So x^2 + (2b-1)x + (b^2 - a) = 0
        # Pick a clean solution
        ans = randint(2, 12)
        # We need sqrt(ans + a) = ans + b
        # So ans + a = (ans + b)^2
        a_val = (ans + b)^2 - ans
        
        lhs = sqrt(x + a_val)
        rhs = x + b
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$x + $(a_val) = (x + $(b))^2\$",
                "Expand: \$x + $(a_val) = x^2 + $(2*b)x + $(b^2)\$",
                "Rearrange: \$x^2 + $(2*b - 1)x + $(b^2 - a_val) = 0\$",
                "Solve to get \$x = $(ans)\$",
                "Check in original equation to verify ✓"
            ),
            time=150
        )
        
    elseif problem_type == 3
        # sqrt(ax) + b = c, simpler form
        ans = randint(1, 20)
        a = choice([1, 4, 9, 16, 25])
        sqrt_val = randint(3, 10)
        inside = a * ans
        # sqrt(inside) = sqrt_val, so inside = sqrt_val^2
        inside_val = sqrt_val^2
        ans_val = inside_val // a
        
        b = randint(-8, 8)
        c = sqrt_val + b
        
        lhs = sqrt(a*x)
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) + $(b) = $(c)\$",
            answer=ans_val,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", lhs + b ~ c),
                "Isolate the radical: \$$(tex(lhs)) = $(c - b)\$",
                "Square both sides: \$$(a)x = $(c - b)^2 = $((c-b)^2)\$",
                sol("Answer", "x = $(ans_val)")
            ),
            time=75
        )
        
    elseif problem_type == 4
        # sqrt(x^2 + a) = x + b, careful with extraneous solutions
        b = randint(2, 8)
        ans = randint(b + 1, 15)
        # sqrt(ans^2 + a) = ans + b
        # ans^2 + a = (ans + b)^2 = ans^2 + 2*b*ans + b^2
        a_val = 2*b*ans + b^2
        
        lhs = sqrt(x^2 + a_val)
        rhs = x + b
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$x^2 + $(a_val) = x^2 + $(2*b)x + $(b^2)\$",
                "Simplify: \$$(a_val) = $(2*b)x + $(b^2)\$",
                "Solve: \$x = \\frac{$(a_val - b^2)}{$(2*b)} = $(ans)\$",
                "Verify: \$\\sqrt{$(ans)^2 + $(a_val)} = $(ans) + $(b)\$ ✓"
            ),
            time=120
        )
        
    else
        # Two radicals: sqrt(x + a) + sqrt(x + b) = c
        ans = randint(5, 20)
        a = randint(1, 10)
        b = randint(15, 30)
        
        val1 = sqrt(ans + a)
        val2 = sqrt(ans + b)
        c = Int(round(val1 + val2))
        
        # Adjust to make it cleaner
        ans = randint(8, 24)
        a = randint(1, 8)
        diff = randint(12, 25)
        b = a + diff
        c = randint(8, 15)
        
        # For cleaner answer, pick ans such that both are perfect squares
        ans = 0
        a = 9
        b = 16
        c = 7  # sqrt(9) + sqrt(16) = 3 + 4 = 7
        
        lhs1 = sqrt(x + a)
        lhs2 = sqrt(x + b)
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs1)) + $(tex(lhs2)) = $(c)\$",
            answer=ans,
            difficulty=(1100, 1200),
            solution=steps(
                sol("Given", lhs1 + lhs2 ~ c),
                "Isolate one radical: \$$(tex(lhs1)) = $(c) - $(tex(lhs2))\$",
                "Square both sides and simplify",
                "Isolate remaining radical and square again",
                "Solve to get \$x = $(ans)\$",
                "Verify: \$\\sqrt{$(a)} + \\sqrt{$(b)} = $(c)\$ ✓"
            ),
            time=180
        )
    end
end