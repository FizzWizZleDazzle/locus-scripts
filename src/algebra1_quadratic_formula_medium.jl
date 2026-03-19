# algebra1 - quadratic_formula (medium)
# Generated: 2026-03-08T20:01:04.802778

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    # Choose problem type
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Standard quadratic formula application (1200-1400)
        # ax^2 + bx + c = 0 with integer coefficients but irrational roots
        a = nonzero(-5, 5)
        b = randint(-15, 15)
        c = randint(-20, 20)
        
        # Ensure discriminant is positive but not a perfect square
        disc = b^2 - 4*a*c
        for _attempt in 1:1000
            (disc <= 0 || isqrt(disc)^2 == disc) || break
            b = randint(-15, 15)
            c = randint(-20, 20)
            disc = b^2 - 4*a*c
        end
        
        expr = a*x^2 + b*x + c
        
        # Calculate roots using quadratic formula
        sqrt_disc = sqrt(disc)
        root1 = (-b + sqrt_disc) / (2*a)
        root2 = (-b - sqrt_disc) / (2*a)
        
        # Format answer as set
        ans_str = "\\{\\frac{$(-b) + \\sqrt{$(disc)}}{$(2*a)}, \\frac{$(-b) - \\sqrt{$(disc)}}{$(2*a)}\\}"
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$",
            answer=ans_str,
            difficulty=(1200, 1400),
            answer_type="expression",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\$",
                "Here \$a = $(a)\$, \$b = $(b)\$, \$c = $(c)\$",
                "Discriminant: \$\\Delta = $(b)^2 - 4($(a))($(c)) = $(disc)\$",
                sol("Solutions", ans_str)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Quadratic with one repeated root (1200-1300)
        a = nonzero(-6, 6)
        root = randint(-12, 12)
        
        # Form (x - root)^2, then multiply by a
        expr = expand(a * (x - root)^2)
        
        ans_str = "\\{$(root)\\}"
        
        problem(
            question="Solve using the quadratic formula: \$$(tex(expr)) = 0\$",
            answer=ans_str,
            difficulty=(1200, 1300),
            answer_type="expression",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\$",
                "Discriminant: \$\\Delta = 0\$ (perfect square)",
                "One repeated root: \$x = $(root)\$",
                sol("Solution", ans_str)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Quadratic with no real solutions (1300-1500)
        a = nonzero(-4, 4)
        b = randint(-10, 10)
        c = randint(-20, 20)
        
        # Ensure negative discriminant
        disc = b^2 - 4*a*c
        for _attempt in 1:1000
            disc >= 0 || break
            c = randint(-20, 20)
            disc = b^2 - 4*a*c
        end
        
        expr = a*x^2 + b*x + c
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$. If there are no real solutions, write \"no real solutions\".",
            answer="no real solutions",
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\$",
                "Calculate discriminant: \$\\Delta = $(b)^2 - 4($(a))($(c)) = $(disc)\$",
                "Since \$\\Delta < 0\$, there are no real solutions"
            ),
            time=90
        )
        
    else
        # Word problem requiring quadratic formula setup (1500-1800)
        # Rectangle problem: length is k more than width, area is A
        k = randint(3, 10)
        w = randint(8, 20)
        l = w + k
        area = w * l
        
        # Equation: w(w + k) = area
        # w^2 + kw - area = 0
        
        expr_setup = x^2 + k*x - area
        
        # Discriminant
        disc = k^2 + 4*area
        
        problem(
            question="A rectangle has length $(k) meters more than its width. If the area is $(area) square meters, find the width using the quadratic formula.",
            answer=w,
            difficulty=(1500, 1800),
            solution=steps(
                "Let width = \$x\$ meters, then length = \$x + $(k)\$ meters",
                "Area equation: \$x(x + $(k)) = $(area)\$",
                sol("Simplify", expr_setup ~ 0),
                "Apply quadratic formula: \$x = \\frac{-$(k) \\pm \\sqrt{$(k)^2 + 4($(area))}}{2}\$",
                "Discriminant: \$\\Delta = $(disc)\$",
                "Solutions: \$x = \\frac{-$(k) \\pm $(isqrt(disc))}{2}\$",
                "Taking positive solution: \$x = $(w)\$ meters",
                sol("Width", "$(w) meters")
            ),
            time=180
        )
    end
end