# calculus - definite_integrals (very_easy)
# Generated: 2026-03-08T20:46:44.541527

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # ELO 200-400: Recognize integral notation and basic concepts
        a = randint(0, 5)
        b = randint(a+1, 10)
        c = randint(1, 9)
        
        problem(
            question="What are the limits of integration in \\\$\\int_{$(a)}^{$(b)} $(c)x \\, dx\\\$?",
            answer=fmt_list([a, b]),
            difficulty=(200, 400),
            answer_type="list",
            solution=steps(
                "In the integral \\\$\\int_{a}^{b} f(x) \\, dx\\\$, the lower limit is \\\$a\\\$ and the upper limit is \\\$b\\\$",
                "For \\\$\\int_{$(a)}^{$(b)} $(c)x \\, dx\\\$",
                sol("Answer", "Lower limit = $(a), Upper limit = $(b)")
            ),
            time=30
        )
        
    elseif problem_type == 2
        # ELO 300-500: Evaluate definite integral of a constant
        a = randint(-5, 5)
        b = randint(a+1, a+8)
        c = nonzero(-9, 9)
        ans = c * (b - a)
        
        problem(
            question="Evaluate \\\$\\int_{$(a)}^{$(b)} $(c) \\, dx\\\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} $(c) \\, dx"),
                "The integral of a constant \\\$c\\\$ is \\\$cx\\\$",
                "Evaluate: \\\$[$(c)x]_{$(a)}^{$(b)} = $(c)($(b)) - $(c)($(a)) = $(c*b) - $(c*a)\\\$",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # ELO 400-600: Evaluate definite integral of x
        a = randint(0, 4)
        b = randint(a+1, a+6)
        c = nonzero(-8, 8)
        ans = c * (b^2 - a^2) // 2
        
        problem(
            question="Evaluate \\\$\\int_{$(a)}^{$(b)} $(c)x \\, dx\\\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} $(c)x \\, dx"),
                "Find antiderivative: \\\$\\frac{$(c)x^2}{2}\\\$",
                "Evaluate: \\\$\\left[\\frac{$(c)x^2}{2}\\right]_{$(a)}^{$(b)} = \\frac{$(c)($(b))^2}{2} - \\frac{$(c)($(a))^2}{2}\\\$",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # ELO 500-700: Evaluate definite integral of x^2
        a = randint(0, 3)
        b = randint(a+1, a+4)
        c = nonzero(-6, 6)
        ans = c * (b^3 - a^3) // 3
        
        problem(
            question="Evaluate \\\$\\int_{$(a)}^{$(b)} $(c)x^2 \\, dx\\\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} $(c)x^2 \\, dx"),
                "Find antiderivative using power rule: \\\$\\frac{$(c)x^3}{3}\\\$",
                "Apply Fundamental Theorem: \\\$\\left[\\frac{$(c)x^3}{3}\\right]_{$(a)}^{$(b)} = \\frac{$(c)($(b))^3}{3} - \\frac{$(c)($(a))^3}{3}\\\$",
                "Simplify: \\\$\\frac{$(c*b^3)}{3} - \\frac{$(c*a^3)}{3} = \\frac{$(c*(b^3-a^3))}{3}\\\$",
                sol("Answer", ans)
            ),
            time=75
        )
        
    else
        # ELO 600-700: Evaluate simple polynomial definite integral
        a = randint(0, 2)
        b = randint(a+2, a+4)
        c1 = nonzero(-4, 4)
        c2 = nonzero(-6, 6)
        
        # Integral of c1*x^2 + c2*x from a to b
        ans = c1 * (b^3 - a^3) // 3 + c2 * (b^2 - a^2) // 2
        
        expr = c1*x^2 + c2*x
        
        problem(
            question="Evaluate \\\$\\int_{$(a)}^{$(b)} ($(tex(expr))) \\, dx\\\$",
            answer=ans,
            difficulty=(600, 700),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} ($(tex(expr))) \\, dx"),
                "Find antiderivative: \\\$\\frac{$(c1)x^3}{3} + \\frac{$(c2)x^2}{2}\\\$",
                "Evaluate at upper limit \\\$x=$(b)\\\$: \\\$\\frac{$(c1)($(b))^3}{3} + \\frac{$(c2)($(b))^2}{2}\\\$",
                "Evaluate at lower limit \\\$x=$(a)\\\$: \\\$\\frac{$(c1)($(a))^3}{3} + \\frac{$(c2)($(a))^2}{2}\\\$",
                "Subtract to get final answer",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end