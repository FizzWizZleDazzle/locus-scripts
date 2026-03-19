# linear_algebra - linear_independence (easy)
# Generated: 2026-03-08T21:12:07.337022

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/linear_independence")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Check if two 2D vectors are linearly independent (ELO 700-900)
        a1 = nonzero(-8, 8)
        a2 = nonzero(-8, 8)
        b1 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
        
        # Ensure they're not scalar multiples
        while abs(a1 * b2 - a2 * b1) < 2
            b1 = nonzero(-8, 8)
            b2 = nonzero(-8, 8)
        end
        
        det_val = a1 * b2 - a2 * b1
        is_indep = det_val != 0
        
        v1_str = "\\begin{bmatrix} $(a1) \\\\ $(a2) \\end{bmatrix}"
        v2_str = "\\begin{bmatrix} $(b1) \\\\ $(b2) \\end{bmatrix}"
        
        problem(
            question="Are the vectors \$$(v1_str)\$ and \$$(v2_str)\$ linearly independent? Answer 'yes' or 'no'.",
            answer=is_indep ? "yes" : "no",
            difficulty=(700, 900),
            answer_type="text",
            solution=steps(
                "Two vectors in ℝ² are linearly independent if and only if they are not scalar multiples of each other.",
                "Check the determinant: \$$(a1) \\cdot $(b2) - $(a2) \\cdot $(b1) = $(det_val)\$",
                det_val != 0 ? "Since the determinant is nonzero, the vectors are linearly independent." : "Since the determinant is zero, the vectors are linearly dependent.",
                sol("Answer", is_indep ? "yes" : "no")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Determine if three 2D vectors are linearly independent (ELO 800-1000)
        a1 = nonzero(-7, 7)
        a2 = nonzero(-7, 7)
        b1 = nonzero(-7, 7)
        b2 = nonzero(-7, 7)
        c1 = nonzero(-7, 7)
        c2 = nonzero(-7, 7)
        
        v1_str = "\\begin{bmatrix} $(a1) \\\\ $(a2) \\end{bmatrix}"
        v2_str = "\\begin{bmatrix} $(b1) \\\\ $(b2) \\end{bmatrix}"
        v3_str = "\\begin{bmatrix} $(c1) \\\\ $(c2) \\end{bmatrix}"
        
        problem(
            question="Are the vectors \$$(v1_str)\$, \$$(v2_str)\$, and \$$(v3_str)\$ linearly independent? Answer 'yes' or 'no'.",
            answer="no",
            difficulty=(800, 1000),
            answer_type="text",
            solution=steps(
                "We have three vectors in ℝ², which is a 2-dimensional space.",
                "Any set of more than 2 vectors in ℝ² must be linearly dependent.",
                "This is because the maximum number of linearly independent vectors in ℝⁿ is n.",
                sol("Answer", "no")
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Type 3: Check if two 3D vectors are linearly independent (ELO 750-950)
        a1 = nonzero(-6, 6)
        a2 = nonzero(-6, 6)
        a3 = nonzero(-6, 6)
        
        # Create second vector not a scalar multiple
        b1 = nonzero(-6, 6)
        b2 = nonzero(-6, 6)
        b3 = nonzero(-6, 6)
        
        # Check not parallel (at least one 2x2 minor is nonzero)
        while abs(a1*b2 - a2*b1) < 1 && abs(a1*b3 - a3*b1) < 1 && abs(a2*b3 - a3*b2) < 1
            b1 = nonzero(-6, 6)
            b2 = nonzero(-6, 6)
            b3 = nonzero(-6, 6)
        end
        
        v1_str = "\\begin{bmatrix} $(a1) \\\\ $(a2) \\\\ $(a3) \\end{bmatrix}"
        v2_str = "\\begin{bmatrix} $(b1) \\\\ $(b2) \\\\ $(b3) \\end{bmatrix}"
        
        problem(
            question="Are the vectors \$$(v1_str)\$ and \$$(v2_str)\$ linearly independent? Answer 'yes' or 'no'.",
            answer="yes",
            difficulty=(750, 950),
            answer_type="text",
            solution=steps(
                "Two vectors are linearly independent if neither is a scalar multiple of the other.",
                "Check if \$\\mathbf{v}_2 = k\\mathbf{v}_1\$ for some scalar k.",
                "If this were true, we'd need \$$(b1) = k \\cdot $(a1)\$, \$$(b2) = k \\cdot $(a2)\$, and \$$(b3) = k \\cdot $(a3)\$ for the same k.",
                "These ratios are not all equal, so the vectors are linearly independent.",
                sol("Answer", "yes")
            ),
            time=100
        )
        
    else
        # Type 4: Find value that makes vectors linearly dependent (ELO 900-1200)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # Second vector with parameter k
        # Want det = 0, so a*k - b*c = 0, thus k = bc/a
        k_answer = (b * c) // a
        
        v1_str = "\\begin{bmatrix} $(a) \\\\ $(b) \\end{bmatrix}"
        v2_str = "\\begin{bmatrix} k \\\\ $(c) \\end{bmatrix}"
        
        problem(
            question="Find the value of k that makes the vectors \$$(v1_str)\$ and \$$(v2_str)\$ linearly dependent.",
            answer=k_answer,
            difficulty=(900, 1200),
            solution=steps(
                "Two vectors are linearly dependent if one is a scalar multiple of the other, or equivalently, if their determinant is zero.",
                sol("Determinant", "$(a) \\cdot $(c) - $(b) \\cdot k = 0"),
                "Solve for k: \$$(a * c) - $(b)k = 0\$",
                sol("k", "\\frac{$(a * c)}{$(b)} = $(k_answer)")
            ),
            time=120
        )
    end
end