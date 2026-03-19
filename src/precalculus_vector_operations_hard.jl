# precalculus - vector_operations (hard)
# Generated: 2026-03-08T20:35:21.955272

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Dot product and angle between vectors
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        
        dot_prod = a1*b1 + a2*b2 + a3*b3
        mag_a = sqrt(a1^2 + a2^2 + a3^2)
        mag_b = sqrt(b1^2 + b2^2 + b3^2)
        cos_theta = dot_prod / (mag_a * mag_b)
        theta = acos(cos_theta) * 180 / π
        
        problem(
            question="Let \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩ and \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩. Find the angle between \\vec{u} and \\vec{v} in degrees. Round to the nearest tenth.",
            answer=round(theta, digits=1),
            difficulty=(1800, 2000),
            solution=steps(
                "Given vectors: \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩, \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩",
                "Compute \\vec{u} ⋅ \\vec{v} = $(a1)($(b1)) + $(a2)($(b2)) + $(a3)($(b3)) = $(dot_prod)",
                "Compute |\\vec{u}| = \\sqrt{$(a1)^2 + $(a2)^2 + $(a3)^2} = $(round(mag_a, digits=3))",
                "Compute |\\vec{v}| = \\sqrt{$(b1)^2 + $(b2)^2 + $(b3)^2} = $(round(mag_b, digits=3))",
                "Use \\cos θ = \\frac{\\vec{u} ⋅ \\vec{v}}{|\\vec{u}||\\vec{v}|} = $(round(cos_theta, digits=4))",
                "θ = \\arccos($(round(cos_theta, digits=4))) ≈ $(round(theta, digits=1))°"
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Projection of one vector onto another
        a1, a2 = randint(-10, 10), nonzero(-10, 10)
        b1, b2 = nonzero(-10, 10), randint(-10, 10)
        
        dot_prod = a1*b1 + a2*b2
        mag_b_sq = b1^2 + b2^2
        scalar_proj = dot_prod / sqrt(mag_b_sq)
        proj_x = (dot_prod * b1) // mag_b_sq
        proj_y = (dot_prod * b2) // mag_b_sq
        
        problem(
            question="Find the vector projection of \\vec{u} = ⟨$(a1), $(a2)⟩ onto \\vec{v} = ⟨$(b1), $(b2)⟩. Express your answer as ⟨a, b⟩.",
            answer="⟨$(proj_x), $(proj_y)⟩",
            difficulty=(1900, 2100),
            solution=steps(
                "Given: \\vec{u} = ⟨$(a1), $(a2)⟩, \\vec{v} = ⟨$(b1), $(b2)⟩",
                "Formula: \\text{proj}_{\\vec{v}}\\vec{u} = \\frac{\\vec{u} ⋅ \\vec{v}}{\\vec{v} ⋅ \\vec{v}} \\vec{v}",
                "Compute \\vec{u} ⋅ \\vec{v} = $(a1)($(b1)) + $(a2)($(b2)) = $(dot_prod)",
                "Compute \\vec{v} ⋅ \\vec{v} = $(b1)^2 + $(b2)^2 = $(mag_b_sq)",
                "Scalar coefficient: \\frac{$(dot_prod)}{$(mag_b_sq)}",
                "Projection: \\frac{$(dot_prod)}{$(mag_b_sq)} ⟨$(b1), $(b2)⟩ = ⟨$(proj_x), $(proj_y)⟩"
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Cross product magnitude and area
        a1, a2, a3 = randint(-7, 7), randint(-7, 7), nonzero(-7, 7)
        b1, b2, b3 = randint(-7, 7), nonzero(-7, 7), randint(-7, 7)
        
        cross_x = a2*b3 - a3*b2
        cross_y = a3*b1 - a1*b3
        cross_z = a1*b2 - a2*b1
        
        area = sqrt(cross_x^2 + cross_y^2 + cross_z^2)
        
        problem(
            question="Find the area of the parallelogram spanned by vectors \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩ and \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩. Round to two decimal places.",
            answer=round(area, digits=2),
            difficulty=(2000, 2200),
            solution=steps(
                "Given: \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩, \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩",
                "Area = |\\vec{u} × \\vec{v}|",
                "Cross product: \\vec{u} × \\vec{v} = ⟨$(a2)($(b3)) - $(a3)($(b2)), $(a3)($(b1)) - $(a1)($(b3)), $(a1)($(b2)) - $(a2)($(b1))⟩",
                "\\vec{u} × \\vec{v} = ⟨$(cross_x), $(cross_y), $(cross_z)⟩",
                "Magnitude: \\sqrt{$(cross_x)^2 + $(cross_y)^2 + $(cross_z)^2} = $(round(area, digits=2))"
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Unit vector in direction
        a = nonzero(-12, 12)
        b = nonzero(-12, 12)
        c = nonzero(-12, 12)
        
        mag = sqrt(a^2 + b^2 + c^2)
        unit_x = a / mag
        unit_y = b / mag
        unit_z = c / mag
        
        problem(
            question="Find a unit vector in the direction of \\vec{v} = ⟨$(a), $(b), $(c)⟩. Express components as decimals rounded to three places.",
            answer="⟨$(round(unit_x, digits=3)), $(round(unit_y, digits=3)), $(round(unit_z, digits=3))⟩",
            difficulty=(1800, 1950),
            solution=steps(
                "Given: \\vec{v} = ⟨$(a), $(b), $(c)⟩",
                "Compute magnitude: |\\vec{v}| = \\sqrt{$(a)^2 + $(b)^2 + $(c)^2} = $(round(mag, digits=3))",
                "Unit vector: \\hat{v} = \\frac{\\vec{v}}{|\\vec{v}|}",
                "\\hat{v} = \\frac{1}{$(round(mag, digits=3))} ⟨$(a), $(b), $(c)⟩",
                "\\hat{v} = ⟨$(round(unit_x, digits=3)), $(round(unit_y, digits=3)), $(round(unit_z, digits=3))⟩"
            ),
            time=150,
            calculator="scientific"
        )
        
    elseif problem_type == 5
        # Vector triple scalar product
        a1, a2, a3 = randint(-6, 6), randint(-6, 6), nonzero(-6, 6)
        b1, b2, b3 = randint(-6, 6), nonzero(-6, 6), randint(-6, 6)
        c1, c2, c3 = nonzero(-6, 6), randint(-6, 6), randint(-6, 6)
        
        cross_x = b2*c3 - b3*c2
        cross_y = b3*c1 - b1*c3
        cross_z = b1*c2 - b2*c1
        
        scalar_triple = a1*cross_x + a2*cross_y + a3*cross_z
        volume = abs(scalar_triple)
        
        problem(
            question="Find the volume of the parallelepiped determined by vectors \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩, \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩, and \\vec{w} = ⟨$(c1), $(c2), $(c3)⟩.",
            answer=volume,
            difficulty=(2100, 2300),
            solution=steps(
                "Given: \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩, \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩, \\vec{w} = ⟨$(c1), $(c2), $(c3)⟩",
                "Volume = |\\vec{u} ⋅ (\\vec{v} × \\vec{w})|",
                "Compute \\vec{v} × \\vec{w} = ⟨$(cross_x), $(cross_y), $(cross_z)⟩",
                "Compute \\vec{u} ⋅ (\\vec{v} × \\vec{w}) = $(a1)($(cross_x)) + $(a2)($(cross_y)) + $(a3)($(cross_z)) = $(scalar_triple)",
                "Volume = |$(scalar_triple)| = $(volume)"
            ),
            time=240
        )
        
    else
        # Orthogonal decomposition
        a1, a2, a3 = randint(-9, 9), randint(-9, 9), nonzero(-9, 9)
        b1, b2, b3 = nonzero(-9, 9), randint(-9, 9), randint(-9, 9)
        
        dot_prod = a1*b1 + a2*b2 + a3*b3
        mag_b_sq = b1^2 + b2^2 + b3^2
        proj_x = (dot_prod * b1) // mag_b_sq
        proj_y = (dot_prod * b2) // mag_b_sq
        proj_z = (dot_prod * b3) // mag_b_sq
        
        orth_x = a1 - proj_x
        orth_y = a2 - proj_y
        orth_z = a3 - proj_z
        
        problem(
            question="Decompose \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩ into components parallel and perpendicular to \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩. Find the perpendicular component.",
            answer="⟨$(orth_x), $(orth_y), $(orth_z)⟩",
            difficulty=(2000, 2250),
            solution=steps(
                "Given: \\vec{u} = ⟨$(a1), $(a2), $(a3)⟩, \\vec{v} = ⟨$(b1), $(b2), $(b3)⟩",
                "Parallel component: \\vec{u}_{\\parallel} = \\text{proj}_{\\vec{v}}\\vec{u} = ⟨$(proj_x), $(proj_y), $(proj_z)⟩",
                "Perpendicular component: \\vec{u}_{\\perp} = \\vec{u} - \\vec{u}_{\\parallel}",
                "\\vec{u}_{\\perp} = ⟨$(a1), $(a2), $(a3)⟩ - ⟨$(proj_x), $(proj_y), $(proj_z)⟩",
                "\\vec{u}_{\\perp} = ⟨$(orth_x), $(orth_y), $(orth_z)⟩"
            ),
            time=210
        )
    end
end