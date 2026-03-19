# algebra2 - complex_number_equations (hard)
# Generated: 2026-03-08T20:15:17.302383

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Quadratic with complex roots (standard form)
        # Target: 1800-2100
        real_part = randint(-8, 8)
        imag_part = nonzero(-8, 8)
        
        # Roots are real_part ± imag_part*i
        # (x - (a+bi))(x - (a-bi)) = x^2 - 2ax + (a^2 + b^2)
        b_coeff = -2 * real_part
        c_coeff = real_part^2 + imag_part^2
        
        expr = x^2 + b_coeff*x + c_coeff
        
        root1_str = real_part == 0 ? "$(imag_part)i" : "$(real_part) + $(imag_part)i"
        root2_str = real_part == 0 ? "$((-imag_part))i" : "$(real_part) - $(imag_part)i"
        
        ans = fmt_set(Set([root1_str, root2_str]))
        
        discriminant = b_coeff^2 - 4*c_coeff
        
        problem(
            question="Find all complex solutions to \\\$$(tex(expr)) = 0\\\$",
            answer=ans,
            difficulty=(1800, 2100),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Use quadratic formula: \\\$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}\\\$",
                "Discriminant: \\\$\\Delta = $(b_coeff)^2 - 4(1)($(c_coeff)) = $(discriminant)\\\$",
                "\\\$x = \\frac{$((-b_coeff))}{ \\pm \\sqrt{$(discriminant)}}{2} = \\frac{$((-b_coeff)) \\pm $(abs(imag_part)*2)i}{2}\\\$",
                sol("Solutions", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Polynomial equation with complex conjugate pairs
        # Target: 2000-2300
        real_root = nonzero(-6, 6)
        a = randint(-4, 4)
        if a == 0
            a = 1
        end
        b = nonzero(-5, 5)
        
        # (x - real_root)(x - (a+bi))(x - (a-bi))
        # = (x - real_root)(x^2 - 2ax + (a^2 + b^2))
        quad_part = x^2 - 2*a*x + (a^2 + b^2)
        expr = expand((x - real_root) * quad_part)
        
        root1_str = "$(real_root)"
        root2_str = a == 0 ? "$(b)i" : "$(a) + $(b)i"
        root3_str = a == 0 ? "$((-b))i" : "$(a) - $(b)i"
        
        ans = fmt_set(Set([root1_str, root2_str, root3_str]))
        
        problem(
            question="Find all complex solutions to \\\$$(tex(expr)) = 0\\\$",
            answer=ans,
            difficulty=(2000, 2300),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Factor out real root: \\\$(x - $(real_root))\\\$",
                "Remaining quadratic: \\\$$(tex(quad_part)) = 0\\\$",
                "Apply quadratic formula to find complex conjugate pair",
                "Real root: \\\$x = $(real_root)\\\$",
                "Complex roots: \\\$x = $(root2_str), $(root3_str)\\\$",
                sol("All solutions", ans)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Equation of form x^4 + bx^2 + c = 0 (biquadratic with complex solutions)
        # Target: 1900-2200
        # Let u = x^2, solve u^2 + bu + c = 0
        # Choose u-values that give complex x-values
        u1 = -randint(1, 8)  # Negative so sqrt gives complex
        u2 = -randint(1, 8)
        
        b_coeff = -(u1 + u2)
        c_coeff = u1 * u2
        
        expr = x^4 + b_coeff*x^2 + c_coeff
        
        # x^2 = u1 gives x = ±√u1 = ±i√|u1|
        # x^2 = u2 gives x = ±√u2 = ±i√|u2|
        sqrt_u1 = isqrt(abs(u1))
        sqrt_u2 = isqrt(abs(u2))
        
        root1_str = "$(sqrt_u1)i"
        root2_str = "$((-sqrt_u1))i"
        root3_str = "$(sqrt_u2)i"
        root4_str = "$((-sqrt_u2))i"
        
        ans = fmt_set(Set([root1_str, root2_str, root3_str, root4_str]))
        
        problem(
            question="Find all complex solutions to \\\$$(tex(expr)) = 0\\\$",
            answer=ans,
            difficulty=(1900, 2200),
            answer_type="set",
            solution=steps(
                sol("Given", expr ~ 0),
                "Substitute \\\$u = x^2\\\$ to get: \\\$u^2 + $(b_coeff)u + $(c_coeff) = 0\\\$",
                "Factor or use quadratic formula: \\\$u = $(u1)\\\$ or \\\$u = $(u2)\\\$",
                "For \\\$x^2 = $(u1)\\\$: \\\$x = \\pm $(sqrt_u1)i\\\$",
                "For \\\$x^2 = $(u2)\\\$: \\\$x = \\pm $(sqrt_u2)i\\\$",
                sol("All solutions", ans)
            ),
            time=210
        )
        
    elseif problem_type == 4
        # System with complex solutions
        # Target: 2100-2400
        # x + iy = a + bi and x - iy = c + di type problem
        a = randint(-6, 6)
        b = nonzero(-6, 6)
        c = randint(-6, 6)
        d = nonzero(-6, 6)
        
        # From x + iy = a + bi, we get x = a, y = b
        # But make it more interesting: z^2 = a + bi
        
        # z^2 = a + bi
        # Let z = x + yi, then z^2 = (x^2 - y^2) + 2xyi
        # So x^2 - y^2 = a and 2xy = b
        
        expr_real = a
        expr_imag = b
        
        # Solve: |z|^2 = sqrt(a^2 + b^2)
        # x^2 + y^2 = sqrt(a^2 + b^2)
        r_squared = a^2 + b^2
        
        # Solutions exist when a^2 + b^2 is a perfect square
        # For simplicity, construct backward
        x_val = randint(1, 5)
        y_val = randint(1, 5)
        
        a = x_val^2 - y_val^2
        b = 2*x_val*y_val
        
        root1_str = "$(x_val) + $(y_val)i"
        root2_str = "$((-x_val)) - $(y_val)i"
        
        ans = fmt_set(Set([root1_str, root2_str]))
        
        problem(
            question="Find all complex numbers \\\$z\\\$ such that \\\$z^2 = $(a) + $(b)i\\\$",
            answer=ans,
            difficulty=(2100, 2400),
            answer_type="set",
            solution=steps(
                "Let \\\$z = x + yi\\\$ where \\\$x, y \\in \\mathbb{R}\\\$",
                "Then \\\$z^2 = (x^2 - y^2) + 2xyi = $(a) + $(b)i\\\$",
                "Equate real and imaginary parts: \\\$x^2 - y^2 = $(a)\\\$ and \\\$2xy = $(b)\\\$",
                "Also \\\$|z|^2 = x^2 + y^2 = \\sqrt{$(a)^2 + $(b)^2}\\\$",
                "Solving the system gives \\\$x = \\pm $(x_val)\\\$, \\\$y = \\pm $(y_val)\\\$",
                "Check signs from \\\$2xy = $(b)\\\$",
                sol("Solutions", ans)
            ),
            time=270
        )
        
    else
        # Equation involving complex number properties
        # Target: 2000-2300
        # |z - a| = r type problem leading to quadratic
        h = randint(-5, 5)
        k = randint(-5, 5)
        r = randint(2, 6)
        
        # |z - (h + ki)| = r and Im(z) = k
        # This gives (x - h)^2 + (y - k)^2 = r^2 with y = k
        # So (x - h)^2 = r^2, meaning x = h ± r
        
        x1 = h + r
        x2 = h - r
        
        root1_str = k == 0 ? "$(x1)" : "$(x1) + $(k)i"
        root2_str = k == 0 ? "$(x2)" : "$(x2) + $(k)i"
        
        ans = fmt_set(Set([root1_str, root2_str]))
        
        center_str = k == 0 ? "$(h)" : "$(h) + $(k)i"
        
        problem(
            question="Find all complex numbers \\\$z\\\$ satisfying \\\$|z - ($(center_str))| = $(r)\\\$ and \\\$\\text{Im}(z) = $(k)\\\$",
            answer=ans,
            difficulty=(2000, 2300),
            answer_type="set",
            solution=steps(
                "Let \\\$z = x + yi\\\$ where \\\$x, y \\in \\mathbb{R}\\\$",
                "Given constraint: \\\$\\text{Im}(z) = y = $(k)\\\$",
                "Distance condition: \\\$|z - ($(center_str))| = |(x - $(h)) + ($(k) - $(k))i| = $(r)\\\$",
                "This gives \\\$|x - $(h)| = $(r)\\\$",
                "Therefore \\\$x = $(h) \\pm $(r)\\\$, so \\\$x = $(x1)\\\$ or \\\$x = $(x2)\\\$",
                sol("Solutions", ans)
            ),
            time=200
        )
    end
end