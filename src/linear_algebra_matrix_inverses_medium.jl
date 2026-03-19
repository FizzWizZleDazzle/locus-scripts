# linear_algebra - matrix_inverses (medium)
# Generated: 2026-03-08T21:08:52.715769

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # 2x2 matrix inverse computation
        a = nonzero(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = nonzero(-5, 5)
        
        det_val = a*d - b*c
        for _attempt in 1:1000
            det_val == 0 || break
            d = nonzero(-5, 5)
            det_val = a*d - b*c
        end

        inv_a = d // det_val
        inv_b = -b // det_val
        inv_c = -c // det_val
        inv_d = a // det_val
        
        A_str = "\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}"
        inv_str = "\\begin{bmatrix} $(inv_a) & $(inv_b) \\\\ $(inv_c) & $(inv_d) \\end{bmatrix}"
        
        problem(
            question="Find the inverse of the matrix \$A = $A_str\$",
            answer=inv_str,
            difficulty=(1200, 1400),
            answer_type="matrix",
            solution=steps(
                "Given: \$A = $A_str\$",
                sol("Determinant", "\\det(A) = $(a)($(d)) - $(b)($(c)) = $(det_val)"),
                "Apply formula: \$A^{-1} = \\frac{1}{\\det(A)} \\begin{bmatrix} d & -b \\\\ -c & a \\end{bmatrix}\$",
                sol("Answer", inv_str)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Check if matrix is invertible (determinant test)
        a = randint(-6, 6)
        b = randint(-6, 6)
        c = randint(-6, 6)
        
        if choice([true, false])
            # Make it non-invertible (det = 0)
            d = (b * c) // a
            if denominator(d) != 1
                d = 0
            else
                d = numerator(d)
            end
            ans = "No"
            det_val = a*d - b*c
        else
            # Make it invertible
            d = nonzero(-6, 6)
            det_val = a*d - b*c
            for _attempt in 1:1000
                det_val == 0 || break
                d = nonzero(-6, 6)
                det_val = a*d - b*c
            end
            ans = "Yes"
        end
        
        A_str = "\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}"
        
        problem(
            question="Is the matrix \$A = $A_str\$ invertible? Answer Yes or No.",
            answer=ans,
            difficulty=(1100, 1300),
            answer_type="text",
            solution=steps(
                "Given: \$A = $A_str\$",
                sol("Determinant", "\\det(A) = $(a)($(d)) - $(b)($(c)) = $(det_val)"),
                "A matrix is invertible if and only if its determinant is nonzero",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Solve system using matrix inverse: Ax = b
        a = nonzero(-4, 4)
        b = randint(-4, 4)
        c = randint(-4, 4)
        d = nonzero(-4, 4)
        
        det_val = a*d - b*c
        for _attempt in 1:1000
            det_val == 0 || break
            d = nonzero(-4, 4)
            det_val = a*d - b*c
        end

        # Choose solution
        x_sol = randint(-8, 8)
        y_sol = randint(-8, 8)
        
        # Compute b vector
        e = a*x_sol + b*y_sol
        f = c*x_sol + d*y_sol
        
        A_str = "\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}"
        b_str = "\\begin{bmatrix} $e \\\\ $f \\end{bmatrix}"
        ans_str = "($x_sol, $y_sol)"
        
        problem(
            question="Solve the system \$A\\mathbf{x} = \\mathbf{b}\$ where \$A = $A_str\$ and \$\\mathbf{b} = $b_str\$. Give your answer as an ordered pair \$(x, y)\$.",
            answer=ans_str,
            difficulty=(1400, 1600),
            answer_type="point",
            solution=steps(
                "Given: \$A = $A_str\$, \$\\mathbf{b} = $b_str\$",
                sol("Determinant", "\\det(A) = $(det_val)"),
                "Compute \$A^{-1}\$ and multiply: \$\\mathbf{x} = A^{-1}\\mathbf{b}\$",
                sol("Answer", "(x, y) = $ans_str")
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Find determinant given that inverse exists and one element
        a = nonzero(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = nonzero(-5, 5)
        
        det_val = a*d - b*c
        for _attempt in 1:1000
            (det_val == 0 || abs(det_val) > 20) || break
            d = nonzero(-5, 5)
            det_val = a*d - b*c
        end
        
        inv_11 = d // det_val
        
        A_str = "\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}"
        
        problem(
            question="If \$A = $A_str\$ and \$A^{-1} = \\begin{bmatrix} $(inv_11) & * \\\\ * & * \\end{bmatrix}\$ (where * represents unknown entries), find \$\\det(A)\$.",
            answer=det_val,
            difficulty=(1300, 1500),
            solution=steps(
                "Given: \$A = $A_str\$",
                "The (1,1) entry of \$A^{-1}\$ is \$\\frac{d}{\\det(A)} = \\frac{$d}{\\det(A)} = $(inv_11)\$",
                "Solving: \$\\det(A) = \\frac{$d}{$(inv_11)} = $(det_val)\$",
                sol("Answer", det_val)
            ),
            time=150
        )
        
    else
        # Verify inverse relationship: check if AB = I
        a = nonzero(-3, 3)
        b = randint(-3, 3)
        c = randint(-3, 3)
        d = nonzero(-3, 3)
        
        det_val = a*d - b*c
        for _attempt in 1:1000
            det_val == 0 || break
            d = nonzero(-3, 3)
            det_val = a*d - b*c
        end

        inv_a = d // det_val
        inv_b = -b // det_val
        inv_c = -c // det_val
        inv_d = a // det_val
        
        # Multiply to verify we get I
        prod_11 = a*inv_a + b*inv_c
        prod_12 = a*inv_b + b*inv_d
        prod_21 = c*inv_a + d*inv_c
        prod_22 = c*inv_b + d*inv_d
        
        A_str = "\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}"
        B_str = "\\begin{bmatrix} $(inv_a) & $(inv_b) \\\\ $(inv_c) & $(inv_d) \\end{bmatrix}"
        
        ans = "Yes"
        
        problem(
            question="Verify that \$B = $B_str\$ is the inverse of \$A = $A_str\$ by computing \$AB\$. Does \$AB = I\$? Answer Yes or No.",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "Given: \$A = $A_str\$, \$B = $B_str\$",
                "Compute: \$AB = \\begin{bmatrix} $(prod_11) & $(prod_12) \\\\ $(prod_21) & $(prod_22) \\end{bmatrix} = I\$",
                "Since \$AB = I\$, \$B = A^{-1}\$",
                sol("Answer", "Yes")
            ),
            time=150
        )
    end
end