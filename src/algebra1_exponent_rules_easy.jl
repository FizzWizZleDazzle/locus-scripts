# algebra1 - exponent_rules (easy)
# Generated: 2026-03-08T19:58:22.178011

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
            difficulty=(700, 900),
            solution=steps(
                "Use the product rule: \$x^a \\cdot x^b = x^{a+b}\$",
                sol("Combine exponents", "x^{$a + $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Quotient rule: x^a / x^b = x^(a-b)
        a = randint(5, 12)
        b = randint(2, a-1)
        ans = a - b
        
        problem(
            question="Simplify: \$\\frac{x^{$a}}{x^{$b}}\$",
            answer="x^$ans",
            difficulty=(750, 950),
            solution=steps(
                "Use the quotient rule: \$\\frac{x^a}{x^b} = x^{a-b}\$",
                sol("Subtract exponents", "x^{$a - $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Power rule: (x^a)^b = x^(ab)
        a = randint(2, 6)
        b = randint(2, 5)
        ans = a * b
        
        problem(
            question="Simplify: \$(x^{$a})^{$b}\$",
            answer="x^$ans",
            difficulty=(750, 950),
            solution=steps(
                "Use the power rule: \$(x^a)^b = x^{ab}\$",
                sol("Multiply exponents", "x^{$a \\cdot $b}"),
                sol("Answer", "x^{$ans}")
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Combined: (x^a * x^b)^c
        a = randint(1, 4)
        b = randint(1, 4)
        c = randint(2, 4)
        ans = (a + b) * c
        
        problem(
            question="Simplify: \$(x^{$a} \\cdot x^{$b})^{$c}\$",
            answer="x^$ans",
            difficulty=(900, 1100),
            solution=steps(
                "First apply product rule inside: \$x^{$a} \\cdot x^{$b} = x^{$(a+b)}\$",
                "Then apply power rule: \$(x^{$(a+b)})^{$c} = x^{$(a+b) \\cdot $c}\$",
                sol("Answer", "x^{$ans}")
            ),
            time=75
        )
        
    elseif problem_type == 5
        # Negative exponent: x^(-a) = 1/x^a
        a = randint(2, 8)
        
        problem(
            question="Simplify using positive exponents: \$x^{-$a}\$",
            answer="1/x^$a",
            difficulty=(800, 1000),
            solution=steps(
                "Use negative exponent rule: \$x^{-a} = \\frac{1}{x^a}\$",
                sol("Rewrite with positive exponent", "\\frac{1}{x^{$a}}"),
                sol("Answer", "\\frac{1}{x^{$a}}")
            ),
            time=60
        )
        
    else
        # Zero exponent: x^0 = 1
        coefficient = nonzero(-9, 9)
        
        problem(
            question="Simplify: \$($coefficient x)^0\$",
            answer=1,
            difficulty=(700, 850),
            solution=steps(
                "Use the zero exponent rule: \$a^0 = 1\$ for any \$a \\neq 0\$",
                "Any non-zero expression raised to the power 0 equals 1",
                sol("Answer", 1)
            ),
            time=30
        )
    end
end