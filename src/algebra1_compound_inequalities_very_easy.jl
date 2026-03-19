# algebra1 - compound_inequalities (very_easy)
# Generated: 2026-03-08T19:54:44.554955

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/compound_inequalities")
    
    # Pick a problem type based on ELO 100-700 (foundational/elementary)
    problem_type = choice([:and_simple, :or_simple, :and_solve, :or_solve])
    
    if problem_type == :and_simple
        # Simple "and" compound inequality: a < x < b
        a = randint(-15, 10)
        b = randint(a + 3, a + 20)
        
        ans = fmt_interval(a, b, false, false)
        
        problem(
            question="Write the solution set in interval notation: \$$(a) < x < $(b)\$",
            answer=ans,
            difficulty=(200, 400),
            answer_type="interval",
            solution=steps(
                "The compound inequality \$$(a) < x < $(b)\$ means x is between $(a) and $(b)",
                "Both endpoints are NOT included (open circles)",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == :or_simple
        # Simple "or" compound inequality: x < a or x > b
        a = randint(-10, 5)
        b = randint(a + 5, a + 20)
        
        ans = "(-\\infty, $(a)) \\cup ($(b), \\infty)"
        
        problem(
            question="Write the solution set in interval notation: \$x < $(a)\$ or \$x > $(b)\$",
            answer=ans,
            answer_type="union",
            difficulty=(300, 500),
            solution=steps(
                "The word 'or' means x satisfies at least one inequality",
                "\$x < $(a)\$ gives \$(-\\infty, $(a))\$",
                "\$x > $(b)\$ gives \$($(b), \\infty)\$",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == :and_solve
        # Solve compound "and" inequality: a < mx + b < c
        m = nonzero(-5, 5)
        b = randint(-10, 10)
        
        # Pick bounds
        lower = randint(-15, 10)
        upper = randint(lower + 5, lower + 25)
        
        # Solve: lower < mx + b < upper
        # lower - b < mx < upper - b
        # (lower - b)/m < x < (upper - b)/m  (if m > 0)
        # (upper - b)/m < x < (lower - b)/m  (if m < 0)
        
        left_bound = (lower - b) // m
        right_bound = (upper - b) // m
        
        if m > 0
            ans = fmt_interval(left_bound, right_bound, false, false)
            sol_text = "Divide all parts by $(m)"
        else
            ans = fmt_interval(right_bound, left_bound, false, false)
            sol_text = "Divide all parts by $(m) (flip inequality signs)"
        end
        
        problem(
            question="Solve and write in interval notation: \$$(lower) < $(tex(m*x + b)) < $(upper)\$",
            answer=ans,
            difficulty=(500, 700),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(lower) < $(tex(m*x + b)) < $(upper)"),
                "Subtract $(b) from all parts: \$$(lower - b) < $(tex(m*x)) < $(upper - b)\$",
                sol_text,
                sol("Answer", ans)
            ),
            time=90
        )
        
    else  # or_solve
        # Solve compound "or" inequality: mx + b < a or mx + b > c
        m = nonzero(-5, 5)
        b = randint(-10, 10)
        
        lower = randint(-15, 5)
        upper = randint(lower + 10, lower + 25)
        
        # Solve: mx + b < lower or mx + b > upper
        left_bound = (lower - b) // m
        right_bound = (upper - b) // m
        
        if m > 0
            ans = "(-\\infty, $(left_bound)) \\cup ($(right_bound), \\infty)"
        else
            ans = "(-\\infty, $(right_bound)) \\cup ($(left_bound), \\infty)"
        end
        
        problem(
            question="Solve and write in interval notation: \$$(tex(m*x + b)) < $(lower)\$ or \$$(tex(m*x + b)) > $(upper)\$",
            answer=ans,
            difficulty=(550, 700),
            answer_type="union",
            solution=steps(
                "Solve each inequality separately",
                "First: \$$(tex(m*x + b)) < $(lower)\$ gives \$x $(m > 0 ? "<" : ">") $(left_bound)\$",
                "Second: \$$(tex(m*x + b)) > $(upper)\$ gives \$x $(m > 0 ? ">" : "<") $(right_bound)\$",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end