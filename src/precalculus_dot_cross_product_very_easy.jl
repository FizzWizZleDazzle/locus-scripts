# precalculus - dot_cross_product (very_easy)
# Generated: 2026-03-08T20:35:12.038331

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/dot_cross_product")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Dot product calculation (200-400 ELO)
        a1 = randint(-5, 5)
        a2 = randint(-5, 5)
        b1 = randint(-5, 5)
        b2 = randint(-5, 5)
        
        dot_result = a1 * b1 + a2 * b2
        
        problem(
            question = "Calculate the dot product of \\(\\mathbf{a} = \\langle $(a1), $(a2) \\rangle\\) and \\(\\mathbf{b} = \\langle $(b1), $(b2) \\rangle\\).",
            answer = dot_result,
            difficulty = (200, 400),
            solution = steps(
                "Given vectors: \\(\\mathbf{a} = \\langle $(a1), $(a2) \\rangle\\) and \\(\\mathbf{b} = \\langle $(b1), $(b2) \\rangle\\)",
                "Apply dot product formula: \\(\\mathbf{a} \\cdot \\mathbf{b} = a_1 b_1 + a_2 b_2\\)",
                "\\(\\mathbf{a} \\cdot \\mathbf{b} = ($(a1))($(b1)) + ($(a2))($(b2)) = $(a1*b1) + $(a2*b2) = $(dot_result)\\)"
            ),
            time = 45
        )
        
    elseif problem_type == 2
        # Magnitude calculation (300-500 ELO)
        v1 = randint(-6, 6)
        v2 = randint(-6, 6)
        
        mag_squared = v1^2 + v2^2
        mag = sqrt(mag_squared)
        
        problem(
            question = "Find the magnitude of the vector \\(\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\\).",
            answer = mag,
            difficulty = (300, 500),
            solution = steps(
                "Given vector: \\(\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\\)",
                "Apply magnitude formula: \\(\\|\\mathbf{v}\\| = \\sqrt{v_1^2 + v_2^2}\\)",
                "\\(\\|\\mathbf{v}\\| = \\sqrt{($(v1))^2 + ($(v2))^2} = \\sqrt{$(v1^2) + $(v2^2)} = \\sqrt{$(mag_squared)}\\)"
            ),
            time = 60
        )
        
    elseif problem_type == 3
        # Cross product magnitude in 2D (400-600 ELO)
        a1 = randint(-7, 7)
        a2 = randint(-7, 7)
        b1 = randint(-7, 7)
        b2 = randint(-7, 7)
        
        cross_result = a1 * b2 - a2 * b1
        
        problem(
            question = "Find the \\(z\\)-component of the cross product \\(\\mathbf{a} \\times \\mathbf{b}\\), where \\(\\mathbf{a} = \\langle $(a1), $(a2), 0 \\rangle\\) and \\(\\mathbf{b} = \\langle $(b1), $(b2), 0 \\rangle\\).",
            answer = cross_result,
            difficulty = (400, 600),
            solution = steps(
                "Given: \\(\\mathbf{a} = \\langle $(a1), $(a2), 0 \\rangle\\) and \\(\\mathbf{b} = \\langle $(b1), $(b2), 0 \\rangle\\)",
                "For 2D vectors in the \\(xy\\)-plane, the cross product has only a \\(z\\)-component: \\(a_1 b_2 - a_2 b_1\\)",
                "\\((\\mathbf{a} \\times \\mathbf{b})_z = ($(a1))($(b2)) - ($(a2))($(b1)) = $(a1*b2) - $(a2*b1) = $(cross_result)\\)"
            ),
            time = 75
        )
        
    else
        # Dot product with scalar multiples (500-700 ELO)
        k = randint(2, 4)
        v1 = randint(-5, 5)
        v2 = randint(-5, 5)
        w1 = randint(-5, 5)
        w2 = randint(-5, 5)
        
        # Calculate k*v · w
        kv1 = k * v1
        kv2 = k * v2
        dot_result = kv1 * w1 + kv2 * w2
        
        problem(
            question = "Calculate \\(($(k)\\mathbf{v}) \\cdot \\mathbf{w}\\), where \\(\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\\) and \\(\\mathbf{w} = \\langle $(w1), $(w2) \\rangle\\).",
            answer = dot_result,
            difficulty = (500, 700),
            solution = steps(
                "Given: \\(\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\\) and \\(\\mathbf{w} = \\langle $(w1), $(w2) \\rangle\\)",
                "First compute \\($(k)\\mathbf{v} = \\langle $(kv1), $(kv2) \\rangle\\)",
                "Apply dot product: \\(($(k)\\mathbf{v}) \\cdot \\mathbf{w} = ($(kv1))($(w1)) + ($(kv2))($(w2)) = $(kv1*w1) + $(kv2*w2) = $(dot_result)\\)"
            ),
            time = 90
        )
    end
end