# algebra2 - radical_equations (medium)
# Generated: 2026-03-08T20:17:59.740626

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple sqrt(ax + b) = c, solution exists
        ans = randint(1, 25)
        a = nonzero(-8, 8)
        c = randint(2, 12)
        b = c^2 - a * ans
        
        lhs = sqrt(a*x + b)
        
        problem(
            question="Solve: \$$(tex(lhs)) = $(c)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", lhs ~ c),
                "Square both sides: \$$(tex(a*x + b)) = $(c^2)\$",
                "Solve for x: \$x = $(ans)\$",
                "Check: \$\\sqrt{$(a*ans + b)} = \\sqrt{$(c^2)} = $(c)\$ ✓"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # sqrt(ax + b) = sqrt(cx + d)
        ans = randint(-15, 15)
        a = nonzero(-10, 10)
        c = nonzero(-10, 10)
        while a == c
            c = nonzero(-10, 10)
        end
        b = randint(-30, 30)
        d = a * ans + b - c * ans
        
        lhs = sqrt(a*x + b)
        rhs = sqrt(c*x + d)
        
        problem(
            question="Solve: \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Square both sides: \$$(tex(a*x + b)) = $(tex(c*x + d))\$",
                "Simplify: \$$(tex((a-c)*x)) = $(d - b)\$",
                sol("Answer", ans),
                "Verify both radicals are defined and equal"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # sqrt(ax + b) + c = d, isolate radical first
        ans = randint(-20, 20)
        a = nonzero(-12, 12)
        radical_val = randint(3, 15)
        b = radical_val^2 - a * ans
        c = randint(-8, 8)
        d = radical_val + c
        
        lhs = sqrt(a*x + b) + c
        
        problem(
            question="Solve: \$$(tex(lhs)) = $(d)\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", lhs ~ d),
                "Isolate radical: \$$(tex(sqrt(a*x + b))) = $(d - c)\$",
                "Square both sides: \$$(tex(a*x + b)) = $((d-c)^2)\$",
                "Solve: \$x = $(ans)\$",
                "Check solution in original equation"
            ),
            time=120
        )
        
    elseif problem_type == 4
        # sqrt(ax + b) = x + c (quadratic after squaring)
        r1 = randint(3, 18)
        r2 = randint(-12, -2)
        c = randint(-6, 6)
        
        # For sqrt(ax+b) = x+c, squaring gives ax+b = x^2+2cx+c^2
        # So x^2 + (2c-a)x + (c^2-b) = 0 should have roots r1, r2
        # But we need to check which root is valid
        
        # Pick valid root
        ans = r1  # typically the positive one works
        a = nonzero(2, 15)
        b = (ans + c)^2 - a * ans
        
        lhs = sqrt(a*x + b)
        rhs = x + c
        
        # Verify ans works
        check_val = a * ans + b
        if check_val >= 0 && sqrt(check_val) == ans + c
            problem(
                question="Solve: \$$(tex(lhs)) = $(tex(rhs))\$",
                answer=ans,
                difficulty=(1500, 1700),
                solution=steps(
                    sol("Given", lhs ~ rhs),
                    "Square both sides: \$$(tex(a*x + b)) = $(tex(expand((x+c)^2)))\$",
                    "Rearrange to standard form and solve",
                    "Check both potential solutions in original equation",
                    sol("Valid solution", ans)
                ),
                time=180
            )
        else
            # Fallback to simpler problem
            ans = randint(1, 20)
            a = nonzero(2, 10)
            c = randint(2, 10)
            b = c^2 - a * ans
            
            problem(
                question="Solve: \$$(tex(sqrt(a*x + b))) = $(c)\$",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", sqrt(a*x + b) ~ c),
                    "Square both sides: \$$(tex(a*x + b)) = $(c^2)\$",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    else  # problem_type == 5
        # Two radicals: sqrt(ax+b) + sqrt(cx+d) = e
        ans = randint(2, 20)
        a = randint(2, 8)
        c = randint(2, 8)
        val1 = randint(3, 10)
        val2 = randint(3, 10)
        b = val1^2 - a * ans
        d = val2^2 - c * ans
        e = val1 + val2
        
        lhs = sqrt(a*x + b) + sqrt(c*x + d)
        
        problem(
            question="Solve: \$$(tex(lhs)) = $(e)\$",
            answer=ans,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Given", lhs ~ e),
                "Isolate one radical: \$$(tex(sqrt(a*x + b))) = $(e) - $(tex(sqrt(c*x + d)))\$",
                "Square both sides and simplify",
                "Isolate remaining radical and square again",
                "Solve resulting equation: \$x = $(ans)\$",
                "Verify solution satisfies original equation"
            ),
            time=240
        )
    end
end