# differential_equations - second_order_constant (easy)
# Generated: 2026-03-08T20:52:57.062658

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/second_order_constant")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Characteristic equation - find roots (700-900 ELO)
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        problem(
            question="Find the roots of the characteristic equation \$r^2 $(b_coef >= 0 ? "+" : "")$(b_coef)r $(c_coef >= 0 ? "+" : "")$(c_coef) = 0\$ for the differential equation \$y'' $(b_coef >= 0 ? "+" : "")$(b_coef)y' $(c_coef >= 0 ? "+" : "")$(c_coef)y = 0\$",
            answer=fmt_set(Set([r1, r2])),
            difficulty=(700, 900),
            answer_type="set",
            solution=steps(
                "The characteristic equation is \$r^2 $(b_coef >= 0 ? "+" : "")$(b_coef)r $(c_coef >= 0 ? "+" : "")$(c_coef) = 0\$",
                "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
                sol("Roots", fmt_set(Set([r1, r2])))
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Simple homogeneous solution - distinct real roots (800-1000 ELO)
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        while r2 == r1
            r2 = nonzero(-6, 6)
        end
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        ans_expr = "C_1 e^{$(r1)x} + C_2 e^{$(r2)x}"
        
        problem(
            question="Find the general solution to \$y'' $(b_coef >= 0 ? "+" : "")$(b_coef)y' $(c_coef >= 0 ? "+" : "")$(c_coef)y = 0\$",
            answer=ans_expr,
            difficulty=(800, 1000),
            answer_type="expression",
            grading_mode="exact",
            solution=steps(
                "Form the characteristic equation: \$r^2 $(b_coef >= 0 ? "+" : "")$(b_coef)r $(c_coef >= 0 ? "+" : "")$(c_coef) = 0\$",
                "Factor to get roots: \$r = $(r1), $(r2)\$",
                "Since roots are distinct and real, general solution is:",
                sol("y(x) = $(ans_expr)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Repeated roots (900-1100 ELO)
        r = nonzero(-7, 7)
        b_coef = -2*r
        c_coef = r^2
        
        ans_expr = "C_1 e^{$(r)x} + C_2 x e^{$(r)x}"
        
        problem(
            question="Find the general solution to \$y'' $(b_coef >= 0 ? "+" : "")$(b_coef)y' $(c_coef >= 0 ? "+" : "")$(c_coef)y = 0\$",
            answer=ans_expr,
            difficulty=(900, 1100),
            answer_type="expression",
            grading_mode="exact",
            solution=steps(
                "Form the characteristic equation: \$r^2 $(b_coef >= 0 ? "+" : "")$(b_coef)r $(c_coef >= 0 ? "+" : "")$(c_coef) = 0\$",
                "Factor: \$(r - $(r))^2 = 0\$, giving repeated root \$r = $(r)\$",
                "For repeated root \$r\$, general solution is:",
                sol("y(x) = $(ans_expr)")
            ),
            time=150
        )
        
    else
        # Complex roots (1000-1200 ELO)
        alpha = randint(-5, 5)
        beta = nonzero(1, 6)
        b_coef = -2*alpha
        c_coef = alpha^2 + beta^2
        
        ans_expr = "e^{$(alpha)x}(C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x))"
        
        problem(
            question="Find the general solution to \$y'' $(b_coef >= 0 ? "+" : "")$(b_coef)y' $(c_coef >= 0 ? "+" : "")$(c_coef)y = 0\$",
            answer=ans_expr,
            difficulty=(1000, 1200),
            answer_type="expression",
            grading_mode="exact",
            solution=steps(
                "Form the characteristic equation: \$r^2 $(b_coef >= 0 ? "+" : "")$(b_coef)r $(c_coef >= 0 ? "+" : "")$(c_coef) = 0\$",
                "Using quadratic formula: \$r = $(alpha) \\pm $(beta)i\$",
                "Complex roots \$\\alpha \\pm \\beta i\$ give solution \$e^{\\alpha x}(C_1 \\cos(\\beta x) + C_2 \\sin(\\beta x))\$",
                sol("y(x) = $(ans_expr)")
            ),
            time=180
        )
    end
end