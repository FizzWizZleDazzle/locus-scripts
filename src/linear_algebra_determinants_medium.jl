# linear_algebra - determinants (medium)
# Generated: 2026-03-08T21:09:29.472750

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # 2x2 determinant computation (1200-1400)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        det_val = a*d - b*c
        
        problem(
            question="Calculate the determinant of the matrix \$\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$",
            answer=det_val,
            difficulty=(1200, 1400),
            solution=steps(
                "Given matrix: \$\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$",
                "Apply formula: \$\\det(A) = ad - bc\$",
                sol("Calculation", "$(a)($(d)) - $(b)($(c)) = $(a*d) - $(b*c) = $(det_val)")
            ),
            time=60
        )
        
    elseif problem_type == 2
        # 3x3 determinant with cofactor expansion (1400-1600)
        a11 = randint(-5, 5)
        a12 = randint(-5, 5)
        a13 = randint(-5, 5)
        a21 = randint(-5, 5)
        a22 = randint(-5, 5)
        a23 = randint(-5, 5)
        a31 = randint(-5, 5)
        a32 = randint(-5, 5)
        a33 = randint(-5, 5)
        
        # Calculate determinant using first row expansion
        minor1 = a22*a33 - a23*a32
        minor2 = a21*a33 - a23*a31
        minor3 = a21*a32 - a22*a31
        det_val = a11*minor1 - a12*minor2 + a13*minor3
        
        problem(
            question="Calculate the determinant of \$\\begin{bmatrix} $(a11) & $(a12) & $(a13) \\\\ $(a21) & $(a22) & $(a23) \\\\ $(a31) & $(a32) & $(a33) \\end{bmatrix}\$ using cofactor expansion along the first row.",
            answer=det_val,
            difficulty=(1400, 1600),
            solution=steps(
                "Expand along first row: \$\\det(A) = a_{11}C_{11} + a_{12}C_{12} + a_{13}C_{13}\$",
                "Minors: \$M_{11} = $(minor1)\$, \$M_{12} = $(minor2)\$, \$M_{13} = $(minor3)\$",
                sol("Calculation", "$(a11)($(minor1)) - $(a12)($(minor2)) + $(a13)($(minor3)) = $(det_val)")
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Determinant with parameter (1500-1700)
        a = randint(-6, 6)
        b = randint(-6, 6)
        c = randint(-6, 6)
        d = randint(-6, 6)
        
        # Matrix [[a, x], [c, d]] has det = ad - cx
        # We want det = 0, so x = ad/c (if c != 0)
        if c == 0
            c = nonzero(-6, 6)
        end
        
        ans = (a*d) // c
        
        problem(
            question="For what value of \$x\$ is the determinant of \$\\begin{bmatrix} $(a) & x \\\\ $(c) & $(d) \\end{bmatrix}\$ equal to zero?",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Set up equation: \$\\det(A) = 0\$",
                sol("Determinant formula", "$(a)($(d)) - x($(c)) = 0"),
                sol("Solve for x", "x = \\frac{$(a*d)}{$(c)} = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Determinant of triangular matrix (1200-1400)
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        r1 = randint(-6, 6)
        r2 = randint(-6, 6)
        r3 = randint(-6, 6)
        det_val = a * b * c
        
        problem(
            question="Calculate the determinant of the upper triangular matrix \$\\begin{bmatrix} $(a) & $(r1) & $(r2) \\\\ 0 & $(b) & $(r3) \\\\ 0 & 0 & $(c) \\end{bmatrix}\$",
            answer=det_val,
            difficulty=(1200, 1400),
            solution=steps(
                "For a triangular matrix, the determinant equals the product of diagonal entries",
                sol("Diagonal entries", "$(a), $(b), $(c)"),
                sol("Answer", "\\det(A) = $(a) \\cdot $(b) \\cdot $(c) = $(det_val)")
            ),
            time=60
        )
        
    else
        # Row operation effect on determinant (1600-1800)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        k = nonzero(-4, 4)
        
        det_original = a*d - b*c
        det_new = det_original  # Adding k*row1 to row2 doesn't change det
        
        problem(
            question="Matrix \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$ has determinant \$\\det(A) = $(det_original)\$. What is the determinant of the matrix obtained by adding $(k) times the first row to the second row?",
            answer=det_new,
            difficulty=(1600, 1800),
            solution=steps(
                "Row operation: \$R_2 \\to R_2 + $(k)R_1\$",
                "Adding a multiple of one row to another does NOT change the determinant",
                sol("Answer", "\\det(A') = $(det_new)")
            ),
            time=120
        )
    end
end