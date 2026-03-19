# algebra2 - rational_equations (hard)
# Generated: 2026-03-08T20:16:46.130987

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Basic rational equation with two fractions equal to each other
        # ELO 1800-2000
        a1 = nonzero(-8, 8)
        b1 = randint(-15, 15)
        a2 = nonzero(-8, 8)
        b2 = randint(-15, 15)
        
        # Denominators with linear factors
        den1_root = nonzero(-10, 10)
        den2_root = nonzero(-10, 10)
        while den2_root == den1_root
            den2_root = nonzero(-10, 10)
        end
        
        den1 = x - den1_root
        den2 = x - den2_root
        
        # Cross multiply to find solution
        # (a1*x + b1) / den1 = (a2*x + b2) / den2
        # (a1*x + b1) * den2 = (a2*x + b2) * den1
        lhs = expand((a1*x + b1) * den2)
        rhs = expand((a2*x + b2) * den1)
        
        sols = solve(lhs ~ rhs, x)
        if length(sols) > 0
            ans = sols[1]
            # Check it's not an excluded value
            if Float64(ans) != Float64(den1_root) && Float64(ans) != Float64(den2_root)
                num1 = a1*x + b1
                num2 = a2*x + b2
                
                problem(
                    question="Solve the rational equation: \\frac{$(tex(num1))}{$(tex(den1))} = \\frac{$(tex(num2))}{$(tex(den2))}",
                    answer=ans,
                    difficulty=(1800, 2000),
                    solution=steps(
                        sol("Given equation", num1/den1 ~ num2/den2),
                        "Cross multiply: \$($(tex(num1)))($(tex(den2))) = ($(tex(num2)))($(tex(den1)))\$",
                        sol("Expand", lhs ~ rhs),
                        "Solve for x",
                        sol("Answer", ans),
                        "Verify \\(x \\neq $(den1_root), $(den2_root)\\) (excluded values)"
                    ),
                    time=180
                )
            else
                # Solution is excluded, create no solution case
                problem(
                    question="Solve the rational equation: \\frac{$(tex(num1))}{$(tex(den1))} = \\frac{$(tex(num2))}{$(tex(den2))}",
                    answer="no solution",
                    difficulty=(2000, 2200),
                    answer_type="text",
                    solution=steps(
                        sol("Given equation", num1/den1 ~ num2/den2),
                        "Cross multiply and solve",
                        "Get \\(x = $(ans)\\)",
                        "But \\(x = $(ans)\\) makes a denominator zero",
                        "Therefore: no solution"
                    ),
                    time=200
                )
            end
        else
            # Backup simple problem
            ans = randint(-10, 10)
            a = nonzero(-5, 5)
            b = randint(-10, 10)
            den = x - nonzero(-8, 8)
            num = expand(a*(x - ans) + b)
            problem(
                question="Solve: \\frac{$(tex(num))}{$(tex(den))} = $(b)",
                answer=ans,
                difficulty=(1800, 1900),
                solution=steps(
                    "Multiply both sides by denominator",
                    sol("Simplified", num ~ b*den),
                    "Solve for x",
                    sol("Answer", ans)
                ),
                time=150
            )
        end
        
    elseif problem_type == 2
        # Type 2: Sum of rational expressions equals a constant
        # ELO 1900-2100
        den1_root = nonzero(-10, 10)
        den2_root = nonzero(-10, 10)
        while den2_root == den1_root
            den2_root = nonzero(-10, 10)
        end
        
        den1 = x - den1_root
        den2 = x - den2_root
        
        # Pick answer first
        ans = randint(-12, 12)
        while ans == den1_root || ans == den2_root
            ans = randint(-12, 12)
        end
        
        # Create numerators that give a nice equation
        a1 = nonzero(-6, 6)
        a2 = nonzero(-6, 6)
        c = randint(-10, 10)
        
        # a1/(x-r1) + a2/(x-r2) = c
        # Common denominator: (x-r1)(x-r2)
        # a1(x-r2) + a2(x-r1) = c(x-r1)(x-r2)
        
        lhs_num = expand(a1*(x - den2_root) + a2*(x - den1_root))
        rhs_expanded = expand(c * (x - den1_root) * (x - den2_root))
        
        problem(
            question="Solve the equation: \\frac{$(a1)}{$(tex(den1))} + \\frac{$(a2)}{$(tex(den2))} = $(c)",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Find common denominator: \$($(tex(den1)))($(tex(den2)))\$",
                "Multiply both sides by LCD",
                sol("Equation becomes", lhs_num ~ rhs_expanded),
                "Simplify and solve for x",
                sol("Answer", ans),
                "Check excluded values \\(x \\neq $(den1_root), $(den2_root)\\)"
            ),
            time=210
        )
        
    elseif problem_type == 3
        # Type 3: Rational equation with quadratic denominator
        # ELO 2000-2300
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        quad_den = expand((x - r1) * (x - r2))
        linear_den = x - r1
        
        # Pick clean answer
        ans = randint(-10, 10)
        while ans == r1 || ans == r2
            ans = randint(-10, 10)
        end
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-8, 8)
        
        # a/(x-r1) + b/[(x-r1)(x-r2)] = c
        num1 = a
        num2 = b
        
        problem(
            question="Solve: \\frac{$(a)}{$(tex(linear_den))} + \\frac{$(b)}{$(tex(quad_den))} = $(c)",
            answer=ans,
            difficulty=(2000, 2300),
            solution=steps(
                "Factor denominators if needed",
                "LCD is \$($(tex(quad_den)))\$",
                "Multiply through by LCD",
                "Get: \\($(a)($(tex(x - r2))) + $(b) = $(c)($(tex(quad_den)))\\)",
                "Expand and solve",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Type 4: Proportion with quadratics
        # ELO 2100-2400
        q1 = rand_factorable(x; roots=(-8, 8))
        q2 = rand_factorable(x; roots=(-8, 8))
        
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        
        # (ax + b) / q1.expr = constant / q2.expr
        k = nonzero(-5, 5)
        
        # Cross multiply: (ax+b)*q2.expr = k*q1.expr
        lhs = expand((a*x + b) * q2.expr)
        rhs = expand(k * q1.expr)
        
        sols = solve(lhs ~ rhs, x)
        
        if length(sols) > 0
            ans = sols[1]
            excluded = Set([q1.r1, q1.r2, q2.r1, q2.r2])
            
            if !(Float64(ans) in Set(Float64.(collect(excluded))))
                problem(
                    question="Solve: \\frac{$(tex(a*x + b))}{$(tex(q1.expr))} = \\frac{$(k)}{$(tex(q2.expr))}",
                    answer=ans,
                    difficulty=(2100, 2400),
                    solution=steps(
                        "Cross multiply",
                        sol("Get", lhs ~ rhs),
                        "Expand both sides and collect like terms",
                        "Solve the resulting equation",
                        sol("Answer", ans),
                        "Verify solution doesn't make any denominator zero"
                    ),
                    time=270
                )
            else
                problem(
                    question="Solve: \\frac{$(tex(a*x + b))}{$(tex(q1.expr))} = \\frac{$(k)}{$(tex(q2.expr))}",
                    answer="no solution",
                    difficulty=(2200, 2500),
                    answer_type="text",
                    solution=steps(
                        "Cross multiply",
                        "Expand and solve",
                        "Algebraic solution: \\(x = $(ans)\\)",
                        "But \\(x = $(ans)\\) is an excluded value",
                        "Final answer: no solution"
                    ),
                    time=280
                )
            end
        else
            # Fallback
            ans = randint(-8, 8)
            num = expand(2*(x - ans))
            den = expand((x - nonzero(-6, 6)) * (x - nonzero(-6, 6)))
            problem(
                question="Solve: \\frac{$(tex(num))}{$(tex(den))} = 0",
                answer=ans,
                difficulty=(2000, 2200),
                solution=steps(
                    "A fraction equals zero when numerator is zero",
                    sol("Set numerator to zero", num ~ 0),
                    "Solve for x",
                    sol("Answer", ans)
                ),
                time=180
            )
        end
        
    else
        # Type 5: Work/rate problem leading to rational equation
        # ELO 2200-2500
        t1 = randint(3, 15)
        t2 = randint(3, 15)
        while t2 == t1
            t2 = randint(3, 15)
        end
        
        # Working together time
        t_together = (t1 * t2) // (t1 + t2)
        ans = float(t_together)
        
        problem(
            question="Person A can complete a job in $(t1) hours. Person B can complete the same job in $(t2) hours. How long will it take them to complete the job working together? (Give exact answer as a fraction or decimal)",
            answer=ans,
            difficulty=(2200, 2500),
            solution=steps(
                "Rate of A: \\(\\frac{1}{$(t1)}\\) jobs/hour",
                "Rate of B: \\(\\frac{1}{$(t2)}\\) jobs/hour",
                "Combined rate: \\(\\frac{1}{$(t1)} + \\frac{1}{$(t2)} = \\frac{1}{t}\\)",
                "Solve: \\(\\frac{$(t1 + t2)}{$(t1 * t2)} = \\frac{1}{t}\\)",
                sol("Answer", t_together)
            ),
            time=240
        )
    end
end