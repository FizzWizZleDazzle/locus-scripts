# algebra2 - rational_equations (medium)
# Generated: 2026-03-08T20:16:15.851961

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Simple rational equation: a/(x+b) = c
        a = nonzero(-15, 15)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        ans = a//c - b
        
        lhs = a//(x + b)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(c)\$",
            answer = ans,
            difficulty = (1200, 1400),
            solution = steps(
                sol("Given", lhs ~ c),
                "Multiply both sides by \$$(tex(x + b))\$: \$$(a) = $(c)(x + $(b))\$",
                "Expand: \$$(a) = $(tex(expand(c*(x + b))))\$",
                "Solve for x: \$x = $(tex(ans))\$",
                sol("Answer", ans)
            ),
            time = 90
        )
    elseif problem_type == 2
        # Two fractions equal: a/(x+b) = c/(x+d)
        a = nonzero(-20, 20)
        b = nonzero(-10, 10)
        c = nonzero(-20, 20)
        d = nonzero(-10, 10)
        
        # Ensure b != d to avoid trivial cases
        while b == d
            d = nonzero(-10, 10)
        end
        
        # Cross multiply: a(x+d) = c(x+b)
        # ax + ad = cx + cb
        # ax - cx = cb - ad
        # x(a-c) = cb - ad
        
        if a == c
            # No solution or infinite solutions
            a = nonzero(-20, 20)
            while a == c
                a = nonzero(-20, 20)
            end
        end
        
        ans = (c*b - a*d)//(a - c)
        
        lhs = a//(x + b)
        rhs = c//(x + d)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                sol("Given", lhs ~ rhs),
                "Cross multiply: \$$(a)(x + $(d)) = $(c)(x + $(b))\$",
                "Expand: \$$(tex(expand(a*(x + d)))) = $(tex(expand(c*(x + b))))\$",
                "Collect like terms and solve for x",
                sol("Answer", ans)
            ),
            time = 120
        )
    elseif problem_type == 3
        # Sum of fractions: a/(x+b) + c/(x+d) = e
        a = nonzero(-12, 12)
        b = nonzero(-8, 8)
        c = nonzero(-12, 12)
        d = nonzero(-8, 8)
        e = nonzero(-6, 6)
        
        while b == d
            d = nonzero(-8, 8)
        end
        
        # a/(x+b) + c/(x+d) = e
        # [a(x+d) + c(x+b)] / [(x+b)(x+d)] = e
        # a(x+d) + c(x+b) = e(x+b)(x+d)
        
        lhs_expr = a//(x + b) + c//(x + d)
        
        # Solve manually for cleaner answer
        # ax + ad + cx + cb = e(x^2 + dx + bx + bd)
        # (a+c)x + ad + cb = ex^2 + e(b+d)x + ebd
        # 0 = ex^2 + [e(b+d) - (a+c)]x + [ebd - ad - cb]
        
        quad_a = e
        quad_b = e*(b + d) - (a + c)
        quad_c_coef = e*b*d - a*d - c*b
        
        # Use quadratic formula
        discriminant = quad_b^2 - 4*quad_a*quad_c_coef
        
        if discriminant >= 0 && quad_a != 0
            ans1 = (-quad_b + sqrt(discriminant))//(2*quad_a)
            ans2 = (-quad_b - sqrt(discriminant))//(2*quad_a)
            
            # Check which solutions are valid (don't make denominators zero)
            valid_sols = []
            if ans1 != -b && ans1 != -d
                push!(valid_sols, ans1)
            end
            if ans2 != -b && ans2 != -d && ans1 != ans2
                push!(valid_sols, ans2)
            end
            
            if length(valid_sols) == 1
                ans = valid_sols[1]
            elseif length(valid_sols) == 2
                ans = fmt_set(Set(valid_sols))
            else
                # Regenerate
                ans = 0
            end
        else
            ans = 0
        end
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs_expr)) = $(e)\$",
            answer = ans,
            difficulty = (1500, 1700),
            solution = steps(
                sol("Given", lhs_expr ~ e),
                "Find common denominator: \$$(tex((x+b)*(x+d)))\$",
                "Multiply both sides by common denominator",
                "Simplify to get a quadratic equation",
                "Solve using quadratic formula or factoring",
                sol("Answer", ans)
            ),
            time = 180
        )
    else
        # Equation with solution that creates extraneous root
        # (x+a)/(x+b) = c, but check x != -b
        root = nonzero(-15, 15)
        b = nonzero(-12, 12)
        
        # Ensure root != -b
        while root == -b
            b = nonzero(-12, 12)
        end
        
        c = nonzero(-5, 5)
        
        # (x+a)/(x+b) = c
        # x + a = c(x + b)
        # x + a = cx + cb
        # x - cx = cb - a
        # x(1-c) = cb - a
        # x = (cb - a)/(1 - c)
        
        if c == 1
            c = nonzero(-5, 5)
            while c == 1
                c = nonzero(-5, 5)
            end
        end
        
        a = c*b - root*(1 - c)
        ans = root
        
        lhs = (x + a)//(x + b)
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(lhs)) = $(c)\$. If there is no solution, enter \"none\".",
            answer = ans,
            difficulty = (1400, 1600),
            solution = steps(
                sol("Given", lhs ~ c),
                "Multiply both sides by \$$(tex(x + b))\$: \$x + $(a) = $(c)(x + $(b))\$",
                "Expand: \$x + $(a) = $(tex(expand(c*(x + b))))\$",
                "Solve for x: \$x = $(tex(ans))\$",
                "Check that \$x \\neq $(tex(-b))\$ (denominator restriction)",
                sol("Answer", ans)
            ),
            time = 120
        )
    end
end