# algebra2 - logarithm_properties (easy)
# Generated: 2026-03-08T20:20:05.435039

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify log(a) + log(b) using product rule
        a = randint(2, 12)
        b = randint(2, 12)
        product = a * b
        
        problem(
            question="Simplify: \\(\\log($(a)) + \\log($(b))\\)",
            answer="\\log($(product))",
            difficulty=(700, 900),
            solution=steps(
                "Given: \\(\\log($(a)) + \\log($(b))\\)",
                "Apply the product rule: \\(\\log(a) + \\log(b) = \\log(ab)\\)",
                sol("Answer", "\\log($(product))")
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Simplify log(a) - log(b) using quotient rule
        a = randint(20, 100)
        b = randint(2, 10)
        while a % b != 0
            a = randint(20, 100)
            b = randint(2, 10)
        end
        quotient = a ÷ b
        
        problem(
            question="Simplify: \\(\\log($(a)) - \\log($(b))\\)",
            answer="\\log($(quotient))",
            difficulty=(700, 900),
            solution=steps(
                "Given: \\(\\log($(a)) - \\log($(b))\\)",
                "Apply the quotient rule: \\(\\log(a) - \\log(b) = \\log\\left(\\frac{a}{b}\\right)\\)",
                sol("Answer", "\\log($(quotient))")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Simplify k*log(a) using power rule
        k = randint(2, 6)
        a = randint(2, 15)
        power = a^k
        
        problem(
            question="Simplify: \\($(k)\\log($(a))\\)",
            answer="\\log($(power))",
            difficulty=(700, 900),
            solution=steps(
                "Given: \\($(k)\\log($(a))\\)",
                "Apply the power rule: \\(k\\log(a) = \\log(a^k)\\)",
                sol("Answer", "\\log($(power))")
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Expand log(a*b) or log(a/b)
        if rand(Bool)
            # Product
            a = randint(2, 12)
            b = randint(2, 12)
            product = a * b
            
            problem(
                question="Expand using logarithm properties: \\(\\log($(product))\\), given that \\($(product) = $(a) \\times $(b)\\)",
                answer="\\log($(a)) + \\log($(b))",
                difficulty=(800, 1000),
                solution=steps(
                    "Given: \\(\\log($(product))\\) where \\($(product) = $(a) \\times $(b)\\)",
                    "Rewrite as \\(\\log($(a) \\times $(b))\\)",
                    "Apply product rule: \\(\\log(ab) = \\log(a) + \\log(b)\\)",
                    sol("Answer", "\\log($(a)) + \\log($(b))")
                ),
                time=90
            )
        else
            # Quotient
            b = randint(2, 10)
            a = b * randint(3, 12)
            
            problem(
                question="Expand using logarithm properties: \\(\\log\\left(\\frac{$(a)}{$(b)}\\right)\\)",
                answer="\\log($(a)) - \\log($(b))",
                difficulty=(800, 1000),
                solution=steps(
                    "Given: \\(\\log\\left(\\frac{$(a)}{$(b)}\\right)\\)",
                    "Apply quotient rule: \\(\\log\\left(\\frac{a}{b}\\right) = \\log(a) - \\log(b)\\)",
                    sol("Answer", "\\log($(a)) - \\log($(b))")
                ),
                time=90
            )
        end
        
    else
        # Combine multiple properties
        a = randint(2, 8)
        b = randint(2, 8)
        k = randint(2, 4)
        power = b^k
        product = a * power
        
        problem(
            question="Simplify: \\(\\log($(a)) + $(k)\\log($(b))\\)",
            answer="\\log($(product))",
            difficulty=(900, 1200),
            solution=steps(
                "Given: \\(\\log($(a)) + $(k)\\log($(b))\\)",
                "Apply power rule to \\($(k)\\log($(b))\\): \\(\\log($(a)) + \\log($(b)^$(k))\\)",
                "Simplify: \\(\\log($(a)) + \\log($(power))\\)",
                "Apply product rule: \\(\\log($(a) \\times $(power))\\)",
                sol("Answer", "\\log($(product))")
            ),
            time=120
        )
    end
end