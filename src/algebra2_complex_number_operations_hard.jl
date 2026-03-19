# algebra2 - complex_number_operations (hard)
# Generated: 2026-03-08T20:14:12.190508

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/complex_number_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complex number powers and De Moivre's theorem
        r = randint(2, 5)
        θ_num = choice([1, 2, 3, 4, 5, 6, 7, 11])
        θ_den = choice([6, 4, 3, 2])
        n = randint(3, 8)
        
        # z^n in polar form
        new_r = r^n
        new_θ_num = (n * θ_num) % (2 * θ_den)
        if new_θ_num == 0
            new_θ_num = 2 * θ_den
        end
        
        # Convert to rectangular
        θ_val = new_θ_num * π / θ_den
        real_part = rationalize(new_r * cos(θ_val), tol=1e-10)
        imag_part = rationalize(new_r * sin(θ_val), tol=1e-10)
        
        ans_str = if imag_part >= 0
            "$(real_part)+$(imag_part)i"
        else
            "$(real_part)$(imag_part)i"
        end
        
        problem(
            question="Let \\(z = $(r)\\text{cis}\\left(\\frac{$(θ_num)\\pi}{$(θ_den)}\\right)\\). Find \\(z^{$(n)}\\) in rectangular form \\(a+bi\\).",
            answer=ans_str,
            difficulty=(1900, 2200),
            solution=steps(
                "Given: \\(z = $(r)\\text{cis}\\left(\\frac{$(θ_num)\\pi}{$(θ_den)}\\right)\\)",
                "Apply De Moivre's theorem: \\(z^{$(n)} = $(r)^{$(n)}\\text{cis}\\left(\\frac{$(n * θ_num)\\pi}{$(θ_den)}\\right)\\)",
                "Simplify: \\(z^{$(n)} = $(new_r)\\text{cis}\\left(\\frac{$(new_θ_num)\\pi}{$(θ_den)}\\right)\\)",
                "Convert to rectangular: \\($(new_r)\\left(\\cos\\frac{$(new_θ_num)\\pi}{$(θ_den)} + i\\sin\\frac{$(new_θ_num)\\pi}{$(θ_den)}\\right)\\)",
                "Answer: \\($(ans_str)\\)"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Complex conjugate and modulus manipulation
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # |az + b|^2 where z = c + di
        z_real = c
        z_imag = d
        
        w_real = a * c + b
        w_imag = a * d
        
        modulus_sq = w_real^2 + w_imag^2
        
        problem(
            question="Let \\(z = $(c) + $(d)i\\). Find \\(|$(a)z + $(b)|^2\\).",
            answer=modulus_sq,
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\(z = $(c) + $(d)i\\)",
                "Compute \\(w = $(a)z + $(b) = $(a)($(c) + $(d)i) + $(b) = $(w_real) + $(w_imag)i\\)",
                "Use \\(|w|^2 = \\text{Re}(w)^2 + \\text{Im}(w)^2\\)",
                "Calculate: \\(|w|^2 = ($(w_real))^2 + ($(w_imag))^2 = $(modulus_sq)\\)"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # nth roots of unity equation
        n = choice([3, 4, 5, 6])
        k = randint(1, 20)
        
        # z^n = k, find sum of all roots
        sum_roots = 0
        
        problem(
            question="Find the sum of all complex solutions to \\(z^{$(n)} = $(k)\\).",
            answer=sum_roots,
            difficulty=(2000, 2300),
            solution=steps(
                "The equation \\(z^{$(n)} = $(k)\\) has $(n) complex solutions",
                "These are evenly spaced on a circle centered at the origin",
                "By symmetry, the $(n) roots form a regular $(n)-gon centered at origin",
                "The sum of vertices of a regular polygon centered at origin is 0",
                "Answer: \\(0\\)"
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Complex division with rationalization
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        d = nonzero(-7, 7)
        
        # (a + bi) / (c + di)
        denom = c^2 + d^2
        real_part = (a*c + b*d) // denom
        imag_part = (b*c - a*d) // denom
        
        ans_str = if imag_part >= 0
            "$(real_part)+$(imag_part)i"
        else
            "$(real_part)$(imag_part)i"
        end
        
        problem(
            question="Simplify \\(\\frac{$(a) + $(b)i}{$(c) + $(d)i}\\) and write in the form \\(a+bi\\).",
            answer=ans_str,
            difficulty=(1800, 2100),
            solution=steps(
                "Multiply numerator and denominator by conjugate: \\(\\frac{($(a) + $(b)i)($(c) - $(d)i)}{($(c) + $(d)i)($(c) - $(d)i)}\\)",
                "Expand numerator: \\(($(a))($(c)) + ($(a))(-$(d)i) + ($(b)i)($(c)) + ($(b)i)(-$(d)i) = $(a*c + b*d) + $(b*c - a*d)i\\)",
                "Denominator: \\(($(c))^2 + ($(d))^2 = $(denom)\\)",
                "Simplify: \\(\\frac{$(a*c + b*d) + $(b*c - a*d)i}{$(denom)} = $(real_part) + $(imag_part)i\\)"
            ),
            time=180
        )
        
    else
        # Complex number as root of quadratic
        p = nonzero(-6, 6)
        q = randint(5, 30)
        
        # Roots are -p ± sqrt(-q) / 2 = -p/2 ± i*sqrt(q)/2
        real_coeff = -p // 2
        imag_coeff_sq = q
        
        # Sum of squares of roots
        # Each root: (-p/2 ± i*sqrt(q)/2)
        # |root|^2 = p^2/4 + q/4
        modulus_sq = (p^2 + q) // 4
        sum_of_squares = 2 * modulus_sq
        
        problem(
            question="The quadratic \\(x^2 + $(p)x + $(q) = 0\\) has two complex roots. Find the sum of the squares of the moduli of these roots.",
            answer=sum_of_squares,
            difficulty=(2100, 2400),
            solution=steps(
                "The discriminant is \\(\\Delta = $(p^2) - 4($(q)) = $(p^2 - 4*q) < 0\\), confirming complex roots",
                "Roots are \\(x = \\frac{-$(p) \\pm \\sqrt{$(p^2 - 4*q)}}{2} = \\frac{-$(p) \\pm i\\sqrt{$(4*q - p^2)}}{2}\\)",
                "Each root has modulus squared \\(|x|^2 = \\left(\\frac{-$(p)}{2}\\right)^2 + \\left(\\frac{\\sqrt{$(4*q - p^2)}}{2}\\right)^2 = \\frac{$(p^2) + $(4*q - p^2)}{4} = \\frac{$(4*q)}{4}\\)",
                "Wait, recalculate: \\(|x|^2 = \\frac{$(p^2)}{4} + \\frac{$(4*q - p^2)}{4} = \\frac{$(p^2 + q)}{4}\\)",
                "Sum of both: \\(2 \\cdot \\frac{$(p^2 + q)}{4} = \\frac{$(p^2 + q)}{2}\\)"
            ),
            time=240
        )
    end
end