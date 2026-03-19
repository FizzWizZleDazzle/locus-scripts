# linear_algebra - linear_independence (very_easy)
# Generated: 2026-03-08T21:12:06.138101

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/linear_independence")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Recognize definition of linear independence (ELO 200-400)
        problem(
            question="True or False: A set of vectors is **linearly independent** if no vector in the set can be written as a linear combination of the others.",
            answer="True",
            difficulty=(200, 400),
            answer_type="multiple_choice",
            solution=steps(
                "Linear independence means no vector is redundant",
                "This is equivalent to saying no vector can be expressed using the others",
                sol("Answer", "True")
            ),
            time=30
        )
    elseif problem_type == 2
        # Identify linearly dependent vs independent (simple 2D case) (ELO 400-600)
        scalar = nonzero(-5, 5)
        if rand(Bool)
            # Dependent case
            v1_x, v1_y = nonzero(-8, 8), nonzero(-8, 8)
            v2_x, v2_y = scalar * v1_x, scalar * v1_y
            ans = "linearly dependent"
            explain = "\\mathbf{v}_2 = $(scalar)\\mathbf{v}_1, so one vector is a scalar multiple of the other"
        else
            # Independent case
            v1_x, v1_y = nonzero(-8, 8), nonzero(-8, 8)
            v2_x, v2_y = nonzero(-8, 8), nonzero(-8, 8)
            while v1_x * v2_y == v1_y * v2_x  # Ensure not parallel
                v2_x, v2_y = nonzero(-8, 8), nonzero(-8, 8)
            end
            ans = "linearly independent"
            explain = "Neither vector is a scalar multiple of the other"
        end
        
        problem(
            question="Are the vectors \\mathbf{v}_1 = \\begin{bmatrix} $(v1_x) \\\\ $(v1_y) \\end{bmatrix} and \\mathbf{v}_2 = \\begin{bmatrix} $(v2_x) \\\\ $(v2_y) \\end{bmatrix} **linearly independent** or **linearly dependent**?",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Check if one vector is a scalar multiple of the other",
                explain,
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 3
        # Count maximum linearly independent vectors in R^n (ELO 300-500)
        n = randint(2, 5)
        problem(
            question="What is the maximum number of linearly independent vectors that can exist in \\mathbb{R}^{$(n)}?",
            answer=n,
            difficulty=(300, 500),
            solution=steps(
                "The dimension of \\mathbb{R}^{$(n)} is $(n)",
                "Any set of more than $(n) vectors in \\mathbb{R}^{$(n)} must be linearly dependent",
                sol("Answer", n)
            ),
            time=45
        )
    elseif problem_type == 4
        # Recognize zero vector makes set dependent (ELO 400-600)
        v1 = nonzero(-9, 9)
        v2 = nonzero(-9, 9)
        
        problem(
            question="Consider the set of vectors \\left\\{ \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}, \\begin{bmatrix} 0 \\\\ 0 \\end{bmatrix} \\right\\}. Is this set linearly independent or linearly dependent?",
            answer="linearly dependent",
            difficulty=(400, 600),
            solution=steps(
                "Any set containing the zero vector is linearly dependent",
                "We can write \\mathbf{0} = 0 \\cdot \\mathbf{v}_1, a nontrivial linear combination",
                sol("Answer", "linearly dependent")
            ),
            time=45
        )
    else
        # Simple 3-vector dependence check in R^3 (ELO 500-700)
        if rand(Bool)
            # Create dependent set: v3 = a*v1 + b*v2
            v1_x, v1_y, v1_z = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            v2_x, v2_y, v2_z = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            a_coef = rand([-2, -1, 2, 3])
            b_coef = rand([-2, -1, 2, 3])
            v3_x, v3_y, v3_z = a_coef*v1_x + b_coef*v2_x, a_coef*v1_y + b_coef*v2_y, a_coef*v1_z + b_coef*v2_z
            ans = "linearly dependent"
            explain = "\\mathbf{v}_3 = $(a_coef)\\mathbf{v}_1 + $(b_coef)\\mathbf{v}_2"
        else
            # Standard basis vectors (independent)
            coords = shuffle([1, 2, 3])
            v1_x, v1_y, v1_z = (coords[1]==1 ? 1 : 0), (coords[1]==2 ? 1 : 0), (coords[1]==3 ? 1 : 0)
            v2_x, v2_y, v2_z = (coords[2]==1 ? 1 : 0), (coords[2]==2 ? 1 : 0), (coords[2]==3 ? 1 : 0)
            v3_x, v3_y, v3_z = (coords[3]==1 ? 1 : 0), (coords[3]==2 ? 1 : 0), (coords[3]==3 ? 1 : 0)
            ans = "linearly independent"
            explain = "These are standard basis vectors (or a permutation), which are linearly independent"
        end
        
        problem(
            question="Determine if the vectors \\mathbf{v}_1 = \\begin{bmatrix} $(v1_x) \\\\ $(v1_y) \\\\ $(v1_z) \\end{bmatrix}, \\mathbf{v}_2 = \\begin{bmatrix} $(v2_x) \\\\ $(v2_y) \\\\ $(v2_z) \\end{bmatrix}, and \\mathbf{v}_3 = \\begin{bmatrix} $(v3_x) \\\\ $(v3_y) \\\\ $(v3_z) \\end{bmatrix} are **linearly independent** or **linearly dependent**.",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Check if one vector can be written as a linear combination of the others",
                explain,
                sol("Answer", ans)
            ),
            time=90
        )
    end
end