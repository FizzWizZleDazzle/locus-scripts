# precalculus - inverse_functions (very_easy)
# Generated: 2026-03-08T20:24:56.709993

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Basic: Does this point lie on f or f^(-1)?
        # ELO: 200-400
        a = randint(-8, 8)
        b = randint(-8, 8)
        if rand(Bool)
            question_text = "If the point ($(a), $(b)) lies on the graph of \\(f(x)\\), what point must lie on the graph of \\(f^{-1}(x)\\)?"
            ans = fmt_tuple([b, a])
            sol_text = steps(
                "If \\((a, b)\\) is on \\(f(x)\\), then \\(f(a) = b\\)",
                "By definition of inverse function, \\(f^{-1}(b) = a\\)",
                sol("Answer", "The point \\(($(b), $(a))\\) lies on \\(f^{-1}(x)\\)")
            )
        else
            question_text = "If the point ($(a), $(b)) lies on the graph of \\(f^{-1}(x)\\), what point must lie on the graph of \\(f(x)\\)?"
            ans = fmt_tuple([b, a])
            sol_text = steps(
                "If \\((a, b)\\) is on \\(f^{-1}(x)\\), then \\(f^{-1}(a) = b\\)",
                "By definition of inverse function, \\(f(b) = a\\)",
                sol("Answer", "The point \\(($(b), $(a))\\) lies on \\(f(x)\\)")
            )
        end
        
        problem(
            question=question_text,
            answer=ans,
            answer_type="tuple",
            difficulty=(200, 400),
            solution=sol_text,
            time=45
        )
        
    elseif problem_type == 2
        # Elementary: Find f^(-1)(value) given simple linear function
        # ELO: 400-600
        m = nonzero(-7, 7)
        b = randint(-12, 12)
        input_val = randint(-10, 10)
        ans = (input_val - b) // m
        
        problem(
            question="Given \\(f(x) = $(m)x + $(b)\\), find \\(f^{-1}($(input_val))\\).",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "f(x) = $(m)x + $(b)"),
                "To find \\(f^{-1}($(input_val))\\), solve \\(f(x) = $(input_val)\\)",
                sol("Solve", "$(m)x + $(b) = $(input_val)"),
                "\\($(m)x = $(input_val - b)\\)",
                sol("Answer", "x = $(ans)")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Elementary: Find inverse of simple linear function
        # ELO: 500-700
        m = nonzero(-6, 6)
        b = randint(-10, 10)
        inv_expr = (x - b) // m
        
        problem(
            question="Find the inverse function \\(f^{-1}(x)\\) if \\(f(x) = $(m)x + $(b)\\).",
            answer=inv_expr,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "f(x) = $(m)x + $(b)"),
                "Let \\(y = $(m)x + $(b)\\), swap \\(x\\) and \\(y\\)",
                sol("Swap", "x = $(m)y + $(b)"),
                "Solve for \\(y\\): \\($(m)y = x - $(b)\\)",
                sol("Answer", "f^{-1}(x) = " * tex(inv_expr))
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Elementary: Verify two functions are inverses (simple linear)
        # ELO: 500-700
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        f_expr = a*x + b
        g_expr = (x - b) // a
        
        # Check composition
        comp1 = substitute(f_expr, x => g_expr)
        comp1_simplified = simplify(comp1)
        
        problem(
            question="Verify that \\(f(x) = $(tex(f_expr))\\) and \\(g(x) = $(tex(g_expr))\\) are inverse functions by computing \\(f(g(x))\\).",
            answer=x,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "f(x) = $(tex(f_expr)), g(x) = $(tex(g_expr))"),
                sol("Compute f(g(x))", "f(g(x)) = $(a) \\cdot \\left($(tex(g_expr))\\right) + $(b)"),
                "Simplify: \\(= $(tex(comp1_simplified))\\)",
                sol("Answer", "f(g(x)) = x, so they are inverses")
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Elementary: Find f(f^(-1)(a)) or f^(-1)(f(a))
        # ELO: 300-500
        val = randint(-15, 15)
        if rand(Bool)
            question_text = "If \\(f\\) is a one-to-one function, what is \\(f(f^{-1}($(val)))\\)?"
            ans = val
            sol_text = steps(
                "By definition of inverse functions, \\(f(f^{-1}(x)) = x\\) for all \\(x\\) in the domain of \\(f^{-1}\\)",
                sol("Apply definition with x = $(val)"),
                sol("Answer", val)
            )
        else
            question_text = "If \\(f\\) is a one-to-one function, what is \\(f^{-1}(f($(val)))\\)?"
            ans = val
            sol_text = steps(
                "By definition of inverse functions, \\(f^{-1}(f(x)) = x\\) for all \\(x\\) in the domain of \\(f\\)",
                sol("Apply definition with x = $(val)"),
                sol("Answer", val)
            )
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(300, 500),
            solution=sol_text,
            time=30
        )
        
    else
        # Elementary: Given f(a) = b, find f^(-1)(b)
        # ELO: 300-500
        a_val = randint(-12, 12)
        b_val = randint(-12, 12)
        
        problem(
            question="If \\(f($(a_val)) = $(b_val)\\) and \\(f\\) is one-to-one, what is \\(f^{-1}($(b_val))\\)?",
            answer=a_val,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", "f($(a_val)) = $(b_val)"),
                "By definition of inverse function, if \\(f(a) = b\\), then \\(f^{-1}(b) = a\\)",
                sol("Answer", "f^{-1}($(b_val)) = $(a_val)")
            ),
            time=45
        )
    end
end