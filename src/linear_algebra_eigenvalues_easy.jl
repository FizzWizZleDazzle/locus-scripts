# linear_algebra - eigenvalues (easy)
# Generated: 2026-03-08T21:13:03.811915

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Find eigenvalues of 2x2 diagonal matrix (easiest, ~700-800)
        λ1 = randint(-12, 12)
        λ2 = randint(-12, 12)
        
        matrix_str = "\\begin{bmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{bmatrix}"
        
        problem(
            question="Find all eigenvalues of the matrix \$A = $(matrix_str)\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(700, 800),
            answer_type="set",
            solution=steps(
                "Given: \$A = $(matrix_str)\$",
                "For a diagonal matrix, the eigenvalues are the diagonal entries",
                "Eigenvalues: \$\\{$(λ1), $(λ2)\\}\$"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Type 2: Find eigenvalues of 2x2 triangular matrix (~750-850)
        λ1 = randint(-15, 15)
        λ2 = randint(-15, 15)
        off_diag = randint(-8, 8)
        
        if choice([true, false])
            # Upper triangular
            matrix_str = "\\begin{bmatrix} $(λ1) & $(off_diag) \\\\ 0 & $(λ2) \\end{bmatrix}"
        else
            # Lower triangular
            matrix_str = "\\begin{bmatrix} $(λ1) & 0 \\\\ $(off_diag) & $(λ2) \\end{bmatrix}"
        end
        
        problem(
            question="Find all eigenvalues of the matrix \$A = $(matrix_str)\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(750, 850),
            answer_type="set",
            solution=steps(
                "Given: \$A = $(matrix_str)\$",
                "For a triangular matrix, the eigenvalues are the diagonal entries",
                "Eigenvalues: \$\\{$(λ1), $(λ2)\\}\$"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Find eigenvalues via characteristic polynomial - simple case (~900-1000)
        λ1 = randint(-10, 10)
        λ2 = randint(-10, 10)
        
        # Construct A with eigenvalues λ1, λ2
        # Use A = [[a, b], [c, d]] where trace = a+d = λ1+λ2, det = ad-bc = λ1*λ2
        trace = λ1 + λ2
        det = λ1 * λ2
        
        a = randint(-5, 5)
        d = trace - a
        # Now need ad - bc = det, so bc = ad - det
        prod_bc = a * d - det
        
        if prod_bc == 0
            b = 0
            c = randint(-5, 5)
        else
            # Find factors of prod_bc
            factors = []
            for i in -8:8
                if i != 0 && prod_bc % i == 0
                    push!(factors, (i, prod_bc ÷ i))
                end
            end
            if !isempty(factors)
                b, c = choice(factors)
            else
                b = 1
                c = prod_bc
            end
        end
        
        matrix_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        char_poly = "\\lambda^2 - $(trace)\\lambda + $(det)"
        
        problem(
            question="Find all eigenvalues of the matrix \$A = $(matrix_str)\$ by solving the characteristic equation. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(900, 1000),
            answer_type="set",
            solution=steps(
                "Given: \$A = $(matrix_str)\$",
                "Characteristic polynomial: \$\\det(A - \\lambda I) = $(char_poly) = 0\$",
                "Factor: \$(\\lambda - $(λ1))(\\lambda - $(λ2)) = 0\$",
                "Eigenvalues: \$\\{$(λ1), $(λ2)\\}\$"
            ),
            time=120
        )
        
    else
        # Type 4: Check if a value is an eigenvalue (~1000-1200)
        λ_true = randint(-10, 10)
        test_val = choice([true, false]) ? λ_true : λ_true + nonzero(-3, 3)
        
        a = randint(-5, 5)
        d = 2 * λ_true - a
        det = λ_true * λ_true
        prod_bc = a * d - det
        
        if prod_bc == 0
            b = 0
            c = randint(-5, 5)
        else
            factors = []
            for i in -6:6
                if i != 0 && prod_bc % i == 0
                    push!(factors, (i, prod_bc ÷ i))
                end
            end
            if !isempty(factors)
                b, c = choice(factors)
            else
                b = 1
                c = prod_bc
            end
        end
        
        matrix_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        
        is_eigenvalue = (test_val == λ_true)
        answer_str = is_eigenvalue ? "yes" : "no"
        
        det_result = (a - test_val) * (d - test_val) - b * c
        
        problem(
            question="Is \$\\lambda = $(test_val)\$ an eigenvalue of \$A = $(matrix_str)\$? Answer 'yes' or 'no'.",
            answer=answer_str,
            difficulty=(1000, 1200),
            answer_type="text",
            solution=steps(
                "Check if \$\\det(A - $(test_val)I) = 0\$",
                "\$A - $(test_val)I = \\begin{bmatrix} $(a - test_val) & $(b) \\\\ $(c) & $(d - test_val) \\end{bmatrix}\$",
                "Determinant: \$($(a - test_val))($(d - test_val)) - ($(b))($(c)) = $(det_result)\$",
                is_eigenvalue ? "Since determinant is 0, \$\\lambda = $(test_val)\$ is an eigenvalue" : "Since determinant is not 0, \$\\lambda = $(test_val)\$ is not an eigenvalue"
            ),
            time=90
        )
    end
end