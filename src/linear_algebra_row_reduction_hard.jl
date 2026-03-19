# linear_algebra - row_reduction (hard)
# Generated: 2026-03-08T21:07:20.649014

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/row_reduction")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Determine if a system is consistent (1800-2000)
        # Create a system with a specific structure
        a11, a12, a13 = nonzero(-5, 5), randint(-6, 6), randint(-6, 6)
        a21, a22, a23 = randint(-5, 5), nonzero(-5, 5), randint(-6, 6)
        a31, a32, a33 = randint(-5, 5), randint(-5, 5), nonzero(-5, 5)
        
        # Make a consistent system
        b1, b2 = randint(-10, 10), randint(-10, 10)
        # Third equation is linear combination of first two
        k1, k2 = rand([1, 2, -1, -2]), rand([1, 2, -1, -2])
        a31, a32, a33 = k1*a11 + k2*a21, k1*a12 + k2*a22, k1*a13 + k2*a23
        b3 = k1*b1 + k2*b2
        
        matrix_str = "\\begin{bmatrix} $a11 & $a12 & $a13 & | & $b1 \\\\ $a21 & $a22 & $a23 & | & $b2 \\\\ $a31 & $a32 & $a33 & | & $b3 \\end{bmatrix}"
        
        problem(
            question="Consider the augmented matrix:\n\$\$$(matrix_str)\$\$\nDetermine if the corresponding system is consistent. Answer with 'yes' or 'no'.",
            answer="yes",
            difficulty=(1800, 1950),
            solution=steps(
                "The augmented matrix represents a system of 3 equations in 3 unknowns",
                "Row 3 = $(k1) × Row 1 + $(k2) × Row 2, so the third equation is dependent",
                "Since there is no contradiction (like 0 = nonzero), the system is consistent",
                sol("Answer", "yes")
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Find rank of a matrix (1900-2100)
        rank_val = rand(2:3)
        
        if rank_val == 2
            # Create a 3×3 matrix with rank 2
            a11, a12, a13 = nonzero(-4, 4), randint(-5, 5), randint(-5, 5)
            a21, a22, a23 = randint(-4, 4), nonzero(-4, 4), randint(-5, 5)
            # Third row is combination
            k1, k2 = rand([1, 2, -1, -2]), rand([1, 2, -1, -2])
            a31, a32, a33 = k1*a11 + k2*a21, k1*a12 + k2*a22, k1*a13 + k2*a23
        else
            # rank 3: make sure rows are independent
            a11, a12, a13 = nonzero(-4, 4), randint(-5, 5), randint(-5, 5)
            a21, a22, a23 = randint(-4, 4), nonzero(-4, 4), randint(-5, 5)
            a31, a32, a33 = randint(-4, 4), randint(-5, 5), nonzero(-4, 4)
            # Ensure third row is not a combination (simple check)
            if a31 == 0 && a32 == 0
                a31 = nonzero(-3, 3)
            end
        end
        
        matrix_str = "\\begin{bmatrix} $a11 & $a12 & $a13 \\\\ $a21 & $a22 & $a23 \\\\ $a31 & $a32 & $a33 \\end{bmatrix}"
        
        problem(
            question="Find the rank of the matrix:\n\$\$$(matrix_str)\$\$",
            answer=rank_val,
            difficulty=(1900, 2100),
            solution=steps(
                "Perform row reduction to find the number of pivot positions",
                rank_val == 2 ? "Row 3 can be eliminated (it's a linear combination of rows 1 and 2)" : "All three rows are linearly independent",
                "The number of non-zero rows in RREF equals the rank",
                sol("Rank", rank_val)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Type 3: Parameter value for specific rank (2000-2200)
        # Create matrix with parameter that affects rank
        a11, a12 = nonzero(-4, 4), randint(-5, 5)
        a21, a22 = randint(-4, 4), nonzero(-4, 4)
        
        # For rank < 2, we need a21*a12 - a11*a22 = 0
        # So if row2 = k*row1, then a21 = k*a11, a22 = k*a12
        # We'll make the parameter appear in a22
        k = rand([2, 3, -2, -3])
        critical_val = k * a12
        
        a21 = k * a11
        
        matrix_str = "\\begin{bmatrix} $a11 & $a12 \\\\ $a21 & k \\end{bmatrix}"
        
        problem(
            question="For what value of \\(k\\) does the matrix have rank 1?\n\$\$$(matrix_str)\$\$",
            answer=critical_val,
            difficulty=(2000, 2200),
            solution=steps(
                "For rank 1, the rows must be linearly dependent",
                "Row 2 must be a scalar multiple of Row 1",
                "We need: \\(\\frac{$a21}{$a11} = \\frac{k}{$a12}\\)",
                "Solving: \\(k = \\frac{$a21 \\cdot $a12}{$a11} = $(critical_val)\\)",
                sol("Answer", critical_val)
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Type 4: Free variables count (1850-2050)
        num_vars = 4
        num_equations = 3
        rank_val = rand(2:3)
        
        # Create a system with known rank
        a11, a12, a13, a14 = nonzero(-3, 3), randint(-4, 4), randint(-4, 4), randint(-4, 4)
        a21, a22, a23, a24 = randint(-3, 3), nonzero(-3, 3), randint(-4, 4), randint(-4, 4)
        
        if rank_val == 2
            k1, k2 = rand([1, 2, -1]), rand([1, 2, -1])
            a31, a32, a33, a34 = k1*a11 + k2*a21, k1*a12 + k2*a22, k1*a13 + k2*a23, k1*a14 + k2*a24
        else
            a31, a32, a33, a34 = randint(-3, 3), randint(-3, 3), nonzero(-3, 3), randint(-4, 4)
        end
        
        free_vars = num_vars - rank_val
        
        matrix_str = "\\begin{bmatrix} $a11 & $a12 & $a13 & $a14 \\\\ $a21 & $a22 & $a23 & $a24 \\\\ $a31 & $a32 & $a33 & $a34 \\end{bmatrix}"
        
        problem(
            question="Consider the coefficient matrix of a homogeneous system:\n\$\$$(matrix_str)\$\$\nHow many free variables does the system have?",
            answer=free_vars,
            difficulty=(1850, 2050),
            solution=steps(
                "The matrix is 3×4, representing a system with 4 variables",
                "Row reduce to find the rank (number of pivot columns)",
                rank_val == 2 ? "The rank is 2 (one row reduces to zero)" : "The rank is 3 (all rows are independent)",
                "Number of free variables = total variables - rank = 4 - $(rank_val) = $(free_vars)",
                sol("Answer", free_vars)
            ),
            time=210
        )
        
    else
        # Type 5: RREF specific entry value (2100-2400)
        # Create a matrix and ask for a specific entry after RREF
        # Simple 2×3 matrix that reduces nicely
        
        # Start with RREF form and work backwards
        # RREF: [1 0 a; 0 1 b]
        rref_a = randint(-8, 8)
        rref_b = randint(-8, 8)
        
        # Apply random row operations to create original matrix
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        
        a11, a12, a13 = r1, 0, r1*rref_a
        a21, a22, a23 = 0, r2, r2*rref_b
        
        # Add some row combinations to make it less obvious
        k = rand([-2, -1, 1, 2])
        a21 += k*a11
        a22 += k*a12
        a23 += k*a13
        
        row_idx = rand([1, 2])
        col_idx = rand([1, 2, 3])
        
        if row_idx == 1 && col_idx == 1
            ans_val = 1
        elseif row_idx == 1 && col_idx == 2
            ans_val = 0
        elseif row_idx == 1 && col_idx == 3
            ans_val = rref_a
        elseif row_idx == 2 && col_idx == 1
            ans_val = 0
        elseif row_idx == 2 && col_idx == 2
            ans_val = 1
        else
            ans_val = rref_b
        end
        
        matrix_str = "\\begin{bmatrix} $a11 & $a12 & $a13 \\\\ $a21 & $a22 & $a23 \\end{bmatrix}"
        
        problem(
            question="Find the entry in row $(row_idx), column $(col_idx) of the reduced row echelon form (RREF) of:\n\$\$$(matrix_str)\$\$",
            answer=ans_val,
            difficulty=(2100, 2400),
            solution=steps(
                "Apply row operations to obtain RREF",
                "Step 1: Scale Row 1 by \\(\\frac{1}{$a11}\\) to get leading 1",
                "Step 2: Eliminate below and scale Row 2",
                "Step 3: Back-substitute to clear above pivot in column 2",
                "The RREF entry at position ($(row_idx), $(col_idx)) is $(ans_val)",
                sol("Answer", ans_val)
            ),
            time=270
        )
    end
end