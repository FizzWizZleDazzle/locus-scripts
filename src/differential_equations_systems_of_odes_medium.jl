# differential_equations - systems_of_odes (medium)
# Generated: 2026-03-08T20:57:18.363763

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    problem_type = choice([:decoupled_system, :coupled_linear, :eigenvalue_system, :initial_value])
    
    if problem_type == :decoupled_system
        # System where equations are independent
        a1 = nonzero(-5, 5)
        a2 = nonzero(-5, 5)
        b1 = randint(-8, 8)
        b2 = randint(-8, 8)
        
        question_text = "Solve the system of differential equations:<br>" *
                       "\$\\frac{dx}{dt} = $(a1)x + $(b1)\$<br>" *
                       "\$\\frac{dy}{dt} = $(a2)y + $(b2)\$"
        
        if b1 == 0
            sol_x = "x(t) = C_1 e^{$(a1)t}"
        else
            sol_x = "x(t) = C_1 e^{$(a1)t} - $(b1//a1)"
        end
        
        if b2 == 0
            sol_y = "y(t) = C_2 e^{$(a2)t}"
        else
            sol_y = "y(t) = C_2 e^{$(a2)t} - $(b2//a2)"
        end
        
        answer_text = sol_x * ", " * sol_y
        
        solution_text = steps(
            "System is decoupled - solve each equation independently",
            sol("First equation", "\\frac{dx}{dt} = $(a1)x + $(b1)"),
            b1 == 0 ? "Separable: \$x(t) = C_1 e^{$(a1)t}\$" : "Linear ODE: \$x(t) = C_1 e^{$(a1)t} - \\frac{$(b1)}{$(a1)}\$",
            sol("Second equation", "\\frac{dy}{dt} = $(a2)y + $(b2)"),
            b2 == 0 ? "Separable: \$y(t) = C_2 e^{$(a2)t}\$" : "Linear ODE: \$y(t) = C_2 e^{$(a2)t} - \\frac{$(b2)}{$(a2)}\$",
            sol("General solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1200, 1400),
            solution=solution_text,
            time=180,
            answer_type="expression"
        )
        
    elseif problem_type == :coupled_linear
        # 2x2 coupled linear system with triangular structure
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        question_text = "Solve the system:<br>" *
                       "\$\\frac{dx}{dt} = $(a)x + $(b)y\$<br>" *
                       "\$\\frac{dy}{dt} = $(c)y\$"
        
        sol_y = "y(t) = C_2 e^{$(c)t}"
        
        if b == 0
            sol_x = "x(t) = C_1 e^{$(a)t}"
        else
            if a == c
                sol_x = "x(t) = C_1 e^{$(a)t} + $(b) C_2 t e^{$(a)t}"
            else
                coef = b // (c - a)
                sol_x = "x(t) = C_1 e^{$(a)t} + $(coef) C_2 e^{$(c)t}"
            end
        end
        
        answer_text = sol_x * ", " * sol_y
        
        solution_text = steps(
            "Start with the second equation (decoupled)",
            sol("\\frac{dy}{dt} = $(c)y", "y(t) = C_2 e^{$(c)t}"),
            "Substitute into first equation",
            sol("\\frac{dx}{dt} = $(a)x + $(b)C_2 e^{$(c)t}", ""),
            "Solve linear first-order ODE using integrating factor",
            sol("Solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1400, 1600),
            solution=solution_text,
            time=240,
            answer_type="expression"
        )
        
    elseif problem_type == :eigenvalue_system
        # Simple eigenvalue problem with real distinct eigenvalues
        lambda1 = nonzero(-6, 6)
        lambda2 = nonzero(-6, 6)
        while lambda2 == lambda1
            lambda2 = nonzero(-6, 6)
        end
        
        # Construct matrix with eigenvalues lambda1, lambda2
        # Use diagonal or simple form
        if choice([true, false])
            a11, a22 = lambda1, lambda2
            a12, a21 = 0, 0
            v1_text = "\\begin{pmatrix} 1 \\\\ 0 \\end{pmatrix}"
            v2_text = "\\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix}"
        else
            # Create 2x2 with trace = lambda1 + lambda2, det = lambda1*lambda2
            trace_val = lambda1 + lambda2
            det_val = lambda1 * lambda2
            a11 = randint(-3, 3)
            a22 = trace_val - a11
            a12 = nonzero(-4, 4)
            a21 = (det_val - a11*a22) // a12
            v1_text = "\\begin{pmatrix} $(a12) \\\\ $(lambda1 - a11) \\end{pmatrix}"
            v2_text = "\\begin{pmatrix} $(a12) \\\\ $(lambda2 - a11) \\end{pmatrix}"
        end
        
        question_text = "Find the eigenvalues of the system:<br>" *
                       "\$\\frac{d\\mathbf{x}}{dt} = \\begin{pmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{pmatrix} \\mathbf{x}\$"
        
        answer_text = fmt_set(Set([lambda1, lambda2]))
        
        solution_text = steps(
            sol("Matrix", "A = \\begin{pmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{pmatrix}"),
            "Find eigenvalues by solving \$\\det(A - \\lambda I) = 0\$",
            sol("Characteristic equation", "($(a11) - \\lambda)($(a22) - \\lambda) - ($(a12))($(a21)) = 0"),
            "Expand and solve quadratic equation",
            sol("Eigenvalues", "\\lambda = $(lambda1), $(lambda2)")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1400, 1700),
            solution=solution_text,
            time=200,
            answer_type="set"
        )
        
    else  # initial_value
        # System with initial conditions
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        x0 = randint(-10, 10)
        y0 = randint(-10, 10)
        
        question_text = "Solve the initial value problem:<br>" *
                       "\$\\frac{dx}{dt} = $(a)x\$, \$x(0) = $(x0)\$<br>" *
                       "\$\\frac{dy}{dt} = $(b)y\$, \$y(0) = $(y0)\$"
        
        sol_x = "x(t) = $(x0) e^{$(a)t}"
        sol_y = "y(t) = $(y0) e^{$(b)t}"
        answer_text = sol_x * ", " * sol_y
        
        solution_text = steps(
            "Solve each decoupled equation separately",
            sol("For x(t)", "\\frac{dx}{dt} = $(a)x \\implies x(t) = C_1 e^{$(a)t}"),
            "Apply initial condition \$x(0) = $(x0)\$: \$C_1 = $(x0)\$",
            sol("For y(t)", "\\frac{dy}{dt} = $(b)y \\implies y(t) = C_2 e^{$(b)t}"),
            "Apply initial condition \$y(0) = $(y0)\$: \$C_2 = $(y0)\$",
            sol("Particular solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1300, 1500),
            solution=solution_text,
            time=150,
            answer_type="expression"
        )
    end
end