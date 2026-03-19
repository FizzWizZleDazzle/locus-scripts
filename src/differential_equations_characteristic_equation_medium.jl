# differential_equations - characteristic_equation (medium)
# Generated: 2026-03-08T20:53:54.519881

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/characteristic_equation")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Second-order homogeneous with distinct real roots
        # ay'' + by' + cy = 0
        # Pick roots r1, r2, construct characteristic polynomial
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        while r2 == r1
            r2 = randint(-8, 8)
        end
        
        # Characteristic equation: (r - r1)(r - r2) = 0
        # r^2 - (r1+r2)r + r1*r2 = 0
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        a_coeff = 1
        
        # General solution: y = C1*e^(r1*x) + C2*e^(r2*x)
        if r1 < r2
            ans = "C_1 e^{$(r1)x} + C_2 e^{$(r2)x}"
        else
            ans = "C_1 e^{$(r2)x} + C_2 e^{$(r1)x}"
        end
        
        de_str = a_coeff == 1 ? "y'' " : "$(a_coeff)y'' "
        de_str *= b_coeff >= 0 ? "+ $(b_coeff)y' " : "- $(-b_coeff)y' "
        de_str *= c_coeff >= 0 ? "+ $(c_coeff)y = 0" : "- $(-c_coeff)y = 0"
        
        char_eq = "r^2"
        char_eq *= b_coeff >= 0 ? " + $(b_coeff)r" : " - $(-b_coeff)r"
        char_eq *= c_coeff >= 0 ? " + $(c_coeff) = 0" : " - $(-c_coeff) = 0"
        
        problem(
            question="Solve the differential equation using the characteristic equation method: \$$(de_str)\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="text",
            solution=steps(
                "The characteristic equation is: \$$(char_eq)\$",
                "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
                "Roots: \$r_1 = $(min(r1,r2)), r_2 = $(max(r1,r2))\$",
                "Since the roots are distinct and real, the general solution is:",
                sol("y = $(ans)")
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Second-order with repeated real root
        # ay'' + by' + cy = 0 where discriminant = 0
        # Pick root r, construct (r - r)^2 = r^2 - 2rr + r^2
        r = randint(-6, 6)
        
        b_coeff = -2 * r
        c_coeff = r * r
        a_coeff = 1
        
        ans = "C_1 e^{$(r)x} + C_2 x e^{$(r)x}"
        
        de_str = a_coeff == 1 ? "y'' " : "$(a_coeff)y'' "
        de_str *= b_coeff >= 0 ? "+ $(b_coeff)y' " : "- $(-b_coeff)y' "
        de_str *= c_coeff >= 0 ? "+ $(c_coeff)y = 0" : "- $(-c_coeff)y = 0"
        
        char_eq = "r^2"
        char_eq *= b_coeff >= 0 ? " + $(b_coeff)r" : " - $(-b_coeff)r"
        char_eq *= c_coeff >= 0 ? " + $(c_coeff) = 0" : " - $(-c_coeff) = 0"
        
        problem(
            question="Solve the differential equation using the characteristic equation method: \$$(de_str)\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "The characteristic equation is: \$$(char_eq)\$",
                "Factor: \$(r - $(r))^2 = 0\$",
                "Repeated root: \$r = $(r)\$ (multiplicity 2)",
                "For repeated roots, the general solution is:",
                sol("y = $(ans)")
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Second-order with complex roots
        # r = α ± βi
        alpha = randint(-5, 5)
        beta = nonzero(1, 6)
        
        # (r - (α + βi))(r - (α - βi)) = r^2 - 2αr + (α^2 + β^2)
        b_coeff = -2 * alpha
        c_coeff = alpha^2 + beta^2
        a_coeff = 1
        
        ans = "e^{$(alpha)x}(C_1 \\cos($(beta)x) + C_2 \\sin($(beta)x))"
        
        de_str = a_coeff == 1 ? "y'' " : "$(a_coeff)y'' "
        de_str *= b_coeff >= 0 ? "+ $(b_coeff)y' " : "- $(-b_coeff)y' "
        de_str *= c_coeff >= 0 ? "+ $(c_coeff)y = 0" : "- $(-c_coeff)y = 0"
        
        char_eq = "r^2"
        char_eq *= b_coeff >= 0 ? " + $(b_coeff)r" : " - $(-b_coeff)r"
        char_eq *= c_coeff >= 0 ? " + $(c_coeff) = 0" : " - $(-c_coeff) = 0"
        
        problem(
            question="Solve the differential equation using the characteristic equation method: \$$(de_str)\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="text",
            solution=steps(
                "The characteristic equation is: \$$(char_eq)\$",
                "Using the quadratic formula: \$r = \\frac{$(−b_coeff) \\pm \\sqrt{$(b_coeff^2) - $(4*c_coeff)}}{2}\$",
                "Simplify: \$r = $(alpha) \\pm $(beta)i\$",
                "For complex roots \$r = \\alpha \\pm \\beta i\$, the general solution is:",
                sol("y = $(ans)")
            ),
            time=180
        )
        
    else
        # Higher difficulty: finding characteristic equation from distinct real roots
        r1 = randint(-7, 7)
        r2 = randint(-7, 7)
        r3 = randint(-7, 7)
        while r2 == r1
            r2 = randint(-7, 7)
        end
        while r3 == r1 || r3 == r2
            r3 = randint(-7, 7)
        end
        
        # Third order: (r - r1)(r - r2)(r - r3) = 0
        # Expand to get coefficients
        b_coeff = -(r1 + r2 + r3)
        c_coeff = r1*r2 + r1*r3 + r2*r3
        d_coeff = -r1*r2*r3
        
        roots_sorted = sort([r1, r2, r3])
        ans = "C_1 e^{$(roots_sorted[1])x} + C_2 e^{$(roots_sorted[2])x} + C_3 e^{$(roots_sorted[3])x}"
        
        de_str = "y''' "
        de_str *= b_coeff >= 0 ? "+ $(b_coeff)y'' " : "- $(-b_coeff)y'' "
        de_str *= c_coeff >= 0 ? "+ $(c_coeff)y' " : "- $(-c_coeff)y' "
        de_str *= d_coeff >= 0 ? "+ $(d_coeff)y = 0" : "- $(-d_coeff)y = 0"
        
        char_eq = "r^3"
        char_eq *= b_coeff >= 0 ? " + $(b_coeff)r^2" : " - $(-b_coeff)r^2"
        char_eq *= c_coeff >= 0 ? " + $(c_coeff)r" : " - $(-c_coeff)r"
        char_eq *= d_coeff >= 0 ? " + $(d_coeff) = 0" : " - $(-d_coeff) = 0"
        
        problem(
            question="Solve the third-order differential equation using the characteristic equation method: \$$(de_str)\$",
            answer=ans,
            difficulty=(1500, 1800),
            answer_type="text",
            solution=steps(
                "The characteristic equation is: \$$(char_eq)\$",
                "Factor: \$(r - $(r1))(r - $(r2))(r - $(r3)) = 0\$",
                "Roots: \$r_1 = $(roots_sorted[1]), r_2 = $(roots_sorted[2]), r_3 = $(roots_sorted[3])\$",
                "Since all roots are distinct and real, the general solution is:",
                sol("y = $(ans)")
            ),
            time=240
        )
    end
end