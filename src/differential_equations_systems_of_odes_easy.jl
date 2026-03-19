# differential_equations - systems_of_odes (easy)
# Generated: 2026-03-08T20:56:54.197693

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    problem_type = choice(["solve_system_decoupled", "solve_system_initial_value", "verify_solution", "eigenvalue_system"])
    
    if problem_type == "solve_system_decoupled"
        # Decoupled system: dx/dt = ax, dy/dt = by
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        while a == b
            b = nonzero(-5, 5)
        end
        
        question_text = "Solve the decoupled system of ODEs:<br>\$\\frac{dx}{dt} = $(a)x\$<br>\$\\frac{dy}{dt} = $(b)y\$"
        
        answer_text = "x(t) = C₁e^{$(a)t}, y(t) = C₂e^{$(b)t}"
        
        solution_text = steps(
            "System: dx/dt = $(a)x, dy/dt = $(b)y",
            "These are separable first-order ODEs",
            "For dx/dt = $(a)x: separate and integrate to get x(t) = C₁e^{$(a)t}",
            "For dy/dt = $(b)y: separate and integrate to get y(t) = C₂e^{$(b)t}",
            sol("Answer", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(800, 1000),
            solution=solution_text,
            answer_type="expression",
            time=120
        )
        
    elseif problem_type == "solve_system_initial_value"
        # Simple system with initial conditions
        a = nonzero(-4, 4)
        c1 = randint(-8, 8)
        c2 = randint(-8, 8)
        
        question_text = "Solve the initial value problem:<br>\$\\frac{dx}{dt} = $(a)x\$, \$x(0) = $(c1)\$<br>\$\\frac{dy}{dt} = 0\$, \$y(0) = $(c2)\$"
        
        if a > 0
            answer_text = "x(t) = $(c1)e^{$(a)t}, y(t) = $(c2)"
        else
            answer_text = "x(t) = $(c1)e^{$(a)t}, y(t) = $(c2)"
        end
        
        solution_text = steps(
            "System: dx/dt = $(a)x with x(0) = $(c1), dy/dt = 0 with y(0) = $(c2)",
            "For dx/dt = $(a)x: general solution is x(t) = Ce^{$(a)t}",
            "Apply initial condition x(0) = $(c1): C = $(c1), so x(t) = $(c1)e^{$(a)t}",
            "For dy/dt = 0: y is constant, y(t) = $(c2)",
            sol("Answer", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(900, 1100),
            solution=solution_text,
            answer_type="expression",
            time=150
        )
        
    elseif problem_type == "verify_solution"
        # Verify a proposed solution to a system
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        question_text = "Verify that x(t) = e^{$(a)t}, y(t) = e^{$(b)t} is a solution to the system:<br>\$\\frac{dx}{dt} = $(a)x\$<br>\$\\frac{dy}{dt} = $(b)y\$"
        
        answer_text = "Yes"
        
        solution_text = steps(
            "Given: x(t) = e^{$(a)t}, y(t) = e^{$(b)t}",
            "Compute dx/dt = $(a)e^{$(a)t} = $(a)x ✓",
            "Compute dy/dt = $(b)e^{$(b)t} = $(b)y ✓",
            "Both equations are satisfied",
            sol("Answer", "The solution is verified")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(700, 900),
            solution=solution_text,
            answer_type="text",
            time=90
        )
        
    else  # eigenvalue_system
        # 2x2 system with diagonal matrix (easy eigenvalues)
        lambda1 = nonzero(-5, 5)
        lambda2 = nonzero(-5, 5)
        
        while lambda1 == lambda2
            lambda2 = nonzero(-5, 5)
        end
        
        question_text = "Find the eigenvalues of the system:<br>\$\\frac{dx}{dt} = $(lambda1)x\$<br>\$\\frac{dy}{dt} = $(lambda2)y\$<br>(This corresponds to the matrix \$\\begin{pmatrix}$(lambda1) & 0\\\\0 & $(lambda2)\\end{pmatrix}\$)"
        
        if lambda1 < lambda2
            answer_text = fmt_set(Set([lambda1, lambda2]))
        else
            answer_text = fmt_set(Set([lambda2, lambda1]))
        end
        
        solution_text = steps(
            "System matrix: A = [$(lambda1) 0; 0 $(lambda2)]",
            "For a diagonal matrix, eigenvalues are the diagonal entries",
            "Eigenvalues are λ₁ = $(lambda1) and λ₂ = $(lambda2)",
            sol("Answer", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1000, 1200),
            solution=solution_text,
            answer_type="set",
            time=120
        )
    end
end