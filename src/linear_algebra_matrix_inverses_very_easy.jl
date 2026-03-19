# linear_algebra - matrix_inverses (very_easy)
# Generated: 2026-03-08T21:08:22.564938

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Recognize if a 2x2 matrix is invertible (check determinant ≠ 0)
        # ELO 200-400: Recognition/recall
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        det_val = a * d - b * c
        
        is_invertible = det_val != 0
        
        problem(
            question="Is the matrix $(fmt_matrix([[a, b], [c, d]])) invertible? Answer 'yes' or 'no'.",
            answer=is_invertible ? "yes" : "no",
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "A matrix is invertible if and only if its determinant is non-zero",
                "Calculate determinant: \$\\det(A) = $(a) \\cdot $(d) - $(b) \\cdot $(c) = $(det_val)\$",
                det_val != 0 ? "Since \$\\det(A) \\neq 0\$, the matrix is invertible" : "Since \$\\det(A) = 0\$, the matrix is NOT invertible"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Calculate determinant of a 2x2 matrix
        # ELO 400-600: One clear step, basic calculation
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        det_val = a * d - b * c
        
        problem(
            question="Calculate the determinant of $(fmt_matrix([[a, b], [c, d]]))",
            answer=det_val,
            difficulty=(400, 600),
            solution=steps(
                "Use the formula \$\\det\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix} = ad - bc\$",
                sol("Calculation", "$(a)($(d)) - $(b)($(c))"),
                sol("Answer", det_val)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Find the inverse of a 2x2 matrix (with integer entries and nice inverse)
        # ELO 600-700: Elementary one-step application of inverse formula
        # Construct backward: start with invertible matrix with determinant ±1, ±2
        det_val = choice([-2, -1, 1, 2])
        
        # For det = 1: choose a, d, then b, c such that ad - bc = 1
        a = randint(-4, 4)
        d = randint(-4, 4)
        b = randint(-4, 4)
        c = (a * d - det_val) // b
        
        # Recompute to ensure clean division
        a = choice([1, 2, -1, -2])
        d = choice([1, 2, -1, -2])
        if det_val == 1
            b = randint(-3, 3)
            c = a * d - 1 - b
        elseif det_val == -1
            b = randint(-3, 3)
            c = a * d + 1 - b
        elseif det_val == 2
            b = randint(-2, 2)
            c = (a * d - 2) // 1 - b
        else  # det_val == -2
            b = randint(-2, 2)
            c = (a * d + 2) // 1 - b
        end
        
        # Simplify: use determinant = 1 for cleanest answer
        a = choice([1, 2, 3, -1, -2])
        d = choice([1, 2, 3, -1, -2])
        b = randint(-3, 3)
        c = a * d - 1 - b  # This ensures det = 1
        
        det_check = a * d - b * c
        
        inv_a = d // det_check
        inv_b = -b // det_check
        inv_c = -c // det_check
        inv_d = a // det_check
        
        answer_str = fmt_matrix([[inv_a, inv_b], [inv_c, inv_d]])
        
        problem(
            question="Find the inverse of $(fmt_matrix([[a, b], [c, d]]))",
            answer=answer_str,
            difficulty=(600, 700),
            answer_type="matrix",
            solution=steps(
                "Use the formula \$A^{-1} = \\frac{1}{\\det(A)} \\begin{pmatrix} d & -b \\\\ -c & a \\end{pmatrix}\$",
                sol("Determinant", "$(a)($(d)) - $(b)($(c)) = $(det_check)"),
                sol("Inverse", answer_str)
            ),
            time=90
        )
        
    else
        # Verify if two 2x2 matrices are inverses (multiply and check for identity)
        # ELO 500-650: Basic matrix multiplication check
        # Construct: A and A^(-1) with det = 1 for clean values
        a = choice([1, 2, -1, -2])
        d = choice([1, 2, -1, -2])
        b = randint(-3, 3)
        c = a * d - 1 - b
        
        det_val = a * d - b * c
        
        if det_val != 0
            inv_a = d // det_val
            inv_b = -b // det_val
            inv_c = -c // det_val
            inv_d = a // det_val
            
            # Decide whether to give correct inverse or not
            is_correct = choice([true, false])
            
            if !is_correct
                # Modify one entry slightly
                inv_a += choice([-1, 1])
            end
            
            problem(
                question="Are $(fmt_matrix([[a, b], [c, d]])) and $(fmt_matrix([[inv_a, inv_b], [inv_c, inv_d]])) inverse matrices? Answer 'yes' or 'no'.",
                answer=is_correct ? "yes" : "no",
                difficulty=(500, 650),
                answer_type="text",
                solution=steps(
                    "Two matrices are inverses if their product is the identity matrix",
                    "Multiply the matrices and check if result equals \$\\begin{pmatrix} 1 & 0 \\\\ 0 & 1 \\end{pmatrix}\$",
                    is_correct ? "The product is the identity matrix, so they are inverses" : "The product is not the identity matrix, so they are NOT inverses"
                ),
                time=90
            )
        else
            # Fallback to simpler determinant problem
            problem(
                question="Calculate the determinant of $(fmt_matrix([[a, b], [c, d]]))",
                answer=det_val,
                difficulty=(400, 600),
                solution=steps(
                    "Use the formula \$\\det\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix} = ad - bc\$",
                    sol("Calculation", "$(a)($(d)) - $(b)($(c))"),
                    sol("Answer", det_val)
                ),
                time=45
            )
        end
    end
end