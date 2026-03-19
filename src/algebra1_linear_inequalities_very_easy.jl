# algebra1 - linear_inequalities (very_easy)
# Generated: 2026-03-08T19:53:54.727641

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Very basic: x + b > c (ELO 100-300)
        b = randint(-15, 15)
        c = randint(-20, 20)
        ans = c - b
        
        problem(
            question="Solve for \\(x\\): \\[x + $b > $c\\]",
            answer=fmt_interval(ans, Inf, false, true),
            difficulty=(150, 300),
            answer_type="interval",
            solution=steps(
                sol("Given", x + b),
                "Subtract $b from both sides",
                sol("Answer", "x > $ans")
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Basic: ax > b where a > 0 (ELO 300-500)
        a = randint(2, 8)
        b = randint(-25, 25)
        bound = b // a
        
        problem(
            question="Solve for \\(x\\): \\[$(a)x > $b\\]",
            answer=fmt_interval(bound, Inf, false, true),
            difficulty=(300, 500),
            answer_type="interval",
            solution=steps(
                sol("Given", a*x),
                "Divide both sides by $a",
                sol("Answer", "x > $(tex(bound))")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # ax < b where a < 0 (flip inequality) (ELO 400-600)
        a = randint(-8, -2)
        b = randint(-25, 25)
        bound = b // a
        
        problem(
            question="Solve for \\(x\\): \\[$(a)x < $b\\]",
            answer=fmt_interval(-Inf, bound, true, false),
            difficulty=(400, 600),
            answer_type="interval",
            solution=steps(
                sol("Given", a*x),
                "Divide both sides by $a (flip inequality since $a < 0)",
                sol("Answer", "x > $(tex(bound))")
            ),
            time=75
        )
        
    elseif problem_type == 4
        # ax + b ≥ c (ELO 500-700)
        a = nonzero(-7, 7)
        b = randint(-20, 20)
        c = randint(-20, 20)
        bound = (c - b) // a
        
        ineq_symbol = choice(["\\geq", "\\leq"])
        
        if ineq_symbol == "\\geq"
            if a > 0
                ans = fmt_interval(bound, Inf, true, true)
                ans_text = "x \\geq $(tex(bound))"
            else
                ans = fmt_interval(-Inf, bound, true, true)
                ans_text = "x \\leq $(tex(bound))"
            end
        else
            if a > 0
                ans = fmt_interval(-Inf, bound, true, true)
                ans_text = "x \\leq $(tex(bound))"
            else
                ans = fmt_interval(bound, Inf, true, true)
                ans_text = "x \\geq $(tex(bound))"
            end
        end
        
        problem(
            question="Solve for \\(x\\): \\[$(a)x + $b $ineq_symbol $c\\]",
            answer=ans,
            difficulty=(500, 700),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(a)x + $b $ineq_symbol $c"),
                "Subtract $b from both sides: $(a)x $ineq_symbol $(c - b)",
                "Divide by $a" * (a < 0 ? " (flip inequality)" : ""),
                sol("Answer", ans_text)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Recognition: is value a solution? (ELO 100-250)
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        c = randint(-15, 15)
        test_val = randint(-10, 10)
        
        result = a * test_val + b
        is_solution = result > c
        
        problem(
            question="Is \\(x = $test_val\\) a solution to \\($(a)x + $b > $c\\)?",
            answer=is_solution ? "Yes" : "No",
            difficulty=(100, 250),
            answer_type="multiple_choice",
            solution=steps(
                "Substitute \\(x = $test_val\\)",
                sol("Left side", "$(a)($(test_val)) + $b = $result"),
                "Compare: $result " * (is_solution ? ">" : "≤") * " $c",
                sol("Answer", is_solution ? "Yes" : "No")
            ),
            time=60
        )
        
    else
        # Simple comparison: which values satisfy (ELO 200-400)
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        bound = -b // a
        
        test_vals = [randint(-15, 15) for _ in 1:4]
        
        if a > 0
            solutions = [v for v in test_vals if v > bound]
            direction = "greater than"
        else
            solutions = [v for v in test_vals if v < bound]
            direction = "less than"
        end
        
        problem(
            question="Which of the following values satisfy \\($(a)x + $b > 0\\)? Options: $(fmt_list(test_vals))",
            answer=fmt_set(Set(solutions)),
            difficulty=(200, 400),
            answer_type="set",
            solution=steps(
                "Solve: \\($(a)x + $b > 0\\)",
                "\\(x\\) must be $direction \\($(tex(bound))\\)",
                "Test each value",
                sol("Answer", fmt_set(Set(solutions)))
            ),
            time=90
        )
    end
end