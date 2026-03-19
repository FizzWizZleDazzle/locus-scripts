# linear_algebra - determinants (easy)
# Generated: 2026-03-08T21:09:27.747870

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # 2x2 determinant - basic calculation (700-900 ELO)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        det_val = a*d - b*c
        
        matrix_str = "\\begin{vmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{vmatrix}"
        
        problem(
            question="Calculate the determinant: \$$(matrix_str)\$",
            answer=det_val,
            difficulty=(700, 900),
            solution=steps(
                "Use the formula for 2×2 determinant: \$\\det(A) = ad - bc\$",
                sol("Calculation", "$(a)($(d)) - ($(b))($(c)) = $(a*d) - $(b*c)"),
                sol("Answer", det_val)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # 2x2 determinant equals zero - find parameter (900-1100 ELO)
        a = randint(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        # ad - bc = 0, so d = bc/a
        # Choose a such that bc/a is an integer
        while a == 0 || (b*c) % a != 0
            a = randint(-6, 6)
        end
        
        d_val = (b*c) ÷ a
        
        matrix_str = "\\begin{vmatrix} $(a) & $(b) \\\\ $(c) & x \\end{vmatrix}"
        
        problem(
            question="Find the value of \$x\$ such that \$$(matrix_str) = 0\$",
            answer=d_val,
            difficulty=(900, 1100),
            solution=steps(
                sol("Set up equation", "$(a) \\cdot x - ($(b))($(c)) = 0"),
                sol("Simplify", "$(a)x - $(b*c) = 0"),
                sol("Solve for x", "x = $(d_val)")
            ),
            time=90
        )
        
    elseif problem_type == 3
        # 3x3 determinant using cofactor expansion (1000-1200 ELO)
        # Create a matrix with some zeros for easier computation
        row = choice(1:3)
        
        if row == 1
            a11, a12, a13 = randint(-5, 5), 0, randint(-5, 5)
            a21, a22, a23 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a31, a32, a33 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        elseif row == 2
            a11, a12, a13 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a21, a22, a23 = 0, randint(-5, 5), randint(-5, 5)
            a31, a32, a33 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        else
            a11, a12, a13 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a21, a22, a23 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
            a31, a32, a33 = randint(-5, 5), 0, randint(-5, 5)
        end
        
        det_val = a11*(a22*a33 - a23*a32) - a12*(a21*a33 - a23*a31) + a13*(a21*a32 - a22*a31)
        
        matrix_str = "\\begin{vmatrix} $(a11) & $(a12) & $(a13) \\\\ $(a21) & $(a22) & $(a23) \\\\ $(a31) & $(a32) & $(a33) \\end{vmatrix}"
        
        problem(
            question="Calculate the determinant: \$$(matrix_str)\$",
            answer=det_val,
            difficulty=(1000, 1200),
            solution=steps(
                "Expand along the first row using cofactor expansion",
                sol("Formula", "$(a11)\\begin{vmatrix} $(a22) & $(a23) \\\\ $(a32) & $(a33) \\end{vmatrix} - $(a12)\\begin{vmatrix} $(a21) & $(a23) \\\\ $(a31) & $(a33) \\end{vmatrix} + $(a13)\\begin{vmatrix} $(a21) & $(a22) \\\\ $(a31) & $(a32) \\end{vmatrix}"),
                sol("Calculate", "$(a11)($(a22*a33 - a23*a32)) - $(a12)($(a21*a33 - a23*a31)) + $(a13)($(a21*a32 - a22*a31))"),
                sol("Answer", det_val)
            ),
            time=150
        )
        
    else
        # Properties: determinant after row operation (800-1000 ELO)
        original_det = nonzero(-15, 15)
        scalar = nonzero(-4, 4)
        
        operation = choice(["multiply_row", "swap_rows"])
        
        if operation == "multiply_row"
            new_det = scalar * original_det
            question_text = "If \$\\det(A) = $(original_det)\$, what is \$\\det(B)\$ where \$B\$ is obtained by multiplying one row of \$A\$ by \$$(scalar)\$?"
            step1 = "Multiplying a single row by a scalar \$k\$ multiplies the determinant by \$k\$"
            step2 = sol("Calculation", "\\det(B) = $(scalar) \\cdot $(original_det)")
        else
            new_det = -original_det
            question_text = "If \$\\det(A) = $(original_det)\$, what is \$\\det(B)\$ where \$B\$ is obtained by swapping two rows of \$A\$?"
            step1 = "Swapping two rows changes the sign of the determinant"
            step2 = sol("Calculation", "\\det(B) = -$(original_det)")
        end
        
        problem(
            question=question_text,
            answer=new_det,
            difficulty=(800, 1000),
            solution=steps(
                step1,
                step2,
                sol("Answer", new_det)
            ),
            time=75
        )
    end
end