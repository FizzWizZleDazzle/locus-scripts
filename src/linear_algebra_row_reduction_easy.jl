# linear_algebra - row_reduction (easy)
# Generated: 2026-03-08T21:06:37.891714

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/row_reduction")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Basic 2x2 row reduction - identify pivot positions
        a11 = nonzero(-8, 8)
        a12 = randint(-8, 8)
        a21 = randint(-8, 8)
        a22 = randint(-8, 8)
        
        mat_str = "\\begin{bmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{bmatrix}"
        
        # The first pivot is always in position (1,1) if a11 ≠ 0
        # Second pivot depends on whether we can make a 0 below first pivot
        if a22 - (a21 * a12) // a11 != 0
            ans = fmt_set(Set(["(1,1)", "(2,2)"]))
        else
            ans = fmt_set(Set(["(1,1)"]))
        end
        
        problem(
            question="Identify the pivot positions in the matrix after row reduction to echelon form:\n\$\$$(mat_str)\$\$\nEnter your answer as a set of ordered pairs, e.g. {(1,1), (2,2)}",
            answer=ans,
            difficulty=(700, 900),
            answer_type="set",
            solution=steps(
                "Given matrix: \$$(mat_str)\$",
                "First pivot is at position (1,1) since entry is $(a11) ≠ 0",
                "After row operations, check if second row has a non-zero entry in column 2",
                "Pivot positions: $(ans)"
            ),
            time=90
        )
        
    elseif prob_type == 2
        # What row operation converts one matrix to another (2x2)
        a = nonzero(-6, 6)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        k = nonzero(-4, 4)
        
        mat1_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        
        new_c = c + k * a
        new_d = d + k * b
        
        mat2_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(new_c) & $(new_d) \\end{bmatrix}"
        
        if k > 0
            ans = "R2 + $(k)R1 → R2"
        else
            ans = "R2 - $(abs(k))R1 → R2"
        end
        
        problem(
            question="What row operation transforms\n\$\$$(mat1_str)\$\$\ninto\n\$\$$(mat2_str)\$\$?\nUse notation like 'R2 + 3R1 → R2' or 'R2 - 2R1 → R2'",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Original matrix: \$$(mat1_str)\$",
                "New matrix: \$$(mat2_str)\$",
                "Row 1 is unchanged: $(a), $(b)",
                "Row 2: ($(new_c), $(new_d)) = ($(c), $(d)) + $(k)×($(a), $(b))",
                "Row operation: $(ans)"
            ),
            time=75
        )
        
    elseif prob_type == 3
        # Determine if matrix is in row echelon form
        scenario = rand(1:3)
        
        if scenario == 1
            # Yes - valid REF
            a = nonzero(-6, 6)
            b = randint(-8, 8)
            c = nonzero(-6, 6)
            mat_str = "\\begin{bmatrix} $(a) & $(b) \\\\ 0 & $(c) \\end{bmatrix}"
            ans = "yes"
            reason = "Leading entry of row 2 (position 2) is to the right of leading entry of row 1 (position 1)"
        elseif scenario == 2
            # No - non-zero below pivot
            a = nonzero(-6, 6)
            b = randint(-8, 8)
            c = nonzero(-6, 6)
            d = randint(-8, 8)
            mat_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
            ans = "no"
            reason = "There is a non-zero entry ($(c)) below the leading entry in column 1"
        else
            # Yes - zero row at bottom
            a = nonzero(-6, 6)
            b = randint(-8, 8)
            mat_str = "\\begin{bmatrix} $(a) & $(b) \\\\ 0 & 0 \\end{bmatrix}"
            ans = "yes"
            reason = "Zero row is at the bottom and first row has leading entry in column 1"
        end
        
        problem(
            question="Is the following matrix in row echelon form?\n\$\$$(mat_str)\$\$\nAnswer 'yes' or 'no'.",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                "Given matrix: \$$(mat_str)\$",
                "Check row echelon form conditions: (1) Leading entries move right, (2) Zero rows at bottom",
                reason,
                "Answer: $(ans)"
            ),
            time=60
        )
        
    else
        # Perform one row operation on a 2x3 augmented matrix
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        c = randint(-6, 6)
        d = nonzero(-5, 5)
        e = randint(-6, 6)
        f = randint(-6, 6)
        
        mat_str = "\\begin{bmatrix} $(a) & $(b) & $(c) \\\\ $(d) & $(e) & $(f) \\end{bmatrix}"
        
        # Eliminate first entry of second row
        k = d // a
        
        new_d = 0
        new_e = e - k * b
        new_f = f - k * c
        
        result_str = "\\begin{bmatrix} $(a) & $(b) & $(c) \\\\ 0 & $(new_e) & $(new_f) \\end{bmatrix}"
        
        problem(
            question="Perform the row operation R2 - ($(k))R1 → R2 on the augmented matrix:\n\$\$$(mat_str)\$\$\nEnter the resulting matrix in the form [[a,b,c],[d,e,f]]",
            answer="[[$(a),$(b),$(c)],[0,$(new_e),$(new_f)]]",
            difficulty=(850, 1100),
            answer_type="matrix",
            solution=steps(
                "Original matrix: \$$(mat_str)\$",
                "Row operation: R2 - ($(k))R1 → R2",
                "New row 2: ($(d), $(e), $(f)) - ($(k))×($(a), $(b), $(c)) = (0, $(new_e), $(new_f))",
                "Result: \$$(result_str)\$"
            ),
            time=90
        )
    end
end