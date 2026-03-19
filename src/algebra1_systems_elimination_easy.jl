# algebra1 - systems_elimination (easy)
# Generated: 2026-03-08T19:57:45.547581

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_elimination")
    
    # Generate system of equations using elimination method
    # Start with clean solutions
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Create two equations with different coefficients
    # Equation 1: a1*x + b1*y = c1
    a1 = nonzero(-8, 8)
    b1 = nonzero(-8, 8)
    c1 = a1 * x_sol + b1 * y_sol
    
    # Equation 2: a2*x + b2*y = c2
    # Make sure equations are independent (not multiples)
    a2 = nonzero(-8, 8)
    b2 = nonzero(-8, 8)
    
    # Ensure the system isn't degenerate
    while abs(a1 * b2 - a2 * b1) < 2
        a2 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
    end
    
    c2 = a2 * x_sol + b2 * y_sol
    
    eq1 = a1*x + b1*y
    eq2 = a2*x + b2*y
    
    # Determine which variable is easier to eliminate
    # Check if coefficients have a simple relationship
    eliminate_x = rand(Bool)
    
    if eliminate_x
        # Multiply to eliminate x
        mult1 = abs(a2)
        mult2 = abs(a1)
        sign = (a1 * a2 > 0) ? "-" : "+"
        
        elim_steps = "Multiply equation 1 by $(mult1) and equation 2 by $(mult2), then $(sign == "+" ? "add" : "subtract") to eliminate x"
        new_b_coeff = mult1 * b1 + (sign == "+" ? 1 : -1) * mult2 * b2
        new_c = mult1 * c1 + (sign == "+" ? 1 : -1) * mult2 * c2
        solve_var = "y"
    else
        # Multiply to eliminate y
        mult1 = abs(b2)
        mult2 = abs(b1)
        sign = (b1 * b2 > 0) ? "-" : "+"
        
        elim_steps = "Multiply equation 1 by $(mult1) and equation 2 by $(mult2), then $(sign == "+" ? "add" : "subtract") to eliminate y"
        new_a_coeff = mult1 * a1 + (sign == "+" ? 1 : -1) * mult2 * a2
        new_c = mult1 * c1 + (sign == "+" ? 1 : -1) * mult2 * c2
        solve_var = "x"
    end
    
    difficulty_level = randint(700, 1200)
    
    problem(
        question = "Solve the system of equations using elimination:<br>\$$(tex(eq1)) = $(c1)\$<br>\$$(tex(eq2)) = $(c2)\$",
        answer = fmt_tuple((x_sol, y_sol)),
        difficulty = difficulty_level,
        answer_type = "tuple",
        solution = steps(
            "System: \$$(tex(eq1)) = $(c1)\$ and \$$(tex(eq2)) = $(c2)\$",
            elim_steps,
            "Solve for $(solve_var), then substitute back to find the other variable",
            "Solution: \$x = $(x_sol), y = $(y_sol)\$"
        ),
        time = 120
    )
end