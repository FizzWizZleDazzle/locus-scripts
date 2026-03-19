# linear_algebra - determinants (hard)
# Generated: 2026-03-08T21:09:54.104254

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # 2x2 determinant with parameter, solve for parameter to get specific det value
        # ELO: 1800-2000
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        target_det = nonzero(-15, 15)
        
        # det = a*d - b*c = target_det
        # so d = (target_det + b*c) / a
        d_val = (target_det + b*c) // a
        
        problem(
            question="Find the value of \\(d\\) such that \\(\\det\\begin{pmatrix} $(a) & $(b) \\\\ $(c) & d \\end{pmatrix} = $(target_det)\\).",
            answer=d_val,
            difficulty=(1800, 1950),
            solution=steps(
                "The determinant of a 2×2 matrix \\(\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}\\) is \\(ad - bc\\)",
                sol("Setup", "$(a) \\cdot d - $(b) \\cdot $(c) = $(target_det)"),
                sol("Simplify", "$(a)d - $(b*c) = $(target_det)"),
                sol("Solve for d", "$(a)d = $(target_det + b*c)"),
                sol("Answer", "d = $(d_val)")
            ),
            time=120
        )
        
    elseif problem_type == 2
        # 3x3 determinant using cofactor expansion
        # ELO: 1900-2100
        a11, a12, a13 = randint(-5, 5), nonzero(-6, 6), randint(-5, 5)
        a21, a22, a23 = nonzero(-6, 6), randint(-5, 5), nonzero(-6, 6)
        a31, a32, a33 = randint(-5, 5), nonzero(-6, 6), randint(-5, 5)
        
        # Calculate determinant using first row cofactor expansion
        minor11 = a22 * a33 - a23 * a32
        minor12 = a21 * a33 - a23 * a31
        minor13 = a21 * a32 - a22 * a31
        
        det_val = a11 * minor11 - a12 * minor12 + a13 * minor13
        
        problem(
            question="Compute \\(\\det\\begin{pmatrix} $(a11) & $(a12) & $(a13) \\\\ $(a21) & $(a22) & $(a23) \\\\ $(a31) & $(a32) & $(a33) \\end{pmatrix}\\) using cofactor expansion along the first row.",
            answer=det_val,
            difficulty=(1900, 2100),
            solution=steps(
                "Use cofactor expansion along the first row:",
                sol("Formula", "\\det(A) = a_{11}C_{11} + a_{12}C_{12} + a_{13}C_{13}"),
                "Calculate minors:",
                sol("M_{11}", "\\begin{vmatrix} $(a22) & $(a23) \\\\ $(a32) & $(a33) \\end{vmatrix} = $(minor11)"),
                sol("M_{12}", "\\begin{vmatrix} $(a21) & $(a23) \\\\ $(a31) & $(a33) \\end{vmatrix} = $(minor12)"),
                sol("M_{13}", "\\begin{vmatrix} $(a21) & $(a22) \\\\ $(a31) & $(a32) \\end{vmatrix} = $(minor13)"),
                sol("Determinant", "$(a11)($(minor11)) - $(a12)($(minor12)) + $(a13)($(minor13)) = $(det_val)")
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Determinant of triangular matrix (product of diagonal)
        # ELO: 1850-2000
        size = rand(3:5)
        diag_entries = [nonzero(-7, 7) for _ in 1:size]
        det_val = prod(diag_entries)
        
        if size == 3
            matrix_str = "\\begin{pmatrix} $(diag_entries[1]) & $(randint(-5,5)) & $(randint(-5,5)) \\\\ 0 & $(diag_entries[2]) & $(randint(-5,5)) \\\\ 0 & 0 & $(diag_entries[3]) \\end{pmatrix}"
        elseif size == 4
            matrix_str = "\\begin{pmatrix} $(diag_entries[1]) & $(randint(-5,5)) & $(randint(-5,5)) & $(randint(-5,5)) \\\\ 0 & $(diag_entries[2]) & $(randint(-5,5)) & $(randint(-5,5)) \\\\ 0 & 0 & $(diag_entries[3]) & $(randint(-5,5)) \\\\ 0 & 0 & 0 & $(diag_entries[4]) \\end{pmatrix}"
        else
            matrix_str = "\\begin{pmatrix} $(diag_entries[1]) & $(randint(-4,4)) & $(randint(-4,4)) & $(randint(-4,4)) & $(randint(-4,4)) \\\\ 0 & $(diag_entries[2]) & $(randint(-4,4)) & $(randint(-4,4)) & $(randint(-4,4)) \\\\ 0 & 0 & $(diag_entries[3]) & $(randint(-4,4)) & $(randint(-4,4)) \\\\ 0 & 0 & 0 & $(diag_entries[4]) & $(randint(-4,4)) \\\\ 0 & 0 & 0 & 0 & $(diag_entries[5]) \\end{pmatrix}"
        end
        
        problem(
            question="Find the determinant of the upper triangular matrix \\($(matrix_str)\\).",
            answer=det_val,
            difficulty=(1850, 2000),
            solution=steps(
                "For a triangular matrix, the determinant is the product of diagonal entries",
                sol("Diagonal entries", "$(join(string.(diag_entries), ", "))"),
                sol("Product", "$(join(string.(diag_entries), " \\cdot "))"),
                sol("Answer", det_val)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Row operation effect on determinant
        # ELO: 2000-2200
        original_det = nonzero(-20, 20)
        k = nonzero(-6, 6)
        
        operation_type = rand(1:3)
        if operation_type == 1
            # Multiply row by k
            new_det = k * original_det
            op_desc = "multiplying row $(rand(1:3)) by $(k)"
            explanation = "Multiplying a row by \\(k\\) multiplies the determinant by \\(k\\)"
        elseif operation_type == 2
            # Swap two rows
            new_det = -original_det
            op_desc = "swapping rows $(rand(1:2)) and $(rand(2:3))"
            explanation = "Swapping two rows negates the determinant"
        else
            # Add multiple of one row to another
            new_det = original_det
            op_desc = "adding $(k) times row $(rand(1:2)) to row $(rand(2:3))"
            explanation = "Adding a multiple of one row to another does not change the determinant"
        end
        
        problem(
            question="If matrix \\(A\\) has \\(\\det(A) = $(original_det)\\), and matrix \\(B\\) is obtained from \\(A\\) by $(op_desc), what is \\(\\det(B)\\)?",
            answer=new_det,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "\\det(A) = $(original_det)"),
                "$(explanation)",
                sol("Therefore", "\\det(B) = $(new_det)")
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Determinant with variable, find when det = 0 (singular)
        # ELO: 2100-2300
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        while r2 == r1
            r2 = nonzero(-10, 10)
        end
        
        # Create matrix that has det = (λ-r1)(λ-r2)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        # For 2x2 with λ on diagonal: det = (λ-a11)(λ-a22) - a12*a21
        # We want det = (λ-r1)(λ-r2) = λ² - (r1+r2)λ + r1*r2
        # So we need a11 + a22 = r1+r2 and a11*a22 - a12*a21 = r1*r2
        
        # Simpler: use characteristic polynomial structure
        # det(λI - A) for A = [[a, b], [c, d]]
        # = λ² - (a+d)λ + (ad-bc)
        
        trace = r1 + r2
        det_constant = r1 * r2
        
        a11 = randint(-4, 4)
        a22 = trace - a11
        # Need a11*a22 - a12*a21 = det_constant
        a12 = nonzero(-5, 5)
        a21_times_a12 = a11 * a22 - det_constant
        if a12 != 0 && a21_times_a12 % a12 == 0
            a21 = a21_times_a12 // a12
        else
            a21 = nonzero(-5, 5)
        end
        
        problem(
            question="For what values of \\(\\lambda\\) is the matrix \\(\\begin{pmatrix} \\lambda - $(a11) & $(-a12) \\\\ $(-a21) & \\lambda - $(a22) \\end{pmatrix}\\) singular?",
            answer=fmt_set(Set([r1, r2])),
            answer_type="set",
            difficulty=(2100, 2300),
            solution=steps(
                "A matrix is singular when its determinant equals zero",
                sol("Determinant", "(\\lambda - $(a11))(\\lambda - $(a22)) - $(-a12) \\cdot $(-a21) = 0"),
                "Expand to get characteristic equation",
                sol("Factor", "(\\lambda - $(r1))(\\lambda - $(r2)) = 0"),
                sol("Solutions", "\\{$(r1), $(r2)\\}")
            ),
            time=180
        )
        
    else
        # Determinant property: det(AB) = det(A)det(B)
        # ELO: 2150-2400
        det_A = nonzero(-12, 12)
        det_B = nonzero(-12, 12)
        k = nonzero(-5, 5)
        
        query_type = rand(1:3)
        if query_type == 1
            # det(AB)
            ans = det_A * det_B
            expr = "AB"
            calc = "$(det_A) \\cdot $(det_B)"
        elseif query_type == 2
            # det(A^k)
            ans = det_A^k
            expr = "A^{$(k)}"
            calc = "$(det_A)^{$(k)}"
        else
            # det(kA) for n×n matrix
            n = rand(2:4)
            ans = (k^n) * det_A
            expr = "$(k)A"
            calc = "$(k)^{$(n)} \\cdot $(det_A)"
        end
        
        problem(
            question="If \\(A\\) and \\(B\\) are \\($(query_type == 3 ? n : 3)\\times $(query_type == 3 ? n : 3)\\) matrices with \\(\\det(A) = $(det_A)\\) and \\(\\det(B) = $(det_B)\\), find \\(\\det($(expr))\\).",
            answer=ans,
            difficulty=(2150, 2400),
            solution=steps(
                sol("Given", "\\det(A) = $(det_A), \\det(B) = $(det_B)"),
                if query_type == 1
                    "Use property: \\(\\det(AB) = \\det(A) \\cdot \\det(B)\\)"
                elseif query_type == 2
                    "Use property: \\(\\det(A^k) = (\\det(A))^k\\)"
                else
                    "Use property: \\(\\det(kA) = k^n \\det(A)\\) for \\(n \\times n\\) matrix"
                end,
                sol("Calculation", "\\det($(expr)) = $(calc)"),
                sol("Answer", ans)
            ),
            time=150
        )
    end
end