# multivariable_calculus - double_integrals (easy)
# Generated: 2026-03-08T21:01:08.837104

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/double_integrals")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Simple rectangular region with polynomial integrand (700-900 ELO)
        a = randint(1, 5)
        b = randint(1, 5)
        c = randint(1, 4)
        d = randint(1, 4)
        
        power_x = rand(0:2)
        power_y = rand(0:2)
        coeff = randint(1, 6)
        
        integrand = coeff * x^power_x * y^power_y
        
        # Compute answer
        inner_result = (coeff // (power_y + 1)) * x^power_x * (d^(power_y + 1) - c^(power_y + 1))
        ans_num = (1 // (power_x + 1)) * (b^(power_x + 1) - a^(power_x + 1)) * (coeff // (power_y + 1)) * (d^(power_y + 1) - c^(power_y + 1))
        ans = Float64(ans_num)
        
        problem(
            question="Evaluate the double integral \\(\\displaystyle\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy \\, dx\\)",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy \\, dx"),
                "Integrate with respect to y first: \\(\\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy = $(tex(inner_result))\\big|_{$(c)}^{$(d)}\\)",
                "Evaluate and integrate with respect to x",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Rectangular region with sum integrand (800-1000 ELO)
        a = randint(0, 3)
        b = randint(a + 2, a + 5)
        c = randint(0, 3)
        d = randint(c + 2, c + 5)
        
        coeff1 = randint(1, 4)
        coeff2 = randint(1, 4)
        power_x = rand(1:2)
        power_y = rand(1:2)
        
        integrand = coeff1 * x^power_x + coeff2 * y^power_y
        
        # Compute answer
        term1 = (coeff1 // (power_x + 1)) * (b^(power_x + 1) - a^(power_x + 1)) * (d - c)
        term2 = (b - a) * (coeff2 // (power_y + 1)) * (d^(power_y + 1) - c^(power_y + 1))
        ans = Float64(term1 + term2)
        
        problem(
            question="Evaluate the double integral \\(\\displaystyle\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} ($(tex(integrand))) \\, dy \\, dx\\)",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} ($(tex(integrand))) \\, dy \\, dx"),
                "Split the integral: \\(\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(coeff1 * x^power_x)) \\, dy \\, dx + \\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(coeff2 * y^power_y)) \\, dy \\, dx\\)",
                "Evaluate each integral separately using power rule",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Type 3: Variable limits (y-dependent x bounds) (900-1100 ELO)
        c = randint(0, 2)
        d = randint(c + 2, c + 4)
        
        coeff = randint(1, 5)
        power_y = rand(1:2)
        
        integrand = coeff * x * y^power_y
        
        # x from 0 to y
        # Compute answer
        inner_int = (coeff // 2) * y^(power_y + 2)
        ans = Float64((coeff // (2 * (power_y + 3))) * (d^(power_y + 3) - c^(power_y + 3)))
        
        problem(
            question="Evaluate the double integral \\(\\displaystyle\\int_{$(c)}^{$(d)} \\int_{0}^{y} $(tex(integrand)) \\, dx \\, dy\\)",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", "\\int_{$(c)}^{$(d)} \\int_{0}^{y} $(tex(integrand)) \\, dx \\, dy"),
                "Integrate with respect to x: \\(\\int_{0}^{y} $(tex(integrand)) \\, dx = $(tex(inner_int))\\big|_{0}^{y}\\)",
                "Integrate the resulting expression with respect to y",
                sol("Answer", ans)
            ),
            time=150
        )
        
    else
        # Type 4: Rectangular region with xy term (750-950 ELO)
        a = randint(1, 3)
        b = randint(a + 1, a + 4)
        c = randint(1, 3)
        d = randint(c + 1, c + 4)
        
        coeff = randint(2, 8)
        
        integrand = coeff * x * y
        
        # Compute answer
        ans = Float64((coeff // 4) * (b^2 - a^2) * (d^2 - c^2))
        
        problem(
            question="Evaluate the double integral \\(\\displaystyle\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy \\, dx\\)",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy \\, dx"),
                "Integrate with respect to y: \\(\\int_{$(c)}^{$(d)} $(tex(integrand)) \\, dy = $(tex(coeff//2 * x * (y^2)))\\big|_{$(c)}^{$(d)} = $(tex(coeff//2 * x * (d^2 - c^2)))\\)",
                "Integrate with respect to x: \\(\\int_{$(a)}^{$(b)} $(tex(coeff//2 * (d^2 - c^2) * x)) \\, dx\\)",
                sol("Answer", ans)
            ),
            time=100
        )
    end
end