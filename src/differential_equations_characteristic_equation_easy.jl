# differential_equations - characteristic_equation (easy)
# Generated: 2026-03-08T20:53:41.558969

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/characteristic_equation")
    
    # Randomly choose problem type
    problem_type = choice(["distinct_real", "repeated_real", "complex"])
    
    if problem_type == "distinct_real"
        # Distinct real roots: y'' + by' + c*y = 0
        # Choose two distinct roots r1, r2
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        while r2 == r1
            r2 = randint(-8, 8)
        end
        
        # Characteristic equation: (m - r1)(m - r2) = 0
        # Expands to: m^2 - (r1+r2)m + r1*r2 = 0
        b = -(r1 + r2)
        c = r1 * r2
        
        # Differential equation: y'' + by' + cy = 0
        @variables y(t) m
        
        de_str = "y'' "
        if b >= 0
            de_str *= "+ $(b)y' "
        else
            de_str *= "- $(abs(b))y' "
        end
        if c >= 0
            de_str *= "+ $(c)y = 0"
        else
            de_str *= "- $(abs(c))y = 0"
        end
        
        char_eq_str = "m^2 "
        if b >= 0
            char_eq_str *= "+ $(b)m "
        else
            char_eq_str *= "- $(abs(b))m "
        end
        if c >= 0
            char_eq_str *= "+ $(c) = 0"
        else
            char_eq_str *= "- $(abs(c)) = 0"
        end
        
        solution_str = "y(t) = C_1 e^{$(r1)t} + C_2 e^{$(r2)t}"
        
        problem(
            question="Find the general solution to the differential equation: \$$(de_str)\$",
            answer=solution_str,
            difficulty=(800, 1000),
            solution=steps(
                "Write the characteristic equation: \$$(char_eq_str)\$",
                "Factor: \$(m - $(r1))(m - $(r2)) = 0\$",
                "Roots: \$m_1 = $(r1), m_2 = $(r2)\$",
                sol("General solution", solution_str)
            ),
            time=90
        )
        
    elseif problem_type == "repeated_real"
        # Repeated real root: y'' + by' + c*y = 0
        # Choose a repeated root r
        r = randint(-7, 7)
        
        # Characteristic equation: (m - r)^2 = 0
        # Expands to: m^2 - 2r*m + r^2 = 0
        b = -2*r
        c = r^2
        
        @variables y(t) m
        
        de_str = "y'' "
        if b >= 0
            de_str *= "+ $(b)y' "
        else
            de_str *= "- $(abs(b))y' "
        end
        if c >= 0
            de_str *= "+ $(c)y = 0"
        else
            de_str *= "- $(abs(c))y = 0"
        end
        
        char_eq_str = "m^2 "
        if b >= 0
            char_eq_str *= "+ $(b)m "
        else
            char_eq_str *= "- $(abs(b))m "
        end
        if c >= 0
            char_eq_str *= "+ $(c) = 0"
        else
            char_eq_str *= "- $(abs(c)) = 0"
        end
        
        solution_str = "y(t) = C_1 e^{$(r)t} + C_2 t e^{$(r)t}"
        
        problem(
            question="Find the general solution to the differential equation: \$$(de_str)\$",
            answer=solution_str,
            difficulty=(900, 1100),
            solution=steps(
                "Write the characteristic equation: \$$(char_eq_str)\$",
                "Factor: \$(m - $(r))^2 = 0\$",
                "Repeated root: \$m = $(r)\$ (multiplicity 2)",
                sol("General solution", solution_str)
            ),
            time=100
        )
        
    else  # complex roots
        # Complex roots: y'' + by' + c*y = 0
        # Choose alpha and beta for roots alpha ± beta*i
        alpha = randint(-5, 5)
        beta = randint(1, 6)  # beta > 0 for complex
        
        # Characteristic equation roots: alpha ± beta*i
        # m^2 - 2*alpha*m + (alpha^2 + beta^2) = 0
        b = -2*alpha
        c = alpha^2 + beta^2
        
        @variables y(t) m
        
        de_str = "y'' "
        if b >= 0
            de_str *= "+ $(b)y' "
        else
            de_str *= "- $(abs(b))y' "
        end
        de_str *= "+ $(c)y = 0"
        
        char_eq_str = "m^2 "
        if b >= 0
            char_eq_str *= "+ $(b)m "
        else
            char_eq_str *= "- $(abs(b))m "
        end
        char_eq_str *= "+ $(c) = 0"
        
        if alpha == 0
            solution_str = "y(t) = C_1 \\cos($(beta)t) + C_2 \\sin($(beta)t)"
        else
            solution_str = "y(t) = e^{$(alpha)t}(C_1 \\cos($(beta)t) + C_2 \\sin($(beta)t))"
        end
        
        roots_str = if alpha >= 0
            "m = $(alpha) \\pm $(beta)i"
        else
            "m = -$(abs(alpha)) \\pm $(beta)i"
        end
        
        problem(
            question="Find the general solution to the differential equation: \$$(de_str)\$",
            answer=solution_str,
            difficulty=(1000, 1200),
            solution=steps(
                "Write the characteristic equation: \$$(char_eq_str)\$",
                "Use quadratic formula to find complex roots",
                "Roots: \$$(roots_str)\$",
                "For complex roots \$\\alpha \\pm \\beta i\$: \$\\alpha = $(alpha), \\beta = $(beta)\$",
                sol("General solution", solution_str)
            ),
            time=120
        )
    end
end