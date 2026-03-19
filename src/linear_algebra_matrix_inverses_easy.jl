# linear_algebra - matrix_inverses (easy)
# Generated: 2026-03-08T21:08:30.877222

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # 2x2 determinant calculation (700-900 ELO)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        det = a*d - b*c
        
        problem(
            question="Find the determinant of the matrix \$\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$",
            answer=det,
            difficulty=(700, 900),
            solution=steps(
                "Use the formula for 2×2 determinant: \$\\det(A) = ad - bc\$",
                sol("Calculation", "$(a) \\cdot $(d) - $(b) \\cdot $(c) = $(a*d) - $(b*c)"),
                sol("Answer", det)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Check if 2x2 matrix is invertible (800-1000 ELO)
        if choice([true, false])
            # Make non-invertible (det = 0)
            a = nonzero(-10, 10)
            b = nonzero(-10, 10)
            k = nonzero(-5, 5)
            c = k * a
            d = k * b
            det = 0
            ans = "No"
        else
            # Make invertible (det ≠ 0)
            a = randint(-8, 8)
            b = randint(-8, 8)
            c = randint(-8, 8)
            d = randint(-8, 8)
            det = a*d - b*c
            while det == 0
                d = randint(-8, 8)
                det = a*d - b*c
            end
            ans = "Yes"
        end
        
        problem(
            question="Is the matrix \$\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$ invertible? Answer Yes or No.",
            answer=ans,
            difficulty=(800, 1000),
            answer_type="text",
            solution=steps(
                "A matrix is invertible if and only if its determinant is nonzero",
                sol("Determinant", "$(a) \\cdot $(d) - $(b) \\cdot $(c) = $(det)"),
                det == 0 ? "Since the determinant is 0, the matrix is NOT invertible" : "Since the determinant is nonzero, the matrix IS invertible",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Compute 2x2 inverse (900-1100 ELO)
        # Pick d, b, c first, then choose a so det = 1 or -1 for clean inverse
        d = randint(-6, 6)
        b = randint(-6, 6)
        c = randint(-6, 6)
        det = choice([1, -1, 2, -2])
        a = (det + b*c) // d
        
        # Make sure a is an integer
        while !isinteger(a) || abs(a) > 10
            d = nonzero(-6, 6)
            b = randint(-6, 6)
            c = randint(-6, 6)
            det = choice([1, -1, 2, -2])
            a = (det + b*c) // d
        end
        a = Int(a)
        
        # Inverse formula: (1/det) * [d, -b; -c, a]
        inv_a = d // det
        inv_b = -b // det
        inv_c = -c // det
        inv_d = a // det
        
        problem(
            question="Find the inverse of the matrix \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$. Enter your answer as a matrix.",
            answer=fmt_matrix([[inv_a, inv_b], [inv_c, inv_d]]),
            difficulty=(900, 1100),
            answer_type="matrix",
            solution=steps(
                sol("Given matrix", "A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"),
                sol("Determinant", "\\det(A) = $(a) \\cdot $(d) - $(b) \\cdot $(c) = $(det)"),
                "Use formula: \$A^{-1} = \\frac{1}{\\det(A)} \\begin{bmatrix} d & -b \\\\ -c & a \\end{bmatrix}\$",
                sol("Answer", "A^{-1} = \\frac{1}{$(det)} \\begin{bmatrix} $(d) & $(-b) \\\\ $(-c) & $(a) \\end{bmatrix} = \\begin{bmatrix} $(inv_a) & $(inv_b) \\\\ $(inv_c) & $(inv_d) \\end{bmatrix}")
            ),
            time=120
        )
        
    else
        # Solve matrix equation AX = B for 2x2 (1000-1200 ELO)
        # Choose X first (the answer), then B, then invertible A
        x1 = randint(-5, 5)
        x2 = randint(-5, 5)
        
        b1 = randint(-10, 10)
        b2 = randint(-10, 10)
        
        # Make A with det = ±1 or ±2
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        det = choice([1, -1, 2, -2])
        d = (det + b*c) // a
        
        while !isinteger(d) || abs(d) > 8 || a == 0
            a = nonzero(-5, 5)
            b = randint(-5, 5)
            c = randint(-5, 5)
            det = choice([1, -1, 2, -2])
            d = (det + b*c) // a
        end
        d = Int(d)
        
        # Verify and compute B = AX
        b1 = a*x1 + b*x2
        b2 = c*x1 + d*x2
        
        problem(
            question="Solve for the matrix \$X\$ in the equation \$AX = B\$ where \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$ and \$B = \\begin{bmatrix} $(b1) \\\\ $(b2) \\end{bmatrix}\$",
            answer=fmt_matrix([[x1], [x2]]),
            difficulty=(1000, 1200),
            answer_type="matrix",
            solution=steps(
                "To solve \$AX = B\$, multiply both sides by \$A^{-1}\$: \$X = A^{-1}B\$",
                sol("Determinant of A", "\\det(A) = $(a) \\cdot $(d) - $(b) \\cdot $(c) = $(det)"),
                sol("Inverse", "A^{-1} = \\frac{1}{$(det)} \\begin{bmatrix} $(d) & $(-b) \\\\ $(-c) & $(a) \\end{bmatrix}"),
                "Multiply \$A^{-1}B\$ to get \$X\$",
                sol("Answer", "X = \\begin{bmatrix} $(x1) \\\\ $(x2) \\end{bmatrix}")
            ),
            time=180
        )
    end
end