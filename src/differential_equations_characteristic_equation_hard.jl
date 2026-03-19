# differential_equations - characteristic_equation (hard)
# Generated: 2026-03-08T20:53:50.778611

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/characteristic_equation")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Second-order homogeneous with distinct real roots
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        question_str = "Solve the differential equation: \$y'' + $(b_coeff)y' + $(c_coeff)y = 0\$"
        answer_str = "y = C₁e^($(r1)x) + C₂e^($(r2)x)"
        
        solution_str = steps(
            "The characteristic equation is: \$r^2 + $(b_coeff)r + $(c_coeff) = 0\$",
            "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
            "Roots: \$r_1 = $(r1), r_2 = $(r2)\$",
            "Since the roots are real and distinct, the general solution is:",
            sol("Answer", "y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}")
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1800, 2000),
            solution=solution_str,
            time=180,
            answer_type="text"
        )
        
    elseif problem_type == 2
        # Second-order with repeated real root
        r = nonzero(-7, 7)
        
        b_coeff = -2*r
        c_coeff = r^2
        
        question_str = "Solve the differential equation: \$y'' + $(b_coeff)y' + $(c_coeff)y = 0\$"
        answer_str = "y = C₁e^($(r)x) + C₂xe^($(r)x)"
        
        solution_str = steps(
            "The characteristic equation is: \$r^2 + $(b_coeff)r + $(c_coeff) = 0\$",
            "Factor: \$(r - $(r))^2 = 0\$",
            "Double root: \$r = $(r)\$ (multiplicity 2)",
            "For repeated roots, the general solution is:",
            sol("Answer", "y = C_1 e^{$(r)x} + C_2 x e^{$(r)x}")
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1900, 2100),
            solution=solution_str,
            time=200,
            answer_type="text"
        )
        
    elseif problem_type == 3
        # Second-order with complex roots
        alpha = randint(-6, 6)
        beta = nonzero(1, 8)
        
        b_coeff = -2*alpha
        c_coeff = alpha^2 + beta^2
        
        question_str = "Solve the differential equation: \$y'' + $(b_coeff)y' + $(c_coeff)y = 0\$"
        answer_str = "y = e^($(alpha)x)(C₁cos($(beta)x) + C₂sin($(beta)x))"
        
        solution_str = steps(
            "The characteristic equation is: \$r^2 + $(b_coeff)r + $(c_coeff) = 0\$",
            "Using the quadratic formula: \$r = \\frac{$(2*alpha) \\pm \\sqrt{$(4*alpha^2) - $(4*c_coeff)}}{2}\$",
            "Simplify: \$r = $(alpha) \\pm $(beta)i\$",
            "Complex roots: \$\\alpha = $(alpha), \\beta = $(beta)\$",
            "For complex roots \$\\alpha \\pm \\beta i\$, the general solution is:",
            sol("Answer", "y = e^{$(alpha)x}(C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x))")
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2000, 2200),
            solution=solution_str,
            time=220,
            answer_type="text"
        )
        
    else
        # Third-order with mixed roots
        r1 = nonzero(-5, 5)
        alpha = randint(-4, 4)
        beta = nonzero(1, 5)
        
        # Characteristic polynomial: (r - r1)(r^2 - 2*alpha*r + (alpha^2 + beta^2))
        # Expand to get coefficients
        a_coeff = -(r1 + 2*alpha)
        b_coeff = alpha^2 + beta^2 + 2*r1*alpha
        c_coeff = -r1*(alpha^2 + beta^2)
        
        question_str = "Solve the differential equation: \$y''' + $(a_coeff)y'' + $(b_coeff)y' + $(c_coeff)y = 0\$"
        answer_str = "y = C₁e^($(r1)x) + e^($(alpha)x)(C₂cos($(beta)x) + C₃sin($(beta)x))"
        
        solution_str = steps(
            "The characteristic equation is: \$r^3 + $(a_coeff)r^2 + $(b_coeff)r + $(c_coeff) = 0\$",
            "Factor: \$(r - $(r1))(r^2 - $(2*alpha)r + $(alpha^2 + beta^2)) = 0\$",
            "Real root: \$r_1 = $(r1)\$",
            "Complex roots from quadratic: \$r = $(alpha) \\pm $(beta)i\$",
            "Combine real and complex solutions:",
            sol("Answer", "y = C_1 e^{$(r1)x} + e^{$(alpha)x}(C_2 \\cos($(beta)x) + C_3 \\sin($(beta)x))")
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2200, 2400),
            solution=solution_str,
            time=280,
            answer_type="text"
        )
    end
end