# algebra1 - exponent_rules (medium)
# Generated: 2026-03-08T19:58:37.321212

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/exponent_rules")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Product rule: x^a * x^b = x^(a+b)
        a = randint(2, 8)
        b = randint(2, 8)
        ans = a + b
        
        problem(
            question="Simplify: \$x^{$a} \\cdot x^{$b}\$",
            answer="x^$ans",
            difficulty=(1200, 1400),
            solution=steps(
                "Apply the product rule: \$x^a \\cdot x^b = x^{a+b}\$",
                sol("Calculation", "x^{$a} \\cdot x^{$b} = x^{$a + $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Quotient rule: x^a / x^b = x^(a-b)
        a = randint(5, 12)
        b = randint(2, 6)
        ans = a - b
        
        problem(
            question="Simplify: \$\\frac{x^{$a}}{x^{$b}}\$",
            answer="x^$ans",
            difficulty=(1200, 1400),
            solution=steps(
                "Apply the quotient rule: \$\\frac{x^a}{x^b} = x^{a-b}\$",
                sol("Calculation", "\\frac{x^{$a}}{x^{$b}} = x^{$a - $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Power rule: (x^a)^b = x^(ab)
        a = randint(2, 6)
        b = randint(2, 5)
        ans = a * b
        
        problem(
            question="Simplify: \$(x^{$a})^{$b}\$",
            answer="x^$ans",
            difficulty=(1200, 1400),
            solution=steps(
                "Apply the power rule: \$(x^a)^b = x^{ab}\$",
                sol("Calculation", "(x^{$a})^{$b} = x^{$a \\cdot $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Combined product and power: (x^a)^b * x^c
        a = randint(2, 5)
        b = randint(2, 4)
        c = randint(2, 6)
        ans = a * b + c
        
        problem(
            question="Simplify: \$(x^{$a})^{$b} \\cdot x^{$c}\$",
            answer="x^$ans",
            difficulty=(1400, 1600),
            solution=steps(
                "Apply the power rule: \$(x^{$a})^{$b} = x^{$(a*b)}\$",
                "Apply the product rule: \$x^{$(a*b)} \\cdot x^{$c} = x^{$(a*b) + $c}\$",
                sol("Answer", "x^{$ans}")
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Combined quotient and power: (x^a)^b / x^c
        a = randint(3, 6)
        b = randint(2, 4)
        c = randint(2, 8)
        ans = a * b - c
        
        problem(
            question="Simplify: \$\\frac{(x^{$a})^{$b}}{x^{$c}}\$",
            answer="x^$ans",
            difficulty=(1400, 1600),
            solution=steps(
                "Apply the power rule: \$(x^{$a})^{$b} = x^{$(a*b)}\$",
                "Apply the quotient rule: \$\\frac{x^{$(a*b)}}{x^{$c}} = x^{$(a*b) - $c}\$",
                sol("Answer", "x^{$ans}")
            ),
            time=90
        )
        
    else
        # Multi-step: (x^a * x^b)^c / x^d
        a = randint(2, 4)
        b = randint(2, 4)
        c = randint(2, 3)
        d = randint(3, 8)
        ans = (a + b) * c - d
        
        problem(
            question="Simplify: \$\\frac{(x^{$a} \\cdot x^{$b})^{$c}}{x^{$d}}\$",
            answer="x^$ans",
            difficulty=(1500, 1800),
            solution=steps(
                "Apply the product rule inside parentheses: \$x^{$a} \\cdot x^{$b} = x^{$(a+b)}\$",
                "Apply the power rule: \$(x^{$(a+b)})^{$c} = x^{$((a+b)*c)}\$",
                "Apply the quotient rule: \$\\frac{x^{$((a+b)*c)}}{x^{$d}} = x^{$((a+b)*c) - $d}\$",
                sol("Answer", "x^{$ans}")
            ),
            time=120
        )
    end
end