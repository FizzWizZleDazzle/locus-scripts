# algebra2 - exponential_equations (very_easy)
# Generated: 2026-03-08T20:19:12.656583

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/exponential_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple exponential: b^x = value (ELO 200-400)
        base = choice([2, 3, 4, 5, 10])
        exponent = randint(0, 4)
        value = base^exponent
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x = $(value)\$",
            answer=exponent,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", base^x ~ value),
                "Recognize that \$$(value) = $(base)^{$(exponent)}\$",
                sol("Answer", x ~ exponent)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Same base comparison: b^x = b^k (ELO 300-500)
        base = choice([2, 3, 4, 5, 7])
        ans = randint(-5, 8)
        rhs_exp = ans
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x = $(base)^{$(rhs_exp)}\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", base^x ~ base^rhs_exp),
                "Since the bases are equal, the exponents must be equal",
                sol("Answer", x ~ ans)
            ),
            time=40
        )
        
    elseif problem_type == 3
        # Linear exponent: b^(ax+c) = b^k (ELO 400-600)
        base = choice([2, 3, 5])
        ans = randint(-8, 10)
        a = nonzero(-4, 4)
        c = randint(-6, 6)
        k = a * ans + c
        lhs_exp = a*x + c
        
        problem(
            question="Solve for \\(x\\): \$$(base)^{$(tex(lhs_exp))} = $(base)^{$(k)}\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", base^lhs_exp ~ base^k),
                "Equate exponents: \$$(tex(lhs_exp)) = $(k)\$",
                "Solve for \\(x\\): \$$(tex(lhs_exp ~ k))\$",
                sol("Answer", x ~ ans)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Power of power: (b^a)^x = b^k (ELO 450-650)
        base = choice([2, 3, 5])
        inner_exp = choice([2, 3])
        ans = randint(1, 6)
        k = inner_exp * ans
        
        problem(
            question="Solve for \\(x\\): \$($(base)^{$(inner_exp)})^x = $(base)^{$(k)}\$",
            answer=ans,
            difficulty=(450, 650),
            solution=steps(
                "Given: \$($(base)^{$(inner_exp)})^x = $(base)^{$(k)}\$",
                "Apply power rule: \$$(base)^{$(inner_exp)x} = $(base)^{$(k)}\$",
                "Equate exponents: \$$(inner_exp)x = $(k)\$",
                sol("Answer", x ~ ans)
            ),
            time=75
        )
        
    elseif problem_type == 5
        # Simple exponential with fraction: b^x = 1/b^k (ELO 500-700)
        base = choice([2, 3, 4, 5])
        k = randint(1, 5)
        ans = -k
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x = \\frac{1}{$(base)^{$(k)}}\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", base^x ~ 1/base^k),
                "Rewrite: \$\\frac{1}{$(base)^{$(k)}} = $(base)^{-$(k)}\$",
                "Equate exponents: \$x = -$(k)\$",
                sol("Answer", x ~ ans)
            ),
            time=70
        )
        
    else
        # Product of powers: b^x * b^c = b^k (ELO 550-700)
        base = choice([2, 3, 5])
        ans = randint(1, 8)
        c = randint(1, 5)
        k = ans + c
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x \\cdot $(base)^{$(c)} = $(base)^{$(k)}\$",
            answer=ans,
            difficulty=(550, 700),
            solution=steps(
                sol("Given", base^x * base^c ~ base^k),
                "Apply product rule: \$$(base)^{x + $(c)} = $(base)^{$(k)}\$",
                "Equate exponents: \$x + $(c) = $(k)\$",
                sol("Answer", x ~ ans)
            ),
            time=80
        )
    end
end