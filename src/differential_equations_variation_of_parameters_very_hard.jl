# differential_equations - variation_of_parameters (very_hard)
# Generated: 2026-03-08T20:56:00.836002

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/variation_of_parameters")
    
    # Competition to Olympiad level: 2500-3500 ELO
    # Variation of parameters for second-order linear ODEs
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Type 1: y'' + p(x)y' + q(x)y = g(x) with exponential forcing
        # Choose characteristic equation roots
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1
            r2 = nonzero(-5, 5)
        end
        
        # Homogeneous solution: y_h = c1*e^(r1*x) + c2*e^(r2*x)
        p_coeff = -(r1 + r2)
        q_coeff = r1 * r2
        
        # Choose forcing function that creates interesting particular solution
        k = nonzero(-8, 8)
        forcing_exp = nonzero(-6, 6)
        while forcing_exp == r1 || forcing_exp == r2
            forcing_exp = nonzero(-6, 6)
        end
        
        g_expr = k * exp(forcing_exp * x)
        
        # Compute particular solution using variation of parameters
        y1 = exp(r1 * x)
        y2 = exp(r2 * x)
        
        # Wronskian W = y1*y2' - y2*y1'
        W_val = (r2 - r1) * exp((r1 + r2) * x)
        
        # u1' = -y2*g/W, u2' = y1*g/W
        # Particular solution involves integration
        
        denom = (forcing_exp - r1) * (forcing_exp - r2)
        yp_coeff = k // denom
        
        question_text = "Consider the differential equation: \$\$y'' "
        if p_coeff >= 0
            question_text *= "+ $(p_coeff)y' "
        else
            question_text *= "- $(abs(p_coeff))y' "
        end
        if q_coeff >= 0
            question_text *= "+ $(q_coeff)y "
        else
            question_text *= "- $(abs(q_coeff))y "
        end
        question_text *= "= $(tex(g_expr))\$\$ "
        question_text *= "Find the particular solution using variation of parameters, given the homogeneous solutions \$y_1 = e^{$(r1)x}\$ and \$y_2 = e^{$(r2)x}\$. Express your answer as a coefficient times \$e^{$(forcing_exp)x}\$ (ignoring the homogeneous solution)."
        
        answer_expr = yp_coeff * exp(forcing_exp * x)
        
        solution_text = steps(
            "The homogeneous solutions are \$y_1 = e^{$(r1)x}\$ and \$y_2 = e^{$(r2)x}\$",
            "Compute Wronskian: \$W = y_1 y_2' - y_2 y_1' = $(r2-r1)e^{$(r1+r2)x}\$",
            "Using variation of parameters: \$u_1' = -\\frac{y_2 g}{W}\$ and \$u_2' = \\frac{y_1 g}{W}\$",
            "After integration and simplification, the particular solution is: " * sol(answer_expr),
            "The coefficient is \$\\frac{$(k)}{$(denom)}\$"
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=(2600, 3200),
            solution=solution_text,
            time=480,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Type 2: More challenging with polynomial forcing
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1
            r2 = nonzero(-4, 4)
        end
        
        p_coeff = -(r1 + r2)
        q_coeff = r1 * r2
        
        # Polynomial forcing
        a_poly = nonzero(-10, 10)
        b_poly = randint(-15, 15)
        g_expr = a_poly * x + b_poly
        
        # For polynomial forcing with exponential homogeneous solutions,
        # particular solution is also polynomial
        yp_c1 = -p_coeff * b_poly - a_poly
        yp_c1 = yp_c1 // q_coeff
        yp_c0 = (a_poly * p_coeff + b_poly * q_coeff) // (q_coeff^2)
        
        answer_expr = yp_c1 * x + yp_c0
        
        question_text = "Solve using variation of parameters: \$\$y'' "
        if p_coeff >= 0
            question_text *= "+ $(p_coeff)y' "
        else
            question_text *= "- $(abs(p_coeff))y' "
        end
        if q_coeff >= 0
            question_text *= "+ $(q_coeff)y "
        else
            question_text *= "- $(abs(q_coeff))y "
        end
        question_text *= "= $(tex(g_expr))\$\$ "
        question_text *= "Given homogeneous solutions \$y_1 = e^{$(r1)x}\$ and \$y_2 = e^{$(r2)x}\$, find the particular solution (polynomial form only)."
        
        solution_text = steps(
            "Set up variation of parameters with \$y_1 = e^{$(r1)x}\$, \$y_2 = e^{$(r2)x}\$",
            "Wronskian: \$W = $(r2-r1)e^{$(r1+r2)x}\$",
            "For polynomial forcing with exponential homogeneous solutions, assume \$y_p = Ax + B\$",
            "Substitute and solve for coefficients using method of undetermined coefficients",
            sol("Particular solution", answer_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=(2700, 3300),
            solution=solution_text,
            time=420,
            calculator="none"
        )
        
    else
        # Type 3: Olympiad-level with trigonometric and exponential mixing
        alpha = nonzero(-3, 3)
        beta = nonzero(1, 5)
        
        # Characteristic equation: r^2 - 2*alpha*r + (alpha^2 + beta^2) = 0
        # Solutions: r = alpha ± i*beta
        # Homogeneous: y_h = e^(alpha*x)[c1*cos(beta*x) + c2*sin(beta*x)]
        
        p_coeff = -2 * alpha
        q_coeff = alpha^2 + beta^2
        
        k = nonzero(-12, 12)
        forcing_exp = nonzero(-5, 5)
        while forcing_exp == alpha
            forcing_exp = nonzero(-5, 5)
        end
        
        g_expr = k * exp(forcing_exp * x)
        
        # Particular solution when forcing doesn't match characteristic roots
        denom_val = forcing_exp^2 - 2*alpha*forcing_exp + alpha^2 + beta^2
        yp_coeff = k // denom_val
        
        answer_expr = yp_coeff * exp(forcing_exp * x)
        
        question_text = "Consider \$\$y'' "
        if p_coeff >= 0
            question_text *= "+ $(p_coeff)y' "
        else
            question_text *= "- $(abs(p_coeff))y' "
        end
        question_text *= "+ $(q_coeff)y = $(tex(g_expr))\$\$ "
        question_text *= "The characteristic equation has complex roots \$$(alpha) \\pm $(beta)i\$. "
        question_text *= "Find the particular solution using variation of parameters. Express as a coefficient times \$e^{$(forcing_exp)x}\$."
        
        solution_text = steps(
            "Characteristic roots: \$r = $(alpha) \\pm $(beta)i\$",
            "Homogeneous solutions: \$y_1 = e^{$(alpha)x}\\cos($(beta)x)\$, \$y_2 = e^{$(alpha)x}\\sin($(beta)x)\$",
            "Apply variation of parameters formula with Wronskian \$W = $(beta)e^{$(2*alpha)x}\$",
            "Integrate \$u_1' = -\\frac{y_2 g}{W}\$ and \$u_2' = \\frac{y_1 g}{W}\$",
            "After extensive integration and simplification:",
            sol("Particular solution", answer_expr),
            "Coefficient: \$\\frac{$(k)}{$(denom_val)}\$"
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=(3000, 3500),
            solution=solution_text,
            time=540,
            calculator="scientific"
        )
    end
end