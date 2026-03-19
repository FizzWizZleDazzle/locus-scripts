# differential_equations - second_order_constant (hard)
# Generated: 2026-03-08T20:53:20.183845

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/second_order_constant")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Characteristic equation with distinct real roots
        r1 = randint(-8, -1)
        r2 = randint(1, 8)
        while r2 == -r1
            r2 = randint(1, 8)
        end
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        general_solution = "y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}"
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        problem(
            question="Solve the second-order linear homogeneous differential equation: \$$(diff_eq)\$",
            answer=general_solution,
            difficulty=(1800, 2000),
            answer_type="text",
            solution=steps(
                "Given: \$$(diff_eq)\$",
                "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
                "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
                "Roots: \$r_1 = $(r1), r_2 = $(r2)\$ (distinct real roots)",
                sol("General solution", general_solution)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Characteristic equation with repeated real root
        r = randint(-6, 6)
        while r == 0
            r = randint(-6, 6)
        end
        
        b_coeff = -2*r
        c_coeff = r^2
        
        general_solution = "y = C_1 e^{$(r)x} + C_2 x e^{$(r)x}"
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        problem(
            question="Solve the second-order linear homogeneous differential equation: \$$(diff_eq)\$",
            answer=general_solution,
            difficulty=(1900, 2100),
            answer_type="text",
            solution=steps(
                "Given: \$$(diff_eq)\$",
                "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
                "Factor: \$(r - $(r))^2 = 0\$",
                "Repeated root: \$r = $(r)\$ (multiplicity 2)",
                sol("General solution", general_solution)
            ),
            time=200
        )
        
    elseif problem_type == 3
        # Complex conjugate roots
        alpha = randint(-5, 5)
        beta = randint(2, 8)
        
        b_coeff = -2*alpha
        c_coeff = alpha^2 + beta^2
        
        if alpha == 0
            general_solution = "y = C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x)"
        else
            general_solution = "y = e^{$(alpha)x}(C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x))"
        end
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        problem(
            question="Solve the second-order linear homogeneous differential equation: \$$(diff_eq)\$",
            answer=general_solution,
            difficulty=(2000, 2200),
            answer_type="text",
            solution=steps(
                "Given: \$$(diff_eq)\$",
                "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
                "Use quadratic formula: \$r = \\frac{$(- b_coeff) \\pm \\sqrt{$(b_coeff^2) - $(4*c_coeff)}}{2}\$",
                "Complex roots: \$r = $(alpha) \\pm $(beta)i\$",
                sol("General solution", general_solution)
            ),
            time=220
        )
        
    elseif problem_type == 4
        # IVP with distinct real roots
        r1 = randint(-6, -1)
        r2 = randint(1, 6)
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        y0 = randint(-8, 8)
        yp0 = randint(-15, 15)
        
        C1 = (yp0 - r2*y0) // (r1 - r2)
        C2 = (yp0 - r1*y0) // (r2 - r1)
        
        if C1 == 0 && C2 == 0
            C1 = 1
            C2 = 1
            y0 = C1 + C2
            yp0 = r1*C1 + r2*C2
        end
        
        particular_solution = "y = "
        if C1 != 0
            particular_solution *= "$(C1)e^{$(r1)x}"
        end
        if C2 != 0
            if C1 != 0
                particular_solution *= C2 > 0 ? " + " : " - "
                particular_solution *= "$(abs(C2))e^{$(r2)x}"
            else
                particular_solution *= "$(C2)e^{$(r2)x}"
            end
        end
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        problem(
            question="Solve the initial value problem: \$$(diff_eq)\$, \$y(0) = $(y0)\$, \$y'(0) = $(yp0)\$",
            answer=particular_solution,
            difficulty=(2100, 2300),
            answer_type="text",
            solution=steps(
                "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
                "Roots: \$r_1 = $(r1), r_2 = $(r2)\$",
                "General solution: \$y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}\$",
                "Apply initial conditions: \$y(0) = C_1 + C_2 = $(y0)\$, \$y'(0) = $(r1)C_1 + $(r2)C_2 = $(yp0)\$",
                "Solve system: \$C_1 = $(C1), C_2 = $(C2)\$",
                sol("Particular solution", particular_solution)
            ),
            time=240
        )
        
    else
        # IVP with complex roots
        alpha = randint(-3, 3)
        beta = randint(2, 6)
        
        b_coeff = -2*alpha
        c_coeff = alpha^2 + beta^2
        
        y0 = randint(-8, 8)
        yp0 = randint(-12, 12)
        
        C1 = y0
        C2 = (yp0 - alpha*y0) // beta
        
        if C1 == 0 && C2 == 0
            C1 = 1
            C2 = 1
            y0 = C1
            yp0 = alpha*C1 + beta*C2
        end
        
        if alpha == 0
            particular_solution = "y = $(C1)\\cos($(beta)x)"
            if C2 != 0
                particular_solution *= C2 > 0 ? " + " : " - "
                particular_solution *= "$(abs(C2))\\sin($(beta)x)"
            end
        else
            particular_solution = "y = e^{$(alpha)x}($(C1)\\cos($(beta)x)"
            if C2 != 0
                particular_solution *= C2 > 0 ? " + " : " - "
                particular_solution *= "$(abs(C2))\\sin($(beta)x))"
            else
                particular_solution *= ")"
            end
        end
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        problem(
            question="Solve the initial value problem: \$$(diff_eq)\$, \$y(0) = $(y0)\$, \$y'(0) = $(yp0)\$",
            answer=particular_solution,
            difficulty=(2200, 2400),
            answer_type="text",
            solution=steps(
                "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
                "Complex roots: \$r = $(alpha) \\pm $(beta)i\$",
                alpha == 0 ? "General solution: \$y = C_1\\cos($(beta)x) + C_2\\sin($(beta)x)\$" : "General solution: \$y = e^{$(alpha)x}(C_1\\cos($(beta)x) + C_2\\sin($(beta)x))\$",
                "Apply \$y(0) = $(y0)\$: \$C_1 = $(C1)\$",
                "Apply \$y'(0) = $(yp0)\$: \$C_2 = $(C2)\$",
                sol("Particular solution", particular_solution)
            ),
            time=260
        )
    end
end