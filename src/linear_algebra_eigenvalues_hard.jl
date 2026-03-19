# linear_algebra - eigenvalues (hard)
# Generated: 2026-03-08T21:13:24.814045

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # 2x2 matrix with integer eigenvalues - characteristic polynomial approach
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        
        # Create a diagonal matrix with eigenvalues, then apply similarity transform
        # P * D * P^(-1) where D is diagonal with eigenvalues
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        # Ensure invertible transformation matrix
        while a*d - b*c == 0
            d = nonzero(-3, 3)
        end
        
        # Simple approach: use a traceable matrix
        # For 2x2: trace = λ1 + λ2, det = λ1*λ2
        trace = λ1 + λ2
        det = λ1 * λ2
        
        # Construct matrix with desired trace and determinant
        m11 = randint(-5, 5)
        m22 = trace - m11
        m12 = nonzero(-6, 6)
        m21 = (det - m11*m22) // m12
        
        matrix_tex = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        char_poly_tex = "\\lambda^2 - $(trace)\\lambda + $(det)"
        
        problem(
            question="Find all eigenvalues of the matrix \$A = $(matrix_tex)\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(1800, 2000),
            answer_type="set",
            solution=steps(
                "Find eigenvalues by solving \$\\det(A - \\lambda I) = 0\$",
                "Characteristic polynomial: \$$(char_poly_tex) = 0\$",
                "Factor or use quadratic formula to get \$\\lambda = $(λ1), $(λ2)\$",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2])))
            ),
            time=180
        )
        
    elseif problem_type == 2
        # 3x3 triangular matrix (eigenvalues on diagonal)
        λ1 = randint(-7, 7)
        λ2 = randint(-7, 7)
        λ3 = randint(-7, 7)
        
        if rand(Bool)
            # Upper triangular
            m12 = randint(-5, 5)
            m13 = randint(-5, 5)
            m23 = randint(-5, 5)
            matrix_tex = "\\begin{bmatrix} $(λ1) & $(m12) & $(m13) \\\\ 0 & $(λ2) & $(m23) \\\\ 0 & 0 & $(λ3) \\end{bmatrix}"
        else
            # Lower triangular
            m21 = randint(-5, 5)
            m31 = randint(-5, 5)
            m32 = randint(-5, 5)
            matrix_tex = "\\begin{bmatrix} $(λ1) & 0 & 0 \\\\ $(m21) & $(λ2) & 0 \\\\ $(m31) & $(m32) & $(λ3) \\end{bmatrix}"
        end
        
        problem(
            question="Find all eigenvalues of the matrix \$A = $(matrix_tex)\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2, λ3])),
            difficulty=(1850, 2050),
            answer_type="set",
            solution=steps(
                "For a triangular matrix, eigenvalues are the diagonal entries",
                "The characteristic polynomial factors as \$(\\lambda - $(λ1))(\\lambda - $(λ2))(\\lambda - $(λ3)) = 0\$",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2, λ3])))
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Eigenvalue multiplicity problem - repeated eigenvalue
        λ = randint(-6, 6)
        k = randint(2, 3)
        
        if k == 2
            # 2x2 matrix with repeated eigenvalue
            a = randint(-4, 4)
            if rand(Bool)
                # Scalar matrix (geometric multiplicity = algebraic multiplicity)
                matrix_tex = "\\begin{bmatrix} $(λ) & 0 \\\\ 0 & $(λ) \\end{bmatrix}"
                geom_mult = 2
            else
                # Jordan block (geometric multiplicity < algebraic multiplicity)
                matrix_tex = "\\begin{bmatrix} $(λ) & 1 \\\\ 0 & $(λ) \\end{bmatrix}"
                geom_mult = 1
            end
            
            problem(
                question="Find the algebraic multiplicity of the eigenvalue \$\\lambda = $(λ)\$ for the matrix \$A = $(matrix_tex)\$.",
                answer=2,
                difficulty=(1900, 2100),
                solution=steps(
                    "Find characteristic polynomial: \$\\det(A - \\lambda I) = (\\lambda - $(λ))^2\$",
                    "The eigenvalue \$\\lambda = $(λ)\$ appears with exponent 2",
                    sol("Algebraic multiplicity", 2)
                ),
                time=150
            )
        else
            # 3x3 with repeated eigenvalue
            matrix_tex = "\\begin{bmatrix} $(λ) & 1 & 0 \\\\ 0 & $(λ) & 1 \\\\ 0 & 0 & $(λ) \\end{bmatrix}"
            
            problem(
                question="Find the algebraic multiplicity of the eigenvalue \$\\lambda = $(λ)\$ for the matrix \$A = $(matrix_tex)\$.",
                answer=3,
                difficulty=(2000, 2200),
                solution=steps(
                    "Find characteristic polynomial: \$\\det(A - \\lambda I) = (\\lambda - $(λ))^3\$",
                    "The eigenvalue \$\\lambda = $(λ)\$ appears with exponent 3",
                    sol("Algebraic multiplicity", 3)
                ),
                time=180
            )
        end
        
    elseif problem_type == 4
        # Trace and determinant relationship
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        
        trace = λ1 + λ2
        det = λ1 * λ2
        
        if rand(Bool)
            # Ask for trace given eigenvalues
            problem(
                question="A \$2 \\times 2\$ matrix has eigenvalues \$\\lambda_1 = $(λ1)\$ and \$\\lambda_2 = $(λ2)\$. What is the trace of this matrix?",
                answer=trace,
                difficulty=(1850, 2050),
                solution=steps(
                    "The trace of a matrix equals the sum of its eigenvalues",
                    "\$\\text{tr}(A) = \\lambda_1 + \\lambda_2 = $(λ1) + $(λ2)\$",
                    sol("Trace", trace)
                ),
                time=90
            )
        else
            # Ask for determinant given eigenvalues
            problem(
                question="A \$2 \\times 2\$ matrix has eigenvalues \$\\lambda_1 = $(λ1)\$ and \$\\lambda_2 = $(λ2)\$. What is the determinant of this matrix?",
                answer=det,
                difficulty=(1850, 2050),
                solution=steps(
                    "The determinant of a matrix equals the product of its eigenvalues",
                    "\$\\det(A) = \\lambda_1 \\cdot \\lambda_2 = $(λ1) \\cdot $(λ2)\$",
                    sol("Determinant", det)
                ),
                time=90
            )
        end
        
    else
        # Matrix power eigenvalue problem
        λ1 = randint(2, 5)
        λ2 = randint(2, 5)
        n = randint(3, 6)
        
        trace = λ1 + λ2
        det = λ1 * λ2
        
        m11 = randint(-4, 4)
        m22 = trace - m11
        m12 = nonzero(-5, 5)
        m21 = (det - m11*m22) // m12
        
        matrix_tex = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        
        λ1_power = λ1^n
        λ2_power = λ2^n
        
        problem(
            question="Matrix \$A = $(matrix_tex)\$ has eigenvalues \$\\lambda_1 = $(λ1)\$ and \$\\lambda_2 = $(λ2)\$. Find the largest eigenvalue of \$A^{$(n)}\$.",
            answer=max(λ1_power, λ2_power),
            difficulty=(2100, 2400),
            solution=steps(
                "If \$\\lambda\$ is an eigenvalue of \$A\$, then \$\\lambda^n\$ is an eigenvalue of \$A^n\$",
                "Eigenvalues of \$A^{$(n)}\$ are: \$$(λ1)^{$(n)} = $(λ1_power)\$ and \$$(λ2)^{$(n)} = $(λ2_power)\$",
                sol("Largest eigenvalue", max(λ1_power, λ2_power))
            ),
            time=200
        )
    end
end