# linear_algebra - matrix_inverses (hard)
# Generated: 2026-03-08T21:09:05.141123

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # 2x2 matrix inverse computation (ELO 1800-2000)
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        c = randint(-6, 6)
        d = nonzero(-5, 5)
        det = a*d - b*c
        
        while abs(det) < 2 || abs(det) > 30
            a = nonzero(-5, 5)
            b = randint(-6, 6)
            c = randint(-6, 6)
            d = nonzero(-5, 5)
            det = a*d - b*c
        end
        
        inv_matrix = "\\begin{pmatrix} $(d//det) & $((-b)//det) \\\\ $((-c)//det) & $(a//det) \\end{pmatrix}"
        
        problem(
            question="Find the inverse of the matrix \$A = \\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}\$",
            answer=inv_matrix,
            difficulty=(1800, 2000),
            answer_type="matrix",
            solution=steps(
                "Compute the determinant: \$\\det(A) = ($a)($d) - ($b)($c) = $det\$",
                "Since \$\\det(A) \\neq 0\$, the inverse exists",
                "Apply the formula \$A^{-1} = \\frac{1}{\\det(A)} \\begin{pmatrix} d & -b \\\\ -c & a \\end{pmatrix}\$",
                sol("Answer", inv_matrix)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Condition for invertibility (ELO 1900-2100)
        a = nonzero(-8, 8)
        b = randint(-10, 10)
        c = randint(-10, 10)
        d_expr = choice(["k", "x", "t", "λ"])
        
        det_value = a*c
        ans = det_value // b
        
        problem(
            question="For what value of \$$d_expr\$ is the matrix \$A = \\begin{pmatrix} $a & $b \\\\ $c & $d_expr \\end{pmatrix}\$ NOT invertible?",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "A matrix is not invertible when its determinant equals zero",
                "Compute: \$\\det(A) = ($a)($d_expr) - ($b)($c) = 0\$",
                "Solve: \$$(a)$d_expr = $(b*c)\$",
                sol("Answer", "$d_expr = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 3
        # 3x3 determinant for invertibility (ELO 2000-2200)
        a11 = nonzero(-4, 4)
        a12 = randint(-5, 5)
        a13 = randint(-5, 5)
        a21 = randint(-5, 5)
        a22 = nonzero(-4, 4)
        a23 = randint(-5, 5)
        a31 = randint(-5, 5)
        a32 = randint(-5, 5)
        a33 = nonzero(-4, 4)
        
        det = a11*(a22*a33 - a23*a32) - a12*(a21*a33 - a23*a31) + a13*(a21*a32 - a22*a31)
        
        while abs(det) < 5
            a11 = nonzero(-4, 4)
            a12 = randint(-5, 5)
            a13 = randint(-5, 5)
            a21 = randint(-5, 5)
            a22 = nonzero(-4, 4)
            a23 = randint(-5, 5)
            a31 = randint(-5, 5)
            a32 = randint(-5, 5)
            a33 = nonzero(-4, 4)
            det = a11*(a22*a33 - a23*a32) - a12*(a21*a33 - a23*a31) + a13*(a21*a32 - a22*a31)
        end
        
        is_invertible = det != 0
        ans = is_invertible ? "Yes" : "No"
        
        problem(
            question="Is the matrix \$A = \\begin{pmatrix} $a11 & $a12 & $a13 \\\\ $a21 & $a22 & $a23 \\\\ $a31 & $a32 & $a33 \\end{pmatrix}\$ invertible? Answer Yes or No.",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "A matrix is invertible if and only if its determinant is nonzero",
                "Compute \$\\det(A)\$ using cofactor expansion along the first row:",
                "\$\\det(A) = $a11($a22 \\cdot $a33 - $a23 \\cdot $a32) - $a12($a21 \\cdot $a33 - $a23 \\cdot $a31) + $a13($a21 \\cdot $a32 - $a22 \\cdot $a31)\$",
                "\$\\det(A) = $det\$",
                sol("Answer", det != 0 ? "Yes, the matrix is invertible" : "No, the matrix is not invertible")
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Solving system using matrix inverse (ELO 2100-2300)
        x_ans = randint(-8, 8)
        y_ans = randint(-8, 8)
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        det = a*d - b*c
        while abs(det) < 2
            a = nonzero(-5, 5)
            b = nonzero(-5, 5)
            c = nonzero(-5, 5)
            d = nonzero(-5, 5)
            det = a*d - b*c
        end
        
        e = a*x_ans + b*y_ans
        f = c*x_ans + d*y_ans
        
        ans = fmt_tuple([x_ans, y_ans])
        
        problem(
            question="Use the matrix inverse method to solve the system: \$\\begin{cases} $(a)x + $(b)y = $e \\\\ $(c)x + $(d)y = $f \\end{cases}\$. Express your answer as an ordered pair \$(x, y)\$.",
            answer=ans,
            difficulty=(2100, 2300),
            answer_type="tuple",
            solution=steps(
                "Write the system as \$A\\mathbf{x} = \\mathbf{b}\$ where \$A = \\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}\$, \$\\mathbf{b} = \\begin{pmatrix} $e \\\\ $f \\end{pmatrix}\$",
                "Compute \$\\det(A) = ($a)($d) - ($b)($c) = $det\$",
                "Find \$A^{-1} = \\frac{1}{$det}\\begin{pmatrix} $d & $(-b) \\\\ $(-c) & $a \\end{pmatrix}\$",
                "Multiply: \$\\mathbf{x} = A^{-1}\\mathbf{b} = \\frac{1}{$det}\\begin{pmatrix} $d & $(-b) \\\\ $(-c) & $a \\end{pmatrix}\\begin{pmatrix} $e \\\\ $f \\end{pmatrix}\$",
                "Simplify to get \$x = $x_ans\$, \$y = $y_ans\$",
                sol("Answer", ans)
            ),
            time=240
        )
        
    else
        # Matrix equation solving with inverses (ELO 2200-2400)
        k = nonzero(-6, 6)
        m = randint(-8, 8)
        n = randint(-8, 8)
        
        a = nonzero(-4, 4)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = nonzero(-4, 4)
        
        det = a*d - b*c
        while abs(det) < 2 || abs(det) > 20
            a = nonzero(-4, 4)
            b = randint(-5, 5)
            c = randint(-5, 5)
            d = nonzero(-4, 4)
            det = a*d - b*c
        end
        
        x11 = (k*d - b*m) // det
        x12 = (k*d - b*n) // det
        x21 = (-k*c + a*m) // det
        x22 = (-k*c + a*n) // det
        
        ans_matrix = "\\begin{pmatrix} $(x11) & $(x12) \\\\ $(x21) & $(x22) \\end{pmatrix}"
        
        problem(
            question="Solve for the matrix \$X\$ in the equation \$\\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix} X = \\begin{pmatrix} $k & $k \\\\ $m & $n \\end{pmatrix}\$",
            answer=ans_matrix,
            difficulty=(2200, 2400),
            answer_type="matrix",
            solution=steps(
                "The equation is \$AX = B\$, so \$X = A^{-1}B\$",
                "Compute \$\\det(A) = ($a)($d) - ($b)($c) = $det\$",
                "Find \$A^{-1} = \\frac{1}{$det}\\begin{pmatrix} $d & $(-b) \\\\ $(-c) & $a \\end{pmatrix}\$",
                "Multiply: \$X = A^{-1}B = \\frac{1}{$det}\\begin{pmatrix} $d & $(-b) \\\\ $(-c) & $a \\end{pmatrix}\\begin{pmatrix} $k & $k \\\\ $m & $n \\end{pmatrix}\$",
                "Compute each entry and simplify",
                sol("Answer", ans_matrix)
            ),
            time=300
        )
    end
end