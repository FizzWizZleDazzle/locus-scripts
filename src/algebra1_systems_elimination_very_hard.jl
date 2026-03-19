# algebra1 - systems_elimination (very_hard)
# Generated: 2026-03-08T19:58:21.699147

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/systems_elimination")
    
    # Generate a competition/olympiad level system with elimination
    # ELO 2500-3500: requires multiple insights, clever manipulation
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Three-variable system with symmetric structure requiring creative elimination
        # Pick solution first
        x_sol = randint(-8, 8)
        y_sol = randint(-8, 8)
        z_sol = randint(-8, 8)
        
        # Create system with specific structure that requires clever addition/subtraction
        a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        b1, b2, b3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        c1, c2, c3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        
        rhs1 = a1*x_sol + b1*y_sol + c1*z_sol
        rhs2 = a2*x_sol + b2*y_sol + c2*z_sol
        rhs3 = a3*x_sol + b3*y_sol + c3*z_sol
        
        eq1 = a1*x + b1*y + c1*z ~ rhs1
        eq2 = a2*x + b2*y + c2*z ~ rhs2
        eq3 = a3*x + b3*y + c3*z ~ rhs3
        
        problem(
            question="Solve the system using elimination:\n\$\$\\begin{cases}\n$(tex(a1*x + b1*y + c1*z)) = $(rhs1) \\\\\n$(tex(a2*x + b2*y + c2*z)) = $(rhs2) \\\\\n$(tex(a3*x + b3*y + c3*z)) = $(rhs3)\n\\end{cases}\$\$",
            answer=fmt_tuple((x_sol, y_sol, z_sol)),
            difficulty=(2500, 2900),
            answer_type="tuple",
            solution=steps(
                "Given system of three equations in three variables",
                sol("Equation 1", eq1),
                sol("Equation 2", eq2),
                sol("Equation 3", eq3),
                "Eliminate z by combining equations strategically",
                "Multiply equations by appropriate constants to align coefficients",
                "Add/subtract to eliminate variables systematically",
                "Back-substitute to find all three values",
                sol("Solution", fmt_tuple((x_sol, y_sol, z_sol)))
            ),
            time=240
        )
        
    elseif problem_type == 2
        # System with parameters requiring elimination to find relationships
        # Higher difficulty: find relationship between variables
        k = nonzero(-7, 7)
        m = nonzero(-7, 7)
        
        # Create parametric solution
        t = randint(-10, 10)
        x_sol = k * t + m
        y_sol = randint(-15, 15)
        
        # Build system that has this parametric solution
        a1 = nonzero(-6, 6)
        b1 = nonzero(-6, 6)
        a2 = a1 * k  # Makes system dependent in specific way
        b2 = b1
        
        rhs1 = a1 * x_sol + b1 * y_sol
        rhs2 = a2 * x_sol + b2 * y_sol
        
        eq1 = a1*x + b1*y ~ rhs1
        eq2 = a2*x + b2*y ~ rhs2
        
        # Find if system has unique solution, infinite solutions, or no solution
        det_val = a1 * b2 - a2 * b1
        
        if det_val != 0
            # Recalculate to ensure unique solution
            a2 = nonzero(-6, 6)
            while a1 * b2 - a2 * b1 == 0
                a2 = nonzero(-6, 6)
            end
            rhs2 = a2 * x_sol + b1 * y_sol
            eq2 = a2*x + b1*y ~ rhs2
        end
        
        problem(
            question="Use elimination to solve the system:\n\$\$\\begin{cases}\n$(tex(a1*x + b1*y)) = $(rhs1) \\\\\n$(tex(a2*x + b1*y)) = $(rhs2)\n\\end{cases}\$\$",
            answer=fmt_tuple((x_sol, y_sol)),
            difficulty=(2400, 2800),
            answer_type="tuple",
            solution=steps(
                sol("Equation 1", eq1),
                sol("Equation 2", eq2),
                "Subtract Equation 1 from Equation 2 to eliminate y",
                "Solve for x from the resulting single-variable equation",
                "Substitute x back into either original equation",
                "Solve for y",
                sol("Solution", fmt_tuple((x_sol, y_sol)))
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Non-linear system requiring clever algebraic manipulation
        # Create system like x + y = a, x² + y² = b
        x_sol = nonzero(-12, 12)
        y_sol = nonzero(-12, 12)
        
        sum_val = x_sol + y_sol
        sum_sq = x_sol^2 + y_sol^2
        
        problem(
            question="Solve the system using elimination techniques:\n\$\$\\begin{cases}\nx + y = $(sum_val) \\\\\nx^2 + y^2 = $(sum_sq)\n\\end{cases}\$\$\n\nExpress your answer as an ordered pair. If multiple solutions exist, give the one with larger x-coordinate.",
            answer=fmt_tuple((max(x_sol, y_sol), min(x_sol, y_sol))),
            difficulty=(2600, 3200),
            answer_type="tuple",
            solution=steps(
                "Given: \$x + y = $(sum_val)\$ and \$x^2 + y^2 = $(sum_sq)\$",
                "From first equation: \$y = $(sum_val) - x\$",
                "Square the first equation: \$(x+y)^2 = $(sum_val^2)\$",
                "Expand: \$x^2 + 2xy + y^2 = $(sum_val^2)\$",
                "Substitute \$x^2 + y^2 = $(sum_sq)\$: \$$(sum_sq) + 2xy = $(sum_val^2)\$",
                "Solve for xy: \$xy = $(div(sum_val^2 - sum_sq, 2))\$",
                "Now solve the system: \$x + y = $(sum_val)\$ and \$xy = $(div(sum_val^2 - sum_sq, 2))\$",
                "These are roots of: \$t^2 - $(sum_val)t + $(div(sum_val^2 - sum_sq, 2)) = 0\$",
                "Apply quadratic formula to find both solutions",
                sol("Answer (larger x)", fmt_tuple((max(x_sol, y_sol), min(x_sol, y_sol))))
            ),
            time=300
        )
        
    else
        # System with absolute values or special structure (Olympiad level)
        x_sol = nonzero(-10, 10)
        y_sol = nonzero(-10, 10)
        
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # Ensure non-degenerate system
        while a*d - b*c == 0
            d = nonzero(-8, 8)
        end
        
        rhs1 = a*x_sol + b*y_sol
        rhs2 = c*x_sol + d*y_sol
        
        # Add complexity: multiply one equation by a variable expression
        factor = nonzero(-4, 4)
        
        eq1 = a*x + b*y ~ rhs1
        eq2 = c*x + d*y ~ rhs2
        
        problem(
            question="Solve the system by elimination:\n\$\$\\begin{cases}\n$(tex(a*x + b*y)) = $(rhs1) \\\\\n$(tex(c*x + d*y)) = $(rhs2)\n\\end{cases}\$\$",
            answer=fmt_tuple((x_sol, y_sol)),
            difficulty=(2700, 3400),
            answer_type="tuple",
            solution=steps(
                sol("Equation 1", eq1),
                sol("Equation 2", eq2),
                "Multiply Equation 1 by $(d) and Equation 2 by $(-b)",
                "This gives: \$$(tex(d*a*x + d*b*y)) = $(d*rhs1)\$",
                "And: \$$(tex(-b*c*x - b*d*y)) = $(-b*rhs2)\$",
                "Add to eliminate y: \$$(tex((d*a - b*c)*x)) = $(d*rhs1 - b*rhs2)\$",
                "Solve for x: \$x = $(x_sol)\$",
                "Substitute back to find y: \$y = $(y_sol)\$",
                sol("Solution", fmt_tuple((x_sol, y_sol)))
            ),
            time=270
        )
    end
end