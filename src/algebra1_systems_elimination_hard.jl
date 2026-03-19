# algebra1 - systems_elimination (hard)
# Generated: 2026-03-08T19:58:01.366555

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_elimination")
    
    # Pick a clean solution first
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Generate coefficients for two equations
    # Equation 1: a1*x + b1*y = c1
    # Equation 2: a2*x + b2*y = c2
    
    a1 = nonzero(-8, 8)
    b1 = nonzero(-8, 8)
    c1 = a1 * x_sol + b1 * y_sol
    
    a2 = nonzero(-8, 8)
    b2 = nonzero(-8, 8)
    c2 = a2 * x_sol + b2 * y_sol
    
    # Make sure the system is not trivially proportional
    while abs(a1 * b2 - a2 * b1) < 2
        a2 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
        c2 = a2 * x_sol + b2 * y_sol
    end
    
    # Decide elimination strategy based on coefficients
    eliminate_var = choice(["x", "y"])
    
    if eliminate_var == "x"
        # Eliminate x by multiplying equations
        mult1 = abs(a2)
        mult2 = abs(a1)
        
        # After multiplication and subtraction
        new_b_coeff = mult1 * b1 - (a2 > 0 ? mult2 : -mult2) * (a1 > 0 ? b2 : -b2)
        new_c = mult1 * c1 - (a2 > 0 ? mult2 : -mult2) * (a1 > 0 ? c2 : -c2)
        
        solution_steps = steps(
            "Given system:",
            "\$$(a1)x + $(b1)y = $(c1)\$",
            "\$$(a2)x + $(b2)y = $(c2)\$",
            "To eliminate \$x\$, multiply equation (1) by \$$(mult1)\$ and equation (2) by \$$(mult2)\$:",
            "\$$(mult1 * a1)x + $(mult1 * b1)y = $(mult1 * c1)\$",
            "\$$(mult2 * a2)x + $(mult2 * b2)y = $(mult2 * c2)\$",
            "Subtract to eliminate \$x\$ and solve for \$y\$:",
            sol("y", y_sol),
            "Substitute \$y = $(y_sol)\$ back into equation (1):",
            "\$$(a1)x + $(b1)($(y_sol)) = $(c1)\$",
            sol("x", x_sol),
            "Solution: \$($(x_sol), $(y_sol))\$"
        )
    else
        # Eliminate y
        mult1 = abs(b2)
        mult2 = abs(b1)
        
        solution_steps = steps(
            "Given system:",
            "\$$(a1)x + $(b1)y = $(c1)\$",
            "\$$(a2)x + $(b2)y = $(c2)\$",
            "To eliminate \$y\$, multiply equation (1) by \$$(mult1)\$ and equation (2) by \$$(mult2)\$:",
            "\$$(mult1 * a1)x + $(mult1 * b1)y = $(mult1 * c1)\$",
            "\$$(mult2 * a2)x + $(mult2 * b2)y = $(mult2 * c2)\$",
            "Subtract to eliminate \$y\$ and solve for \$x\$:",
            sol("x", x_sol),
            "Substitute \$x = $(x_sol)\$ back into equation (1):",
            "\$$(a1)($(x_sol)) + $(b1)y = $(c1)\$",
            sol("y", y_sol),
            "Solution: \$($(x_sol), $(y_sol))\$"
        )
    end
    
    problem(
        question = "Solve the system using elimination:\n\$\$\\begin{cases} $(a1)x + $(b1)y = $(c1) \\\\ $(a2)x + $(b2)y = $(c2) \\end{cases}\$\$",
        answer = fmt_tuple((x_sol, y_sol)),
        difficulty = randint(1850, 2450),
        answer_type = "tuple",
        solution = solution_steps,
        time = randint(180, 300)
    )
end