# linear_algebra - matrix_arithmetic (very_easy)
# Generated: 2026-03-08T21:07:18.759432

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_arithmetic")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Matrix addition (2x2)
        a11, a12 = randint(-15, 15), randint(-15, 15)
        a21, a22 = randint(-15, 15), randint(-15, 15)
        b11, b12 = randint(-15, 15), randint(-15, 15)
        b21, b22 = randint(-15, 15), randint(-15, 15)
        
        A = [[a11, a12], [a21, a22]]
        B = [[b11, b12], [b21, b22]]
        ans = [[a11+b11, a12+b12], [a21+b21, a22+b22]]
        
        problem(
            question="Add the matrices: $(fmt_matrix(A)) + $(fmt_matrix(B))",
            answer=fmt_matrix(ans),
            difficulty=(200, 400),
            answer_type="matrix",
            solution=steps(
                "Add corresponding elements",
                "Row 1: ($(a11) + $(b11), $(a12) + $(b12)) = ($(a11+b11), $(a12+b12))",
                "Row 2: ($(a21) + $(b21), $(a22) + $(b22)) = ($(a21+b21), $(a22+b22))",
                "Answer: $(fmt_matrix(ans))"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Matrix subtraction (2x2)
        a11, a12 = randint(-15, 15), randint(-15, 15)
        a21, a22 = randint(-15, 15), randint(-15, 15)
        b11, b12 = randint(-15, 15), randint(-15, 15)
        b21, b22 = randint(-15, 15), randint(-15, 15)
        
        A = [[a11, a12], [a21, a22]]
        B = [[b11, b12], [b21, b22]]
        ans = [[a11-b11, a12-b12], [a21-b21, a22-b22]]
        
        problem(
            question="Subtract the matrices: $(fmt_matrix(A)) - $(fmt_matrix(B))",
            answer=fmt_matrix(ans),
            difficulty=(200, 450),
            answer_type="matrix",
            solution=steps(
                "Subtract corresponding elements",
                "Row 1: ($(a11) - $(b11), $(a12) - $(b12)) = ($(a11-b11), $(a12-b12))",
                "Row 2: ($(a21) - $(b21), $(a22) - $(b22)) = ($(a21-b21), $(a22-b22))",
                "Answer: $(fmt_matrix(ans))"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Scalar multiplication (2x2)
        k = nonzero(-8, 8)
        a11, a12 = randint(-10, 10), randint(-10, 10)
        a21, a22 = randint(-10, 10), randint(-10, 10)
        
        A = [[a11, a12], [a21, a22]]
        ans = [[k*a11, k*a12], [k*a21, k*a22]]
        
        problem(
            question="Multiply the matrix by the scalar: $(k) \\cdot $(fmt_matrix(A))",
            answer=fmt_matrix(ans),
            difficulty=(250, 500),
            answer_type="matrix",
            solution=steps(
                "Multiply each element by $(k)",
                "Row 1: ($(k) × $(a11), $(k) × $(a12)) = ($(k*a11), $(k*a12))",
                "Row 2: ($(k) × $(a21), $(k) × $(a22)) = ($(k*a21), $(k*a22))",
                "Answer: $(fmt_matrix(ans))"
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Matrix addition (3x2)
        A = [[randint(-12, 12), randint(-12, 12)], 
             [randint(-12, 12), randint(-12, 12)],
             [randint(-12, 12), randint(-12, 12)]]
        B = [[randint(-12, 12), randint(-12, 12)], 
             [randint(-12, 12), randint(-12, 12)],
             [randint(-12, 12), randint(-12, 12)]]
        
        ans = [[A[1][1]+B[1][1], A[1][2]+B[1][2]],
               [A[2][1]+B[2][1], A[2][2]+B[2][2]],
               [A[3][1]+B[3][1], A[3][2]+B[3][2]]]
        
        problem(
            question="Add the matrices: $(fmt_matrix(A)) + $(fmt_matrix(B))",
            answer=fmt_matrix(ans),
            difficulty=(300, 550),
            answer_type="matrix",
            solution=steps(
                "Add corresponding elements in each position",
                "Row 1: ($(A[1][1]) + $(B[1][1]), $(A[1][2]) + $(B[1][2])) = ($(ans[1][1]), $(ans[1][2]))",
                "Row 2: ($(A[2][1]) + $(B[2][1]), $(A[2][2]) + $(B[2][2])) = ($(ans[2][1]), $(ans[2][2]))",
                "Row 3: ($(A[3][1]) + $(B[3][1]), $(A[3][2]) + $(B[3][2])) = ($(ans[3][1]), $(ans[3][2]))",
                "Answer: $(fmt_matrix(ans))"
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Single element identification
        i = rand(1:2)
        j = rand(1:2)
        a11, a12 = randint(-20, 20), randint(-20, 20)
        a21, a22 = randint(-20, 20), randint(-20, 20)
        
        A = [[a11, a12], [a21, a22]]
        ans = A[i][j]
        
        row_names = ["first", "second"]
        col_names = ["first", "second"]
        
        problem(
            question="What is the element in the $(row_names[i]) row and $(col_names[j]) column of $(fmt_matrix(A))?",
            answer=ans,
            difficulty=(100, 300),
            solution=steps(
                "Identify the $(row_names[i]) row: $(fmt_list(A[i]))",
                "The $(col_names[j]) element of this row is $(ans)",
                "Answer: $(ans)"
            ),
            time=30
        )
        
    else
        # Scalar multiplication with negative scalar
        k = nonzero(-10, -2)
        a11, a12 = randint(-8, 8), randint(-8, 8)
        a21, a22 = randint(-8, 8), randint(-8, 8)
        
        A = [[a11, a12], [a21, a22]]
        ans = [[k*a11, k*a12], [k*a21, k*a22]]
        
        problem(
            question="Multiply: $(k) \\cdot $(fmt_matrix(A))",
            answer=fmt_matrix(ans),
            difficulty=(300, 600),
            answer_type="matrix",
            solution=steps(
                "Multiply each matrix element by $(k)",
                "Row 1: ($(k) × $(a11), $(k) × $(a12)) = ($(k*a11), $(k*a12))",
                "Row 2: ($(k) × $(a21), $(k) × $(a22)) = ($(k*a21), $(k*a22))",
                "Answer: $(fmt_matrix(ans))"
            ),
            time=75
        )
    end
end