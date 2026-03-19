# algebra1 - systems_elimination (medium)
# Generated: 2026-03-08T19:57:53.723576

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_elimination")
    
    # Pick random solution values
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Generate coefficients for two equations
    # First equation: a1*x + b1*y = c1
    a1 = nonzero(-8, 8)
    b1 = nonzero(-8, 8)
    c1 = a1 * x_sol + b1 * y_sol
    
    # Second equation: a2*x + b2*y = c2
    # Make sure the system isn't degenerate
    a2 = nonzero(-8, 8)
    b2 = nonzero(-8, 8)
    
    # Ensure not a multiple of the first equation
    while abs(a1 * b2 - a2 * b1) < 2
        a2 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
    end
    
    c2 = a2 * x_sol + b2 * y_sol
    
    # Build the equations
    eq1 = a1*x + b1*y
    eq2 = a2*x + b2*y
    
    # Determine elimination strategy
    elimination_var = choice(["x", "y"])
    
    if elimination_var == "x"
        mult1 = abs(a2)
        mult2 = abs(a1)
        if sign(a1) == sign(a2)
            operation = "subtract"
        else
            operation = "add"
        end
    else
        mult1 = abs(b2)
        mult2 = abs(b1)
        if sign(b1) == sign(b2)
            operation = "subtract"
        else
            operation = "add"
        end
    end
    
    # Format the system
    eq1_str = "$(tex(eq1)) = $(c1)"
    eq2_str = "$(tex(eq2)) = $(c2)"
    
    solution_text = steps(
        "Given system:",
        "\$$(eq1_str)\$",
        "\$$(eq2_str)\$",
        "Use elimination method to solve for $(elimination_var) first",
        operation == "subtract" ? 
            "Multiply equations to match coefficients and subtract" :
            "Multiply equations to match coefficients and add",
        "Solve for one variable, then substitute back",
        sol("x", x_sol),
        sol("y", y_sol)
    )
    
    problem(
        question="Solve the system of equations using elimination:<br>\$$(eq1_str)\$<br>\$$(eq2_str)\$<br>Enter your answer as an ordered pair (x, y).",
        answer=fmt_tuple([x_sol, y_sol]),
        difficulty=(1200, 1600),
        answer_type="tuple",
        solution=solution_text,
        time=180
    )
end