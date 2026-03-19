# algebra1 - exponent_rules (very_easy)
# Generated: 2026-03-08T19:58:20.017911

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
            difficulty=(200, 400),
            solution=steps(
                "Use the product rule: \$x^a \\cdot x^b = x^{a+b}\$",
                sol("Add exponents", "$a + $b = $ans"),
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
            difficulty=(300, 500),
            solution=steps(
                "Use the quotient rule: \$\\frac{x^a}{x^b} = x^{a-b}\$",
                sol("Subtract exponents", "$a - $b = $ans"),
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
            difficulty=(300, 500),
            solution=steps(
                "Use the power rule: \$(x^a)^b = x^{ab}\$",
                sol("Multiply exponents", "$a \\cdot $b = $ans"),
                sol("Answer", "x^{$ans}")
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Zero exponent: x^0 = 1
        base = choice([2, 3, 5, 7, 10, 15, 20, 25])
        
        problem(
            question="Evaluate: \$$base^0\$",
            answer=1,
            difficulty=(100, 300),
            solution=steps(
                "Use the zero exponent rule: \$a^0 = 1\$ for any \$a \\neq 0\$",
                "Any non-zero number raised to the power 0 equals 1",
                sol("Answer", "1")
            ),
            time=30
        )
        
    elseif problem_type == 5
        # Negative exponent: x^(-a) = 1/x^a
        a = randint(2, 6)
        base = choice([2, 3, 4, 5, 10])
        ans = 1 // base^a
        
        problem(
            question="Simplify as a fraction: \$$base^{-$a}\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Use the negative exponent rule: \$a^{-n} = \\frac{1}{a^n}\$",
                sol("Rewrite", "\\frac{1}{$base^{$a}}"),
                sol("Answer", "\\frac{1}{$(base^a)}")
            ),
            time=60
        )
        
    else
        # Combined: (x^a)^b * x^c
        a = randint(2, 4)
        b = randint(2, 3)
        c = randint(2, 6)
        ans = a * b + c
        
        problem(
            question="Simplify: \$(x^{$a})^{$b} \\cdot x^{$c}\$",
            answer="x^$ans",
            difficulty=(500, 700),
            solution=steps(
                "First apply power rule: \$(x^{$a})^{$b} = x^{$(a*b)}\$",
                "Then apply product rule: \$x^{$(a*b)} \\cdot x^{$c} = x^{$(a*b) + $c}\$",
                sol("Answer", "x^{$ans}")
            ),
            time=75
        )
    end
end