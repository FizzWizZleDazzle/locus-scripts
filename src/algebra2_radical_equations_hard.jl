# algebra2 - radical_equations (hard)
# Generated: 2026-03-08T20:18:07.558802

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Single radical equation: √(ax + b) = c, where solution is clean
        ans = randint(5, 30)
        a = nonzero(2, 8)
        c = randint(3, 12)
        b = c^2 - a * ans
        
        lhs = sqrt(a*x + b)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(c)\$",
            answer = ans,
            difficulty = (1800, 2000),
            solution = steps(
                sol("Given", lhs ~ c),
                "Square both sides: \$$(tex(a*x + b)) = $(c^2)\$",
                "Solve for x: \$$(a)x = $(c^2 - b)\$",
                sol("Answer", ans),
                "Check: \$\\sqrt{$(a*ans + b)} = \\sqrt{$(c^2)} = $(c)\$ ✓"
            ),
            time = 120
        )
        
    elseif problem_type == 2
        # √(ax + b) + √(cx + d) = e with strategic coefficients
        ans = randint(8, 25)
        a = choice([2, 3, 4, 5])
        c = choice([2, 3, 4, 5])
        val1 = randint(4, 10)
        val2 = randint(3, 8)
        b = val1^2 - a * ans
        d = val2^2 - c * ans
        e = val1 + val2
        
        lhs = sqrt(a*x + b) + sqrt(c*x + d)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(e)\$",
            answer = ans,
            difficulty = (2000, 2200),
            solution = steps(
                sol("Given", lhs ~ e),
                "Isolate one radical: \$\\sqrt{$(tex(a*x + b))} = $(e) - \\sqrt{$(tex(c*x + d))}\$",
                "Square both sides and simplify",
                "Isolate the remaining radical and square again",
                "Solve the resulting polynomial equation",
                sol("Answer", ans),
                "Verify in original equation"
            ),
            time = 240
        )
        
    elseif problem_type == 3
        # √(ax² + bx + c) = dx + e with one valid solution
        ans = randint(5, 20)
        d = choice([2, 3, 4])
        e = randint(1, 8)
        rhs_val = d * ans + e
        a = choice([1, 2, 3])
        inner = rhs_val^2
        b = randint(-15, 15)
        c = inner - a * ans^2 - b * ans
        
        lhs = sqrt(a*x^2 + b*x + c)
        rhs = d*x + e
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer = ans,
            difficulty = (2100, 2300),
            solution = steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$$(tex(a*x^2 + b*x + c)) = $(tex((d*x + e)^2))\$",
                "Expand right side: \$$(tex(a*x^2 + b*x + c)) = $(tex(expand((d*x + e)^2)))\$",
                "Simplify and solve the resulting equation",
                sol("Answer", ans),
                "Check that answer satisfies domain restrictions and original equation"
            ),
            time = 180
        )
        
    elseif problem_type == 4
        # Two radicals equal: √(ax + b) = √(cx + d)
        ans = randint(10, 35)
        a = nonzero(3, 9)
        c = nonzero(2, 8)
        while a == c
            c = nonzero(2, 8)
        end
        b = randint(-20, 20)
        d = a * ans + b - c * ans
        
        lhs = sqrt(a*x + b)
        rhs = sqrt(c*x + d)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer = ans,
            difficulty = (1850, 2050),
            solution = steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$$(tex(a*x + b)) = $(tex(c*x + d))\$",
                "Simplify: \$$(a - c)x = $(d - b)\$",
                sol("Answer", ans),
                "Verify both radicals are defined and equal at \$x = $(ans)\$"
            ),
            time = 150
        )
        
    else  # problem_type == 5
        # Equation with extraneous solution: √(ax + b) = x + c
        real_ans = randint(8, 24)
        a = choice([2, 3, 4, 5])
        c = randint(-5, 5)
        b = (real_ans + c)^2 - a * real_ans
        
        # The extraneous solution comes from squaring
        extraneous = -(a + 2*c + c^2) // 2
        
        lhs = sqrt(a*x + b)
        rhs = x + c
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$. If there are multiple solutions, enter them as a set. If there is no solution, enter ∅.",
            answer = real_ans,
            difficulty = (2200, 2400),
            solution = steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$$(tex(a*x + b)) = $(tex(expand((x + c)^2)))\$",
                "Expand and rearrange: \$x^2 + $(2*c - a)x + $(c^2 - b) = 0\$",
                "Solve the quadratic equation",
                "Check each solution in the original equation",
                "Only \$x = $(real_ans)\$ satisfies the original (the other is extraneous)",
                sol("Answer", real_ans)
            ),
            time = 210
        )
    end
end