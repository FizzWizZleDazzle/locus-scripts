# algebra1 - linear_inequalities (medium)
# Generated: 2026-03-08T19:54:22.556961

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple linear inequality: ax + b > c
        a = nonzero(-10, 10)
        b = randint(-25, 25)
        c = randint(-25, 25)
        
        bound = (c - b) // a
        
        if a > 0
            ans = fmt_interval(bound, Inf, false, true)
            ineq_sign = ">"
        else
            ans = fmt_interval(-Inf, bound, true, false)
            ineq_sign = "<"
        end
        
        problem(
            question="Solve the inequality: \$$(a)x + $(b) > $(c)\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)x + $(b) > $(c)"),
                "Subtract $(b) from both sides: \$$(a)x > $(c - b)\$",
                "Divide by $(a)$(a < 0 ? " (flip inequality)" : ""): \$x $(ineq_sign) $(bound)\$",
                "Interval notation: $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Compound inequality: a < bx + c < d
        b = nonzero(-8, 8)
        c = randint(-20, 20)
        a = randint(-30, 30)
        d = a + randint(5, 25)
        
        left_bound = (a - c) // b
        right_bound = (d - c) // b
        
        if b > 0
            ans = fmt_interval(left_bound, right_bound, false, false)
        else
            ans = fmt_interval(right_bound, left_bound, false, false)
        end
        
        problem(
            question="Solve the compound inequality: \$$(a) < $(b)x + $(c) < $(d)\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a) < $(b)x + $(c) < $(d)"),
                "Subtract $(c) from all parts: \$$(a - c) < $(b)x < $(d - c)\$",
                "Divide by $(b)$(b < 0 ? " (flip inequalities)" : ""): \$$(b > 0 ? left_bound : right_bound) < x < $(b > 0 ? right_bound : left_bound)\$",
                "Interval notation: $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Multi-step with distribution: a(bx + c) ≥ d
        a = nonzero(-7, 7)
        b = nonzero(-6, 6)
        c = randint(-15, 15)
        d = randint(-30, 30)
        
        bound = (d - a*c) // (a*b)
        
        if a*b > 0
            ans = fmt_interval(bound, Inf, true, true)
            ineq_sign = "\\geq"
        else
            ans = fmt_interval(-Inf, bound, true, true)
            ineq_sign = "\\leq"
        end
        
        problem(
            question="Solve the inequality: \$$(a)($(b)x + $(c)) \\geq $(d)\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)($(b)x + $(c)) \\geq $(d)"),
                "Distribute: \$$(a*b)x + $(a*c) \\geq $(d)\$",
                "Subtract $(a*c): \$$(a*b)x \\geq $(d - a*c)\$",
                "Divide by $(a*b)$(a*b < 0 ? " (flip inequality)" : ""): \$x $(ineq_sign) $(bound)\$",
                "Interval notation: $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Variables on both sides: ax + b ≤ cx + d
        a = nonzero(-9, 9)
        c = nonzero(-9, 9)
        while a == c
            c = nonzero(-9, 9)
        end
        b = randint(-20, 20)
        d = randint(-20, 20)
        
        bound = (d - b) // (a - c)
        
        if a - c > 0
            ans = fmt_interval(-Inf, bound, true, true)
            ineq_sign = "\\leq"
        else
            ans = fmt_interval(bound, Inf, true, true)
            ineq_sign = "\\geq"
        end
        
        problem(
            question="Solve the inequality: \$$(a)x + $(b) \\leq $(c)x + $(d)\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)x + $(b) \\leq $(c)x + $(d)"),
                "Subtract $(c)x from both sides: \$$(a - c)x + $(b) \\leq $(d)\$",
                "Subtract $(b): \$$(a - c)x \\leq $(d - b)\$",
                "Divide by $(a - c)$(a - c < 0 ? " (flip inequality)" : ""): \$x $(ineq_sign) $(bound)\$",
                "Interval notation: $(ans)"
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Fraction inequality: (ax + b)/c > d
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        c = nonzero(2, 8)
        d = randint(-15, 15)
        
        bound = (d*c - b) // a
        
        if a > 0
            ans = fmt_interval(bound, Inf, false, true)
            ineq_sign = ">"
        else
            ans = fmt_interval(-Inf, bound, true, false)
            ineq_sign = "<"
        end
        
        problem(
            question="Solve the inequality: \$\\frac{$(a)x + $(b)}{$(c)} > $(d)\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\frac{$(a)x + $(b)}{$(c)} > $(d)"),
                "Multiply both sides by $(c): \$$(a)x + $(b) > $(d*c)\$",
                "Subtract $(b): \$$(a)x > $(d*c - b)\$",
                "Divide by $(a)$(a < 0 ? " (flip inequality)" : ""): \$x $(ineq_sign) $(bound)\$",
                "Interval notation: $(ans)"
            ),
            time=120
        )
        
    else
        # Complex multi-step: a(bx + c) - d ≥ e(fx + g)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-12, 12)
        d = randint(-15, 15)
        e = nonzero(-5, 5)
        f = nonzero(-5, 5)
        g = randint(-12, 12)
        
        left_coeff = a*b - e*f
        if left_coeff == 0
            left_coeff = 1
        end
        
        right_const = e*g + d - a*c
        bound = right_const // left_coeff
        
        if left_coeff > 0
            ans = fmt_interval(bound, Inf, true, true)
            ineq_sign = "\\geq"
        else
            ans = fmt_interval(-Inf, bound, true, true)
            ineq_sign = "\\leq"
        end
        
        problem(
            question="Solve the inequality: \$$(a)($(b)x + $(c)) - $(d) \\geq $(e)($(f)x + $(g))\$",
            answer=ans,
            difficulty=(1600, 1800),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)($(b)x + $(c)) - $(d) \\geq $(e)($(f)x + $(g))"),
                "Distribute: \$$(a*b)x + $(a*c) - $(d) \\geq $(e*f)x + $(e*g)\$",
                "Collect like terms: \$$(left_coeff)x \\geq $(right_const)\$",
                "Divide by $(left_coeff)$(left_coeff < 0 ? " (flip inequality)" : ""): \$x $(ineq_sign) $(bound)\$",
                "Interval notation: $(ans)"
            ),
            time=180
        )
    end
end