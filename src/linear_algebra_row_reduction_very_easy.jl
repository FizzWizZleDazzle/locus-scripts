# linear_algebra - row_reduction (very_easy)
# Generated: 2026-03-08T21:06:26.258137

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/row_reduction")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Identify pivot position in a single row (ELO 200-400)
        n_cols = rand(3:5)
        row = zeros(Int, n_cols)
        pivot_col = rand(1:n_cols)
        row[pivot_col] = rand([1, 2, 3, -1, -2])
        for j in (pivot_col+1):n_cols
            row[j] = randint(-5, 5)
        end
        
        problem(
            question="In the row $(fmt_list(row)), which column contains the leading entry (leftmost nonzero entry)?",
            answer=pivot_col,
            difficulty=(200, 400),
            solution=steps(
                "The leading entry is the first nonzero entry from the left",
                "Row: $(fmt_list(row))",
                sol("Answer", pivot_col)
            ),
            time=30
        )
        
    elseif prob_type == 2
        # Count number of nonzero rows (ELO 300-500)
        n_rows = rand(3:4)
        n_cols = rand(3:4)
        n_nonzero = rand(2:n_rows)
        
        matrix_rows = []
        for i in 1:n_nonzero
            row = [randint(-5, 5) for _ in 1:n_cols]
            push!(matrix_rows, row)
        end
        for i in (n_nonzero+1):n_rows
            push!(matrix_rows, zeros(Int, n_cols))
        end
        
        problem(
            question="How many nonzero rows are in the matrix?\n\n" * fmt_matrix(matrix_rows),
            answer=n_nonzero,
            difficulty=(300, 500),
            solution=steps(
                "Count rows that contain at least one nonzero entry",
                "Matrix:\n" * fmt_matrix(matrix_rows),
                sol("Number of nonzero rows", n_nonzero)
            ),
            time=45
        )
        
    elseif prob_type == 3
        # Identify if a 2x2 matrix is in row echelon form (ELO 400-600)
        is_ref = rand([true, false])
        
        if is_ref
            # Create valid REF
            a11 = nonzero(-3, 3)
            a12 = randint(-5, 5)
            a22 = nonzero(-3, 3)
            matrix_rows = [[a11, a12], [0, a22]]
        else
            # Create invalid REF (pivot in wrong place)
            a11 = 0
            a12 = nonzero(-3, 3)
            a21 = nonzero(-3, 3)
            a22 = randint(-5, 5)
            matrix_rows = [[a11, a12], [a21, a22]]
        end
        
        problem(
            question="Is this matrix in row echelon form?\n\n" * fmt_matrix(matrix_rows) * "\n\nAnswer YES or NO.",
            answer=is_ref ? "YES" : "NO",
            difficulty=(400, 600),
            solution=steps(
                "A matrix is in row echelon form if:",
                "1. All nonzero rows are above zero rows",
                "2. Leading entry of each row is to the right of the leading entry above it",
                "Matrix:\n" * fmt_matrix(matrix_rows),
                sol("Answer", is_ref ? "YES" : "NO")
            ),
            time=60
        )
        
    elseif prob_type == 4
        # Perform single row operation: multiply row by scalar (ELO 500-700)
        n_cols = rand(2:3)
        row = [randint(-5, 5) for _ in 1:n_cols]
        scalar = nonzero(-4, 4)
        new_row = [scalar * x for x in row]
        
        problem(
            question="Multiply the row $(fmt_list(row)) by $(scalar). What is the resulting row?",
            answer=fmt_list(new_row),
            difficulty=(500, 700),
            answer_type="list",
            solution=steps(
                sol("Original row", fmt_list(row)),
                "Multiply each entry by $(scalar)",
                sol("New row", fmt_list(new_row))
            ),
            time=60
        )
        
    else
        # Perform row operation: add multiple of one row to another (ELO 600-700)
        n_cols = 3
        row1 = [randint(-4, 4) for _ in 1:n_cols]
        row2 = [randint(-4, 4) for _ in 1:n_cols]
        scalar = nonzero(-3, 3)
        new_row2 = [row2[i] + scalar * row1[i] for i in 1:n_cols]
        
        problem(
            question="Given Row 1: $(fmt_list(row1)) and Row 2: $(fmt_list(row2)), compute Row 2 + ($(scalar)) × Row 1. What is the new Row 2?",
            answer=fmt_list(new_row2),
            difficulty=(600, 700),
            answer_type="list",
            solution=steps(
                "Row 1: $(fmt_list(row1))",
                "Row 2: $(fmt_list(row2))",
                "Compute Row 2 + ($(scalar)) × Row 1",
                sol("New Row 2", fmt_list(new_row2))
            ),
            time=90
        )
    end
end