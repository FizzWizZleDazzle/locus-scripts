# algebra1 - multi_step_equations (hard)
# Generated: 2026-03-08T19:53:51.988770

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nested equations with fractions and distribution
        ans = randint(-15, 15)
        a = nonzero(-8, 8)
        b = nonzero(-6, 6)
        c = randint(-20, 20)
        d = nonzero(2, 5)
        e = randint(-15, 15)
        
        # Build: a(x - b)/d + c = e, where x = ans
        lhs = a*(x - b)//d + c
        rhs = e
        
        # Solve for what c and e should be
        lhs_at_ans = substitute(lhs, x => ans)
        rhs = lhs_at_ans
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(1850, 2000),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Subtract $(c) from both sides: \$$(tex(a*(x-b)//d)) = $(tex(rhs - c))\$",
                "Multiply both sides by $(d): \$$(tex(a*(x-b))) = $(tex(d*(rhs - c)))\$",
                "Divide by $(a): \$$(tex(x-b)) = $(tex(d*(rhs - c)//a))\$",
                "Add $(b): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Variable on both sides with complex distribution
        ans = randint(-20, 20)
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        c = nonzero(-7, 7)
        d = randint(-12, 12)
        e = nonzero(-5, 5)
        f = randint(-10, 10)
        
        # Build: a(x - b) + c = d(x - e) + f
        lhs = expand(a*(x - b) + c)
        rhs = expand(d*(x - e) + f)
        
        # Solve backwards
        # a*x - a*b + c = d*x - d*e + f
        # (a-d)*x = -d*e + f + a*b - c
        target_rhs = substitute(rhs, x => ans)
        c_new = substitute(lhs, x => ans) - target_rhs
        lhs = expand(a*(x - b)) + c_new
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Expand both sides",
                "Move all \\(x\\) terms to one side and constants to the other",
                "Combine like terms and isolate \\(x\\)",
                sol("Answer", ans)
            ),
            time=210
        )
        
    elseif problem_type == 3
        # Absolute value equation with two solutions
        inner_offset = randint(-8, 8)
        dist = randint(5, 18)
        r1 = inner_offset - dist
        r2 = inner_offset + dist
        a = nonzero(-6, 6)
        
        # |a*x - a*inner_offset| = a*dist (or adjusted)
        inner = a*x - a*inner_offset
        
        problem(
            question="Solve for \\(x\\): \$|$(tex(inner))| = $(abs(a)*dist)\$",
            answer=fmt_set(Set([r1, r2])),
            difficulty=(1800, 2000),
            answer_type="set",
            solution=steps(
                sol("Given", "|$(tex(inner))| = $(abs(a)*dist)"),
                "Split into two cases:",
                "Case 1: \$$(tex(inner)) = $(abs(a)*dist)\$ gives \\(x = $(r2)\\)",
                "Case 2: \$$(tex(inner)) = -$(abs(a)*dist)\$ gives \\(x = $(r1)\\)",
                "Solution set: \$$(fmt_set(Set([r1, r2])))\$"
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Rational equation requiring LCD
        ans = nonzero(-15, 15)
        a = nonzero(-8, 8)
        b = randint(-10, 10)
        c = nonzero(2, 6)
        d = nonzero(2, 6)
        
        # a/(c) + x/d = b, solve for x = ans
        # x/d = b - a/c
        # x = d*(b - a/c) = ans
        target = ans
        b = a//c + target//d
        
        problem(
            question="Solve for \\(x\\): \$\\frac{$(a)}{$(c)} + \\frac{x}{$(d)} = $(tex(b))\$",
            answer=ans,
            difficulty=(1950, 2150),
            solution=steps(
                sol("Given", "\\frac{$(a)}{$(c)} + \\frac{x}{$(d)} = $(tex(b))"),
                "Subtract \\(\\frac{$(a)}{$(c)}\\) from both sides",
                "Simplify: \\(\\frac{x}{$(d)} = $(tex(b - a//c))\\)",
                "Multiply by $(d): \\(x = $(ans)\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    else
        # Complex multi-step with nested parentheses
        ans = randint(-18, 18)
        a = nonzero(-6, 6)
        b = nonzero(2, 5)
        c = randint(-12, 12)
        d = nonzero(-8, 8)
        e = randint(-15, 15)
        
        # a[b(x - c) - d] = e, solve backwards
        # b(x - c) - d = e/a
        # b(x - c) = e/a + d
        # x - c = (e/a + d)/b = (e + a*d)/(a*b)
        # x = c + (e + a*d)/(a*b) = ans
        
        e = a*b*ans - a*b*c - a*d
        
        inner = b*(x - c) - d
        lhs = a*inner
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(e)\$",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", lhs ~ e),
                "Divide both sides by $(a): \$$(tex(inner)) = $(tex(e//a))\$",
                "Add $(d): \$$(tex(b*(x-c))) = $(tex(e//a + d))\$",
                "Divide by $(b): \$$(tex(x-c)) = $(tex((e//a + d)//b))\$",
                "Add $(c) to get \\(x = $(ans)\\)",
                sol("Answer", ans)
            ),
            time=240
        )
    end
end