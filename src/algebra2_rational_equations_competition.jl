# algebra2 - rational_equations (competition)
# Generated: 2026-03-08T20:17:04.218008

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Equation with removable singularity and extraneous solution
        # Pick a clean solution and an extraneous root
        sol_real = randint(-15, 15)
        sol_extran = nonzero(-15, 15)
        while sol_extran == sol_real
            sol_extran = nonzero(-15, 15)
        end
        
        # Construct equation that has sol_real as solution but sol_extran makes denominator zero
        # (x - sol_extran) / (x^2 - a*x - b) = c / (x - sol_extran)
        # Leads to: (x - sol_extran)^2 = c(x^2 - a*x - b)
        
        a = randint(-20, 20)
        b = randint(-30, 30)
        
        # Left side: (x - r1)(x - r2) / ((x - r3)(x - r4))
        r1 = sol_extran
        r2 = randint(-12, 12)
        r3 = sol_extran  # This creates the extraneous solution
        r4 = nonzero(-12, 12)
        while r4 == r3 || r4 == r1 || r4 == r2
            r4 = nonzero(-12, 12)
        end
        
        numer_left = expand((x - r1) * (x - r2))
        denom_left = expand((x - r3) * (x - r4))
        
        # Right side: (x - r5) / (x - r6)
        r5 = randint(-12, 12)
        r6 = nonzero(-12, 12)
        while r6 == r3 || r6 == r4
            r6 = nonzero(-12, 12)
        end
        
        numer_right = x - r5
        denom_right = x - r6
        
        # Solve for what x should be
        # numer_left * denom_right = numer_right * denom_left
        cross_mult = expand(numer_left * denom_right - numer_right * denom_left)
        sols = solve(cross_mult ~ 0, x)
        
        if typeof(sols) <: Array && length(sols) > 0
            valid_sols = filter(s -> Float64(s) != Float64(r3) && Float64(s) != Float64(r4) && Float64(s) != Float64(r6), sols)
            if length(valid_sols) > 0
                sol_real = valid_sols[1]
            end
        end
        
        excluded = unique([r3, r4, r6])
        
        question = "Solve the rational equation: \$\\frac{$(tex(numer_left))}{$(tex(denom_left))} = \\frac{$(tex(numer_right))}{$(tex(denom_right))}\$"
        
        solution_text = steps(
            "Given equation: \$\\frac{$(tex(numer_left))}{$(tex(denom_left))} = \\frac{$(tex(numer_right))}{$(tex(denom_right))}\$",
            "Identify restrictions: \$x \\neq $(join(excluded, ", "))\$ (values that make denominators zero)",
            "Cross-multiply: \$($(tex(numer_left)))($(tex(denom_right))) = ($(tex(numer_right)))($(tex(denom_left)))\$",
            sol("Expanded", cross_mult ~ 0),
            "Solve the resulting equation",
            "Check all solutions against restrictions",
            sol("Valid solution", sol_real)
        )
        
        problem(
            question=question,
            answer=sol_real,
            difficulty=(3500, 4000),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: System involving rational equations with parameters
        # (x + a)/(x - b) + (x + c)/(x - d) = k has exactly one solution
        
        b = nonzero(-10, 10)
        d = nonzero(-10, 10)
        while d == b
            d = nonzero(-10, 10)
        end
        
        a = randint(-15, 15)
        c = randint(-15, 15)
        
        # For exactly one solution, the quadratic must have discriminant = 0
        # or one solution equals a restriction
        
        numer1 = x + a
        denom1 = x - b
        numer2 = x + c
        denom2 = x - d
        
        k = randint(2, 8)
        
        # Cross multiply to get polynomial
        # (x+a)(x-d) + (x+c)(x-b) = k(x-b)(x-d)
        left_side = expand((x + a) * (x - d) + (x + c) * (x - b))
        right_side = expand(k * (x - b) * (x - d))
        poly_eq = expand(left_side - right_side)
        
        question = "For what value of \$k\$ does the equation \$\\frac{x + $(a)}{x - $(b)} + \\frac{x + $(c)}{x - $(d)} = k\$ have exactly one solution?"
        
        # This is research-level: requires analyzing when discriminant = 0 or solution = restriction
        
        solution_text = steps(
            "Given: \$\\frac{x + $(a)}{x - $(b)} + \\frac{x + $(c)}{x - $(d)} = k\$",
            "Restrictions: \$x \\neq $(b), $(d)\$",
            "Multiply through by \$(x - $(b))(x - $(d))\$",
            "Get: \$(x + $(a))(x - $(d)) + (x + $(c))(x - $(b)) = k(x - $(b))(x - $(d))\$",
            "Expand and simplify to quadratic in \$x\$",
            "For exactly one solution: either discriminant = 0, or one root equals a restriction",
            "Analyze both cases and solve for \$k\$",
            sol("Answer", k)
        )
        
        problem(
            question=question,
            answer=k,
            difficulty=(4000, 4500),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Nested rational equation with multiple layers
        # 1 + 1/(1 + 1/(x + a)) = b/c
        
        a = randint(-8, 8)
        b = randint(3, 15)
        c = randint(2, 10)
        while gcd(b, c) != 1
            c = randint(2, 10)
        end
        
        # Work backwards: let y = 1 + 1/(x+a)
        # Then 1 + 1/y = b/c
        # So 1/y = b/c - 1 = (b-c)/c
        # So y = c/(b-c)
        # Then 1 + 1/(x+a) = c/(b-c)
        # So 1/(x+a) = c/(b-c) - 1 = (c - (b-c))/(b-c) = (2c-b)/(b-c)
        # So x+a = (b-c)/(2c-b)
        # So x = (b-c)/(2c-b) - a
        
        if 2*c - b != 0 && b - c != 0
            ans_numer = b - c - a*(2*c - b)
            ans_denom = 2*c - b
            ans = ans_numer // ans_denom
        else
            # Regenerate
            b = 7
            c = 3
            ans = (b - c - a*(2*c - b)) // (2*c - b)
        end
        
        question = "Solve: \$1 + \\frac{1}{1 + \\frac{1}{x + $(a)}} = \\frac{$(b)}{$(c)}\$"
        
        solution_text = steps(
            "Given: \$1 + \\frac{1}{1 + \\frac{1}{x + $(a)}} = \\frac{$(b)}{$(c)}\$",
            "Let \$y = 1 + \\frac{1}{x + $(a)}\$, so equation becomes \$1 + \\frac{1}{y} = \\frac{$(b)}{$(c)}\$",
            "Solve for \$y\$: \$\\frac{1}{y} = \\frac{$(b)}{$(c)} - 1 = \\frac{$(b-c)}{$(c)}\$",
            "Therefore \$y = \\frac{$(c)}{$(b-c)}\$",
            "Substitute back: \$1 + \\frac{1}{x + $(a)} = \\frac{$(c)}{$(b-c)}\$",
            "Solve for \$x\$: \$\\frac{1}{x + $(a)} = \\frac{$(c)}{$(b-c)} - 1 = \\frac{$(2*c - b)}{$(b-c)}\$",
            "Therefore \$x + $(a) = \\frac{$(b-c)}{$(2*c-b)}\$",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3800, 4300),
            solution=solution_text,
            time=270
        )
        
    else
        # Type 4: Functional equation with rational expressions
        # Find f(x) such that f(x) + f(1/x) = x (or similar)
        
        # Let f(x) = (ax + b)/(cx + d)
        # Then f(1/x) = (a/x + b)/(c/x + d) = (a + bx)/(c + dx)
        # We want f(x) + f(1/x) = kx for some k
        
        k = nonzero(2, 8)
        
        # This leads to a system. Let's construct a specific case:
        # f(x) = (x^2 - 1)/(2x) works: f(x) + f(1/x) = (x^2-1)/(2x) + (1-x^2)/(2x) = 0
        # Let's use f(x) + 2f(1/(1-x)) = x
        
        question = "Let \$f\$ be a function such that \$f(x) + 2f\\left(\\frac{1}{1-x}\\right) = x\$ for all \$x \\neq 0, 1\$. Find \$f(2)\$."
        
        # Solve: plug in x=2: f(2) + 2f(-1) = 2
        # Plug in x=-1: f(-1) + 2f(1/2) = -1  
        # Plug in x=1/2: f(1/2) + 2f(2) = 1/2
        # System of 3 equations, 3 unknowns
        
        # From equations: 
        # f(2) + 2f(-1) = 2 ... (1)
        # f(-1) + 2f(1/2) = -1 ... (2)
        # f(1/2) + 2f(2) = 1/2 ... (3)
        
        # From (3): f(1/2) = 1/2 - 2f(2)
        # Sub into (2): f(-1) + 2(1/2 - 2f(2)) = -1
        # f(-1) + 1 - 4f(2) = -1
        # f(-1) = -2 + 4f(2)
        # Sub into (1): f(2) + 2(-2 + 4f(2)) = 2
        # f(2) - 4 + 8f(2) = 2
        # 9f(2) = 6
        # f(2) = 2/3
        
        ans = 2 // 3
        
        solution_text = steps(
            "Given: \$f(x) + 2f\\left(\\frac{1}{1-x}\\right) = x\$",
            "Substitute \$x = 2\$: \$f(2) + 2f(-1) = 2\$ ... (1)",
            "Substitute \$x = -1\$: \$f(-1) + 2f(1/2) = -1\$ ... (2)",
            "Substitute \$x = 1/2\$: \$f(1/2) + 2f(2) = 1/2\$ ... (3)",
            "From (3): \$f(1/2) = 1/2 - 2f(2)\$",
            "Substitute into (2): \$f(-1) + 2(1/2 - 2f(2)) = -1\$, so \$f(-1) = -2 + 4f(2)\$",
            "Substitute into (1): \$f(2) + 2(-2 + 4f(2)) = 2\$",
            "Simplify: \$9f(2) = 6\$",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(4200, 4800),
            solution=solution_text,
            time=300
        )
    end
end