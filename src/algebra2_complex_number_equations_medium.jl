# algebra2 - complex_number_equations (medium)
# Generated: 2026-03-08T20:14:59.338986

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Quadratic with complex roots: x^2 + bx + c = 0
        # Want discriminant < 0
        real_part = randint(-8, 8)
        imag_part = nonzero(-8, 8)
        
        # Roots are real_part ± imag_part*i
        # Sum of roots = 2*real_part, product = real_part^2 + imag_part^2
        b_coeff = -2 * real_part
        c_coeff = real_part^2 + imag_part^2
        
        expr = x^2 + b_coeff*x + c_coeff
        
        if real_part == 0
            ans = fmt_set(Set(["$(imag_part)i", "$(-imag_part)i"]))
            sol_text = "\\{$(imag_part)i, $(-imag_part)i\\}"
        else
            ans = fmt_set(Set(["$(real_part)+$(imag_part)i", "$(real_part)-$(imag_part)i"]))
            sol_text = "\\{$(real_part)+$(imag_part)i, $(real_part)-$(imag_part)i\\}"
        end
        
        discriminant = b_coeff^2 - 4*c_coeff
        
        problem(
            question = "Solve for \\(x\\): \$$(tex(expr)) = 0\$",
            answer = ans,
            answer_type = "set",
            difficulty = (1200, 1400),
            solution = steps(
                sol("Given", expr ~ 0),
                "Use quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}\$",
                "Discriminant: \$\\Delta = $(b_coeff)^2 - 4(1)($(c_coeff)) = $(discriminant) < 0\$",
                "Solutions: \$$(sol_text)\$"
            ),
            time = 120
        )
        
    elseif problem_type == 2
        # Equation with i: ax + bi = c + di
        a_coeff = nonzero(-10, 10)
        b_coeff = nonzero(-10, 10)
        c_val = randint(-15, 15)
        d_val = randint(-15, 15)
        
        # Solve: a*x_real + b*x_imag*i = c + d*i
        # Real part: a*x_real = c → x_real = c/a
        # Imag part: b*x_imag = d → x_imag = d/b
        
        x_real = c_val // a_coeff
        x_imag = d_val // b_coeff
        
        if x_imag == 0
            ans = "$(x_real)"
        elseif x_real == 0
            ans = "$(x_imag)i"
        else
            ans = "$(x_real)+$(x_imag)i"
        end
        
        problem(
            question = "Solve for the complex number \\(x\\): \$$(a_coeff)x + $(b_coeff)i = $(c_val) + $(d_val)i\$",
            answer = ans,
            difficulty = (1100, 1300),
            solution = steps(
                "Equation: \$$(a_coeff)x + $(b_coeff)i = $(c_val) + $(d_val)i\$",
                "Separate real and imaginary parts: \$$(a_coeff)x = $(c_val)\$ and \$$(b_coeff)i = $(d_val)i\$",
                "Solve for real part: \$x_{real} = \\frac{$(c_val)}{$(a_coeff)} = $(x_real)\$",
                sol("Answer", ans)
            ),
            time = 90
        )
        
    elseif problem_type == 3
        # (x - z1)(x - z2) = 0 where z1, z2 are complex
        r1_real = randint(-8, 8)
        r1_imag = nonzero(-8, 8)
        r2_real = randint(-8, 8)
        r2_imag = nonzero(-8, 8)
        
        # Expand to get coefficients
        # (x - (a+bi))(x - (c+di)) = x^2 - (a+c)x - (bi+di)x + (a+bi)(c+di)
        sum_real = r1_real + r2_real
        sum_imag = r1_imag + r2_imag
        
        prod_real = r1_real * r2_real - r1_imag * r2_imag
        prod_imag = r1_real * r2_imag + r1_imag * r2_real
        
        if sum_imag == 0 && prod_imag == 0
            expr = x^2 - sum_real*x + prod_real
        else
            # Build expression string manually
            b_str = sum_imag == 0 ? "$(sum_real)" : "($(sum_real)+$(sum_imag)i)"
            c_str = prod_imag == 0 ? "$(prod_real)" : "($(prod_real)+$(prod_imag)i)"
            expr_str = "x^2 - $(b_str)x + $(c_str)"
        end
        
        z1_str = r1_imag > 0 ? "$(r1_real)+$(r1_imag)i" : "$(r1_real)$(r1_imag)i"
        z2_str = r2_imag > 0 ? "$(r2_real)+$(r2_imag)i" : "$(r2_real)$(r2_imag)i"
        
        ans = fmt_set(Set([z1_str, z2_str]))
        
        problem(
            question = "Find all complex solutions to \$x^2 - ($(sum_real)+$(sum_imag)i)x + ($(prod_real)+$(prod_imag)i) = 0\$",
            answer = ans,
            answer_type = "set",
            difficulty = (1400, 1600),
            solution = steps(
                "Given quadratic with complex coefficients",
                "Use quadratic formula or factor if possible",
                "The roots are \$$(z1_str)\$ and \$$(z2_str)\$",
                sol("Answer", ans)
            ),
            time = 150
        )
        
    elseif problem_type == 4
        # x^2 = negative number
        k = nonzero(-50, -1)
        sqrt_k = isqrt(-k)
        
        ans = fmt_set(Set(["$(sqrt_k)i", "$(-sqrt_k)i"]))
        
        problem(
            question = "Solve for \\(x\\): \$x^2 = $(k)\$",
            answer = ans,
            answer_type = "set",
            difficulty = (1000, 1200),
            solution = steps(
                sol("Given", x^2 ~ k),
                "Take square root of both sides: \$x = \\pm\\sqrt{$(k)}\$",
                "Since \$\\sqrt{$(k)} = \\sqrt{$(-k)}i = $(sqrt_k)i\$",
                sol("Answer", ans)
            ),
            time = 60
        )
        
    else
        # x^3 = a + bi (one real root, two complex conjugates)
        a_val = nonzero(-20, 20)
        
        # For simplicity, use x^3 = a (real number) to get one real and two complex roots
        # Real root: a^(1/3)
        # Complex roots involve cube roots of unity
        
        real_root = round(Int, sign(a_val) * abs(a_val)^(1/3))
        
        # Check if it's a perfect cube
        if real_root^3 == a_val
            # omega = e^(2πi/3) = -1/2 + sqrt(3)/2 i
            # roots: real_root, real_root*omega, real_root*omega^2
            
            ans = "$(real_root)"
            
            problem(
                question = "Find the real solution to \$x^3 = $(a_val)\$",
                answer = ans,
                difficulty = (1200, 1400),
                solution = steps(
                    sol("Given", x^3 ~ a_val),
                    "Take cube root: \$x = \\sqrt[3]{$(a_val)}\$",
                    "The real solution is \$x = $(real_root)\$",
                    sol("Answer", ans)
                ),
                time = 90
            )
        else
            # Just do x^2 + k = 0 instead
            k = randint(5, 40)
            sqrt_k = isqrt(k)
            
            ans = fmt_set(Set(["$(sqrt_k)i", "$(-sqrt_k)i"]))
            
            problem(
                question = "Solve for \\(x\\): \$x^2 + $(k) = 0\$",
                answer = ans,
                answer_type = "set",
                difficulty = (1100, 1300),
                solution = steps(
                    sol("Given", x^2 + k ~ 0),
                    "Rearrange: \$x^2 = $(-k)\$",
                    "Take square root: \$x = \\pm $(sqrt_k)i\$",
                    sol("Answer", ans)
                ),
                time = 75
            )
        end
    end
end