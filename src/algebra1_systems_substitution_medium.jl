# algebra1 - systems_substitution (medium)
# Generated: 2026-03-08T19:57:18.731249

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # Pick clean solution values first
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Generate first equation: ax + by = c
    a1 = nonzero(-8, 8)
    b1 = nonzero(-8, 8)
    c1 = a1 * x_sol + b1 * y_sol
    
    # Generate second equation in a form good for substitution
    # Either y = mx + k or x = my + k
    if rand() < 0.5
        # y = mx + k form
        m = nonzero(-6, 6)
        k = y_sol - m * x_sol
        
        eq1 = a1*x + b1*y
        eq2_solved = m*x + k
        
        # Substitute into first equation
        substituted = substitute(eq1, y => eq2_solved)
        substituted_simplified = expand(simplify(substituted))
        
        problem(
            question = "Solve the system using substitution:\n\$\$\\begin{cases} $(tex(eq1)) = $(c1) \\\\ y = $(tex(eq2_solved)) \\end{cases}\$\$",
            answer = fmt_tuple((x_sol, y_sol)),
            difficulty = (1200, 1600),
            answer_type = "tuple",
            solution = steps(
                "Given system with second equation already solved for y",
                sol("Substitute", "y = $(tex(eq2_solved)) into first equation"),
                sol("Result", substituted_simplified ~ c1),
                "Solve for x: x = $(x_sol)",
                sol("Substitute back", "y = $(tex(substitute(eq2_solved, x => x_sol)))"),
                "Simplify to get y = $(y_sol)",
                sol("Solution", fmt_tuple((x_sol, y_sol)))
            ),
            time = 180
        )
    else
        # x = my + k form
        m = nonzero(-6, 6)
        k = x_sol - m * y_sol
        
        eq1 = a1*x + b1*y
        eq2_solved = m*y + k
        
        # Substitute into first equation
        substituted = substitute(eq1, x => eq2_solved)
        substituted_simplified = expand(simplify(substituted))
        
        problem(
            question = "Solve the system using substitution:\n\$\$\\begin{cases} $(tex(eq1)) = $(c1) \\\\ x = $(tex(eq2_solved)) \\end{cases}\$\$",
            answer = fmt_tuple((x_sol, y_sol)),
            difficulty = (1200, 1600),
            answer_type = "tuple",
            solution = steps(
                "Given system with second equation already solved for x",
                sol("Substitute", "x = $(tex(eq2_solved)) into first equation"),
                sol("Result", substituted_simplified ~ c1),
                "Solve for y: y = $(y_sol)",
                sol("Substitute back", "x = $(tex(substitute(eq2_solved, y => y_sol)))"),
                "Simplify to get x = $(x_sol)",
                sol("Solution", fmt_tuple((x_sol, y_sol)))
            ),
            time = 180
        )
    end
end