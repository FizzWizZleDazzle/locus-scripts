# algebra1 - compound_inequalities (hard)
# Generated: 2026-03-08T19:55:23.884789

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/compound_inequalities")
    
    # Choose problem type
    problem_type = choice(["and_standard", "or_standard", "and_absolute", "or_absolute", "and_quadratic", "complex_and"])
    
    if problem_type == "and_standard"
        # ax + b < c AND dx + e < f
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = randint(-30, 30)
        d = nonzero(-8, 8)
        e = randint(-25, 25)
        f = randint(-30, 30)
        
        bound1 = (c - b) // a
        bound2 = (f - e) // d
        
        # Ensure bounds are different
        while bound1 == bound2
            f = randint(-30, 30)
            bound2 = (f - e) // d
        end
        
        # Determine interval based on inequality directions
        if a > 0 && d > 0
            lower = max(bound1, bound2)
            upper = Inf
            left_open = true
            ans = fmt_interval(lower, upper, left_open, true)
        elseif a < 0 && d < 0
            upper = min(bound1, bound2)
            lower = -Inf
            ans = fmt_interval(lower, upper, true, true)
        else
            # Mixed directions - creates bounded interval
            if a > 0
                left_bound = bound1
                right_bound = bound2
            else
                left_bound = bound2
                right_bound = bound1
            end
            if left_bound < right_bound
                ans = fmt_interval(left_bound, right_bound, true, true)
            else
                ans = "\\emptyset"
            end
        end
        
        ineq1 = a > 0 ? "$(tex(a*x + b)) < $(c)" : "$(tex(a*x + b)) > $(c)"
        ineq2 = d > 0 ? "$(tex(d*x + e)) < $(f)" : "$(tex(d*x + e)) > $(f)"
        
        problem(
            question="Solve the compound inequality: \$$(ineq1)\$ AND \$$(ineq2)\$",
            answer=ans,
            difficulty=(1800, 2100),
            answer_type="interval",
            solution=steps(
                "Solve first inequality: \$$(ineq1)\$",
                sol("First bound", "x $(a > 0 ? "<" : ">") $(bound1)"),
                "Solve second inequality: \$$(ineq2)\$",
                sol("Second bound", "x $(d > 0 ? "<" : ">") $(bound2)"),
                "Find intersection of both solution sets",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == "or_standard"
        # ax + b < c OR dx + e > f
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = randint(-30, 30)
        d = nonzero(-8, 8)
        e = randint(-25, 25)
        f = randint(-30, 30)
        
        bound1 = (c - b) // a
        bound2 = (f - e) // d
        
        # For OR, we want a gap between bounds
        while abs(bound1 - bound2) < 5
            c = randint(-30, 30)
            f = randint(-30, 30)
            bound1 = (c - b) // a
            bound2 = (f - e) // d
        end
        
        if a > 0 && d > 0
            # x < bound1 OR x > bound2
            if bound1 < bound2
                ans = fmt_interval(-Inf, bound1, true, true) * " \\cup " * fmt_interval(bound2, Inf, true, true)
            else
                ans = fmt_interval(-Inf, Inf, true, true)
            end
        elseif a < 0 && d < 0
            # x > bound1 OR x < bound2
            if bound1 > bound2
                ans = fmt_interval(-Inf, bound2, true, true) * " \\cup " * fmt_interval(bound1, Inf, true, true)
            else
                ans = fmt_interval(-Inf, Inf, true, true)
            end
        else
            ans = fmt_interval(-Inf, Inf, true, true)
        end
        
        ineq1 = a > 0 ? "$(tex(a*x + b)) < $(c)" : "$(tex(a*x + b)) > $(c)"
        ineq2 = d > 0 ? "$(tex(d*x + e)) > $(f)" : "$(tex(d*x + e)) < $(f)"
        
        problem(
            question="Solve the compound inequality: \$$(ineq1)\$ OR \$$(ineq2)\$",
            answer=ans,
            difficulty=(1900, 2200),
            answer_type="interval",
            solution=steps(
                "Solve first inequality: \$$(ineq1)\$",
                sol("First solution", "x $(a > 0 ? "<" : ">") $(bound1)"),
                "Solve second inequality: \$$(ineq2)\$",
                sol("Second solution", "x $(d > 0 ? ">" : "<") $(bound2)"),
                "Find union of both solution sets",
                sol("Answer", ans)
            ),
            time=200
        )
        
    elseif problem_type == "and_absolute"
        # |ax + b| < c AND dx + e > f
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = randint(5, 25)
        d = nonzero(-6, 6)
        e = randint(-20, 20)
        f = randint(-25, 25)
        
        # |ax + b| < c gives -c < ax + b < c
        left_bound = (-c - b) // a
        right_bound = (c - b) // a
        if a < 0
            left_bound, right_bound = right_bound, left_bound
        end
        
        linear_bound = (f - e) // d
        
        # Intersection with linear inequality
        if d > 0
            final_left = max(left_bound, linear_bound)
            final_right = right_bound
        else
            final_left = left_bound
            final_right = min(right_bound, linear_bound)
        end
        
        if final_left < final_right
            ans = fmt_interval(final_left, final_right, true, true)
        else
            ans = "\\emptyset"
        end
        
        problem(
            question="Solve: \$|$(tex(a*x + b))| < $(c)\$ AND \$$(tex(d*x + e)) > $(f)\$",
            answer=ans,
            difficulty=(2000, 2300),
            answer_type="interval",
            solution=steps(
                "Solve absolute value inequality: \$-$(c) < $(tex(a*x + b)) < $(c)\$",
                sol("From absolute value", "$(left_bound) < x < $(right_bound)"),
                "Solve linear inequality: \$$(tex(d*x + e)) > $(f)\$",
                sol("From linear", "x $(d > 0 ? ">" : "<") $(linear_bound)"),
                "Find intersection of solution sets",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == "or_absolute"
        # |ax + b| > c OR dx + e < f
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = randint(5, 25)
        d = nonzero(-6, 6)
        e = randint(-20, 20)
        f = randint(-25, 25)
        
        # |ax + b| > c gives ax + b > c OR ax + b < -c
        right_bound = (c - b) // a
        left_bound = (-c - b) // a
        if a < 0
            left_bound, right_bound = right_bound, left_bound
        end
        
        linear_bound = (f - e) // d
        
        abs_part = fmt_interval(-Inf, left_bound, true, true) * " \\cup " * fmt_interval(right_bound, Inf, true, true)
        linear_part = d > 0 ? fmt_interval(-Inf, linear_bound, true, true) : fmt_interval(linear_bound, Inf, true, true)
        
        # Union is typically all reals or complex union
        ans = fmt_interval(-Inf, Inf, true, true)
        
        problem(
            question="Solve: \$|$(tex(a*x + b))| > $(c)\$ OR \$$(tex(d*x + e)) < $(f)\$",
            answer=ans,
            difficulty=(2100, 2400),
            answer_type="interval",
            solution=steps(
                "Solve absolute value inequality: \$$(tex(a*x + b)) > $(c)\$ OR \$$(tex(a*x + b)) < -$(c)\$",
                "This gives \$x < $(left_bound)\$ OR \$x > $(right_bound)\$",
                "Solve linear inequality: \$$(tex(d*x + e)) < $(f)\$",
                sol("From linear", "x $(d > 0 ? "<" : ">") $(linear_bound)"),
                "Take union of all solution sets",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == "and_quadratic"
        # (x - r1)(x - r2) < 0 AND ax + b > c
        r1 = randint(-15, 15)
        r2 = randint(-15, 15)
        while r1 == r2
            r2 = randint(-15, 15)
        end
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        quad_expr = expand((x - r1) * (x - r2))
        
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = randint(-25, 25)
        linear_bound = (c - b) // a
        
        # Quadratic inequality gives (r1, r2)
        if a > 0
            final_left = max(r1, linear_bound)
            final_right = r2
        else
            final_left = r1
            final_right = min(r2, linear_bound)
        end
        
        if final_left < final_right
            ans = fmt_interval(final_left, final_right, true, true)
        else
            ans = "\\emptyset"
        end
        
        problem(
            question="Solve: \$$(tex(quad_expr)) < 0\$ AND \$$(tex(a*x + b)) > $(c)\$",
            answer=ans,
            difficulty=(2200, 2500),
            answer_type="interval",
            solution=steps(
                "Factor quadratic: \$$(tex((x - r1)*(x - r2))) < 0\$",
                sol("From quadratic", "$(r1) < x < $(r2)"),
                "Solve linear inequality: \$$(tex(a*x + b)) > $(c)\$",
                sol("From linear", "x $(a > 0 ? ">" : "<") $(linear_bound)"),
                "Find intersection of solution sets",
                sol("Answer", ans)
            ),
            time=270
        )
        
    else  # complex_and
        # |ax + b| < c AND |dx + e| < f
        a = nonzero(-5, 5)
        b = randint(-15, 15)
        c = randint(8, 20)
        d = nonzero(-5, 5)
        e = randint(-15, 15)
        f = randint(8, 20)
        
        # First absolute value
        left1 = (-c - b) // a
        right1 = (c - b) // a
        if a < 0
            left1, right1 = right1, left1
        end
        
        # Second absolute value
        left2 = (-f - e) // d
        right2 = (f - e) // d
        if d < 0
            left2, right2 = right2, left2
        end
        
        # Intersection
        final_left = max(left1, left2)
        final_right = min(right1, right2)
        
        if final_left < final_right
            ans = fmt_interval(final_left, final_right, true, true)
        else
            ans = "\\emptyset"
        end
        
        problem(
            question="Solve: \$|$(tex(a*x + b))| < $(c)\$ AND \$|$(tex(d*x + e))| < $(f)\$",
            answer=ans,
            difficulty=(2100, 2500),
            answer_type="interval",
            solution=steps(
                "Solve first absolute value: \$-$(c) < $(tex(a*x + b)) < $(c)\$",
                sol("First interval", "$(left1) < x < $(right1)"),
                "Solve second absolute value: \$-$(f) < $(tex(d*x + e)) < $(f)\$",
                sol("Second interval", "$(left2) < x < $(right2)"),
                "Find intersection of both intervals",
                sol("Answer", ans)
            ),
            time=300
        )
    end
end