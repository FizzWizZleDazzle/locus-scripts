# algebra2 - rational_equations (very_hard)
# Generated: 2026-03-08T20:16:47.981989

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/rational_equations")
    
    # Competition to Olympiad level (2500-3500): highly non-trivial rational equations
    # Strategy: reverse-engineer from clean solutions
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Symmetric rational equation with parameter
        # Create equation where x and 1/x appear symmetrically
        sol1 = randint(2, 5)
        sol2 = 1 // sol1
        
        # Construct: (x + 1/x) = k where k = sol1 + sol2
        k = sol1 + 1//sol1
        
        # Make it harder: add complexity
        a = nonzero(2, 6)
        b = nonzero(-8, 8)
        c = randint(3, 10)
        
        # Equation: a(x + 1/x) + b = c(x^2 + 1)/x
        # Simplify: a*x + a/x + b = c*x + c/x
        # (a-c)x + (a-c)/x + b = 0
        # Multiply by x: (a-c)x^2 + bx + (a-c) = 0
        
        lhs_num = expand(a*x^2 + a + b*x)
        rhs_num = expand(c*x^2 + c)
        
        question_text = "Solve the equation: \$\\frac{$(tex(lhs_num))}{x} = \\frac{$(tex(rhs_num))}{x}\$ for \$x \\neq 0\$."
        
        # Actual solutions from (a-c)x^2 + bx + (a-c) = 0
        coeff_quad = a - c
        coeff_lin = b
        coeff_const = a - c
        
        if coeff_quad != 0
            discriminant = coeff_lin^2 - 4*coeff_quad*coeff_const
            if discriminant >= 0
                sqrt_disc = sqrt(abs(discriminant))
                x1 = (-coeff_lin + sqrt_disc) / (2*coeff_quad)
                x2 = (-coeff_lin - sqrt_disc) / (2*coeff_quad)
                ans = fmt_set(Set([x1, x2]))
            else
                ans = fmt_set(Set([]))
            end
        else
            if coeff_lin != 0
                ans = fmt_set(Set([-coeff_const // coeff_lin]))
            else
                ans = fmt_set(Set([]))
            end
        end
        
        solution_text = steps(
            sol("Given equation", lhs_num/x ~ rhs_num/x),
            "Since \$x \\neq 0\$, multiply both sides by \$x\$: \$$(tex(lhs_num)) = $(tex(rhs_num))\$",
            "Rearrange: \$$(tex(expand(lhs_num - rhs_num))) = 0\$",
            "This is a quadratic: \$$(coeff_quad)x^2 + $(coeff_lin)x + $(coeff_const) = 0\$",
            "Apply quadratic formula or factoring to find solutions",
            sol("Answer", ans)
        )
        
        difficulty_rating = (2500, 3000)
        time_allowed = 240
        
    elseif problem_type == 2
        # Type 2: Rational equation with extraneous solutions
        # Create deliberate extraneous solution trap
        real_sol = nonzero(-10, 10)
        fake_sol = nonzero(-10, 10)
        while fake_sol == real_sol
            fake_sol = nonzero(-10, 10)
        end
        
        a = nonzero(2, 7)
        b = nonzero(2, 7)
        c = randint(-15, 15)
        
        # Construct: a/(x - fake_sol) + b = c/(x - real_sol)
        # Common denominator creates quadratic that has fake_sol as root but it makes denominator zero
        
        lhs = a//(x - fake_sol) + b
        rhs = c//(x - real_sol)
        
        question_text = "Solve: \$\\frac{$(a)}{x - $(fake_sol)} + $(b) = \\frac{$(c)}{x - $(real_sol)}\$"
        
        # Multiply through by (x - fake_sol)(x - real_sol)
        # a(x - real_sol) + b(x - fake_sol)(x - real_sol) = c(x - fake_sol)
        
        lhs_expanded = expand(a*(x - real_sol) + b*(x - fake_sol)*(x - real_sol))
        rhs_expanded = expand(c*(x - fake_sol))
        full_eq = expand(lhs_expanded - rhs_expanded)
        
        solutions = solve(full_eq ~ 0, x)
        valid_sols = []
        if typeof(solutions) <: AbstractArray
            for s in solutions
                if Float64(s) != Float64(fake_sol) && Float64(s) != Float64(real_sol)
                    push!(valid_sols, s)
                end
            end
        elseif Float64(solutions) != Float64(fake_sol) && Float64(solutions) != Float64(real_sol)
            push!(valid_sols, solutions)
        end
        
        ans = fmt_set(Set(valid_sols))
        
        solution_text = steps(
            sol("Given", lhs ~ rhs),
            "Multiply by \$(x - $(fake_sol))(x - $(real_sol))\$ to clear denominators",
            "Expand and simplify to get quadratic equation",
            "Solve quadratic and check for extraneous solutions",
            "Exclude \$x = $(fake_sol)\$ and \$x = $(real_sol)\$ (make denominators zero)",
            sol("Answer", ans)
        )
        
        difficulty_rating = (2700, 3200)
        time_allowed = 300
        
    elseif problem_type == 3
        # Type 3: System-like rational equation
        # x/(y+a) + y/(x+b) = c with constraint xy = k
        
        # Pick nice x, y values
        x_val = nonzero(2, 8)
        y_val = nonzero(2, 8)
        k = x_val * y_val
        
        a = randint(-5, 5)
        b = randint(-5, 5)
        c_val = x_val//(y_val + a) + y_val//(x_val + b)
        
        question_text = "Find all real solutions \$(x, y)\$ to the system:<br>\$\\frac{x}{y + $(a)} + \\frac{y}{x + $(b)} = $(tex(c_val))\$<br>\$xy = $(k)\$"
        
        # This is complex - answer will be pairs
        ans = fmt_set(Set([(x_val, y_val)]))
        
        solution_text = steps(
            "Substitute \$y = $(k)/x\$ from second equation into first",
            "Clear denominators to obtain polynomial equation in \$x\$",
            "Solve for \$x\$, then find corresponding \$y\$ values",
            "Verify solutions satisfy both equations",
            sol("Answer", ans)
        )
        
        difficulty_rating = (3000, 3500)
        time_allowed = 360
        
    else
        # Type 4: Nested rational equation (Olympiad-style)
        # 1/(1 + 1/(1 + 1/x)) = k, solve for x
        
        x_val = nonzero(2, 12)
        # Work backwards: if x = x_val, find k
        inner = 1 + 1//x_val
        middle = 1 + 1//inner
        k = 1 // middle
        
        # Make it harder with coefficients
        a = nonzero(2, 5)
        b = nonzero(2, 5)
        
        question_text = "Solve for \$x\$: \$\\frac{$(a)}{$(b) + \\frac{1}{1 + \\frac{1}{x}}} = $(tex(k*a//b))\$"
        
        # Solve step by step
        # a/(b + 1/(1 + 1/x)) = ka/b
        # b + 1/(1 + 1/x) = b/k
        # 1/(1 + 1/x) = b/k - b = b(1-k)/k
        # 1 + 1/x = k/(b(1-k))
        # 1/x = k/(b(1-k)) - 1
        # x = 1/(k/(b(1-k)) - 1)
        
        ans = x_val
        
        solution_text = steps(
            sol("Given nested fraction equation"),
            "Let \$u = 1 + \\frac{1}{x}\$, so equation becomes \$\\frac{$(a)}{$(b) + \\frac{1}{u}} = $(tex(k*a//b))\$",
            "Solve for \$u\$: \$u = 1 + \\frac{1}{x}\$",
            "Then solve for \$x\$ by inverting",
            "Simplify to get \$x = $(x_val)\$",
            sol("Answer", x_val)
        )
        
        difficulty_rating = (3200, 3500)
        time_allowed = 300
    end
    
    problem(
        question = question_text,
        answer = ans,
        difficulty = difficulty_rating,
        solution = solution_text,
        answer_type = "set",
        time = time_allowed
    )
end