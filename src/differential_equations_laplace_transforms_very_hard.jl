# differential_equations - laplace_transforms (very_hard)
# Generated: 2026-03-08T20:57:04.509942

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script s t begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Inverse Laplace with partial fractions and complex roots
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        omega = randint(2, 7)
        
        # F(s) = (as + b) / ((s^2 + omega^2)(s - alpha))
        alpha = nonzero(-4, 4)
        
        # Compute partial fraction decomposition manually
        # F(s) = (As + B)/(s^2 + omega^2) + C/(s - alpha)
        # as + b = (As + B)(s - alpha) + C(s^2 + omega^2)
        
        # Using residue method
        # C = (a*alpha + b) / (alpha^2 + omega^2)
        C_num = a * alpha + b
        C_den = alpha^2 + omega^2
        
        # A + C = 0 (coefficient of s^2)
        # B - A*alpha + C*omega^2 = a (coefficient of s)
        # -B*alpha = b (constant term)
        
        A_num = -C_num
        A_den = C_den
        B_num = -b
        B_den = alpha
        
        # Simplify for cleaner answer
        # f(t) = (A*cos(omega*t) + B*sin(omega*t)/omega) + C*e^(alpha*t)
        
        answer_str = "\\frac{$(C_num)}{$(C_den)}e^{$(alpha)t}"
        if A_num != 0
            answer_str = "\\frac{$(A_num)}{$(C_den)}\\cos($(omega)t) + " * answer_str
        end
        if B_num != 0
            answer_str = answer_str * " + \\frac{$(B_num)}{$(alpha * omega)}\\sin($(omega)t)"
        end
        
        numerator = a * s + b
        denom1 = s^2 + omega^2
        denom2 = s - alpha
        
        problem(
            question="Find the inverse Laplace transform: \\mathcal{L}^{-1}\\left\\{\\frac{$(tex(numerator))}{($(tex(denom1)))($(tex(denom2)))}\\right\\}",
            answer=answer_str,
            difficulty=(2800, 3200),
            solution=steps(
                "Apply partial fraction decomposition to \\frac{$(tex(numerator))}{($(tex(denom1)))($(tex(denom2)))}",
                "Write as \\frac{As + B}{s^2 + $(omega^2)} + \\frac{C}{s - $(alpha)}",
                "Solve for constants: C = \\frac{$(C_num)}{$(C_den)}, A = \\frac{$(A_num)}{$(C_den)}, B = \\frac{$(B_num)}{$(alpha)}",
                "Apply inverse Laplace: \\mathcal{L}^{-1}\\{\\frac{s}{s^2+\\omega^2}\\} = \\cos(\\omega t), \\mathcal{L}^{-1}\\{\\frac{1}{s^2+\\omega^2}\\} = \\frac{\\sin(\\omega t)}{\\omega}, \\mathcal{L}^{-1}\\{\\frac{1}{s-a}\\} = e^{at}",
                sol("Answer", answer_str)
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Solving IVP with discontinuous forcing (Heaviside function)
        # y'' + ay' + by = f(t), y(0) = y0, y'(0) = v0
        # where f(t) involves unit step function
        
        y0 = randint(-5, 5)
        v0 = randint(-5, 5)
        
        # Use simple characteristic equation with real roots
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r1 == r2
            r2 = nonzero(-4, 4)
        end
        
        a_coef = -(r1 + r2)
        b_coef = r1 * r2
        
        # Forcing function coefficient
        k = nonzero(-8, 8)
        t0 = randint(1, 5)
        
        # Solution involves complementary + particular
        # Complementary: C1*e^(r1*t) + C2*e^(r2*t)
        # Particular: Laplace transform method
        
        question_str = "Solve the initial value problem using Laplace transforms:<br>"
        question_str *= "y'' + $(a_coef)y' + $(b_coef)y = $(k)u(t - $(t0))<br>"
        question_str *= "y(0) = $(y0), y'(0) = $(v0)<br>"
        question_str *= "where u(t) is the unit step function."
        
        # For competition level, ask for Y(s) rather than full solution
        answer_str = "Y(s) = \\frac{$(y0)s + $(v0 - a_coef*y0)}{s^2 + $(a_coef)s + $(b_coef)} + \\frac{$(k)e^{-$(t0)s}}{s(s^2 + $(a_coef)s + $(b_coef))}"
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2600, 3100),
            solution=steps(
                "Take Laplace transform of both sides: \\mathcal{L}\\{y''\\} + $(a_coef)\\mathcal{L}\\{y'\\} + $(b_coef)\\mathcal{L}\\{y\\} = $(k)\\mathcal{L}\\{u(t-$(t0))\\}",
                "Apply initial conditions: s^2Y(s) - $(y0)s - $(v0) + $(a_coef)(sY(s) - $(y0)) + $(b_coef)Y(s) = \\frac{$(k)e^{-$(t0)s}}{s}",
                "Collect terms: (s^2 + $(a_coef)s + $(b_coef))Y(s) = $(y0)s + $(v0 + a_coef*y0) + \\frac{$(k)e^{-$(t0)s}}{s}",
                "Solve for Y(s) and apply partial fractions",
                sol("Answer", answer_str)
            ),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Convolution theorem problem
        # Find L^(-1){F(s)*G(s)} using convolution
        
        a = randint(2, 6)
        b = randint(2, 6)
        while a == b
            b = randint(2, 6)
        end
        
        # F(s) = 1/(s^2 + a^2), G(s) = 1/(s^2 + b^2)
        # f(t) = sin(at)/a, g(t) = sin(bt)/b
        # (f*g)(t) = integral from 0 to t of sin(a*tau)/a * sin(b*(t-tau))/b dtau
        
        question_str = "Using the convolution theorem, find:<br>"
        question_str *= "\\mathcal{L}^{-1}\\left\\{\\frac{1}{(s^2 + $(a^2))(s^2 + $(b^2))}\\right\\}"
        
        # The convolution integral evaluates to:
        # (sin(at) - sin(bt))/(ab(a^2 - b^2)) for a != b
        
        coef = 1 // (a * b * (a^2 - b^2))
        answer_str = "\\frac{\\sin($(a)t) - \\sin($(b)t)}{$(a*b*(a^2 - b^2))}"
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2700, 3300),
            solution=steps(
                "Recognize F(s) = \\frac{1}{s^2 + $(a^2)} and G(s) = \\frac{1}{s^2 + $(b^2)}",
                "Find f(t) = \\mathcal{L}^{-1}\\{F(s)\\} = \\frac{\\sin($(a)t)}{$(a)} and g(t) = \\mathcal{L}^{-1}\\{G(s)\\} = \\frac{\\sin($(b)t)}{$(b)}",
                "Apply convolution theorem: \\mathcal{L}^{-1}\\{F(s)G(s)\\} = (f * g)(t) = \\int_0^t f(\\tau)g(t-\\tau)d\\tau",
                "Evaluate integral: \\int_0^t \\frac{\\sin($(a)\\tau)}{$(a)} \\cdot \\frac{\\sin($(b)(t-\\tau))}{$(b)} d\\tau",
                "Use product-to-sum formula and integrate to obtain",
                sol("Answer", answer_str)
            ),
            time=300,
            calculator="scientific"
        )
        
    else
        # System of differential equations using Laplace transforms
        # x' = ax + by, y' = cx + dy
        # x(0) = x0, y(0) = y0
        
        x0 = nonzero(-5, 5)
        y0 = nonzero(-5, 5)
        
        # Use coefficients that give clean eigenvalues
        a_val = randint(-3, 3)
        d_val = randint(-3, 3)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        
        question_str = "Solve the system using Laplace transforms:<br>"
        question_str *= "x' = $(a_val)x + $(b_val)y, \\quad y' = $(c_val)x + $(d_val)y<br>"
        question_str *= "x(0) = $(x0), \\quad y(0) = $(y0)<br>"
        question_str *= "Find X(s) and Y(s)."
        
        # After Laplace transform:
        # sX(s) - x0 = a*X(s) + b*Y(s)
        # sY(s) - y0 = c*X(s) + d*Y(s)
        # (s-a)X(s) - b*Y(s) = x0
        # -c*X(s) + (s-d)Y(s) = y0
        
        det = (s - a_val) * (s - d_val) - b_val * c_val
        
        answer_x = "X(s) = \\frac{$(x0)(s - $(d_val)) + $(b_val * y0)}{$(tex(expand(det)))}"
        answer_y = "Y(s) = \\frac{$(y0)(s - $(a_val)) + $(c_val * x0)}{$(tex(expand(det)))}"
        
        answer_str = answer_x * ", " * answer_y
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2900, 3400),
            solution=steps(
                "Take Laplace transform: sX(s) - $(x0) = $(a_val)X(s) + $(b_val)Y(s), sY(s) - $(y0) = $(c_val)X(s) + $(d_val)Y(s)",
                "Rearrange: (s - $(a_val))X(s) - $(b_val)Y(s) = $(x0), -$(c_val)X(s) + (s - $(d_val))Y(s) = $(y0)",
                "Write in matrix form and compute determinant: \\Delta(s) = $(tex(expand(det)))",
                "Apply Cramer's rule to solve for X(s) and Y(s)",
                sol("Answer", answer_str)
            ),
            time=300,
            calculator="scientific"
        )
    end
end