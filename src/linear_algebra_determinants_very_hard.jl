# linear_algebra - determinants (very_hard)
# Generated: 2026-03-08T21:10:06.371334

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Determinant with polynomial entries, find value of parameter
        # AMC/AIME level: 2200-2800
        n = choice([3, 4])
        param = choice(['a', 'b', 'c', 'λ', 'k'])
        target_det = randint(-50, 50)
        
        if n == 3
            # Create a matrix with a parameter that makes det = target_det
            a11, a12, a13 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a21, a22, a23 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a31, a32 = randint(-5, 5), randint(-5, 5)
            
            # Make a33 = param, solve for param such that det = target_det
            # det = a11(a22*a33 - a23*a32) - a12(a21*a33 - a23*a31) + a13(a21*a32 - a22*a31)
            coeff_a33 = a11*a22 - a12*a21
            constant_term = -a11*a23*a32 + a12*a23*a31 + a13*a21*a32 - a13*a22*a31
            
            if coeff_a33 != 0
                param_value = (target_det - constant_term) // coeff_a33
                
                matrix_str = "\\begin{vmatrix} $(a11) & $(a12) & $(a13) \\\\ $(a21) & $(a22) & $(a23) \\\\ $(a31) & $(a32) & $(param) \\end{vmatrix}"
                
                problem(
                    question="Find the value of \\($(param)\\) such that $(matrix_str) = $(target_det)",
                    answer=param_value,
                    difficulty=(2200, 2800),
                    solution=steps(
                        "Expand the determinant along the third row",
                        "\\($(a31) \\cdot \\begin{vmatrix} $(a12) & $(a13) \\\\ $(a22) & $(a23) \\end{vmatrix} - $(a32) \\cdot \\begin{vmatrix} $(a11) & $(a13) \\\\ $(a21) & $(a23) \\end{vmatrix} + $(param) \\cdot \\begin{vmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{vmatrix}\\)",
                        "Compute 2×2 determinants: \\($(a31)($(a12*a23 - a13*a22)) - $(a32)($(a11*a23 - a13*a21)) + $(param)($(coeff_a33))\\)",
                        "Simplify: \\($(constant_term) + $(coeff_a33)$(param) = $(target_det)\\)",
                        sol("Solve for $(param)", param_value)
                    ),
                    time=240,
                    calculator="scientific"
                )
            else
                # Fallback: simpler problem
                param_value = randint(-15, 15)
                matrix_str = "\\begin{vmatrix} $(param) & 1 & 2 \\\\ 3 & $(param) & 4 \\\\ 5 & 6 & $(param) \\end{vmatrix}"
                # det = param^3 + 3*4*6 + 2*3*6 - 2*param*5 - param*4*6 - param*1*3
                # = param^3 - 34*param + 108
                
                problem(
                    question="Find all real values of \\($(param)\\) for which $(matrix_str) = 0",
                    answer=fmt_set(Set([param_value])),
                    difficulty=(2500, 3000),
                    answer_type="set",
                    solution=steps(
                        "Expand determinant to get cubic in \\($(param)\\)",
                        "\\($(param)^3 - 34$(param) + 108 = 0\\)",
                        "Factor or use rational root theorem",
                        sol("Solution", param_value)
                    ),
                    time=300,
                    calculator="scientific"
                )
            end
        else
            # 4×4 case with special structure
            param_value = randint(-8, 8)
            
            problem(
                question="Let \\(A\\) be a 4×4 matrix with \\(\\det(A) = 12\\). Find \\(\\det(3A^2)\\).",
                answer=12^2 * 3^4,
                difficulty=(2400, 2800),
                solution=steps(
                    "Use property: \\(\\det(cA) = c^n \\det(A)\\) for \\(n \\times n\\) matrix",
                    "Also: \\(\\det(A^2) = (\\det(A))^2\\)",
                    "\\(\\det(3A^2) = 3^4 \\det(A^2) = 81 \\cdot 12^2\\)",
                    sol("Answer", 12^2 * 81)
                ),
                time=180,
                calculator="scientific"
            )
        end
        
    elseif problem_type == 2
        # Vandermonde-type or structured determinant
        # USAMO level: 3000-3500
        
        a = randint(2, 5)
        b = randint(2, 5)
        c = randint(2, 5)
        
        # Vandermonde determinant formula
        vandermonde_val = (b - a) * (c - a) * (c - b)
        
        matrix_str = "\\begin{vmatrix} 1 & $(a) & $(a^2) \\\\ 1 & $(b) & $(b^2) \\\\ 1 & $(c) & $(c^2) \\end{vmatrix}"
        
        problem(
            question="Evaluate $(matrix_str). (This is a Vandermonde determinant.)",
            answer=vandermonde_val,
            difficulty=(2800, 3200),
            solution=steps(
                "Recognize this as a Vandermonde determinant with nodes \\($(a), $(b), $(c)\\)",
                "Formula: \\(\\det(V) = \\prod_{i<j} (x_j - x_i)\\)",
                "\\(= ($(b) - $(a))($(c) - $(a))($(c) - $(b))\\)",
                sol("Answer", vandermonde_val)
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Determinant involving recurrence or pattern
        # Olympiad level: 3200-3800
        
        n = choice([4, 5, 6])
        
        # Tridiagonal determinant with 2 on diagonal, -1 on off-diagonals
        # These satisfy recurrence D_n = 2*D_{n-1} - D_{n-2}
        # D_1 = 2, D_2 = 3, D_3 = 4, D_4 = 5, ...
        # Pattern: D_n = n+1
        
        det_value = n + 1
        
        if n == 4
            matrix_str = "\\begin{vmatrix} 2 & -1 & 0 & 0 \\\\ -1 & 2 & -1 & 0 \\\\ 0 & -1 & 2 & -1 \\\\ 0 & 0 & -1 & 2 \\end{vmatrix}"
        elseif n == 5
            matrix_str = "\\begin{vmatrix} 2 & -1 & 0 & 0 & 0 \\\\ -1 & 2 & -1 & 0 & 0 \\\\ 0 & -1 & 2 & -1 & 0 \\\\ 0 & 0 & -1 & 2 & -1 \\\\ 0 & 0 & 0 & -1 & 2 \\end{vmatrix}"
        else
            matrix_str = "\\begin{vmatrix} 2 & -1 & 0 & 0 & 0 & 0 \\\\ -1 & 2 & -1 & 0 & 0 & 0 \\\\ 0 & -1 & 2 & -1 & 0 & 0 \\\\ 0 & 0 & -1 & 2 & -1 & 0 \\\\ 0 & 0 & 0 & -1 & 2 & -1 \\\\ 0 & 0 & 0 & 0 & -1 & 2 \\end{vmatrix}"
        end
        
        problem(
            question="Evaluate the $(n)×$(n) tridiagonal determinant: $(matrix_str)",
            answer=det_value,
            difficulty=(3000, 3500),
            solution=steps(
                "Let \\(D_n\\) denote this \\(n \\times n\\) determinant",
                "Expand along first row: \\(D_n = 2D_{n-1} - (-1)(-1)D_{n-2} = 2D_{n-1} - D_{n-2}\\)",
                "Base cases: \\(D_1 = 2\\), \\(D_2 = 3\\)",
                "Solve recurrence to get \\(D_n = n+1\\)",
                sol("Answer", det_value)
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Determinant with geometric/algebraic constraint
        # Competition level: 2600-3200
        
        # Matrix with constraint that columns sum to same value
        k = randint(5, 15)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = k - a - b
        
        d = randint(-8, 8)
        e = randint(-8, 8)
        f = k - d - e
        
        g = randint(-8, 8)
        h = randint(-8, 8)
        i = k - g - h
        
        matrix_str = "\\begin{vmatrix} $(a) & $(d) & $(g) \\\\ $(b) & $(e) & $(h) \\\\ $(c) & $(f) & $(i) \\end{vmatrix}"
        
        problem(
            question="Each column of the matrix $(matrix_str) sums to $(k). What is the value of the determinant?",
            answer=0,
            difficulty=(2600, 3000),
            solution=steps(
                "If all columns sum to the same value \\(k\\), the rows are linearly dependent",
                "Specifically, row 1 + row 2 + row 3 = \\(($(k), $(k), $(k))\\) = \\(k(1,1,1)\\)",
                "A matrix with linearly dependent rows has determinant 0",
                sol("Answer", 0)
            ),
            time=180,
            calculator="none"
        )
        
    else
        # Problem involving determinant and eigenvalues
        # Olympiad level: 3200-3800
        
        lambda1 = randint(-5, 5)
        lambda2 = randint(-5, 5)
        lambda3 = randint(-5, 5)
        
        det_A = lambda1 * lambda2 * lambda3
        trace_A = lambda1 + lambda2 + lambda3
        
        k = randint(2, 4)
        
        # det(A - kI) = (lambda1 - k)(lambda2 - k)(lambda3 - k)
        det_shifted = (lambda1 - k) * (lambda2 - k) * (lambda3 - k)
        
        problem(
            question="Let \\(A\\) be a 3×3 matrix with eigenvalues \\($(lambda1), $(lambda2), $(lambda3)\\). Find \\(\\det(A - $(k)I)\\), where \\(I\\) is the identity matrix.",
            answer=det_shifted,
            difficulty=(3000, 3400),
            solution=steps(
                "If \\(\\lambda\\) is an eigenvalue of \\(A\\), then \\(\\lambda - $(k)\\) is an eigenvalue of \\(A - $(k)I\\)",
                "The eigenvalues of \\(A - $(k)I\\) are \\($(lambda1 - k), $(lambda2 - k), $(lambda3 - k)\\)",
                "Determinant equals product of eigenvalues",
                sol("\\det(A - $(k)I)", det_shifted)
            ),
            time=240,
            calculator="scientific"
        )
    end
end