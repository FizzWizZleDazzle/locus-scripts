# algebra1 - linear_inequalities (easy)
# Generated: 2026-03-08T19:54:25.434169

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple one-step inequality: ax > b or ax < b
        a = nonzero(-10, 10)
        b = randint(-25, 25)
        op = choice([">", "<", "≥", "≤"])
        
        bound = b // a
        
        if op == ">"
            if a > 0
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            end
        elseif op == "<"
            if a > 0
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            else
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            end
        elseif op == "≥"
            if a > 0
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            end
        else  # ≤
            if a > 0
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            else
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            end
        end
        
        problem(
            question="Solve for \\(x\\): \$$(a)x $(op) $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)x $(op) $(b)"),
                "Divide both sides by $(a)" * (a < 0 ? " (flip inequality)" : ""),
                "Answer: \$$(interval_notation)\$"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Two-step inequality: ax + b > c
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        c = randint(-20, 20)
        op = choice([">", "<", "≥", "≤"])
        
        bound = (c - b) // a
        
        if op == ">"
            if a > 0
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            end
        elseif op == "<"
            if a > 0
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            else
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            end
        elseif op == "≥"
            if a > 0
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            end
        else  # ≤
            if a > 0
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            else
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            end
        end
        
        problem(
            question="Solve for \\(x\\): \$$(a)x + $(b) $(op) $(c)\$",
            answer=ans,
            difficulty=(750, 900),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)x + $(b) $(op) $(c)"),
                "Subtract $(b) from both sides: \$$(a)x $(op) $(c - b)\$",
                "Divide by $(a)" * (a < 0 ? " and flip inequality" : "") * ": \$$(interval_notation)\$"
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Multi-step with distribution: a(x + b) > cx + d
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        # Ensure a ≠ c so we don't get degenerate case
        while a == c
            c = nonzero(-6, 6)
        end
        
        op = choice([">", "<", "≥", "≤"])
        
        # Expand: ax + ab > cx + d
        # Solution: (a-c)x > d - ab
        coeff = a - c
        rhs = d - a*b
        bound = rhs // coeff
        
        if op == ">"
            if coeff > 0
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            end
        elseif op == "<"
            if coeff > 0
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            else
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            end
        elseif op == "≥"
            if coeff > 0
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            end
        else  # ≤
            if coeff > 0
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            else
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            end
        end
        
        problem(
            question="Solve for \\(x\\): \$$(a)(x + $(b)) $(op) $(c)x + $(d)\$",
            answer=ans,
            difficulty=(900, 1100),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)(x + $(b)) $(op) $(c)x + $(d)"),
                "Distribute: \$$(a)x + $(a*b) $(op) $(c)x + $(d)\$",
                "Combine like terms: \$$(coeff)x $(op) $(rhs)\$",
                "Solve for x: \$$(interval_notation)\$"
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Compound inequality: a < bx + c < d
        b = nonzero(-5, 5)
        c = randint(-15, 15)
        
        # Generate left and right bounds
        left_val = randint(-20, 10)
        right_val = randint(left_val + 5, 25)
        
        left_bound = (left_val - c) // b
        right_bound = (right_val - c) // b
        
        if b > 0
            ans = fmt_interval(left_bound, right_bound, false, false)
            interval_notation = "($(left_bound), $(right_bound))"
        else
            ans = fmt_interval(right_bound, left_bound, false, false)
            interval_notation = "($(right_bound), $(left_bound))"
        end
        
        problem(
            question="Solve for \\(x\\): \$$(left_val) < $(b)x + $(c) < $(right_val)\$",
            answer=ans,
            difficulty=(1000, 1200),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(left_val) < $(b)x + $(c) < $(right_val)"),
                "Subtract $(c) from all parts: \$$(left_val - c) < $(b)x < $(right_val - c)\$",
                "Divide by $(b)" * (b < 0 ? " and flip inequalities" : "") * ": \$$(interval_notation)\$"
            ),
            time=100
        )
        
    else  # problem_type == 5
        # Inequality with fractions: (ax + b)/c > d
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(2, 6)
        d = randint(-10, 10)
        op = choice([">", "<", "≥", "≤"])
        
        # Solution: ax + b > cd or ax + b < cd (depending on c sign and op)
        rhs = c * d
        bound = (rhs - b) // a
        
        # c is always positive (range 2 to 6), so no flip when multiplying
        if op == ">"
            if a > 0
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            end
        elseif op == "<"
            if a > 0
                ans = fmt_interval(-Inf, bound, true, false)
                interval_notation = "(-∞, $(bound))"
            else
                ans = fmt_interval(bound, Inf, false, true)
                interval_notation = "($(bound), ∞)"
            end
        elseif op == "≥"
            if a > 0
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            else
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            end
        else  # ≤
            if a > 0
                ans = fmt_interval(-Inf, bound, true, true)
                interval_notation = "(-∞, $(bound)]"
            else
                ans = fmt_interval(bound, Inf, true, true)
                interval_notation = "[$(bound), ∞)"
            end
        end
        
        problem(
            question="Solve for \\(x\\): \$\\frac{$(a)x + $(b)}{$(c)} $(op) $(d)\$",
            answer=ans,
            difficulty=(950, 1150),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\frac{$(a)x + $(b)}{$(c)} $(op) $(d)"),
                "Multiply both sides by $(c): \$$(a)x + $(b) $(op) $(rhs)\$",
                "Subtract $(b) and divide by $(a)" * (a < 0 ? " (flip inequality)" : "") * ": \$$(interval_notation)\$"
            ),
            time=95
        )
    end
end