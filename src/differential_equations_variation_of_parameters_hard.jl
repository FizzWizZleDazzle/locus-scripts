# differential_equations - variation_of_parameters (hard)
# Generated: 2026-03-08T20:55:55.645070

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/variation_of_parameters")
    
    prob_type = choice(1:4)
    
    if prob_type == 1
        # Second-order DE: y'' + p(t)y' + q(t)y = g(t)
        # Use variation of parameters for y'' + y = sec(t) or similar
        
        variant = choice(1:3)
        
        if variant == 1
            # y'' + y = sec(t)
            yh = "c_1\\cos(t) + c_2\\sin(t)"
            y1_str = "\\cos(t)"
            y2_str = "\\sin(t)"
            g_str = "\\sec(t)"
            
            W_val = 1
            u1_expr = "-\\int \\frac{\\sin(t)\\sec(t)}{1} dt = -\\int \\tan(t) dt = \\ln|\\cos(t)|"
            u2_expr = "\\int \\frac{\\cos(t)\\sec(t)}{1} dt = \\int 1 dt = t"
            
            yp = "\\cos(t)\\ln|\\cos(t)| + t\\sin(t)"
            general_sol = "y = c_1\\cos(t) + c_2\\sin(t) + \\cos(t)\\ln|\\cos(t)| + t\\sin(t)"
            
            difficulty_val = randint(1900, 2200)
            
            question_text = "Use variation of parameters to find the general solution of \$y'' + y = \\sec(t)\$."
            
            solution_text = steps(
                "Given: \$y'' + y = \\sec(t)\$",
                "Homogeneous solution: \$y_h = $(yh)\$ with \$y_1 = $(y1_str), y_2 = $(y2_str)\$",
                "Wronskian: \$W(y_1, y_2) = $(W_val)\$",
                "Variation of parameters: \$u_1 = $(u1_expr)\$",
                "Similarly: \$u_2 = $(u2_expr)\$",
                "Particular solution: \$y_p = $(yp)\$",
                sol("General solution", general_sol)
            )
            
        elseif variant == 2
            # y'' - 2y' + y = e^t / t^2
            yh = "c_1 e^t + c_2 t e^t"
            y1_str = "e^t"
            y2_str = "te^t"
            g_str = "\\frac{e^t}{t^2}"
            
            W_val = "e^{2t}"
            u1_expr = "-\\int \\frac{te^t \\cdot e^t/t^2}{e^{2t}} dt = -\\int \\frac{1}{t} dt = -\\ln|t|"
            u2_expr = "\\int \\frac{e^t \\cdot e^t/t^2}{e^{2t}} dt = \\int \\frac{1}{t^2} dt = -\\frac{1}{t}"
            
            yp = "-e^t\\ln|t| - e^t"
            general_sol = "y = c_1 e^t + c_2 t e^t - e^t\\ln|t| - e^t"
            
            difficulty_val = randint(2000, 2300)
            
            question_text = "Use variation of parameters to find the general solution of \$y'' - 2y' + y = \\frac{e^t}{t^2}\$."
            
            solution_text = steps(
                "Given: \$y'' - 2y' + y = e^t/t^2\$",
                "Homogeneous solution: \$y_h = $(yh)\$ with \$y_1 = $(y1_str), y_2 = $(y2_str)\$",
                "Wronskian: \$W(y_1, y_2) = $(W_val)\$",
                "Variation of parameters: \$u_1 = $(u1_expr)\$",
                "Similarly: \$u_2 = $(u2_expr)\$",
                "Particular solution: \$y_p = $(yp)\$",
                sol("General solution", general_sol)
            )
            
        else
            # y'' + 4y = tan(2t)
            yh = "c_1\\cos(2t) + c_2\\sin(2t)"
            y1_str = "\\cos(2t)"
            y2_str = "\\sin(2t)"
            g_str = "\\tan(2t)"
            
            W_val = 2
            u1_expr = "-\\int \\frac{\\sin(2t)\\tan(2t)}{2} dt = \\frac{1}{4}\\ln|\\sec(2t) + \\tan(2t)| - \\frac{1}{4}\\sin(2t)"
            u2_expr = "\\int \\frac{\\cos(2t)\\tan(2t)}{2} dt = -\\frac{1}{4}\\cos(2t)"
            
            yp = "\\frac{1}{4}\\cos(2t)\\ln|\\sec(2t) + \\tan(2t)|"
            general_sol = "y = c_1\\cos(2t) + c_2\\sin(2t) + \\frac{1}{4}\\cos(2t)\\ln|\\sec(2t) + \\tan(2t)|"
            
            difficulty_val = randint(2100, 2400)
            
            question_text = "Use variation of parameters to find the general solution of \$y'' + 4y = \\tan(2t)\$."
            
            solution_text = steps(
                "Given: \$y'' + 4y = \\tan(2t)\$",
                "Homogeneous solution: \$y_h = $(yh)\$ with \$y_1 = $(y1_str), y_2 = $(y2_str)\$",
                "Wronskian: \$W(y_1, y_2) = $(W_val)\$",
                "Compute \$u_1 = $(u1_expr)\$ (integration requires careful work)",
                "Compute \$u_2 = $(u2_expr)\$",
                "Particular solution: \$y_p = $(yp)\$",
                sol("General solution", general_sol)
            )
        end
        
        answer_val = general_sol
        
    elseif prob_type == 2
        # System-based variation of parameters problem
        # y'' + a^2 y = g(t), solve using variation of parameters
        
        a_val = choice([1, 2, 3, 4])
        g_choices = [
            ("\\sec($(a_val)t)", "\\frac{\\cos($(a_val)t)\\ln|\\sec($(a_val)t) + \\tan($(a_val)t)|}{$(a_val)}"),
            ("\\csc($(a_val)t)", "\\frac{\\sin($(a_val)t)\\ln|\\csc($(a_val)t) - \\cot($(a_val)t)|}{$(a_val)}"),
            ("\\sec^2($(a_val)t)", "\\frac{\\tan($(a_val)t)}{$(a_val)}"),
        ]
        
        g_str, yp_str = choice(g_choices)
        
        yh = "c_1\\cos($(a_val)t) + c_2\\sin($(a_val)t)"
        general_sol = "y = $(yh) + $(yp_str)"
        
        difficulty_val = randint(1950, 2300)
        
        question_text = "Find the particular solution \$y_p\$ using variation of parameters for \$y'' + $(a_val^2)y = $(g_str)\$."
        
        solution_text = steps(
            "Given: \$y'' + $(a_val^2)y = $(g_str)\$",
            "Homogeneous solution: \$y_h = $(yh)\$",
            "Let \$y_1 = \\cos($(a_val)t), y_2 = \\sin($(a_val)t)\$, Wronskian: \$W = $(a_val)\$",
            "Apply variation of parameters formulas",
            "Compute \$u_1' = -\\frac{y_2 g}{W}\$ and \$u_2' = \\frac{y_1 g}{W}\$",
            "Integrate to find \$u_1\$ and \$u_2\$",
            sol("Particular solution", "y_p = $(yp_str)")
        )
        
        answer_val = yp_str
        
    elseif prob_type == 3
        # Challenging variation with exponential forcing
        # y'' - 4y' + 4y = t^(-2)e^(2t)
        
        r_val = choice([1, 2, 3])
        pow_val = choice([1, 2, 3])
        
        if r_val == 2 && pow_val == 2
            yh = "c_1 e^{2t} + c_2 t e^{2t}"
            g_str = "t^{-2}e^{2t}"
            yp = "\\frac{e^{2t}}{t}"
            general_sol = "y = c_1 e^{2t} + c_2 t e^{2t} + \\frac{e^{2t}}{t}"
        elseif r_val == 1 && pow_val == 1
            yh = "c_1 e^{t} + c_2 t e^{t}"
            g_str = "t^{-1}e^{t}"
            yp = "t e^{t}\\ln|t|"
            general_sol = "y = c_1 e^{t} + c_2 t e^{t} + t e^{t}\\ln|t|"
        else
            yh = "c_1 e^{$(r_val)t} + c_2 t e^{$(r_val)t}"
            g_str = "t^{-$(pow_val)}e^{$(r_val)t}"
            yp = "e^{$(r_val)t}f(t)"
            general_sol = "y = $(yh) + $(yp)"
        end
        
        difficulty_val = randint(2100, 2500)
        
        question_text = "Use variation of parameters to find a particular solution for \$y'' - $(2*r_val)y' + $(r_val^2)y = $(g_str)\$."
        
        solution_text = steps(
            "Given: \$y'' - $(2*r_val)y' + $(r_val^2)y = $(g_str)\$",
            "Characteristic equation: \$(r - $(r_val))^2 = 0\$ gives repeated root \$r = $(r_val)\$",
            "Homogeneous solution: \$y_h = $(yh)\$",
            "Apply variation of parameters with \$y_1 = e^{$(r_val)t}, y_2 = te^{$(r_val)t}\$",
            "Compute Wronskian and integrals \$u_1, u_2\$",
            "Combine to form particular solution",
            sol("Particular solution", "y_p = $(yp)")
        )
        
        answer_val = yp
        
    else
        # First-order DE using variation of parameters
        # y' + p(t)y = g(t)
        
        p_val = choice([1, 2, "t", "2t"])
        g_choices = ["t", "e^t", "\\sin(t)", "t^2", "\\sec(t)"]
        g_str = choice(g_choices)
        
        if p_val == 1
            integrating_factor = "e^t"
            yh = "ce^{-t}"
            if g_str == "t"
                yp = "t - 1"
                general_sol = "y = ce^{-t} + t - 1"
            elseif g_str == "e^t"
                yp = "\\frac{e^t}{2}"
                general_sol = "y = ce^{-t} + \\frac{e^t}{2}"
            else
                yp = "f(t)"
                general_sol = "y = ce^{-t} + f(t)"
            end
        else
            integrating_factor = "\\mu(t)"
            yh = "c/\\mu(t)"
            yp = "g_p(t)"
            general_sol = "y = c/\\mu(t) + g_p(t)"
        end
        
        difficulty_val = randint(1800, 2100)
        
        question_text = "Solve \$y' + $(p_val)y = $(g_str)\$ using variation of parameters (or integrating factor)."
        
        solution_text = steps(
            "Given: \$y' + $(p_val)y = $(g_str)\$",
            "This is a first-order linear DE",
            "Integrating factor: \$\\mu(t) = $(integrating_factor)\$",
            "Multiply through and integrate",
            "Apply variation of parameters or direct integration",
            sol("General solution", general_sol)
        )
        
        answer_val = general_sol
    end
    
    problem(
        question=question_text,
        answer=answer_val,
        difficulty=difficulty_val,
        solution=solution_text,
        time=randint(180, 300),
        calculator="none"
    )
end