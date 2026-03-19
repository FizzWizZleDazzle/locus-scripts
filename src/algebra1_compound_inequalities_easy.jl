# algebra1 - compound_inequalities (easy)
# Generated: 2026-03-08T19:54:50.791121

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/compound_inequalities")
    
    problem_type = choice([:and_basic, :or_basic, :and_solve, :or_solve])
    
    if problem_type == :and_basic
        # Simple compound inequality: a < x < b
        a = randint(-15, 10)
        b = randint(a + 3, a + 20)
        
        ans = fmt_interval(a, b, false, false)
        
        problem(
            question="Solve the compound inequality: \$$(a) < x < $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            answer_type="interval",
            solution=steps(
                "The compound inequality \$$(a) < x < $(b)\$ means x is between $(a) and $(b)",
                "Both bounds are strict (not included)",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == :or_basic
        # Simple OR inequality: x < a or x > b
        a = randint(-10, 5)
        b = randint(a + 5, a + 20)
        
        ans = "(-∞, $(a)) ∪ ($(b), ∞)"
        
        problem(
            question="Solve the compound inequality: \$x < $(a)\$ or \$x > $(b)\$",
            answer=ans,
            answer_type="union",
            difficulty=(750, 900),
            solution=steps(
                "This is an OR compound inequality",
                "x is either less than $(a) OR greater than $(b)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == :and_solve
        # Solve compound inequality with algebra: a < mx + n < b
        m = nonzero(-5, 5)
        n = randint(-12, 12)
        
        left_bound = randint(-20, 10)
        right_bound = randint(left_bound + 5, left_bound + 25)
        
        # Solve: left_bound < mx + n < right_bound
        # (left_bound - n)/m < x < (right_bound - n)/m
        x_left = (left_bound - n) // m
        x_right = (right_bound - n) // m
        
        if m > 0
            ans = fmt_interval(x_left, x_right, false, false)
            ineq_str = "$(left_bound) < $(tex(m*x + n)) < $(right_bound)"
        else
            # When dividing by negative, flip inequality
            ans = fmt_interval(x_right, x_left, false, false)
            ineq_str = "$(left_bound) < $(tex(m*x + n)) < $(right_bound)"
        end
        
        problem(
            question="Solve the compound inequality: \$$(ineq_str)\$",
            answer=ans,
            answer_type="interval",
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", ineq_str),
                "Subtract $(n) from all parts: \$$(left_bound - n) < $(tex(m*x)) < $(right_bound - n)\$",
                "Divide all parts by $(m)" * (m < 0 ? " (flip inequalities since dividing by negative)" : ""),
                sol("Answer", ans)
            ),
            time=90
        )
        
    else  # or_solve
        # OR inequality: ax + b < c or dx + e > f
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        c = randint(-20, 20)
        
        d = nonzero(-6, 6)
        e = randint(-15, 15)
        f = randint(-20, 20)
        
        # Solve ax + b < c => x < (c - b)/a or x > (c - b)/a
        bound1 = (c - b) // a
        # Solve dx + e > f => x > (f - e)/d or x < (f - e)/d
        bound2 = (f - e) // d
        
        if a > 0
            left_part = "(-∞, $(bound1))"
        else
            left_part = "($(bound1), ∞)"
        end
        
        if d > 0
            right_part = "($(bound2), ∞)"
        else
            right_part = "(-∞, $(bound2))"
        end
        
        ans = "$(left_part) ∪ $(right_part)"
        
        problem(
            question="Solve: \$$(tex(a*x + b)) < $(c)\$ or \$$(tex(d*x + e)) > $(f)\$",
            answer=ans,
            answer_type="union",
            difficulty=(1000, 1200),
            solution=steps(
                "Solve each inequality separately",
                "First: \$$(tex(a*x + b)) < $(c)\$ gives \$x $(a > 0 ? "<" : ">") $(bound1)\$",
                "Second: \$$(tex(d*x + e)) > $(f)\$ gives \$x $(d > 0 ? ">" : "<") $(bound2)\$",
                "Combine with union (OR)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end