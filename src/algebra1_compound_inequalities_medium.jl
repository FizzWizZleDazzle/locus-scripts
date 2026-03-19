# algebra1 - compound_inequalities (medium)
# Generated: 2026-03-08T19:55:09.109755

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/compound_inequalities")
    
    problem_type = choice(["and", "or", "and_absolute", "or_mixed"])
    
    if problem_type == "and"
        # Solve a < bx + c < d
        b = nonzero(-5, 5)
        c = randint(-15, 15)
        
        # Pick clean bounds
        lower_bound = randint(-20, 10)
        upper_bound = randint(lower_bound + 3, 25)
        
        # Construct a and d so solutions are clean
        a = b * lower_bound + c
        d = b * upper_bound + c
        
        if b > 0
            ans = fmt_interval(lower_bound, upper_bound, false, false)
            sol_text = "$(lower_bound) < x < $(upper_bound)"
        else
            ans = fmt_interval(upper_bound, lower_bound, false, false)
            sol_text = "$(upper_bound) < x < $(lower_bound)"
        end
        
        problem(
            question="Solve the compound inequality: \$$(a) < $(tex(b*x + c)) < $(d)\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="interval",
            solution=steps(
                "Given: \$$(a) < $(tex(b*x + c)) < $(d)\$",
                "Subtract $(c) from all parts: \$$(a - c) < $(tex(b*x)) < $(d - c)\$",
                "Divide by $(b)$(b < 0 ? " (flip inequalities)" : ""): \$$(sol_text)\$",
                "Answer: \$$(ans)\$"
            ),
            time=120
        )
        
    elseif problem_type == "or"
        # Solve x < a or x > b
        a = randint(-15, 5)
        b = randint(a + 5, 20)
        
        # Create inequalities with coefficients
        coef1 = nonzero(-4, 4)
        const1 = randint(-20, 20)
        coef2 = nonzero(-4, 4)
        const2 = randint(-20, 20)
        
        # Bound values that lead to x < a or x > b
        rhs1 = coef1 * a + const1
        rhs2 = coef2 * b + const2
        
        if coef1 > 0
            ineq1_symbol = "<"
            bound1 = a
            interval1 = fmt_interval(-Inf, bound1, true, false)
        else
            ineq1_symbol = ">"
            bound1 = a
            interval1 = fmt_interval(bound1, Inf, false, true)
        end
        
        if coef2 > 0
            ineq2_symbol = ">"
            bound2 = b
            interval2 = fmt_interval(bound2, Inf, false, true)
        else
            ineq2_symbol = "<"
            bound2 = b
            interval2 = fmt_interval(-Inf, bound2, true, false)
        end
        
        ans = "$(interval1) ∪ $(interval2)"
        
        problem(
            question="Solve the compound inequality: \$$(tex(coef1*x + const1)) $(ineq1_symbol) $(rhs1)\$ or \$$(tex(coef2*x + const2)) $(ineq2_symbol) $(rhs2)\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                "Solve first inequality: \$$(tex(coef1*x + const1)) $(ineq1_symbol) $(rhs1)\$",
                "Get \$x $(ineq1_symbol == "<" ? (coef1 > 0 ? "<" : ">") : (coef1 > 0 ? ">" : "<")) $(bound1)\$",
                "Solve second inequality: \$$(tex(coef2*x + const2)) $(ineq2_symbol) $(rhs2)\$",
                "Get \$x $(ineq2_symbol == ">" ? (coef2 > 0 ? ">" : "<") : (coef2 > 0 ? "<" : ">")) $(bound2)\$",
                "Union: \$$(ans)\$"
            ),
            time=150
        )
        
    elseif problem_type == "and_absolute"
        # Solve compound with absolute value: a < |bx + c| < d
        b = nonzero(-4, 4)
        c = randint(-12, 12)
        
        lower = randint(2, 8)
        upper = randint(lower + 4, 18)
        
        # |bx + c| < upper gives -(upper) < bx + c < upper
        # |bx + c| > lower gives bx + c < -(lower) or bx + c > lower
        
        if b > 0
            left1 = (-upper - c) // b
            right1 = (upper - c) // b
            left2 = (-lower - c) // b
            right2 = (lower - c) // b
            
            # Intersection of x in (left1, right1) and (x < left2 or x > right2)
            ans = "$(fmt_interval(left1, left2, false, false)) ∪ $(fmt_interval(right2, right1, false, false))"
        else
            left1 = (upper - c) // b
            right1 = (-upper - c) // b
            left2 = (lower - c) // b
            right2 = (-lower - c) // b
            
            ans = "$(fmt_interval(left1, left2, false, false)) ∪ $(fmt_interval(right2, right1, false, false))"
        end
        
        problem(
            question="Solve: \$$(lower) < |$(tex(b*x + c))| < $(upper)\$",
            answer=ans,
            difficulty=(1500, 1700),
            answer_type="interval",
            solution=steps(
                "Split into two inequalities: \$|$(tex(b*x + c))| > $(lower)\$ AND \$|$(tex(b*x + c))| < $(upper)\$",
                "From \$|$(tex(b*x + c))| < $(upper)\$: \$$(-(upper)) < $(tex(b*x + c)) < $(upper)\$",
                "From \$|$(tex(b*x + c))| > $(lower)\$: \$$(tex(b*x + c)) < $(-(lower))\$ or \$$(tex(b*x + c)) > $(lower)\$",
                "Find intersection of solution sets",
                "Answer: \$$(ans)\$"
            ),
            time=180
        )
        
    else  # or_mixed
        # ax + b < c or dx + e >= f
        a = nonzero(-5, 5)
        b = randint(-15, 15)
        d = nonzero(-5, 5)
        e = randint(-15, 15)
        
        bound1 = randint(-12, 12)
        bound2 = randint(-12, 12)
        
        c = a * bound1 + b
        f = d * bound2 + e
        
        if a > 0
            interval1 = fmt_interval(-Inf, bound1, true, false)
            ineq1_text = "x < $(bound1)"
        else
            interval1 = fmt_interval(bound1, Inf, false, true)
            ineq1_text = "x > $(bound1)"
        end
        
        if d > 0
            interval2 = fmt_interval(bound2, Inf, true, true)
            ineq2_text = "x \\geq $(bound2)"
        else
            interval2 = fmt_interval(-Inf, bound2, true, true)
            ineq2_text = "x \\leq $(bound2)"
        end
        
        ans = "$(interval1) ∪ $(interval2)"
        
        problem(
            question="Solve: \$$(tex(a*x + b)) < $(c)\$ or \$$(tex(d*x + e)) \\geq $(f)\$",
            answer=ans,
            difficulty=(1200, 1500),
            answer_type="interval",
            solution=steps(
                "Solve \$$(tex(a*x + b)) < $(c)\$: subtract $(b), divide by $(a)$(a < 0 ? " (flip inequality)" : "")",
                "First inequality gives: \$$(ineq1_text)\$",
                "Solve \$$(tex(d*x + e)) \\geq $(f)\$: subtract $(e), divide by $(d)$(d < 0 ? " (flip inequality)" : "")",
                "Second inequality gives: \$$(ineq2_text)\$",
                "Union: \$$(ans)\$"
            ),
            time=150
        )
    end
end