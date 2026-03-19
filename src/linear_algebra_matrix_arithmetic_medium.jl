# linear_algebra - matrix_arithmetic (medium)
# Generated: 2026-03-08T21:07:50.411883

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_arithmetic")
    
    problem_type = choice([
        :matrix_addition,
        :matrix_subtraction,
        :scalar_multiplication,
        :matrix_multiplication_2x2,
        :matrix_multiplication_3x3,
        :matrix_multiplication_mixed,
        :transpose_operations,
        :matrix_power
    ])
    
    if problem_type == :matrix_addition
        rows = choice([2, 3])
        cols = choice([2, 3])
        A = [randint(-15, 15) for i in 1:rows, j in 1:cols]
        B = [randint(-15, 15) for i in 1:rows, j in 1:cols]
        C = A + B
        
        problem(
            question="Calculate \$A + B\$ where \$A = $(fmt_matrix(A))\$ and \$B = $(fmt_matrix(B))\$",
            answer=fmt_matrix(C),
            difficulty=(1200, 1400),
            solution=steps(
                "Add corresponding entries: \$(A + B)_{ij} = A_{ij} + B_{ij}\$",
                sol("A + B", fmt_matrix(A) * " + " * fmt_matrix(B)),
                sol("Result", fmt_matrix(C))
            ),
            time=90
        )
        
    elseif problem_type == :matrix_subtraction
        rows = choice([2, 3])
        cols = choice([2, 3])
        A = [randint(-15, 15) for i in 1:rows, j in 1:cols]
        B = [randint(-15, 15) for i in 1:rows, j in 1:cols]
        C = A - B
        
        problem(
            question="Calculate \$A - B\$ where \$A = $(fmt_matrix(A))\$ and \$B = $(fmt_matrix(B))\$",
            answer=fmt_matrix(C),
            difficulty=(1200, 1400),
            solution=steps(
                "Subtract corresponding entries: \$(A - B)_{ij} = A_{ij} - B_{ij}\$",
                sol("A - B", fmt_matrix(A) * " - " * fmt_matrix(B)),
                sol("Result", fmt_matrix(C))
            ),
            time=90
        )
        
    elseif problem_type == :scalar_multiplication
        rows = choice([2, 3])
        cols = choice([2, 3])
        k = nonzero(-8, 8)
        A = [randint(-10, 10) for i in 1:rows, j in 1:cols]
        C = k * A
        
        problem(
            question="Calculate \$$(k)A\$ where \$A = $(fmt_matrix(A))\$",
            answer=fmt_matrix(C),
            difficulty=(1100, 1300),
            solution=steps(
                "Multiply each entry by the scalar: \$(kA)_{ij} = k \\cdot A_{ij}\$",
                sol("$(k)A", "$(k)" * fmt_matrix(A)),
                sol("Result", fmt_matrix(C))
            ),
            time=75
        )
        
    elseif problem_type == :matrix_multiplication_2x2
        A = [randint(-8, 8) for i in 1:2, j in 1:2]
        B = [randint(-8, 8) for i in 1:2, j in 1:2]
        C = A * B
        
        problem(
            question="Calculate \$AB\$ where \$A = $(fmt_matrix(A))\$ and \$B = $(fmt_matrix(B))\$",
            answer=fmt_matrix(C),
            difficulty=(1300, 1500),
            solution=steps(
                "Use matrix multiplication: \$(AB)_{ij} = \\sum_{k} A_{ik}B_{kj}\$",
                "First row: [$(A[1,1])·$(B[1,1]) + $(A[1,2])·$(B[2,1]), $(A[1,1])·$(B[1,2]) + $(A[1,2])·$(B[2,2])] = [$(C[1,1]), $(C[1,2])]",
                "Second row: [$(A[2,1])·$(B[1,1]) + $(A[2,2])·$(B[2,1]), $(A[2,1])·$(B[1,2]) + $(A[2,2])·$(B[2,2])] = [$(C[2,1]), $(C[2,2])]",
                sol("Result", fmt_matrix(C))
            ),
            time=120
        )
        
    elseif problem_type == :matrix_multiplication_3x3
        A = [randint(-6, 6) for i in 1:3, j in 1:3]
        B = [randint(-6, 6) for i in 1:3, j in 1:3]
        C = A * B
        
        problem(
            question="Calculate \$AB\$ where \$A = $(fmt_matrix(A))\$ and \$B = $(fmt_matrix(B))\$",
            answer=fmt_matrix(C),
            difficulty=(1500, 1700),
            solution=steps(
                "Use matrix multiplication: \$(AB)_{ij} = \\sum_{k} A_{ik}B_{kj}\$",
                "Compute each entry by taking dot product of row \$i\$ of \$A\$ with column \$j\$ of \$B\$",
                "After computing all 9 entries:",
                sol("Result", fmt_matrix(C))
            ),
            time=180
        )
        
    elseif problem_type == :matrix_multiplication_mixed
        m = choice([2, 3])
        n = choice([2, 3, 4])
        p = choice([2, 3])
        
        A = [randint(-8, 8) for i in 1:m, j in 1:n]
        B = [randint(-8, 8) for i in 1:n, j in 1:p]
        C = A * B
        
        problem(
            question="Calculate \$AB\$ where \$A\$ is $(m)×$(n) with \$A = $(fmt_matrix(A))\$ and \$B\$ is $(n)×$(p) with \$B = $(fmt_matrix(B))\$",
            answer=fmt_matrix(C),
            difficulty=(1400, 1600),
            solution=steps(
                "Matrix dimensions: \$($(m) \\times $(n)) \\times ($(n) \\times $(p)) = $(m) \\times $(p)\$",
                "Use matrix multiplication: \$(AB)_{ij} = \\sum_{k=1}^{$(n)} A_{ik}B_{kj}\$",
                "Compute each entry by dot product of corresponding row and column",
                sol("Result", fmt_matrix(C))
            ),
            time=150
        )
        
    elseif problem_type == :transpose_operations
        rows = choice([2, 3])
        cols = choice([2, 3])
        A = [randint(-12, 12) for i in 1:rows, j in 1:cols]
        B = [randint(-12, 12) for i in 1:rows, j in 1:cols]
        
        op_type = choice([:add_transpose, :scalar_mult_transpose])
        
        if op_type == :add_transpose
            C = transpose(A + B)
            
            problem(
                question="Calculate \$(A + B)^T\$ where \$A = $(fmt_matrix(A))\$ and \$B = $(fmt_matrix(B))\$",
                answer=fmt_matrix(C),
                difficulty=(1300, 1500),
                solution=steps(
                    "First compute \$A + B\$:",
                    sol("A + B", fmt_matrix(A + B)),
                    "Then transpose by swapping rows and columns:",
                    sol("(A + B)^T", fmt_matrix(C))
                ),
                time=100
            )
        else
            k = nonzero(-6, 6)
            C = transpose(k * A)
            
            problem(
                question="Calculate \$($(k)A)^T\$ where \$A = $(fmt_matrix(A))\$",
                answer=fmt_matrix(C),
                difficulty=(1200, 1400),
                solution=steps(
                    "First compute \$$(k)A\$:",
                    sol("$(k)A", fmt_matrix(k * A)),
                    "Then transpose by swapping rows and columns:",
                    sol("($(k)A)^T", fmt_matrix(C))
                ),
                time=90
            )
        end
        
    else  # matrix_power
        A = [randint(-4, 4) for i in 1:2, j in 1:2]
        power = choice([2, 3])
        
        C = A
        for _ in 2:power
            C = C * A
        end
        
        problem(
            question="Calculate \$A^{$(power)}\$ where \$A = $(fmt_matrix(A))\$",
            answer=fmt_matrix(C),
            difficulty=(1500, 1800),
            solution=steps(
                sol("Given", "A = " * fmt_matrix(A)),
                power == 2 ? "Compute \$A^2 = A \\cdot A\$" : "Compute \$A^3 = A \\cdot A \\cdot A\$ by first finding \$A^2\$, then \$A^2 \\cdot A\$",
                power == 3 ? sol("A^2", fmt_matrix(A * A)) : "",
                sol("A^{$(power)}", fmt_matrix(C))
            ),
            time=power == 2 ? 120 : 180
        )
    end
end