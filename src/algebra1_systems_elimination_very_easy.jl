# algebra1 - systems_elimination (very_easy)
# Generated: 2026-03-08T19:57:30.875930

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_elimination")
    
    # Pick clean integer solution
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Generate two linear equations that share this solution
    # First equation: a1*x + b1*y = c1
    a1 = nonzero(-8, 8)
    b1 = nonzero(-8, 8)
    c1 = a1 * x_sol + b1 * y_sol
    
    # Second equation: a2*x + b2*y = c2
    # Make sure equations are not multiples of each other
    a2 = nonzero(-8, 8)
    b2 = nonzero(-8, 8)
    c2 = a2 * x_sol + b2 * y_sol
    
    # Check they're not multiples
    while abs(a1 * b2 - a2 * b1) < 1
        a2 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
        c2 = a2 * x_sol + b2 * y_sol
    end
    
    # Format equations nicely
    eq1_str = "$(a1)x $(b1 >= 0 ? "+" : "")$(b1)y = $(c1)"
    eq2_str = "$(a2)x $(b2 >= 0 ? "+" : "")$(b2)y = $(c2)"
    
    # Determine which variable to eliminate (pick one with matching or opposite coefficients if possible)
    eliminate_var = "x"
    multiplier1 = abs(a2)
    multiplier2 = abs(a1)
    
    if abs(b1) == abs(b2) || rand() < 0.5
        eliminate_var = "y"
        multiplier1 = abs(b2)
        multiplier2 = abs(b1)
    end
    
    problem(
        question="Solve the system using elimination:\n\$\$\\begin{cases}\n$(eq1_str) \\\\\n$(eq2_str)\n\\end{cases}\$\$",
        answer=fmt_tuple((x_sol, y_sol)),
        difficulty=(100, 700),
        answer_type="tuple",
        solution=steps(
            "System: \$\\begin{cases} $(eq1_str) \\\\ $(eq2_str) \\end{cases}\$",
            "Multiply equations to eliminate $(eliminate_var), then substitute back",
            "Solution: \$x = $(x_sol), y = $(y_sol)\$",
            sol("Answer", fmt_tuple((x_sol, y_sol)))
        ),
        time=120,
    )
end