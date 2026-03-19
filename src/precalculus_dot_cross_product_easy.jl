# precalculus - dot_cross_product (easy)
# Generated: 2026-03-08T20:35:39.661692

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/dot_cross_product")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Compute dot product of two 2D vectors (700-850 ELO)
        a1, a2 = randint(-8, 8), randint(-8, 8)
        b1, b2 = randint(-8, 8), randint(-8, 8)
        
        ans = a1 * b1 + a2 * b2
        
        problem(
            question="Compute the dot product of \\(\\vec{a} = \\langle $(a1), $(a2) \\rangle\\) and \\(\\vec{b} = \\langle $(b1), $(b2) \\rangle\\).",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Use the formula: \\(\\vec{a} \\cdot \\vec{b} = a_1 b_1 + a_2 b_2\\)",
                "Substitute: \\(($(a1))($(b1)) + ($(a2))($(b2))\\)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Compute dot product of two 3D vectors (750-900 ELO)
        a1, a2, a3 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        b1, b2, b3 = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        
        ans = a1 * b1 + a2 * b2 + a3 * b3
        
        problem(
            question="Compute the dot product of \\(\\vec{u} = \\langle $(a1), $(a2), $(a3) \\rangle\\) and \\(\\vec{v} = \\langle $(b1), $(b2), $(b3) \\rangle\\).",
            answer=ans,
            difficulty=(750, 900),
            solution=steps(
                "Use the formula: \\(\\vec{u} \\cdot \\vec{v} = u_1 v_1 + u_2 v_2 + u_3 v_3\\)",
                "Substitute: \\(($(a1))($(b1)) + ($(a2))($(b2)) + ($(a3))($(b3))\\)",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Find magnitude of a 3D vector (700-850 ELO)
        a, b, c = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        
        ans_squared = a^2 + b^2 + c^2
        ans = sqrt(ans_squared)
        
        problem(
            question="Find the magnitude of the vector \\(\\vec{v} = \\langle $(a), $(b), $(c) \\rangle\\). Simplify your answer.",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Use the formula: \\(\\|\\vec{v}\\| = \\sqrt{a^2 + b^2 + c^2}\\)",
                "Substitute: \\(\\|\\vec{v}\\| = \\sqrt{($(a))^2 + ($(b))^2 + ($(c))^2}\\)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Determine if two vectors are orthogonal (800-950 ELO)
        # Generate orthogonal vectors with probability 0.5
        if rand() < 0.5
            a1, a2 = nonzero(-8, 8), nonzero(-8, 8)
            b1 = nonzero(-8, 8)
            b2 = -(a1 * b1) // a2
            if denominator(b2) == 1
                b2 = Int(b2)
            end
        else
            a1, a2 = randint(-8, 8), randint(-8, 8)
            b1, b2 = randint(-8, 8), randint(-8, 8)
        end
        
        dot_prod = a1 * b1 + a2 * b2
        ans = (dot_prod == 0) ? "Yes" : "No"
        
        problem(
            question="Are the vectors \\(\\vec{a} = \\langle $(a1), $(a2) \\rangle\\) and \\(\\vec{b} = \\langle $(b1), $(b2) \\rangle\\) orthogonal? Answer Yes or No.",
            answer=ans,
            difficulty=(800, 950),
            answer_type="text",
            solution=steps(
                "Two vectors are orthogonal if their dot product is zero",
                "Compute: \\(\\vec{a} \\cdot \\vec{b} = ($(a1))($(b1)) + ($(a2))($(b2)) = $(dot_prod)\\)",
                "Since the dot product is $(dot_prod == 0 ? "zero" : "not zero"), the answer is $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Compute cross product magnitude in 3D (900-1100 ELO)
        a1, a2, a3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        b1, b2, b3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        
        c1 = a2 * b3 - a3 * b2
        c2 = a3 * b1 - a1 * b3
        c3 = a1 * b2 - a2 * b1
        
        problem(
            question="Compute the cross product \\(\\vec{u} \\times \\vec{v}\\) where \\(\\vec{u} = \\langle $(a1), $(a2), $(a3) \\rangle\\) and \\(\\vec{v} = \\langle $(b1), $(b2), $(b3) \\rangle\\). Enter your answer as an ordered triple.",
            answer=fmt_tuple([c1, c2, c3]),
            difficulty=(900, 1100),
            answer_type="tuple",
            solution=steps(
                "Use the formula: \\(\\vec{u} \\times \\vec{v} = \\langle u_2 v_3 - u_3 v_2, u_3 v_1 - u_1 v_3, u_1 v_2 - u_2 v_1 \\rangle\\)",
                "First component: \\(($(a2))($(b3)) - ($(a3))($(b2)) = $(c1)\\)",
                "Second component: \\(($(a3))($(b1)) - ($(a1))($(b3)) = $(c2)\\)",
                "Third component: \\(($(a1))($(b2)) - ($(a2))($(b1)) = $(c3)\\)",
                sol("Answer", fmt_tuple([c1, c2, c3]))
            ),
            time=120
        )
        
    else
        # Find a vector orthogonal to a given 3D vector (850-1050 ELO)
        a, b, c = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        
        # One simple orthogonal vector: swap two components and negate one, set third to 0
        v1, v2, v3 = -b, a, 0
        
        problem(
            question="Find any nonzero vector orthogonal to \\(\\vec{w} = \\langle $(a), $(b), $(c) \\rangle\\). Enter your answer as an ordered triple.",
            answer=fmt_tuple([v1, v2, v3]),
            difficulty=(850, 1050),
            answer_type="tuple",
            solution=steps(
                "A vector \\(\\vec{v} = \\langle x, y, z \\rangle\\) is orthogonal to \\(\\vec{w}\\) if \\(\\vec{v} \\cdot \\vec{w} = 0\\)",
                "This means: \\($(a)x + $(b)y + $(c)z = 0\\)",
                "One solution: set \\(z = 0\\), then \\(x = $(v1)\\), \\(y = $(v2)\\)",
                sol("Answer (one of many)", fmt_tuple([v1, v2, v3]))
            ),
            time=120
        )
    end
end