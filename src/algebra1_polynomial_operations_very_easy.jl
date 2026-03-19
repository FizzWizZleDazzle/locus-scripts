# algebra1 - polynomial_operations (very_easy)
# Generated: 2026-03-08T19:58:54.107774

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Addition of polynomials (200-400 ELO)
        a1 = randint(-5, 5)
        b1 = randint(-10, 10)
        a2 = randint(-5, 5)
        b2 = randint(-10, 10)
        
        p1 = a1*x + b1
        p2 = a2*x + b2
        result = expand(p1 + p2)
        
        problem(
            question="Add the polynomials: \\(($(tex(p1)))\\) + \\(($(tex(p2)))\\)",
            answer=result,
            difficulty=(200, 400),
            solution=steps(
                "Given: \\(($(tex(p1)))\\) + \\(($(tex(p2)))\\)",
                "Combine like terms: \\($(a1)x + $(a2)x = $(a1+a2)x\\) and \\($(b1) + $(b2) = $(b1+b2)\\)",
                sol("Answer", result)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Subtraction of polynomials (300-500 ELO)
        a1 = randint(-8, 8)
        b1 = randint(-15, 15)
        a2 = randint(-8, 8)
        b2 = randint(-15, 15)
        
        p1 = a1*x + b1
        p2 = a2*x + b2
        result = expand(p1 - p2)
        
        problem(
            question="Subtract the polynomials: \\(($(tex(p1)))\\) - \\(($(tex(p2)))\\)",
            answer=result,
            difficulty=(300, 500),
            solution=steps(
                "Given: \\(($(tex(p1)))\\) - \\(($(tex(p2)))\\)",
                "Distribute the negative: \\(($(tex(p1)))\\) + \\(($(tex(-p2)))\\)",
                "Combine like terms",
                sol("Answer", result)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Multiply monomial by polynomial (400-600 ELO)
        k = nonzero(-6, 6)
        a = randint(-10, 10)
        b = randint(-15, 15)
        
        poly = a*x + b
        result = expand(k * poly)
        
        problem(
            question="Multiply: \\($(k) \\cdot ($(tex(poly)))\\)",
            answer=result,
            difficulty=(400, 600),
            solution=steps(
                "Given: \\($(k) \\cdot ($(tex(poly)))\\)",
                "Distribute \\($(k)\\) to each term",
                "\\($(k) \\cdot $(a)x = $(k*a)x\\) and \\($(k) \\cdot $(b) = $(k*b)\\)",
                sol("Answer", result)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Add three monomials (100-300 ELO)
        a1 = randint(-8, 8)
        a2 = randint(-8, 8)
        a3 = randint(-8, 8)
        
        result = (a1 + a2 + a3)*x
        
        problem(
            question="Simplify by combining like terms: \\($(a1)x + $(a2)x + $(a3)x\\)",
            answer=result,
            difficulty=(100, 300),
            solution=steps(
                "Given: \\($(a1)x + $(a2)x + $(a3)x\\)",
                "All terms have the same variable \\(x\\), so add the coefficients",
                "\\($(a1) + $(a2) + $(a3) = $(a1+a2+a3)\\)",
                sol("Answer", result)
            ),
            time=45
        )
        
    else
        # Subtract and simplify (200-500 ELO)
        c1 = randint(2, 8)
        c2 = randint(1, 6)
        const1 = randint(-12, 12)
        const2 = randint(-12, 12)
        
        p1 = c1*x + const1
        p2 = c2*x + const2
        result = expand(p1 - p2)
        
        problem(
            question="Simplify: \\(($(tex(p1)))\\) - \\(($(tex(p2)))\\)",
            answer=result,
            difficulty=(200, 500),
            solution=steps(
                "Given: \\(($(tex(p1)))\\) - \\(($(tex(p2)))\\)",
                "Remove parentheses: \\($(c1)x + $(const1) - $(c2)x - $(const2)\\)",
                "Combine like terms: \\(($(c1) - $(c2))x + ($(const1) - $(const2))\\)",
                sol("Answer", result)
            ),
            time=60
        )
    end
end