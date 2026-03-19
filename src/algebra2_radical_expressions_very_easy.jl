# algebra2 - radical_expressions (very_easy)
# Generated: 2026-03-08T20:16:46.664191

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_expressions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simplify √(a²b) where b is a small prime
        a = randint(2, 12)
        b = choice([2, 3, 5, 7, 11])
        radicand = a^2 * b
        ans_coeff = abs(a)
        
        problem(
            question="Simplify: \\(\\sqrt{$(radicand)}\\)",
            answer="$(ans_coeff)\\sqrt{$(b)}",
            difficulty=(200, 500),
            solution=steps(
                "Given: \\(\\sqrt{$(radicand)}\\)",
                "Factor out perfect square: \\(\\sqrt{$(a^2) \\cdot $(b)}\\)",
                "Simplify: \\($(ans_coeff)\\sqrt{$(b)}\\)"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Evaluate simple square root √(n²)
        n = randint(3, 20)
        radicand = n^2
        
        problem(
            question="Evaluate: \\(\\sqrt{$(radicand)}\\)",
            answer=n,
            difficulty=(100, 300),
            solution=steps(
                "Given: \\(\\sqrt{$(radicand)}\\)",
                "Recognize that \\($(radicand) = $(n)^2\\)",
                "Answer: \\($(n)\\)"
            ),
            time=30
        )
        
    elseif problem_type == 3
        # Add/subtract like radicals: a√b ± c√b
        b = choice([2, 3, 5, 6, 7, 10])
        a = nonzero(-8, 8)
        c = nonzero(-8, 8)
        op = choice(["+", "-"])
        
        if op == "+"
            ans_coeff = a + c
        else
            ans_coeff = a - c
        end
        
        problem(
            question="Simplify: \\($(a)\\sqrt{$(b)} $(op) $(c)\\sqrt{$(b)}\\)",
            answer="$(ans_coeff)\\sqrt{$(b)}",
            difficulty=(400, 600),
            solution=steps(
                "Given: \\($(a)\\sqrt{$(b)} $(op) $(c)\\sqrt{$(b)}\\)",
                "Combine like radicals (same radicand)",
                "Answer: \\(($(a) $(op) $(c))\\sqrt{$(b)} = $(ans_coeff)\\sqrt{$(b)}\\)"
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Multiply simple radicals: √a · √b = √(ab)
        a = randint(2, 15)
        b = randint(2, 15)
        product = a * b
        
        # Check if product is a perfect square for variety
        sqrt_prod = isqrt(product)
        if sqrt_prod^2 == product
            ans_str = "$(sqrt_prod)"
        else
            ans_str = "\\sqrt{$(product)}"
        end
        
        problem(
            question="Multiply: \\(\\sqrt{$(a)} \\cdot \\sqrt{$(b)}\\)",
            answer=ans_str,
            difficulty=(300, 500),
            solution=steps(
                "Given: \\(\\sqrt{$(a)} \\cdot \\sqrt{$(b)}\\)",
                "Use property: \\(\\sqrt{a} \\cdot \\sqrt{b} = \\sqrt{ab}\\)",
                "Answer: \\(\\sqrt{$(product)}$(sqrt_prod^2 == product ? " = $(sqrt_prod)" : "")\\)"
            ),
            time=45
        )
        
    elseif problem_type == 5
        # Simplify cube root ∛(a³b)
        a = randint(2, 6)
        b = choice([2, 3, 5, 7])
        radicand = a^3 * b
        
        problem(
            question="Simplify: \\(\\sqrt[3]{$(radicand)}\\)",
            answer="$(a)\\sqrt[3]{$(b)}",
            difficulty=(400, 700),
            solution=steps(
                "Given: \\(\\sqrt[3]{$(radicand)}\\)",
                "Factor out perfect cube: \\(\\sqrt[3]{$(a^3) \\cdot $(b)}\\)",
                "Simplify: \\($(a)\\sqrt[3]{$(b)}\\)"
            ),
            time=75
        )
        
    else
        # Rationalize simple denominator: a/√b
        a = randint(1, 20)
        b = choice([2, 3, 5, 6, 7, 10])
        
        problem(
            question="Rationalize the denominator: \\(\\frac{$(a)}{\\sqrt{$(b)}}\\)",
            answer="\\frac{$(a)\\sqrt{$(b)}}{$(b)}",
            difficulty=(500, 700),
            solution=steps(
                "Given: \\(\\frac{$(a)}{\\sqrt{$(b)}}\\)",
                "Multiply by \\(\\frac{\\sqrt{$(b)}}{\\sqrt{$(b)}}\\) to rationalize",
                "Answer: \\(\\frac{$(a)\\sqrt{$(b)}}{$(b)}\\)"
            ),
            time=90
        )
    end
end