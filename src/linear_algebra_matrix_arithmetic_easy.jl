# linear_algebra - matrix_arithmetic (easy)
# Generated: 2026-03-08T21:07:54.356169

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_arithmetic")
    
    problem_type = choice([
        :matrix_addition,
        :matrix_subtraction,
        :scalar_multiplication,
        :matrix_multiplication_2x2,
        :matrix_element,
        :transpose,
        :matrix_multiplication_2x3_3x2
    ])
    
    if problem_type == :matrix_addition
        # Generate two 2x2 matrices and ask for their sum
        a11, a12 = randint(-12, 12), randint(-12, 12)
        a21, a22 = randint(-12, 12), randint(-12, 12)
        b11, b12 = randint(-12, 12), randint(-12, 12)
        b21, b22 = randint(-12, 12), randint(-12, 12)
        
        A = [[a11, a12], [a21, a22]]
        B = [[b11, b12], [b21, b22]]
        C = [[a11+b11, a12+b12], [a21+b21, a22+b22]]
        
        problem(
            question="Compute \\(A + B\\) where \\(A = $(fmt_matrix(A))\\) and \\(B = $(fmt_matrix(B))\\)",
            answer=fmt_matrix(C),
            difficulty=(700, 900),
            answer_type="matrix",
            solution=steps(
                "Add corresponding elements of the matrices",
                sol("A + B", fmt_matrix([[a11, a12], [a21, a22]]) * " + " * fmt_matrix([[b11, b12], [b21, b22]])),
                sol("Answer", fmt_matrix(C))
            ),
            time=60
        )
        
    elseif problem_type == :matrix_subtraction
        # Generate two 2x2 matrices and ask for their difference
        a11, a12 = randint(-15, 15), randint(-15, 15)
        a21, a22 = randint(-15, 15), randint(-15, 15)
        b11, b12 = randint(-15, 15), randint(-15, 15)
        b21, b22 = randint(-15, 15), randint(-15, 15)
        
        A = [[a11, a12], [a21, a22]]
        B = [[b11, b12], [b21, b22]]
        C = [[a11-b11, a12-b12], [a21-b21, a22-b22]]
        
        problem(
            question="Compute \\(A - B\\) where \\(A = $(fmt_matrix(A))\\) and \\(B = $(fmt_matrix(B))\\)",
            answer=fmt_matrix(C),
            difficulty=(700, 900),
            answer_type="matrix",
            solution=steps(
                "Subtract corresponding elements of the matrices",
                sol("A - B", fmt_matrix([[a11, a12], [a21, a22]]) * " - " * fmt_matrix([[b11, b12], [b21, b22]])),
                sol("Answer", fmt_matrix(C))
            ),
            time=60
        )
        
    elseif problem_type == :scalar_multiplication
        # Scalar multiplication of a 2x2 or 3x3 matrix
        k = nonzero(-8, 8)
        size = choice([2, 3])
        
        if size == 2
            a11, a12 = randint(-10, 10), randint(-10, 10)
            a21, a22 = randint(-10, 10), randint(-10, 10)
            A = [[a11, a12], [a21, a22]]
            C = [[k*a11, k*a12], [k*a21, k*a22]]
        else
            a11, a12, a13 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            a21, a22, a23 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            a31, a32, a33 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            A = [[a11, a12, a13], [a21, a22, a23], [a31, a32, a33]]
            C = [[k*a11, k*a12, k*a13], [k*a21, k*a22, k*a23], [k*a31, k*a32, k*a33]]
        end
        
        problem(
            question="Compute \\($(k)A\\) where \\(A = $(fmt_matrix(A))\\)",
            answer=fmt_matrix(C),
            difficulty=(700, 850),
            answer_type="matrix",
            solution=steps(
                "Multiply each element of the matrix by the scalar $(k)",
                sol("$(k)A", "$(k) \\cdot " * fmt_matrix(A)),
                sol("Answer", fmt_matrix(C))
            ),
            time=75
        )
        
    elseif problem_type == :matrix_multiplication_2x2
        # 2x2 matrix multiplication
        a11, a12 = randint(-6, 6), randint(-6, 6)
        a21, a22 = randint(-6, 6), randint(-6, 6)
        b11, b12 = randint(-6, 6), randint(-6, 6)
        b21, b22 = randint(-6, 6), randint(-6, 6)
        
        A = [[a11, a12], [a21, a22]]
        B = [[b11, b12], [b21, b22]]
        
        c11 = a11*b11 + a12*b21
        c12 = a11*b12 + a12*b22
        c21 = a21*b11 + a22*b21
        c22 = a21*b12 + a22*b22
        C = [[c11, c12], [c21, c22]]
        
        problem(
            question="Compute \\(AB\\) where \\(A = $(fmt_matrix(A))\\) and \\(B = $(fmt_matrix(B))\\)",
            answer=fmt_matrix(C),
            difficulty=(900, 1200),
            answer_type="matrix",
            solution=steps(
                "Use matrix multiplication: entry (i,j) is the dot product of row i of A with column j of B",
                "\\((AB)_{11} = $(a11)($(b11)) + $(a12)($(b21)) = $(c11)\\)<br>\\((AB)_{12} = $(a11)($(b12)) + $(a12)($(b22)) = $(c12)\\)<br>\\((AB)_{21} = $(a21)($(b11)) + $(a22)($(b21)) = $(c21)\\)<br>\\((AB)_{22} = $(a21)($(b12)) + $(a22)($(b22)) = $(c22)\\)",
                sol("Answer", fmt_matrix(C))
            ),
            time=120
        )
        
    elseif problem_type == :matrix_element
        # Find a specific element in a matrix sum or difference
        op = choice(["+", "-"])
        a11, a12, a13 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        a21, a22, a23 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        b11, b12, b13 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        b21, b22, b23 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        
        A = [[a11, a12, a13], [a21, a22, a23]]
        B = [[b11, b12, b13], [b21, b22, b23]]
        
        i, j = choice([1, 2]), choice([1, 2, 3])
        
        if op == "+"
            C = [[a11+b11, a12+b12, a13+b13], [a21+b21, a22+b22, a23+b23]]
            ans = C[i][j]
        else
            C = [[a11-b11, a12-b12, a13-b13], [a21-b21, a22-b22, a23-b23]]
            ans = C[i][j]
        end
        
        problem(
            question="Find the ($(i),$(j)) entry of \\(A $(op) B\\) where \\(A = $(fmt_matrix(A))\\) and \\(B = $(fmt_matrix(B))\\)",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "The ($(i),$(j)) entry of \\(A $(op) B\\) is \\(a_{$(i)$(j)} $(op) b_{$(i)$(j)}\\)",
                sol("Calculation", "$(A[i][j]) $(op) $(B[i][j]) = $(ans)"),
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == :transpose
        # Find the transpose of a matrix
        size = choice([2, 3])
        
        if size == 2
            a11, a12 = randint(-12, 12), randint(-12, 12)
            a21, a22 = randint(-12, 12), randint(-12, 12)
            A = [[a11, a12], [a21, a22]]
            AT = [[a11, a21], [a12, a22]]
        else
            a11, a12, a13 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
            a21, a22, a23 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
            A = [[a11, a12, a13], [a21, a22, a23]]
            AT = [[a11, a21], [a12, a22], [a13, a23]]
        end
        
        problem(
            question="Find the transpose \\(A^T\\) of \\(A = $(fmt_matrix(A))\\)",
            answer=fmt_matrix(AT),
            difficulty=(700, 850),
            answer_type="matrix",
            solution=steps(
                "The transpose is formed by swapping rows and columns",
                "Row 1 becomes column 1, row 2 becomes column 2, etc.",
                sol("Answer", fmt_matrix(AT))
            ),
            time=60
        )
        
    else  # matrix_multiplication_2x3_3x2
        # 2x3 times 3x2 matrix multiplication
        a11, a12, a13 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        a21, a22, a23 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        b11, b12 = randint(-5, 5), randint(-5, 5)
        b21, b22 = randint(-5, 5), randint(-5, 5)
        b31, b32 = randint(-5, 5), randint(-5, 5)
        
        A = [[a11, a12, a13], [a21, a22, a23]]
        B = [[b11, b12], [b21, b22], [b31, b32]]
        
        c11 = a11*b11 + a12*b21 + a13*b31
        c12 = a11*b12 + a12*b22 + a13*b32
        c21 = a21*b11 + a22*b21 + a23*b31
        c22 = a21*b12 + a22*b22 + a23*b32
        C = [[c11, c12], [c21, c22]]
        
        problem(
            question="Compute \\(AB\\) where \\(A = $(fmt_matrix(A))\\) and \\(B = $(fmt_matrix(B))\\)",
            answer=fmt_matrix(C),
            difficulty=(1000, 1200),
            answer_type="matrix",
            solution=steps(
                "The result is a 2×2 matrix. Each entry is a dot product of a row from A with a column from B",
                "\\((AB)_{11} = $(a11)($(b11)) + $(a12)($(b21)) + $(a13)($(b31)) = $(c11)\\)<br>\\((AB)_{12} = $(a11)($(b12)) + $(a12)($(b22)) + $(a13)($(b32)) = $(c12)\\)<br>\\((AB)_{21} = $(a21)($(b11)) + $(a22)($(b21)) + $(a23)($(b31)) = $(c21)\\)<br>\\((AB)_{22} = $(a21)($(b12)) + $(a22)($(b22)) + $(a23)($(b32)) = $(c22)\\)",
                sol("Answer", fmt_matrix(C))
            ),
            time=150
        )
    end
end