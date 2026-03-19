# algebra1 - quadratic_formula (hard)
# Generated: 2026-03-08T20:01:18.173216

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Quadratic with two rational roots (factorable, but practice quadratic formula)
        r1 = randint(-12, 12)
        r2 = randint(-12, 12)
        for _attempt in 1:1000
            r1 == r2 || break
            r2 = randint(-12, 12)
        end
        a = nonzero(-4, 4)
        expr = expand(a * (x - r1) * (x - r2))
        
        # Extract coefficients for display
        coeffs = [a, -a*(r1 + r2), a*r1*r2]
        
        sols = Set([r1, r2])
        
        discriminant = (coeffs[2])^2 - 4*coeffs[1]*coeffs[3]
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$",
            answer=fmt_set(sols),
            difficulty=(1800, 2000),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\$ where \$a=$(coeffs[1]), b=$(coeffs[2]), c=$(coeffs[3])\$",
                "Discriminant: \$\\Delta = $(coeffs[2])^2 - 4($(coeffs[1]))($(coeffs[3])) = $(discriminant)\$",
                "\$x = \\frac{-$(coeffs[2]) \\pm \\sqrt{$(discriminant)}}{$(2*coeffs[1])}\$",
                sol("Solutions", fmt_set(sols))
            ),
            time=180,
        )
        
    elseif problem_type == 2
        # Quadratic with irrational roots (discriminant is non-square)
        a = nonzero(-3, 3)
        b = randint(-15, 15)
        c = randint(-20, 20)
        
        discriminant = b^2 - 4*a*c
        
        # Ensure discriminant is positive but not a perfect square
        for _attempt in 1:1000
            (discriminant <= 0 || isqrt(discriminant)^2 == discriminant) || break
            b = randint(-15, 15)
            c = randint(-20, 20)
            discriminant = b^2 - 4*a*c
        end
        
        expr = a*x^2 + b*x + c
        
        # Compute exact roots using symbolic sqrt
        sqrt_disc = sqrt(discriminant)
        root1 = (-b + sqrt_disc) / (2*a)
        root2 = (-b - sqrt_disc) / (2*a)
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$. Express your answer in simplest radical form.",
            answer=fmt_set(Set([root1, root2])),
            difficulty=(1900, 2100),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula with \$a=$a, b=$b, c=$c\$",
                "Discriminant: \$\\Delta = $b^2 - 4($a)($c) = $(discriminant)\$",
                "\$x = \\frac{-($b) \\pm \\sqrt{$(discriminant)}}{$(2*a)}\$",
                sol("Solutions", fmt_set(Set([root1, root2])))
            ),
            time=240,
        )
        
    elseif problem_type == 3
        # Complex roots (negative discriminant)
        a = nonzero(-3, 3)
        # Pick b and c to ensure negative discriminant
        b = randint(-8, 8)
        c = randint(10, 30)
        
        discriminant = b^2 - 4*a*c
        
        for _attempt in 1:1000
            discriminant >= 0 || break
            c = randint(10, 30)
            discriminant = b^2 - 4*a*c
        end
        
        expr = a*x^2 + b*x + c
        
        # Complex roots: (-b ± i√|Δ|) / 2a
        abs_disc = abs(discriminant)
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$. Express complex solutions in the form \$a \\pm bi\$.",
            answer="No real solutions (complex roots)",
            difficulty=(2000, 2200),
            answer_type="text",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula with \$a=$a, b=$b, c=$c\$",
                "Discriminant: \$\\Delta = $b^2 - 4($a)($c) = $(discriminant) < 0\$",
                "Since discriminant is negative, the equation has no real solutions",
                "Complex solutions: \$x = \\frac{-($b) \\pm i\\sqrt{$(abs_disc)}}{$(2*a)}\$"
            ),
            time=180,
        )
        
    elseif problem_type == 4
        # One repeated root (discriminant = 0)
        r = randint(-10, 10)
        a = nonzero(-4, 4)
        
        expr = expand(a * (x - r)^2)
        
        # Extract coefficients
        b = -2*a*r
        c = a*r^2
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$",
            answer=fmt_set(Set([r])),
            difficulty=(1850, 2000),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula with \$a=$a, b=$b, c=$c\$",
                "Discriminant: \$\\Delta = $b^2 - 4($a)($c) = 0\$",
                "Since discriminant equals zero, there is one repeated root",
                "\$x = \\frac{-($b)}{2($a)} = $r\$",
                sol("Solution", fmt_set(Set([r])))
            ),
            time=150,
        )
        
    else  # problem_type == 5
        # Quadratic requiring simplification of the radical
        a = choice([1, 2, 3])
        # Choose discriminant that simplifies nicely
        perfect_square = choice([4, 9, 16, 25, 36, 49])
        non_square = choice([2, 3, 5, 6, 7])
        discriminant = perfect_square * non_square
        
        # Work backwards: Δ = b² - 4ac
        b = randint(-12, 12)
        c = (b^2 - discriminant) // (4*a)
        
        for _attempt in 1:1000
            (b^2 - discriminant) % (4*a) != 0 || break
            b = randint(-12, 12)
            c = (b^2 - discriminant) // (4*a)
        end
        
        expr = a*x^2 + b*x + c
        
        sqrt_factor = isqrt(perfect_square)
        
        root1_num = -b + sqrt_factor * sqrt(non_square)
        root2_num = -b - sqrt_factor * sqrt(non_square)
        
        root1 = root1_num / (2*a)
        root2 = root2_num / (2*a)
        
        problem(
            question="Use the quadratic formula to solve: \$$(tex(expr)) = 0\$. Simplify all radicals completely.",
            answer=fmt_set(Set([root1, root2])),
            difficulty=(2100, 2300),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Apply quadratic formula with \$a=$a, b=$b, c=$c\$",
                "Discriminant: \$\\Delta = $b^2 - 4($a)($c) = $(discriminant)\$",
                "Simplify: \$\\sqrt{$(discriminant)} = \\sqrt{$(perfect_square) \\cdot $(non_square)} = $(sqrt_factor)\\sqrt{$(non_square)}\$",
                "\$x = \\frac{-($b) \\pm $(sqrt_factor)\\sqrt{$(non_square)}}{$(2*a)}\$",
                sol("Solutions", fmt_set(Set([root1, root2])))
            ),
            time=270,
        )
    end
end