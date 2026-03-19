# algebra1 - quadratic_formula (very_easy)
# Generated: 2026-03-08T20:00:53.167413

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we want very simple quadratics
    # that are easy to recognize or solve with basic steps
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify coefficients a, b, c (200-400 ELO)
        a = nonzero(-5, 5)
        b = randint(-9, 9)
        c = randint(-9, 9)
        expr = a*x^2 + b*x + c
        
        coeff = choice(["a", "b", "c"])
        if coeff == "a"
            ans = a
        elseif coeff == "b"
            ans = b
        else
            ans = c
        end
        
        problem(
            question="In the quadratic equation \$$(tex(expr)) = 0\$, what is the value of coefficient \$$(coeff)\$?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "The standard form of a quadratic is \$ax^2 + bx + c = 0\$",
                sol("Given equation", expr ~ 0),
                "Coefficient \$$(coeff) = $(ans)\$"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Type 2: Simple perfect square (x^2 = k) (400-550 ELO)
        k = rand([4, 9, 16, 25, 36, 49, 64, 81, 100])
        ans = Int(sqrt(k))
        
        problem(
            question="Solve \$x^2 = $(k)\$ for \$x\$. Give the positive solution.",
            answer=ans,
            difficulty=(400, 550),
            solution=steps(
                sol("Given", x^2 ~ k),
                "Take the square root of both sides",
                sol("x = \\pm\\sqrt{$(k)} = \\pm $(ans)"),
                "Positive solution: \$x = $(ans)\$"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Solve x^2 + bx = 0 by factoring out x (500-650 ELO)
        b = nonzero(-9, 9)
        expr = x^2 + b*x
        
        problem(
            question="Solve \$$(tex(expr)) = 0\$ by factoring. Enter your answers as a set.",
            answer=fmt_set(Set([0, -b])),
            difficulty=(500, 650),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Factor out \$x\$: \$x(x + $(b)) = 0\$",
                "Set each factor to zero: \$x = 0\$ or \$x + $(b) = 0\$",
                sol("Solution set", fmt_set(Set([0, -b])))
            ),
            time=90
        )
        
    else
        # Type 4: Identify which formula to use (300-500 ELO)
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        c = randint(-8, 8)
        expr = a*x^2 + b*x + c
        
        formula_text = "\\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}"
        
        problem(
            question="To solve \$$(tex(expr)) = 0\$, which value should be substituted for \$a\$ in the quadratic formula \$x = $(formula_text)\$?",
            answer=a,
            difficulty=(300, 500),
            solution=steps(
                "The quadratic formula is \$x = $(formula_text)\$",
                sol("Given equation", expr ~ 0),
                "In standard form \$ax^2 + bx + c = 0\$, we have \$a = $(a)\$, \$b = $(b)\$, \$c = $(c)\$",
                sol("Answer: a", a)
            ),
            time=60
        )
    end
end