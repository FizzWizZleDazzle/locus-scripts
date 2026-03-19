# algebra2 - complex_number_equations (easy)
# Generated: 2026-03-08T20:14:36.751716

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple quadratic with complex roots: x^2 + c = 0
        c = randint(1, 25)
        roots = Set([Complex(0, sqrt(c)), Complex(0, -sqrt(c))])
        
        problem(
            question="Solve for \\(x\\): \\(x^2 + $(c) = 0\\)",
            answer=fmt_set(roots),
            difficulty=(700, 900),
            answer_type="set",
            solution=steps(
                sol("Given", x^2 + c ~ 0),
                sol("Rearrange", x^2 ~ -c),
                "Take square root: \\(x = \\pm \\sqrt{-$(c)} = \\pm $(isqrt(c))i\\)",
                "Solution set: \\(\\{$(isqrt(c))i, -$(isqrt(c))i\\}\\)"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Quadratic with complex roots: x^2 + bx + c = 0
        real_part = randint(-8, 8)
        imag_part = nonzero(-6, 6)
        
        # Roots are real_part ± imag_part*i
        b_coeff = -2 * real_part
        c_coeff = real_part^2 + imag_part^2
        
        roots = Set([Complex(real_part, imag_part), Complex(real_part, -imag_part)])
        
        problem(
            question="Solve for \\(x\\): \\(x^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)x + $(c_coeff) = 0\\)",
            answer=fmt_set(roots),
            difficulty=(900, 1100),
            answer_type="set",
            solution=steps(
                sol("Given", x^2 + b_coeff*x + c_coeff ~ 0),
                "Use quadratic formula: \\(x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\\)",
                "Discriminant: \\($(b_coeff^2) - 4(1)($(c_coeff)) = $(b_coeff^2 - 4*c_coeff)\\)",
                "Since discriminant is negative, roots are complex:",
                "\\(x = \\frac{$(−b_coeff) \\pm \\sqrt{$(4*c_coeff - b_coeff^2)}i}{2} = $(real_part) \\pm $(imag_part)i\\)"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Linear equation with complex coefficients: (a+bi)x = c+di
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        d = randint(-10, 10)
        
        # Solution: x = (c+di)/(a+bi) = (c+di)(a-bi)/(a^2+b^2)
        denom = a^2 + b^2
        real_part = Rational(a*c + b*d, denom)
        imag_part = Rational(a*d - b*c, denom)
        
        ans = Complex(real_part, imag_part)
        
        problem(
            question="Solve for \\(x\\): \\(($(a)$(b >= 0 ? "+" : "")$(b)i)x = $(c)$(d >= 0 ? "+" : "")$(d)i\\)",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                "Given: \\(($(a)$(b >= 0 ? "+" : "")$(b)i)x = $(c)$(d >= 0 ? "+" : "")$(d)i\\)",
                "Divide both sides by \\($(a)$(b >= 0 ? "+" : "")$(b)i\\)",
                "Multiply numerator and denominator by conjugate \\($(a)$(b >= 0 ? "-" : "+")$(-b)i\\)",
                "Simplify denominator: \\($(a)^2 + $(b)^2 = $(denom)\\)",
                "Answer: \\(x = $(ans)\\)"
            ),
            time=150
        )
        
    elseif problem_type == 4
        # x^2 = complex number
        real = randint(-10, 10)
        imag = nonzero(-10, 10)
        
        # Roots of x^2 = a+bi
        r = sqrt(real^2 + imag^2)
        theta = atan(imag, real)
        
        root_r = sqrt(r)
        root1_real = root_r * cos(theta/2)
        root1_imag = root_r * sin(theta/2)
        
        roots = Set([Complex(root1_real, root1_imag), Complex(-root1_real, -root1_imag)])
        
        problem(
            question="Solve for \\(x\\): \\(x^2 = $(real)$(imag >= 0 ? "+" : "")$(imag)i\\)",
            answer=fmt_set(roots),
            difficulty=(1100, 1200),
            answer_type="set",
            solution=steps(
                "Given: \\(x^2 = $(real)$(imag >= 0 ? "+" : "")$(imag)i\\)",
                "Convert to polar form: \\(r = \\sqrt{$(real)^2 + $(imag)^2}\\)",
                "Use De Moivre's theorem to find square roots",
                "The two square roots are \\(\\pm($(root1_real) $(root1_imag >= 0 ? "+" : "")$(root1_imag)i)\\)"
            ),
            time=180
        )
        
    else
        # (x - (a+bi))(x - (a-bi)) = 0 expanded
        a = randint(-6, 6)
        b = nonzero(-6, 6)
        
        # Expansion: x^2 - 2ax + (a^2 + b^2)
        b_coeff = -2*a
        c_coeff = a^2 + b^2
        
        roots = Set([Complex(a, b), Complex(a, -b)])
        
        problem(
            question="Find all solutions: \\(x^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)x + $(c_coeff) = 0\\)",
            answer=fmt_set(roots),
            difficulty=(800, 1000),
            answer_type="set",
            solution=steps(
                sol("Given", x^2 + b_coeff*x + c_coeff ~ 0),
                "Apply quadratic formula",
                "Discriminant: \\($(b_coeff)^2 - 4($(c_coeff)) = $(b_coeff^2 - 4*c_coeff)\\)",
                "Roots are complex conjugates: \\(x = $(a) \\pm $(b)i\\)"
            ),
            time=120
        )
    end
end