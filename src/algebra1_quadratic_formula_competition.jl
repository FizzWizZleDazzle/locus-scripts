# algebra1 - quadratic_formula (competition)
# Generated: 2026-03-08T20:01:29.012796

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Complex quadratic with irrational discriminant requiring sophisticated manipulation
        # ELO 3500-4000: Find conditions on parameter for specific root properties
        k = randint(-15, 15)
        m = nonzero(-20, 20)
        n = randint(-25, 25)
        
        # Construct: x^2 + (k+m)x + (km + n) = 0
        # For what values of k does this have roots whose product equals a specific value?
        target_product = randint(-30, 30)
        
        # By Vieta's formulas, product of roots = c/a = km + n
        # So we need: km + n = target_product
        # Therefore: k = (target_product - n) / m
        
        if m != 0
            k_answer = (target_product - n) // m
        else
            k_answer = randint(-10, 10)
        end
        
        b_coeff = k + m
        c_coeff = k*m + n
        
        problem(
            question="Consider the family of quadratic equations \$x^2 + (k + $(m))x + (k \\cdot $(m) + $(n)) = 0\$ where \$k\$ is a real parameter. Find the value of \$k\$ for which the product of the roots equals \$$(target_product)\$.",
            answer=k_answer,
            difficulty=(3500, 3800),
            solution=steps(
                sol("Given family", x^2 + (k + m)*x + (k*m + n) ~ 0),
                "By Vieta's formulas, the product of roots equals \$\\frac{c}{a} = k \\cdot $(m) + $(n)\$",
                "Set product equal to target: \$$(m)k + $(n) = $(target_product)\$",
                "Solve for k: \$k = \\frac{$(target_product) - $(n)}{$(m)} = $(k_answer)\$",
                sol("Answer", k_answer)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Functional equation involving quadratic formula
        # ELO 3800-4200: If roots of ax^2+bx+c=0 are α,β, find quadratic with roots f(α),f(β)
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        c = randint(-25, 25)
        
        # Original roots using quadratic formula
        disc = b^2 - 4*a*c
        
        # New roots are 1/α and 1/β (reciprocals)
        # If α,β are roots of ax^2+bx+c=0, then 1/α,1/β are roots of cx^2+bx+a=0
        
        new_a = c
        new_b = b
        new_c = a
        
        if new_a == 0
            new_a = nonzero(-8, 8)
        end
        
        problem(
            question="Let \$\\alpha\$ and \$\\beta\$ be the roots of \$$(a)x^2 + $(b)x + $(c) = 0\$. Find a monic quadratic equation whose roots are \$\\frac{1}{\\alpha}\$ and \$\\frac{1}{\\beta}\$. Express your answer in the form \$x^2 + px + q = 0\$ and give the ordered pair \$(p, q)\$.",
            answer=fmt_tuple((new_b//new_a, new_c//new_a)),
            answer_type="tuple",
            difficulty=(3700, 4100),
            solution=steps(
                sol("Original equation", a*x^2 + b*x + c ~ 0),
                "If \$\\alpha, \\beta\$ are roots of \$ax^2+bx+c=0\$, then \$\\frac{1}{\\alpha}, \\frac{1}{\\beta}\$ are roots of \$cx^2+bx+a=0\$",
                "Divide by leading coefficient \$$(c)\$ to get monic form: \$x^2 + \\frac{$(b)}{$(c)}x + \\frac{$(a)}{$(c)} = 0\$",
                sol("Coefficients", (new_b//new_a, new_c//new_a)),
                sol("Answer", fmt_tuple((new_b//new_a, new_c//new_a)))
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Olympiad-style constraint problem
        # ELO 4000-4500: Quadratic with integer coefficients and specific discriminant properties
        p = randint(2, 20)
        q = randint(2, 20)
        target_disc = p^2 * q  # Perfect square times non-square
        
        # Find a,b,c such that b^2 - 4ac = target_disc and certain constraints hold
        a = randint(1, 8)
        c = randint(-15, 15)
        
        # b^2 = 4ac + target_disc
        b_squared = 4*a*c + target_disc
        
        if b_squared > 0
            b = Int(floor(sqrt(b_squared)))
            if b^2 != b_squared
                b = b + 1
            end
        else
            b = randint(10, 30)
        end
        
        actual_disc = b^2 - 4*a*c
        
        problem(
            question="Consider the quadratic equation \$$(a)x^2 + $(b)x + $(c) = 0\$. The discriminant can be written in the form \$m^2 \\cdot n\$ where \$n\$ is square-free (not divisible by any perfect square except 1). Find \$m + n\$.",
            answer=actual_disc,
            difficulty=(4000, 4500),
            solution=steps(
                sol("Equation", a*x^2 + b*x + c ~ 0),
                "Calculate discriminant: \$\\Delta = b^2 - 4ac = $(b)^2 - 4($(a))($(c)) = $(actual_disc)\$",
                "Factor the discriminant into perfect square and square-free parts",
                "Compute sum of \$m\$ and square-free part \$n\$",
                sol("Answer", actual_disc)
            ),
            time=360
        )
        
    else
        # Type 4: Research-adjacent optimization with quadratic formula
        # ELO 4200-4800: Minimize expression involving roots
        a = nonzero(-6, 6)
        b = randint(-18, 18)
        c = randint(-20, 20)
        
        # Find minimum of |α| + |β| where α,β are roots
        disc = b^2 - 4*a*c
        
        if disc >= 0 && a != 0
            sqrt_disc = sqrt(abs(disc))
            root1 = (-b + sqrt_disc) / (2*a)
            root2 = (-b - sqrt_disc) / (2*a)
            result = abs(root1) + abs(root2)
        else
            result = abs(b) / abs(a)
        end
        
        # Use Vieta's formulas: sum = -b/a, product = c/a
        sum_roots = -b // a
        prod_roots = c // a
        
        problem(
            question="Let \$\\alpha\$ and \$\\beta\$ be the roots of \$$(a)x^2 + $(b)x + $(c) = 0\$. Using Vieta's formulas, find the exact value of \$\\alpha^2 + \\beta^2\$ expressed as a rational number in lowest terms.",
            answer=(b^2 - 2*a*c) // a^2,
            difficulty=(4200, 4700),
            solution=steps(
                sol("Given equation", a*x^2 + b*x + c ~ 0),
                "By Vieta's formulas: \$\\alpha + \\beta = -\\frac{$(b)}{$(a)}\$ and \$\\alpha\\beta = \\frac{$(c)}{$(a)}\$",
                "Use identity: \$\\alpha^2 + \\beta^2 = (\\alpha + \\beta)^2 - 2\\alpha\\beta\$",
                "Substitute: \$\\alpha^2 + \\beta^2 = \\left(-\\frac{$(b)}{$(a)}\\right)^2 - 2\\left(\\frac{$(c)}{$(a)}\\right) = \\frac{$(b^2)}{$(a^2)} - \\frac{$(2*c)}{$(a)}\$",
                sol("Simplify", (b^2 - 2*a*c) // a^2),
                sol("Answer", (b^2 - 2*a*c) // a^2)
            ),
            time=300
        )
    end
end