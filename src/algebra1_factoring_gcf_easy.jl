# algebra1 - factoring_gcf (easy)
# Generated: 2026-03-08T19:59:43.077290

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_gcf")
    
    # Choose problem type
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Simple GCF factoring: gcf * (binomial)
        gcf = nonzero(-12, 12)
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        
        expr = expand(gcf * (a*x + b))
        factored = gcf * (a*x + b)
        
        problem(
            question="Factor out the greatest common factor: \$$(tex(expr))\$",
            answer=factored,
            difficulty=(700, 900),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Identify GCF of coefficients: $(abs(gcf))",
                sol("Factor out GCF", factored)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # GCF factoring: gcf * (trinomial)
        gcf = choice([2, 3, 4, 5, 6, -2, -3, -4, -5, -6])
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        c = randint(-10, 10)
        
        expr = expand(gcf * (a*x^2 + b*x + c))
        factored = gcf * (a*x^2 + b*x + c)
        
        problem(
            question="Factor out the greatest common factor: \$$(tex(expr))\$",
            answer=factored,
            difficulty=(800, 1000),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Find GCF of all terms: $(abs(gcf))",
                sol("Factor out GCF", factored)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # GCF with variables: x^n * (polynomial)
        n = randint(2, 4)
        a = nonzero(-8, 8)
        b = randint(-12, 12)
        c = randint(-12, 12)
        
        expr = a*x^(n+2) + b*x^(n+1) + c*x^n
        factored = x^n * (a*x^2 + b*x + c)
        
        problem(
            question="Factor out the greatest common factor: \$$(tex(expr))\$",
            answer=factored,
            difficulty=(900, 1100),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "GCF of all terms is \$x^{$(n)}\$",
                "Divide each term by \$x^{$(n)}\$",
                sol("Factored form", factored)
            ),
            time=90
        )
        
    else
        # Combined GCF (coefficient and variable): gcf*x^m * (polynomial)
        gcf = choice([2, 3, 4, 5, -2, -3, -4, -5])
        m = randint(1, 3)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        
        expr = gcf*a*x^(m+2) + gcf*b*x^(m+1)
        factored = gcf*x^(m+1) * (a*x + b)
        
        problem(
            question="Factor out the greatest common factor: \$$(tex(expr))\$",
            answer=factored,
            difficulty=(1000, 1200),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Identify GCF: coefficient $(abs(gcf)) and variable \$x^{$(m+1)}\$",
                "Combined GCF is \$$(abs(gcf))x^{$(m+1)}\$",
                sol("Factored form", factored)
            ),
            time=120
        )
    end
end