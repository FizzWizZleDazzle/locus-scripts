# differential_equations - undetermined_coefficients (easy)
# Generated: 2026-03-08T20:54:19.238803

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # Choose problem type
    prob_type = choice([:nonhomogeneous_poly, :nonhomogeneous_exp, :second_order_simple])
    
    if prob_type == :nonhomogeneous_poly
        # y' + ay = polynomial (first order)
        a = nonzero(-5, 5)
        
        # Right-hand side: simple polynomial
        poly_degree = choice([0, 1])
        if poly_degree == 0
            # y' + ay = c
            c = nonzero(-15, 15)
            rhs = c
            
            # Particular solution: y_p = A (constant)
            # y'_p = 0, so 0 + aA = c => A = c/a
            A = c // a
            y_p = A
            
            question = "Find a particular solution to \$y' + $(a)y = $(c)\$ using undetermined coefficients."
            
            solution_steps = steps(
                sol("Given equation", "y' + $(a)y = $(c)"),
                "For constant right-hand side, assume \$y_p = A\$ (constant)",
                "Then \$y_p' = 0\$",
                "Substitute: \$0 + $(a)A = $(c)\$",
                sol("Solve for A", "A = $(A)"),
                sol("Particular solution", "y_p = $(A)")
            )
        else
            # y' + ay = bx + c
            b = nonzero(-12, 12)
            c = randint(-15, 15)
            rhs = b*x + c
            
            # Particular solution: y_p = Ax + B
            # y'_p = A, so A + a(Ax + B) = bx + c
            # A + aAx + aB = bx + c
            # aAx + (A + aB) = bx + c
            # aA = b => A = b/a
            # A + aB = c => B = (c - A)/a
            A = b // a
            B = (c - A) // a
            y_p = A*x + B
            
            question = "Find a particular solution to \$y' + $(a)y = $(tex(rhs))\$ using undetermined coefficients."
            
            solution_steps = steps(
                sol("Given equation", "y' + $(a)y = $(tex(rhs))"),
                "For polynomial right-hand side, assume \$y_p = Ax + B\$",
                "Then \$y_p' = A\$",
                "Substitute: \$A + $(a)(Ax + B) = $(tex(rhs))\$",
                "Expand: \$A + $(a)Ax + $(a)B = $(tex(rhs))\$",
                "Match coefficients: \$$(a)A = $(b)\$ and \$A + $(a)B = $(c)\$",
                sol("Solve", "A = $(A), B = $(B)"),
                sol("Particular solution", "y_p = $(tex(y_p))")
            )
        end
        
        problem(
            question=question,
            answer=y_p,
            difficulty=(800, 1000),
            solution=solution_steps,
            time=120
        )
        
    elseif prob_type == :nonhomogeneous_exp
        # y' + ay = be^(cx) (first order)
        a = nonzero(-5, 5)
        b = nonzero(-10, 10)
        c = nonzero(-4, 4)
        
        # Make sure c != -a (otherwise resonance case)
        while c == -a
            c = nonzero(-4, 4)
        end
        
        rhs = b * exp(c*x)
        
        # Particular solution: y_p = Ae^(cx)
        # y'_p = Ace^(cx), so Ace^(cx) + aAe^(cx) = be^(cx)
        # A(c + a) = b => A = b/(c + a)
        A = b // (c + a)
        y_p = A * exp(c*x)
        
        question = "Find a particular solution to \$y' + $(a)y = $(b)e^{$(c)x}\$ using undetermined coefficients."
        
        solution_steps = steps(
            sol("Given equation", "y' + $(a)y = $(b)e^{$(c)x}"),
            "For exponential right-hand side, assume \$y_p = Ae^{$(c)x}\$",
            "Then \$y_p' = $(c)Ae^{$(c)x}\$",
            "Substitute: \$$(c)Ae^{$(c)x} + $(a)Ae^{$(c)x} = $(b)e^{$(c)x}\$",
            "Factor: \$A($(c) + $(a))e^{$(c)x} = $(b)e^{$(c)x}\$",
            sol("Solve for A", "A = $(A)"),
            sol("Particular solution", "y_p = $(A)e^{$(c)x}")
        )
        
        problem(
            question=question,
            answer=y_p,
            difficulty=(900, 1100),
            solution=solution_steps,
            time=150
        )
        
    else  # second_order_simple
        # y'' + ay' + by = constant (second order)
        a_coef = nonzero(-6, 6)
        b_coef = nonzero(1, 8)  # Keep b positive to avoid complex roots
        c = nonzero(-20, 20)
        
        # Particular solution: y_p = A (constant)
        # y''_p = 0, y'_p = 0, so 0 + 0 + bA = c => A = c/b
        A = c // b_coef
        y_p = A
        
        question = "Find a particular solution to \$y'' + $(a_coef)y' + $(b_coef)y = $(c)\$ using undetermined coefficients."
        
        solution_steps = steps(
            sol("Given equation", "y'' + $(a_coef)y' + $(b_coef)y = $(c)"),
            "For constant right-hand side, assume \$y_p = A\$ (constant)",
            "Then \$y_p' = 0\$ and \$y_p'' = 0\$",
            "Substitute: \$0 + 0 + $(b_coef)A = $(c)\$",
            sol("Solve for A", "A = $(A)"),
            sol("Particular solution", "y_p = $(A)")
        )
        
        problem(
            question=question,
            answer=y_p,
            difficulty=(700, 950),
            solution=solution_steps,
            time=90
        )
    end
end