# differential_equations - variation_of_parameters (medium)
# Generated: 2026-03-08T20:55:46.288015

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/variation_of_parameters")
    
    # Choose problem type
    problem_type = choice(1:3)
    
    if problem_type == 1
        # Second-order linear ODE: y'' + p*y' + q*y = g(t)
        # Use variation of parameters for simple forcing functions
        
        # Start with clean characteristic roots for homogeneous solution
        r1 = randint(-4, 4)
        r2 = randint(-4, 4)
        
        while r1 == r2
            r2 = randint(-4, 4)
        end
        
        # Construct coefficients from roots: (D-r1)(D-r2) = D^2 - (r1+r2)D + r1*r2
        p_coef = -(r1 + r2)
        q_coef = r1 * r2
        
        # Choose a simple forcing function
        force_type = choice(1:3)
        
        if force_type == 1
            # Exponential forcing e^(at)
            a = nonzero(-3, 3)
            while a == r1 || a == r2  # Avoid resonance for simplicity
                a = nonzero(-3, 3)
            end
            g_expr = "e^{$(a)t}"
            g_desc = "exponential"
        elseif force_type == 2
            # Polynomial forcing
            deg = choice([0, 1])
            if deg == 0
                k = nonzero(-8, 8)
                g_expr = "$(k)"
                g_desc = "constant"
            else
                k = nonzero(-5, 5)
                g_expr = "$(k)t"
                g_desc = "linear"
            end
        else
            # Trigonometric forcing
            omega = choice([1, 2, 3])
            A = nonzero(-6, 6)
            trig_fn = choice(["\\sin", "\\cos"])
            g_expr = "$(A)$(trig_fn)($(omega)t)"
            g_desc = "trigonometric"
        end
        
        # Construct the ODE
        ode_str = "y'' "
        if p_coef > 0
            ode_str *= "+ $(p_coef)y' "
        elseif p_coef < 0
            ode_str *= "- $(-p_coef)y' "
        end
        
        if q_coef > 0
            ode_str *= "+ $(q_coef)y "
        elseif q_coef < 0
            ode_str *= "- $(-q_coef)y "
        end
        
        ode_str *= "= $(g_expr)"
        
        # The homogeneous solution
        if r1 != r2
            y_h = "y_h = C_1 e^{$(r1)t} + C_2 e^{$(r2)t}"
        else
            y_h = "y_h = C_1 e^{$(r1)t} + C_2 t e^{$(r1)t}"
        end
        
        question = "Use variation of parameters to find the general solution to the differential equation: \$\$$(ode_str)\$\$"
        
        answer_desc = "General solution using variation of parameters"
        
        solution_steps = steps(
            "**Step 1**: Find the homogeneous solution",
            "Characteristic equation: \$r^2 $(p_coef >= 0 ? "+" : "")$(p_coef)r $(q_coef >= 0 ? "+" : "")$(q_coef) = 0\$",
            "Roots: \$r_1 = $(r1), r_2 = $(r2)\$",
            "Homogeneous solution: \$$(y_h)\$",
            "**Step 2**: Apply variation of parameters",
            "Let \$y_p = u_1(t)e^{$(r1)t} + u_2(t)e^{$(r2)t}\$ where \$u_1\$ and \$u_2\$ satisfy:",
            "\$u_1'y_1 + u_2'y_2 = 0\$ and \$u_1'y_1' + u_2'y_2' = g(t)\$",
            "**Step 3**: Solve for \$u_1'\$ and \$u_2'\$ using Wronskian",
            "Compute \$W = y_1 y_2' - y_2 y_1'\$, then integrate to find \$u_1\$ and \$u_2\$",
            "**Step 4**: Construct particular solution \$y_p\$ and combine",
            "General solution: \$y = y_h + y_p\$"
        )
        
        difficulty_level = (1300, 1700)
        time_seconds = 240
        
    elseif problem_type == 2
        # First-order linear ODE: y' + p(t)y = g(t) using variation of parameters
        
        p_val = nonzero(-4, 4)
        k = nonzero(-8, 8)
        
        force_choice = choice(1:2)
        if force_choice == 1
            g_expr = "$(k)"
            g_desc = "constant"
        else
            g_expr = "$(k)t"
            g_desc = "linear"
        end
        
        ode_str = "y' "
        if p_val > 0
            ode_str *= "+ $(p_val)y = $(g_expr)"
        else
            ode_str *= "- $(-p_val)y = $(g_expr)"
        end
        
        question = "Use variation of parameters to solve: \$\$$(ode_str)\$\$"
        
        answer_desc = "General solution using variation of parameters"
        
        solution_steps = steps(
            "**Step 1**: Find integrating factor or homogeneous solution",
            "Homogeneous equation: \$y' $(p_val > 0 ? "+" : "-") $(abs(p_val))y = 0\$",
            "Solution: \$y_h = Ce^{$(-p_val)t}\$",
            "**Step 2**: Apply variation of parameters",
            "Let \$y = u(t)e^{$(-p_val)t}\$ and substitute into original ODE",
            "**Step 3**: Solve for \$u'(t)\$",
            "Find \$u'(t) = $(g_expr)e^{$(p_val)t}\$ and integrate",
            "**Step 4**: Construct general solution",
            "Combine \$y_h\$ and particular solution to get general solution"
        )
        
        difficulty_level = (1200, 1500)
        time_seconds = 180
        
    else
        # Standard second-order with specific forcing - setup problem
        
        # Use simple characteristic roots
        r1 = choice([-2, -1, 1, 2])
        r2 = choice([-3, -2, -1, 1, 2, 3])
        
        while r1 == r2
            r2 = choice([-3, -2, -1, 1, 2, 3])
        end
        
        p_coef = -(r1 + r2)
        q_coef = r1 * r2
        
        # Use te^t or t*sin(t) forcing to require variation of parameters
        vop_type = choice(1:2)
        
        if vop_type == 1
            a = choice([1, 2])
            g_expr = "te^{$(a)t}"
        else
            omega = choice([1, 2])
            g_expr = "t\\sin($(omega)t)"
        end
        
        ode_str = "y'' "
        if p_coef > 0
            ode_str *= "+ $(p_coef)y' "
        elseif p_coef < 0
            ode_str *= "- $(-p_coef)y' "
        end
        
        if q_coef > 0
            ode_str *= "+ $(q_coef)y "
        elseif q_coef < 0
            ode_str *= "- $(-q_coef)y "
        end
        
        ode_str *= "= $(g_expr)"
        
        question = "Set up the variation of parameters formula for finding a particular solution to: \$\$$(ode_str)\$\$ Given that the homogeneous solution is \$y_h = C_1 e^{$(r1)t} + C_2 e^{$(r2)t}\$, write the expressions for \$u_1'(t)\$ and \$u_2'(t)\$."
        
        answer_desc = "Expressions for u₁'(t) and u₂'(t) in variation of parameters"
        
        solution_steps = steps(
            "**Step 1**: Identify fundamental solutions",
            "\$y_1 = e^{$(r1)t}\$ and \$y_2 = e^{$(r2)t}\$",
            "**Step 2**: Compute Wronskian",
            "\$W(y_1, y_2) = y_1 y_2' - y_2 y_1' = $(r2 - r1)e^{$(r1 + r2)t}\$",
            "**Step 3**: Apply variation of parameters formulas",
            "\$u_1'(t) = -\\frac{y_2 g(t)}{W}\$ and \$u_2'(t) = \\frac{y_1 g(t)}{W}\$",
            "**Step 4**: Substitute and simplify",
            "Substitute \$g(t) = $(g_expr)\$ and the Wronskian to get explicit expressions"
        )
        
        difficulty_level = (1400, 1700)
        time_seconds = 210
    end
    
    problem(
        question=question,
        answer=answer_desc,
        difficulty=difficulty_level,
        solution=solution_steps,
        answer_type="expression",
        time=time_seconds,
        grading_mode="proof"
    )
end