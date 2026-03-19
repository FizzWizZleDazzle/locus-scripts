# differential_equations - second_order_constant (medium)
# Generated: 2026-03-08T20:53:08.173984

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/second_order_constant")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Homogeneous with distinct real roots
        r1 = randint(-6, -1)
        r2 = randint(1, 6)
        while r2 == -r1
            r2 = randint(1, 6)
        end
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        general_sol = "y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}"
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$",
            "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
            "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
            "Roots: \$r_1 = $(r1), r_2 = $(r2)\$",
            "Since roots are distinct and real, general solution:",
            sol("Answer", general_sol)
        )
        
        problem(
            question="Find the general solution to the differential equation: \$$(diff_eq)\$",
            answer=general_sol,
            difficulty=(1200, 1400),
            solution=solution_steps,
            time=120
        )
        
    elseif problem_type == 2
        # Homogeneous with repeated real roots
        r = randint(-5, 5)
        while r == 0
            r = randint(-5, 5)
        end
        
        b_coeff = -2*r
        c_coeff = r^2
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        general_sol = "y = C_1 e^{$(r)x} + C_2 x e^{$(r)x}"
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$",
            "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
            "Factor: \$(r - $(r))^2 = 0\$",
            "Repeated root: \$r = $(r)\$",
            "For repeated roots, general solution:",
            sol("Answer", general_sol)
        )
        
        problem(
            question="Find the general solution to the differential equation: \$$(diff_eq)\$",
            answer=general_sol,
            difficulty=(1300, 1500),
            solution=solution_steps,
            time=150
        )
        
    elseif problem_type == 3
        # Homogeneous with complex roots
        alpha = randint(-4, 4)
        beta = randint(2, 6)
        
        b_coeff = -2*alpha
        c_coeff = alpha^2 + beta^2
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        if alpha == 0
            general_sol = "y = C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x)"
        else
            general_sol = "y = e^{$(alpha)x}(C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x))"
        end
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$",
            "Characteristic equation: \$r^2 $(b_coeff >= 0 ? "+" : "")$(b_coeff)r $(c_coeff >= 0 ? "+" : "")$(c_coeff) = 0\$",
            "Using quadratic formula: \$r = \\frac{$(−b_coeff) \\pm \\sqrt{$(b_coeff^2 - 4*c_coeff)}}{2}\$",
            "Complex roots: \$r = $(alpha) \\pm $(beta)i\$",
            "For complex roots \$\\alpha \\pm \\beta i\$:",
            sol("Answer", general_sol)
        )
        
        problem(
            question="Find the general solution to the differential equation: \$$(diff_eq)\$",
            answer=general_sol,
            difficulty=(1400, 1600),
            solution=solution_steps,
            time=180
        )
        
    else
        # Initial value problem with distinct real roots
        r1 = randint(-5, -1)
        r2 = randint(1, 5)
        while r2 == -r1
            r2 = randint(1, 5)
        end
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        y0 = randint(-10, 10)
        yp0 = randint(-10, 10)
        
        # Solve for C1 and C2
        # y(0) = C1 + C2 = y0
        # y'(0) = r1*C1 + r2*C2 = yp0
        # C1 = (yp0 - r2*y0)/(r1 - r2)
        # C2 = y0 - C1
        
        c1_num = yp0 - r2*y0
        c1_den = r1 - r2
        c1 = c1_num // c1_den
        c2 = y0 - c1
        
        diff_eq = "y'' $(b_coeff >= 0 ? "+" : "")$(b_coeff)y' $(c_coeff >= 0 ? "+" : "")$(c_coeff)y = 0"
        
        particular_sol = "y = $(c1)e^{$(r1)x} $(c2 >= 0 ? "+" : "")$(c2)e^{$(r2)x}"
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$, \$y(0) = $(y0)\$, \$y'(0) = $(yp0)\$",
            "Characteristic equation gives roots: \$r_1 = $(r1), r_2 = $(r2)\$",
            "General solution: \$y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}\$",
            "Apply initial conditions:",
            "\$y(0) = C_1 + C_2 = $(y0)\$",
            "\$y'(0) = $(r1)C_1 + $(r2)C_2 = $(yp0)\$",
            "Solving system: \$C_1 = $(c1), C_2 = $(c2)\$",
            sol("Answer", particular_sol)
        )
        
        problem(
            question="Solve the initial value problem: \$$(diff_eq)\$, \$y(0) = $(y0)\$, \$y'(0) = $(yp0)\$",
            answer=particular_sol,
            difficulty=(1500, 1800),
            solution=solution_steps,
            time=240
        )
    end
end