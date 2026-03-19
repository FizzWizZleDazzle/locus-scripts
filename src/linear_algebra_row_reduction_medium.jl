# linear_algebra - row_reduction (medium)
# Generated: 2026-03-08T21:06:55.296010

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/row_reduction")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # RREF of 2x3 augmented matrix (one solution)
        # ELO: 1200-1400
        x_sol = randint(-8, 8)
        y_sol = randint(-8, 8)
        
        a11 = nonzero(-5, 5)
        a12 = nonzero(-5, 5)
        b1 = a11 * x_sol + a12 * y_sol
        
        a21 = nonzero(-5, 5)
        a22 = nonzero(-5, 5)
        b2 = a21 * x_sol + a22 * y_sol
        
        # Ensure non-singular
        while a11 * a22 == a12 * a21
            a22 = nonzero(-5, 5)
        end
        
        mat = [[a11, a12, b1], [a21, a22, b2]]
        
        problem(
            question="Find the solution (x, y) by row reducing the augmented matrix to RREF: " * fmt_matrix(mat),
            answer=fmt_tuple([x_sol, y_sol]),
            difficulty=(1200, 1400),
            answer_type="tuple",
            solution=steps(
                "Start with augmented matrix: " * fmt_matrix(mat),
                "Apply row operations to obtain RREF",
                "The RREF gives x = $x_sol and y = $y_sol",
                sol("Solution", (x_sol, y_sol))
            ),
            time=180
        )
        
    elseif problem_type == 2
        # RREF of 3x4 augmented matrix (one solution)
        # ELO: 1400-1600
        x_sol = randint(-6, 6)
        y_sol = randint(-6, 6)
        z_sol = randint(-6, 6)
        
        a11 = nonzero(-4, 4)
        a12 = nonzero(-4, 4)
        a13 = nonzero(-4, 4)
        b1 = a11 * x_sol + a12 * y_sol + a13 * z_sol
        
        a21 = nonzero(-4, 4)
        a22 = nonzero(-4, 4)
        a23 = nonzero(-4, 4)
        b2 = a21 * x_sol + a22 * y_sol + a23 * z_sol
        
        a31 = nonzero(-4, 4)
        a32 = nonzero(-4, 4)
        a33 = nonzero(-4, 4)
        b3 = a31 * x_sol + a32 * y_sol + a33 * z_sol
        
        mat = [[a11, a12, a13, b1], [a21, a22, a23, b2], [a31, a32, a33, b3]]
        
        problem(
            question="Row reduce to RREF and find the solution (x, y, z): " * fmt_matrix(mat),
            answer=fmt_tuple([x_sol, y_sol, z_sol]),
            difficulty=(1400, 1600),
            answer_type="tuple",
            solution=steps(
                "Augmented matrix: " * fmt_matrix(mat),
                "Perform Gaussian elimination with back substitution",
                "Apply row operations systematically to reach RREF",
                sol("Solution", (x_sol, y_sol, z_sol))
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Identify number of solutions from RREF
        # ELO: 1300-1500
        scenario = choice(1:3)
        
        if scenario == 1
            # Unique solution
            x_sol = randint(-7, 7)
            y_sol = randint(-7, 7)
            rref = [[1, 0, x_sol], [0, 1, y_sol]]
            answer = "one"
        elseif scenario == 2
            # Infinitely many (free variable)
            c = randint(-8, 8)
            rref = [[1, nonzero(-5, 5), c], [0, 0, 0]]
            answer = "infinitely many"
        else
            # No solution (contradiction)
            rref = [[1, 0, randint(-8, 8)], [0, 0, nonzero(-8, 8)]]
            answer = "none"
        end
        
        problem(
            question="How many solutions does the system have given this RREF? " * fmt_matrix(rref) * " (Answer: 'one', 'none', or 'infinitely many')",
            answer=answer,
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "RREF: " * fmt_matrix(rref),
                scenario == 1 ? "Each variable has a pivot: unique solution" : 
                scenario == 2 ? "Free variable in column 2: infinitely many solutions" :
                "Row [0, 0, $(rref[2][3])] is a contradiction: no solution",
                sol("Number of solutions", answer)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Determine value of parameter for consistency
        # ELO: 1500-1700
        x_sol = randint(-5, 5)
        y_sol = randint(-5, 5)
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = a * x_sol + b * y_sol
        
        d = nonzero(-4, 4)
        e = nonzero(-4, 4)
        
        # For consistency, k must equal d*x_sol + e*y_sol
        k_value = d * x_sol + e * y_sol
        
        mat_str = "\\begin{bmatrix}$a & $b & $c \\\\ $d & $e & k\\end{bmatrix}"
        
        problem(
            question="For what value of k does the system have at least one solution? " * mat_str,
            answer=k_value,
            difficulty=(1500, 1700),
            solution=steps(
                "Augmented matrix: " * mat_str,
                "Row 2 must be consistent with Row 1 after elimination",
                "If Row 1 gives x=$(x_sol), y=$(y_sol), then k = $d·$(x_sol) + $e·$(y_sol)",
                sol("k", k_value)
            ),
            time=180
        )
        
    else
        # Find parametric solution with free variable
        # ELO: 1600-1800
        lead = nonzero(-4, 4)
        coeff = nonzero(-4, 4)
        const_term = randint(-10, 10)
        
        # RREF: [1, coeff, const_term]
        # x + coeff*y = const_term
        # x = const_term - coeff*y
        # Let y = t (free variable)
        
        rref = [[1, coeff, const_term]]
        
        problem(
            question="Express the solution set in parametric form (x = ?, y = t) for the RREF: " * fmt_matrix(rref),
            answer="x=$(const_term)-$(coeff)t, y=t",
            difficulty=(1600, 1800),
            answer_type="text",
            solution=steps(
                "RREF: " * fmt_matrix(rref),
                "This represents: x + $(coeff)y = $(const_term)",
                "Let y = t (free variable)",
                "Then x = $(const_term) - $(coeff)t",
                sol("Parametric solution", "x = $(const_term) - $(coeff)t, y = t")
            ),
            time=150
        )
    end
end