# algebra1 - factoring_trinomials (very_easy)
# Generated: 2026-03-08T19:59:59.693844

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_trinomials")
    
    # Generate problem type randomly
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Very basic: recognize if (x+a)(x+b) format - FOUNDATIONAL
        a = randint(1, 5)
        b = randint(1, 5)
        factored = (x + a) * (x + b)
        expanded = expand(factored)
        
        problem(
            question="Factor the trinomial: \$$(tex(expanded))\$",
            answer=expanded,
            difficulty=(300, 500),
            grading_mode="factor",
            solution=steps(
                sol("Given", expanded),
                "Find two numbers that multiply to $(a*b) and add to $(a+b): $(a) and $(b)",
                sol("Factored form", factored)
            ),
            time=90
        )
    elseif problem_type == 2
        # Simple trinomial with negative terms - ELEMENTARY
        a = randint(2, 6)
        b = randint(-8, -1)
        factored = (x + a) * (x + b)
        expanded = expand(factored)
        
        problem(
            question="Factor the trinomial: \$$(tex(expanded))\$",
            answer=expanded,
            difficulty=(400, 600),
            grading_mode="factor",
            solution=steps(
                sol("Given", expanded),
                "Find two numbers that multiply to $(a*b) and add to $(a+b): $(a) and $(b)",
                sol("Factored form", factored)
            ),
            time=120
        )
    elseif problem_type == 3
        # Two negative roots - ELEMENTARY
        a = randint(-7, -1)
        b = randint(-7, -1)
        factored = (x + a) * (x + b)
        expanded = expand(factored)
        
        problem(
            question="Factor the trinomial: \$$(tex(expanded))\$",
            answer=expanded,
            difficulty=(500, 700),
            grading_mode="factor",
            solution=steps(
                sol("Given", expanded),
                "Find two numbers that multiply to $(a*b) and add to $(a+b): $(a) and $(b)",
                sol("Factored form", factored)
            ),
            time=120
        )
    else
        # Mixed signs, slightly larger numbers - ELEMENTARY
        a = randint(3, 9)
        b = randint(-9, -2)
        factored = (x + a) * (x + b)
        expanded = expand(factored)
        
        problem(
            question="Factor the trinomial: \$$(tex(expanded))\$",
            answer=expanded,
            difficulty=(500, 700),
            grading_mode="factor",
            solution=steps(
                sol("Given", expanded),
                "Find two numbers that multiply to $(a*b) and add to $(a+b): $(a) and $(b)",
                sol("Factored form", factored)
            ),
            time=150
        )
    end
end