# algebra1 - two_step_equations (very_hard)
# Generated: 2026-03-08T19:53:27.716996

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: nested absolute value equation with multiple cases
        # |ax + b| + c|dx + e| = f, where solution requires casework
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = nonzero(-5, 5)
        d = nonzero(-8, 8)
        e = randint(-25, 25)
        
        # Pick a solution x₀ and construct f from it
        x0 = randint(-15, 15)
        f = abs(a*x0 + b) + c*abs(d*x0 + e)
        
        # Find critical points where expressions inside absolute values are zero
        cp1 = -b // a
        cp2 = -e // d
        
        # Solve in different regions
        solutions = Set()
        
        # Test regions around critical points
        test_points = sort([float(cp1), float(cp2)])
        regions = [
            (-100.0, test_points[1] - 0.1),
            (test_points[1] + 0.1, test_points[2] - 0.1),
            (test_points[2] + 0.1, 100.0)
        ]
        
        for (low, high) in regions
            test_x = (low + high) / 2
            
            sign1 = a*test_x + b >= 0 ? 1 : -1
            sign2 = d*test_x + e >= 0 ? 1 : -1
            
            # Solve: sign1*(ax+b) + c*sign2*(dx+e) = f
            coeff = sign1*a + c*sign2*d
            const_term = sign1*b + c*sign2*e
            
            if coeff != 0
                sol_x = (f - const_term) // coeff
                # Verify solution is in region and satisfies original equation
                if low < float(sol_x) < high
                    check_val = abs(a*sol_x + b) + c*abs(d*sol_x + e)
                    if check_val == f
                        push!(solutions, sol_x)
                    end
                end
            end
        end
        
        problem(
            question="Solve for all real values of \\(x\\): \$|$(tex(a*x + b))| + $(c) \\cdot |$(tex(d*x + e))| = $(f)\$",
            answer=fmt_set(solutions),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                sol("Given", "|$(tex(a*x + b))| + $(c)|$(tex(d*x + e))| = $(f)"),
                "Critical points occur at \\(x = $(tex(cp1))\\) and \\(x = $(tex(cp2))\\)",
                "Consider cases in each region defined by critical points",
                "Solve linear equation in each valid region",
                "Verify each candidate solution in original equation",
                "Solution set: $(fmt_set(solutions))"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Olympiad-level: functional equation with algebraic manipulation
        # Find all x such that f(x) = f(x+k) where f involves nested operations
        k = nonzero(-12, 12)
        a = nonzero(-7, 7)
        b = randint(-20, 20)
        c = nonzero(-6, 6)
        d = randint(-20, 20)
        
        # f(x) = (ax + b)/(cx + d)
        # Solve: (ax + b)/(cx + d) = (a(x+k) + b)/(c(x+k) + d)
        
        # Cross multiply: (ax+b)(c(x+k)+d) = (a(x+k)+b)(cx+d)
        # Expand and simplify to find solutions
        
        lhs_expr = (a*x + b) // (c*x + d)
        rhs_expr = (a*(x+k) + b) // (c*(x+k) + d)
        
        # Cross multiply and expand
        lhs_cross = expand((a*x + b) * (c*(x+k) + d))
        rhs_cross = expand((a*(x+k) + b) * (c*x + d))
        
        equation = expand(lhs_cross - rhs_cross)
        
        # Solve for x
        solutions_list = solve(equation ~ 0, x)
        if isa(solutions_list, Vector)
            solutions = Set(solutions_list)
        else
            solutions = Set([solutions_list])
        end
        
        # Filter out values that make denominator zero
        valid_solutions = Set()
        for sol_x in solutions
            if c*sol_x + d != 0 && c*(sol_x+k) + d != 0
                push!(valid_solutions, sol_x)
            end
        end
        
        problem(
            question="Find all real \\(x\\) such that \\(\\frac{$(tex(a*x + b))}{$(tex(c*x + d))} = \\frac{$(tex(a*(x+k) + b))}{$(tex(c*(x+k) + d))}\\)",
            answer=fmt_set(valid_solutions),
            difficulty=(2800, 3200),
            answer_type="set",
            solution=steps(
                sol("Given", "\\frac{$(tex(a*x + b))}{$(tex(c*x + d))} = \\frac{$(tex(a*(x+k) + b))}{$(tex(c*(x+k) + d))}"),
                "Cross multiply to eliminate fractions",
                sol("Expanded", equation ~ 0),
                "Solve the resulting linear or quadratic equation",
                "Check denominators are non-zero at solutions",
                "Solution set: $(fmt_set(valid_solutions))"
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition-level: parametric constraint problem
        # Given ax + b = c(dx + e), find relationship between parameters
        # where solution must satisfy x² - px + q = 0 for given p, q
        
        p = randint(-15, 15)
        q = randint(-20, 20)
        
        # Roots of x² - px + q = 0
        discriminant = p^2 - 4*q
        
        if discriminant >= 0
            r1 = (p + sqrt(discriminant)) / 2
            r2 = (p - sqrt(discriminant)) / 2
            x_sol = rationalize(r1)
        else
            x_sol = randint(-15, 15)
        end
        
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        d = nonzero(-8, 8)
        e = randint(-25, 25)
        
        # Find c such that ax + b = c(dx + e) at x = x_sol
        if d*x_sol + e != 0
            c = (a*x_sol + b) // (d*x_sol + e)
        else
            c = randint(2, 9)
        end
        
        problem(
            question="If the equation \$$(tex(a*x + b)) = c \\cdot ($(tex(d*x + e)))\$ has the same solution as \$x^2 - $(p)x + $(q) = 0\$, find the value of \\(c\\).",
            answer=c,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Given quadratic", x^2 - p*x + q ~ 0),
                "Solve quadratic using quadratic formula or factoring",
                sol("Solution", "x = $(tex(x_sol))"),
                "Substitute into \$$(tex(a*x + b)) = c($(tex(d*x + e)))\$",
                sol("At x = $(tex(x_sol))", "$(tex(a*x_sol + b)) = c \\cdot $(tex(d*x_sol + e))"),
                sol("Solve for c", c)
            ),
            time=240
        )
        
    else
        # Olympiad-level: system with floor function
        # Solve: a⌊x⌋ + bx = c where ⌊x⌋ is floor function
        
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        
        # Pick an answer with fractional part
        n = randint(-12, 12)
        frac = rand([1//4, 1//3, 1//2, 2//3, 3//4])
        x_ans = n + frac
        
        c = a*n + b*x_ans
        
        problem(
            question="Solve for \\(x\\): \$$(a) \\lfloor x \\rfloor + $(tex(b*x)) = $(tex(c))\$, where \\(\\lfloor x \\rfloor\\) denotes the greatest integer less than or equal to \\(x\\).",
            answer=x_ans,
            difficulty=(3000, 3500),
            solution=steps(
                sol("Given", "$(a)\\lfloor x \\rfloor + $(tex(b*x)) = $(tex(c))"),
                "Let \\(\\lfloor x \\rfloor = n\\), so \\(n \\leq x < n+1\\)",
                "Substitute: \$$(a)n + $(tex(b*x)) = $(tex(c))\$",
                sol("Solve for x", "x = \\frac{$(tex(c - a*n))}{$(b)} = $(tex((c - a*n)//b))"),
                "Verify \\(n \\leq x < n+1\\) to find valid integer \\(n\\)",
                sol("For n = $(n)", "x = $(tex(x_ans))"),
                "Check: \\($(n) \\leq $(tex(x_ans)) < $(n+1)\\) ✓",
                sol("Answer", x_ans)
            ),
            time=300
        )
    end
end