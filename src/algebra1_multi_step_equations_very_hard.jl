# algebra1 - multi_step_equations (very_hard)
# Generated: 2026-03-08T19:53:58.215127

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nested absolute value equation with multiple solutions
        a = nonzero(-8, 8)
        b = nonzero(-15, 15)
        c = nonzero(5, 25)
        
        # |ax + b| = c has solutions x = (c - b)/a and x = (-c - b)/a
        sol1 = (c - b) // a
        sol2 = (-c - b) // a
        
        lhs = abs(a*x + b)
        
        problem(
            question="Solve the equation: \$$(tex(lhs)) = $(c)\$",
            answer=fmt_set(Set([sol1, sol2])),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                sol("Given", lhs ~ c),
                "Consider two cases: \$$(tex(a*x + b)) = $(c)\$ or \$$(tex(a*x + b)) = $(-c)\$",
                "Case 1: \$x = $(sol1)\$",
                "Case 2: \$x = $(sol2)\$",
                "Solution set: \$\\{$(sol1), $(sol2)\\}\$"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # System with parametric constraint
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        # Pick a clean solution
        x_val = randint(-10, 10)
        y_val = randint(-10, 10)
        
        # Construct equations: ax + by = rhs1, cx + dy = rhs2
        rhs1 = a * x_val + b * y_val
        rhs2 = c * x_val + d * y_val
        
        # Check determinant is nonzero
        det_val = a * d - b * c
        if det_val == 0
            a = a + 1
            det_val = a * d - b * c
            rhs1 = a * x_val + b * y_val
        end
        
        problem(
            question="Solve the system of equations and find \$x + y\$:<br>\$$(tex(a*x + b*y)) = $(rhs1)\$<br>\$$(tex(c*x + d*y)) = $(rhs2)\$",
            answer=x_val + y_val,
            difficulty=(2600, 2900),
            solution=steps(
                "System: \$$(tex(a*x + b*y)) = $(rhs1)\$ and \$$(tex(c*x + d*y)) = $(rhs2)\$",
                "Use elimination or substitution",
                sol("x", x_val),
                sol("y", y_val),
                sol("x + y", x_val + y_val)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Rational equation with restrictions
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        # Solution will be at x = r1
        num_coeff = nonzero(-5, 5)
        
        # (x - r1)/(x - r2) = num_coeff
        # x - r1 = num_coeff*(x - r2)
        # x - r1 = num_coeff*x - num_coeff*r2
        # x - num_coeff*x = r1 - num_coeff*r2
        # x(1 - num_coeff) = r1 - num_coeff*r2
        # x = (r1 - num_coeff*r2)/(1 - num_coeff)
        
        if num_coeff != 1
            x_ans = (r1 - num_coeff*r2) // (1 - num_coeff)
            
            problem(
                question="Solve for \$x\$: \$\\frac{x - $(r1)}{x - $(r2)} = $(num_coeff)\$ (where \$x \\neq $(r2)\$)",
                answer=x_ans,
                difficulty=(2700, 3000),
                solution=steps(
                    sol("Given", (x - r1)/(x - r2) ~ num_coeff),
                    "Multiply both sides by \$(x - $(r2))\$: \$x - $(r1) = $(num_coeff)(x - $(r2))\$",
                    "Expand and collect terms",
                    "Solve for \$x\$",
                    sol("Answer", x_ans)
                ),
                time=210
            )
        else
            # Fallback to simpler problem
            x_ans = randint(-15, 15)
            a = nonzero(-7, 7)
            b = randint(-20, 20)
            lhs = expand(a*(x - x_ans) + b)
            
            problem(
                question="Solve for \$x\$: \$$(tex(lhs)) = $(b)\$",
                answer=x_ans,
                difficulty=(2500, 2700),
                solution=steps(
                    sol("Given", lhs ~ b),
                    "Isolate \$x\$ term",
                    "Divide by coefficient",
                    sol("Answer", x_ans)
                ),
                time=150
            )
        end
        
    elseif problem_type == 4
        # Nested fraction equation
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        c = nonzero(-5, 5)
        d = randint(-12, 12)
        k = nonzero(-8, 8)
        
        # Pick solution
        x_ans = nonzero(-10, 10)
        
        # a/(x + b) + c = d  => a = (d - c)(x + b)
        # x = a/(d - c) - b (if d != c)
        if d != c
            x_ans = a // (d - c) - b
        else
            d = d + 1
            x_ans = a // (d - c) - b
        end
        
        problem(
            question="Solve for \$x\$: \$\\frac{$(a)}{x + $(b)} + $(c) = $(d)\$",
            answer=x_ans,
            difficulty=(2800, 3100),
            solution=steps(
                sol("Given", a/(x + b) + c ~ d),
                "Subtract $(c) from both sides: \$\\frac{$(a)}{x + $(b)} = $(d - c)\$",
                "Multiply both sides by \$(x + $(b))\$: \$$(a) = $(d - c)(x + $(b))\$",
                "Expand and solve",
                sol("Answer", x_ans)
            ),
            time=240
        )
        
    else
        # Complex multi-step with distribution and combining
        x_ans = randint(-20, 20)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = randint(-15, 15)
        e = randint(-15, 15)
        
        # a(x - d) + b(x - e) = c
        # ax - ad + bx - be = c
        # (a + b)x = c + ad + be
        # x = (c + ad + be)/(a + b)
        
        if a + b != 0
            rhs_val = c + a*d + b*e - (a + b)*x_ans
            lhs = expand(a*(x - d) + b*(x - e))
            
            problem(
                question="Solve for \$x\$: \$$(tex(lhs)) = $(-rhs_val)\$",
                answer=x_ans,
                difficulty=(3000, 3300),
                solution=steps(
                    sol("Given", lhs ~ -rhs_val),
                    "Distribute: \$$(tex(a*x - a*d + b*x - b*e)) = $(-rhs_val)\$",
                    "Combine like terms: \$$(tex((a+b)*x)) = $(-(rhs_val + a*d + b*e))\$",
                    "Divide by coefficient",
                    sol("Answer", x_ans)
                ),
                time=270
            )
        else
            # Fallback
            x_ans = randint(-15, 15)
            a = nonzero(-9, 9)
            b = randint(-25, 25)
            lhs = expand(a*(x - x_ans) + b)
            
            problem(
                question="Solve for \$x\$: \$$(tex(lhs)) = $(b)\$",
                answer=x_ans,
                difficulty=(2600, 2900),
                solution=steps(
                    sol("Given", lhs ~ b),
                    "Expand and simplify",
                    "Isolate \$x\$",
                    sol("Answer", x_ans)
                ),
                time=180
            )
        end
    end
end