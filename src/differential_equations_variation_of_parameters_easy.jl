# differential_equations - variation_of_parameters (easy)
# Generated: 2026-03-08T20:55:33.914073

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/variation_of_parameters")
    
    # Pick difficulty within PRE-COMPETENT to BEGINNER range (700-1200)
    difficulty_level = randint(700, 1200)
    
    if difficulty_level < 850
        # Simplest: second-order homogeneous with constant coefficients
        # Find homogeneous solution only (variation of parameters setup)
        r1 = randint(-5, 5)
        r2 = randint(-5, 5)
        while r2 == r1
            r2 = randint(-5, 5)
        end
        
        # Characteristic equation has roots r1, r2
        # So differential equation is y'' - (r1+r2)y' + r1*r2*y = 0
        a = 1
        b = -(r1 + r2)
        c = r1 * r2
        
        if r1 != r2
            y_h = "C_1 e^{$(r1)x} + C_2 e^{$(r2)x}"
        else
            y_h = "(C_1 + C_2 x) e^{$(r1)x}"
        end
        
        eq_str = "y'' "
        if b >= 0
            eq_str *= "+ $(b)y' "
        else
            eq_str *= "$(b)y' "
        end
        if c >= 0
            eq_str *= "+ $(c)y "
        else
            eq_str *= "$(c)y "
        end
        eq_str *= "= 0"
        
        problem(
            question="Find the homogeneous solution to the differential equation: \$$(eq_str)\$",
            answer=y_h,
            difficulty=(700, 850),
            answer_type="text",
            solution=steps(
                "Write the characteristic equation: \$r^2 $(b >= 0 ? "+" : "")$(b)r $(c >= 0 ? "+" : "")$(c) = 0\$",
                "Factor or solve: \$(r - $(r1))(r - $(r2)) = 0\$",
                "Roots are \$r_1 = $(r1), r_2 = $(r2)\$",
                sol("Homogeneous solution", y_h)
            ),
            time=120
        )
        
    elseif difficulty_level < 1000
        # Medium: identify y_1 and y_2 for variation of parameters
        r1 = randint(-4, 4)
        r2 = randint(-4, 4)
        while r2 == r1
            r2 = randint(-4, 4)
        end
        
        a = 1
        b = -(r1 + r2)
        c = r1 * r2
        
        y1_str = "e^{$(r1)x}"
        y2_str = "e^{$(r2)x}"
        
        eq_str = "y'' "
        if b >= 0
            eq_str *= "+ $(b)y' "
        else
            eq_str *= "$(b)y' "
        end
        if c >= 0
            eq_str *= "+ $(c)y "
        else
            eq_str *= "$(c)y "
        end
        
        g_term = choice(["e^x", "x", "\\sin(x)", "\\cos(x)", "x^2"])
        eq_str *= "= $(g_term)"
        
        y_p_form = "u_1(x) $(y1_str) + u_2(x) $(y2_str)"
        
        problem(
            question="For the differential equation \$$(eq_str)\$, what form should the particular solution take using variation of parameters?",
            answer=y_p_form,
            difficulty=(850, 1000),
            answer_type="text",
            solution=steps(
                "First solve the homogeneous equation: \$y'' $(b >= 0 ? "+" : "")$(b)y' $(c >= 0 ? "+" : "")$(c)y = 0\$",
                "The homogeneous solutions are \$y_1 = $(y1_str)\$ and \$y_2 = $(y2_str)\$",
                "For variation of parameters, the particular solution has form:",
                sol("y_p", y_p_form)
            ),
            time=150
        )
        
    else
        # Harder: compute Wronskian for variation of parameters
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        while r2 == r1
            r2 = nonzero(-3, 3)
        end
        
        y1_str = "e^{$(r1)x}"
        y2_str = "e^{$(r2)x}"
        
        # Wronskian W = y1*y2' - y2*y1'
        # y1 = e^{r1*x}, y1' = r1*e^{r1*x}
        # y2 = e^{r2*x}, y2' = r2*e^{r2*x}
        # W = e^{r1*x} * r2*e^{r2*x} - e^{r2*x} * r1*e^{r1*x}
        # W = r2*e^{(r1+r2)x} - r1*e^{(r1+r2)x}
        # W = (r2 - r1)*e^{(r1+r2)x}
        
        w_coeff = r2 - r1
        w_exp = r1 + r2
        
        if w_exp == 0
            w_str = "$(w_coeff)"
        elseif w_exp == 1
            w_str = "$(w_coeff)e^{x}"
        else
            w_str = "$(w_coeff)e^{$(w_exp)x}"
        end
        
        problem(
            question="Compute the Wronskian \$W(y_1, y_2)\$ where \$y_1 = $(y1_str)\$ and \$y_2 = $(y2_str)\$",
            answer=w_str,
            difficulty=(1000, 1200),
            answer_type="text",
            solution=steps(
                "The Wronskian is \$W = y_1 y_2' - y_2 y_1'\$",
                "Compute derivatives: \$y_1' = $(r1)$(y1_str)\$ and \$y_2' = $(r2)$(y2_str)\$",
                "Substitute: \$W = $(y1_str) \\cdot $(r2)$(y2_str) - $(y2_str) \\cdot $(r1)$(y1_str)\$",
                "Simplify: \$W = $(r2)e^{$(r1+r2)x} - $(r1)e^{$(r1+r2)x} = $(w_coeff)e^{$(r1+r2)x}\$",
                sol("Wronskian", w_str)
            ),
            time=180
        )
    end
end