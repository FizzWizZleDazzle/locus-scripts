# algebra1 - factoring_trinomials (easy)
# Generated: 2026-03-08T20:00:12.720352

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_trinomials")
    
    # Choose problem type randomly
    prob_type = choice(1:4)
    
    if prob_type == 1
        # Simple factorable trinomial: (x + r1)(x + r2)
        r1 = nonzero(-12, 12)
        r2 = nonzero(-12, 12)
        expr = expand((x + r1) * (x + r2))
        
        b_coeff = r1 + r2
        c_coeff = r1 * r2
        
        problem(
            question="Factor the trinomial: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(700, 900),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Find two numbers that multiply to $(c_coeff) and add to $(b_coeff)",
                "The numbers are $(r1) and $(r2)",
                sol("Factored form", (x + r1) * (x + r2))
            ),
            time=90
        )
        
    elseif prob_type == 2
        # Trinomial with leading coefficient: a(x + r1)(x + r2)
        a = nonzero(-5, 5)
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        expr = expand(a * (x + r1) * (x + r2))
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(900, 1100),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Factor out common factor if any, then find binomial factors",
                "Look for factors of the form \$($(a)x + p)(x + q)\$ or similar",
                sol("Factored form", a * (x + r1) * (x + r2))
            ),
            time=120
        )
        
    elseif prob_type == 3
        # Perfect square trinomial: (x + r)^2
        r = nonzero(-15, 15)
        expr = expand((x + r)^2)
        
        problem(
            question="Factor the perfect square trinomial: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(800, 1000),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Recognize this is a perfect square: \$a^2 + 2ab + b^2 = (a + b)^2\$",
                "Here \$a = x\$ and \$b = $(r)\$",
                sol("Factored form", (x + r)^2)
            ),
            time=90
        )
        
    else
        # Difference of squares disguised or simple factorable
        r1 = nonzero(-12, 12)
        r2 = -r1
        a = nonzero(1, 4)
        expr = expand(a * (x + r1) * (x + r2))
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(850, 1050),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Notice the middle term coefficient is 0 (or factor out \$$(a)\$ first)",
                "This is a difference of squares: \$a^2 - b^2 = (a-b)(a+b)\$",
                sol("Factored form", a * (x + r1) * (x + r2))
            ),
            time=100
        )
    end
end