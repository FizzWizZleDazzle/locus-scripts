# differential_equations - systems_of_odes (very_hard)
# Generated: 2026-03-08T20:57:51.084092

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    problem_type = choice([
        :eigenvalue_diagonalization,
        :phase_plane_analysis,
        :stability_classification,
        :nonlinear_system,
        :matrix_exponential
    ])
    
    if problem_type == :eigenvalue_diagonalization
        # System x' = Ax with distinct real eigenvalues
        # Choose eigenvalues first
        λ1 = randint(-5, -1)
        λ2 = randint(1, 5)
        
        # Choose eigenvectors (simple integers)
        v11, v12 = nonzero(-3, 3), nonzero(-3, 3)
        v21, v22 = nonzero(-3, 3), nonzero(-3, 3)
        
        # Ensure linearly independent
        while v11 * v22 == v12 * v21
            v21, v22 = nonzero(-3, 3), nonzero(-3, 3)
        end
        
        # Construct A = PDP^{-1}
        det_P = v11 * v22 - v12 * v21
        a11 = (λ1 * v11 * v22 - λ2 * v12 * v21) // det_P
        a12 = (λ2 * v12 * v11 - λ1 * v11 * v12) // det_P
        a21 = (λ1 * v21 * v22 - λ2 * v22 * v21) // det_P
        a22 = (λ2 * v22 * v11 - λ1 * v21 * v12) // det_P
        
        # Use simpler construction: trace and determinant
        trace_val = randint(2, 8)
        det_val = randint(-15, -5)
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = trace_val - a
        
        # Ensure distinct real eigenvalues: discriminant > 0
        while (a + d)^2 - 4*(a*d - b*c) <= 0 || abs(b*c) < 2
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            c = nonzero(-4, 4)
            d = nonzero(-4, 4)
        end
        
        trace = a + d
        det = a*d - b*c
        disc = trace^2 - 4*det
        
        λ_pos = (trace + sqrt(disc)) / 2
        λ_neg = (trace - sqrt(disc)) / 2
        
        stability = if λ_pos < 0 && λ_neg < 0
            "stable node"
        elseif λ_pos > 0 && λ_neg > 0
            "unstable node"
        else
            "saddle point"
        end
        
        question = "Consider the system of differential equations:\n\$\$\\begin{cases} \\frac{dx}{dt} = $(a)x + $(b)y \\\\ \\frac{dy}{dt} = $(c)x + $(d)y \\end{cases}\$\$\n\nClassify the stability of the origin and determine the eigenvalues of the coefficient matrix."
        
        answer = stability
        
        solution = steps(
            "Write the coefficient matrix: \$A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\$",
            "Find eigenvalues from characteristic equation: \$\\det(A - \\lambda I) = 0\$",
            "Compute: \$($(a) - \\lambda)($(d) - \\lambda) - $(b*c) = \\lambda^2 - $(trace)\\lambda + $(det) = 0\$",
            "Discriminant: \$\\Delta = $(trace^2) - 4($(det)) = $(disc)\$",
            sol("Eigenvalues", "\\lambda = \\frac{$(trace) \\pm \\sqrt{$(disc)}}{2}"),
            "Since eigenvalues are real with $(λ_pos > 0 && λ_neg > 0 ? "both positive" : λ_pos < 0 && λ_neg < 0 ? "both negative" : "opposite signs"), the origin is a **$(stability)**"
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2500, 3000),
            solution=solution,
            time=240,
            answer_type="text"
        )
        
    elseif problem_type == :phase_plane_analysis
        # Nonlinear system with nullclines
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # System: x' = ax - xy, y' = -by + cxy
        # Equilibria: (0,0) and (b/c, a)
        
        eq_x = b // c
        eq_y = a
        
        question = "Consider the predator-prey system:\n\$\$\\begin{cases} \\frac{dx}{dt} = $(a)x - xy \\\\ \\frac{dy}{dt} = -$(abs(b))y + $(c)xy \\end{cases}\$\$\n\nFind all equilibrium points."
        
        answer = "(0, 0) and ($(eq_x), $(eq_y))"
        
        solution = steps(
            "Set \$\\frac{dx}{dt} = 0\$ and \$\\frac{dy}{dt} = 0\$",
            "From first equation: \$$(a)x - xy = x($(a) - y) = 0\$, so \$x = 0\$ or \$y = $(a)\$",
            "From second equation: \$-$(abs(b))y + $(c)xy = y(-$(abs(b)) + $(c)x) = 0\$, so \$y = 0\$ or \$x = $(eq_x)\$",
            "Combining: \$(0, 0)\$ from \$x=0, y=0\$",
            "And: \$($(eq_x), $(a))\$ from \$y=$(a), x=$(eq_x)\$",
            sol("Equilibrium points", "\\{(0, 0), ($(eq_x), $(a))\\}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2800, 3200),
            solution=solution,
            time=300,
            answer_type="text"
        )
        
    elseif problem_type == :stability_classification
        # Complex eigenvalues case
        a = nonzero(-4, 4)
        d = nonzero(-4, 4)
        b = nonzero(2, 6)
        c = -randint(2, 6)
        
        # Ensure complex eigenvalues: trace^2 - 4*det < 0
        while (a + d)^2 - 4*(a*d - b*c) >= 0
            b = nonzero(2, 6)
            c = -randint(2, 6)
        end
        
        trace = a + d
        det = a*d - b*c
        
        real_part = trace / 2
        
        stability = if real_part < 0
            "stable spiral"
        elseif real_part > 0
            "unstable spiral"
        else
            "center"
        end
        
        question = "Classify the stability of the origin for the linear system with coefficient matrix:\n\$\$A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\$\$"
        
        answer = stability
        
        solution = steps(
            "Compute trace: \$\\text{tr}(A) = $(a) + $(d) = $(trace)\$",
            "Compute determinant: \$\\det(A) = $(a)($(d)) - $(b)($(c)) = $(det)\$",
            "Discriminant: \$\\Delta = $(trace)^2 - 4($(det)) = $(trace^2 - 4*det)\$",
            "Since \$\\Delta < 0\$, eigenvalues are complex: \$\\lambda = \\frac{$(trace) \\pm i\\sqrt{$(4*det - trace^2)}}{2}\$",
            "Real part: \$\\text{Re}(\\lambda) = $(real_part)\$",
            sol("Classification", "$(real_part < 0 ? "Re(\\lambda) < 0" : real_part > 0 ? "Re(\\lambda) > 0" : "Re(\\lambda) = 0") \\implies \\text{$(stability)}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3100),
            solution=solution,
            time=210,
            answer_type="text"
        )
        
    elseif problem_type == :nonlinear_system
        # Linearization around equilibrium
        a = randint(2, 5)
        b = randint(2, 5)
        
        # System: x' = y, y' = -sin(x) - ay
        # Linearize around (0,0): x' = y, y' = -x - ay
        
        trace = -a
        det = 1
        disc = a^2 - 4
        
        stability = if a > 2
            "stable spiral"
        elseif a == 2
            "stable node"
        else
            "unstable or center"
        end
        
        question = "Consider the damped pendulum system:\n\$\$\\begin{cases} \\frac{dx}{dt} = y \\\\ \\frac{dy}{dt} = -\\sin(x) - $(a)y \\end{cases}\$\$\n\nLinearize the system around the equilibrium point \$(0, 0)\$ and classify its stability."
        
        answer = if a >= 2
            "stable"
        else
            "unstable or center depending on a"
        end
        
        solution = steps(
            "The equilibrium point is \$(0, 0)\$",
            "Linearize: \$\\sin(x) \\approx x\$ near \$x = 0\$",
            "Linearized system: \$\\frac{dx}{dt} = y\$, \$\\frac{dy}{dt} = -x - $(a)y\$",
            "Jacobian at \$(0,0)\$: \$J = \\begin{pmatrix} 0 & 1 \\\\ -1 & -$(a) \\end{pmatrix}\$",
            "Eigenvalues: \$\\lambda^2 + $(a)\\lambda + 1 = 0\$ gives \$\\lambda = \\frac{-$(a) \\pm \\sqrt{$(a^2 - 4)}}{2}\$",
            sol("Stability", "$(a >= 2 ? "Both eigenvalues have negative real part, so the origin is **stable**" : "Analysis shows instability or center behavior")")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3000, 3500),
            solution=solution,
            time=360,
            answer_type="text"
        )
        
    else  # matrix_exponential
        # Simple diagonal case
        λ1 = randint(-4, -1)
        λ2 = randint(1, 4)
        
        x0 = nonzero(-5, 5)
        y0 = nonzero(-5, 5)
        
        question = "Solve the initial value problem:\n\$\$\\begin{cases} \\frac{dx}{dt} = $(λ1)x \\\\ \\frac{dy}{dt} = $(λ2)y \\end{cases}, \\quad x(0) = $(x0), \\; y(0) = $(y0)\$\$"
        
        answer = "x(t) = $(x0)e^{$(λ1)t}, y(t) = $(y0)e^{$(λ2)t}"
        
        solution = steps(
            "This is a decoupled system with diagonal coefficient matrix",
            "Each equation is a separable ODE",
            "Solve \$\\frac{dx}{dt} = $(λ1)x\$: \$x(t) = Ce^{$(λ1)t}\$",
            "Apply \$x(0) = $(x0)\$: \$C = $(x0)\$",
            "Similarly for \$y\$: \$y(t) = $(y0)e^{$(λ2)t}\$",
            sol("Solution", "x(t) = $(x0)e^{$(λ1)t}, \\; y(t) = $(y0)e^{$(λ2)t}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2400, 2800),
            solution=solution,
            time=180,
            answer_type="text"
        )
    end
end