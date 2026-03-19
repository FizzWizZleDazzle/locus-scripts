# differential_equations - second_order_constant (competition)
# Generated: 2026-03-08T20:53:49.984437

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/second_order_constant")
    
    # Generate a challenging second-order constant coefficient DE problem
    # at Olympiad to Research-Adjacent level (3500-5000 ELO)
    
    # Choose problem type randomly
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Characteristic equation with complex roots and resonance
        # y'' + ω²y = f(t) where f(t) involves forcing at natural frequency
        omega = randint(2, 5)
        A = randint(2, 8)
        forcing_type = choice([:resonant, :near_resonant])
        
        if forcing_type == :resonant
            # Pure resonance case: forcing at natural frequency
            char_eq = "r^2 + $(omega^2) = 0"
            roots_desc = "r = ±$(omega)i"
            homogeneous = "y_h = c_1\\cos($(omega)t) + c_2\\sin($(omega)t)"
            particular = "y_p = \\frac{$(A)t}{$(2*omega)}\\sin($(omega)t)"
            general = "y = c_1\\cos($(omega)t) + c_2\\sin($(omega)t) + \\frac{$(A)t}{$(2*omega)}\\sin($(omega)t)"
            
            q_text = "Solve the differential equation with initial conditions:\n\$\$y'' + $(omega^2)y = $(A)\\sin($(omega)t), \\quad y(0) = 0, \\quad y'(0) = 0\$\$\n\nExpress your answer in the form \$y(t) = f(t)\$ and identify the coefficient of the secular term (the term growing linearly with time)."
            
            # Apply initial conditions
            # y(0) = 0: c_1 = 0
            # y'(0) = 0: c_2 * omega + A/(2*omega) * 0 = 0, so c_2 = 0
            final_solution = "y(t) = \\frac{$(A)t}{$(2*omega)}\\sin($(omega)t)"
            secular_coeff = A // (2*omega)
            
            answer = secular_coeff
            
            sol_steps = steps(
                "Given: \$y'' + $(omega^2)y = $(A)\\sin($(omega)t)\$ with \$y(0) = 0, y'(0) = 0\$",
                sol("Characteristic equation", char_eq),
                sol("Roots", roots_desc),
                sol("Homogeneous solution", homogeneous),
                "Since forcing frequency equals natural frequency \$\\omega = $(omega)\$, we have resonance.",
                "For particular solution, use \$y_p = At\\cos($(omega)t) + Bt\\sin($(omega)t)\$",
                "Substituting and solving: \$y_p = \\frac{$(A)t}{$(2*omega)}\\sin($(omega)t)\$",
                sol("General solution", general),
                "Applying \$y(0) = 0\$: \$c_1 = 0\$",
                "Applying \$y'(0) = 0\$: \$c_2 = 0\$",
                sol("Final solution", final_solution),
                sol("Secular term coefficient", "\\frac{$(A)}{$(2*omega)} = $(secular_coeff)")
            )
            
        else
            # Near-resonant forcing with beating phenomenon
            omega_f = omega + choice([-1, 1])
            char_eq = "r^2 + $(omega^2) = 0"
            roots_desc = "r = ±$(omega)i"
            
            # The beating solution involves difference and sum frequencies
            beat_freq = abs(omega - omega_f) // 2
            avg_freq = (omega + omega_f) // 2
            
            answer = beat_freq
            
            q_text = "Consider the differential equation:\n\$\$y'' + $(omega^2)y = $(A)\\cos($(omega_f)t), \\quad y(0) = 0, \\quad y'(0) = 0\$\$\n\nThis exhibits beating behavior. Find the beat frequency (the frequency of amplitude modulation)."
            
            sol_steps = steps(
                "Given: \$y'' + $(omega^2)y = $(A)\\cos($(omega_f)t)\$ with \$y(0) = 0, y'(0) = 0\$",
                sol("Characteristic equation", char_eq),
                sol("Natural frequency", "\\omega_n = $(omega)"),
                sol("Forcing frequency", "\\omega_f = $(omega_f)"),
                "Near-resonance condition: \$|\\omega_n - \\omega_f| = $(abs(omega - omega_f))\$ is small",
                "Particular solution: \$y_p = \\frac{$(A)}{$(omega^2 - omega_f^2)}\\cos($(omega_f)t)\$",
                "Applying initial conditions yields beating solution",
                "Beat frequency formula: \$\\omega_{beat} = \\frac{|\\omega_n - \\omega_f|}{2}\$",
                sol("Beat frequency", "\\omega_{beat} = $(beat_freq)")
            )
        end
        
        problem(
            question=q_text,
            answer=answer,
            difficulty=(3600, 4200),
            solution=sol_steps,
            time=300
        )
        
    elseif problem_type == 2
        # Type 2: Boundary value problem with eigenvalue analysis
        L = randint(2, 6)
        lambda = randint(1, 4)
        n = randint(1, 3)
        
        eigenvalue = (n * π / L)^2
        
        q_text = "Consider the boundary value problem:\n\$\$y'' + \\lambda y = 0, \\quad y(0) = 0, \\quad y($(L)) = 0\$\$\n\nFind the $(n)-th positive eigenvalue \$\\lambda_$(n)\$ (exact value, in terms of \$\\pi\$)."
        
        answer = eigenvalue
        
        sol_steps = steps(
            "Given: \$y'' + \\lambda y = 0\$ with \$y(0) = 0, y($(L)) = 0\$",
            "For \$\\lambda > 0\$: general solution is \$y = A\\cos(\\sqrt{\\lambda}t) + B\\sin(\\sqrt{\\lambda}t)\$",
            "Applying \$y(0) = 0\$: \$A = 0\$, so \$y = B\\sin(\\sqrt{\\lambda}t)\$",
            "Applying \$y($(L)) = 0\$: \$B\\sin(\\sqrt{\\lambda} \\cdot $(L)) = 0\$",
            "Non-trivial solutions require: \$\\sqrt{\\lambda} \\cdot $(L) = n\\pi\$ for \$n = 1, 2, 3, \\ldots\$",
            sol("Eigenvalues", "\\lambda_n = \\left(\\frac{n\\pi}{$(L)}\\right)^2"),
            sol("The $(n)-th eigenvalue", "\\lambda_$(n) = \\left(\\frac{$(n)\\pi}{$(L)}\\right)^2 = $(eigenvalue)")
        )
        
        problem(
            question=q_text,
            answer=answer,
            difficulty=(3800, 4400),
            solution=sol_steps,
            time=280
        )
        
    elseif problem_type == 3
        # Type 3: Non-homogeneous with variation of parameters (challenging forcing function)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # Create a characteristic equation with distinct real roots
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1
            r2 = nonzero(-4, 4)
        end
        
        coeff_yp = -(r1 + r2)
        coeff_y = r1 * r2
        
        q_text = "Using variation of parameters, find a particular solution to:\n\$\$y'' - $(coeff_yp)y' + $(coeff_y)y = e^{$(a)t}\\sec($(b)t)\$\$\n\nExpress the Wronskian \$W(y_1, y_2)\$ of the fundamental solutions at \$t = 0\$."
        
        # Fundamental solutions are e^(r1*t) and e^(r2*t)
        # W = e^(r1*t) * r2*e^(r2*t) - e^(r2*t) * r1*e^(r1*t)
        # W = (r2 - r1)*e^((r1+r2)*t)
        # W(0) = r2 - r1
        
        wronskian_at_0 = r2 - r1
        answer = wronskian_at_0
        
        sol_steps = steps(
            "Given: \$y'' - $(coeff_yp)y' + $(coeff_y)y = e^{$(a)t}\\sec($(b)t)\$",
            sol("Characteristic equation", "r^2 - $(coeff_yp)r + $(coeff_y) = 0"),
            sol("Roots", "r_1 = $(r1), r_2 = $(r2)"),
            sol("Fundamental solutions", "y_1 = e^{$(r1)t}, y_2 = e^{$(r2)t}"),
            "Wronskian: \$W(y_1, y_2) = y_1 y_2' - y_2 y_1' = e^{$(r1)t} \\cdot $(r2)e^{$(r2)t} - e^{$(r2)t} \\cdot $(r1)e^{$(r1)t}\$",
            sol("Simplified", "W = $(r2 - r1)e^{$(r1 + r2)t}"),
            "For variation of parameters, we need \$u_1' = -\\frac{y_2 f(t)}{W}\$ and \$u_2' = \\frac{y_1 f(t)}{W}\$",
            sol("Wronskian at t=0", "W(0) = $(wronskian_at_0)")
        )
        
        problem(
            question=q_text,
            answer=answer,
            difficulty=(4000, 4600),
            solution=sol_steps,
            time=320
        )
        
    else
        # Type 4: System reduction and phase plane analysis
        p = randint(2, 5)
        q = randint(1, 4)
        
        # y'' + py' + qy = 0
        # Convert to system: x1 = y, x2 = y'
        # x1' = x2
        # x2' = -qx1 - px2
        
        # Characteristic: r^2 + pr + q = 0
        discriminant = p^2 - 4*q
        
        if discriminant > 0
            node_type = "saddle" 
            stability = "unstable"
        elseif discriminant == 0
            node_type = "degenerate node"
            stability = p > 0 ? "stable" : "unstable"
        else
            if p > 0
                node_type = "spiral"
                stability = "stable (spiral sink)"
            elseif p < 0
                node_type = "spiral"
                stability = "unstable (spiral source)"
            else
                node_type = "center"
                stability = "neutrally stable"
            end
        end
        
        q_text = "Convert the second-order equation \$y'' + $(p)y' + $(q)y = 0\$ to a first-order system and classify the equilibrium at the origin in the phase plane.\n\nWhat is the trace of the coefficient matrix?"
        
        trace_val = -p
        answer = trace_val
        
        sol_steps = steps(
            "Given: \$y'' + $(p)y' + $(q)y = 0\$",
            "Let \$x_1 = y, x_2 = y'\$. Then:",
            sol("System", "x_1' = x_2, \\quad x_2' = -$(q)x_1 - $(p)x_2"),
            sol("Matrix form", "\\mathbf{x}' = \\begin{pmatrix} 0 & 1 \\\\ -$(q) & -$(p) \\end{pmatrix} \\mathbf{x}"),
            "Eigenvalues satisfy characteristic equation: \$\\det(A - \\lambda I) = 0\$",
            sol("Characteristic polynomial", "\\lambda^2 + $(p)\\lambda + $(q) = 0"),
            sol("Trace of matrix", "\\text{tr}(A) = 0 + (-$(p)) = $(trace_val)"),
            sol("Determinant", "\\det(A) = $(q)"),
            "Discriminant: \$\\Delta = $(p)^2 - 4($(q)) = $(discriminant)\$",
            "Classification: $(node_type), $(stability)"
        )
        
        problem(
            question=q_text,
            answer=answer,
            difficulty=(3700, 4300),
            solution=sol_steps,
            time=300
        )
    end
end