# precalculus - dot_cross_product (hard)
# Generated: 2026-03-08T20:36:16.684931

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/dot_cross_product")
    
    problem_type = choice([
        :dot_product_angle,
        :cross_product_area,
        :projection,
        :perpendicular_vector,
        :triple_scalar_product,
        :angle_between_vectors,
        :orthogonal_decomposition,
        :cross_product_magnitude
    ])
    
    if problem_type == :dot_product_angle
        # Find angle between two vectors using dot product
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        
        dot_prod = a1*b1 + a2*b2 + a3*b3
        mag_a = sqrt(a1^2 + a2^2 + a3^2)
        mag_b = sqrt(b1^2 + b2^2 + b3^2)
        cos_theta = dot_prod / (mag_a * mag_b)
        
        # Ensure valid arccos input
        if abs(cos_theta) > 1
            cos_theta = sign(cos_theta)
        end
        
        theta_rad = acos(cos_theta)
        theta_deg = round(theta_rad * 180 / π, digits=2)
        
        problem(
            question="Find the angle (in degrees, rounded to 2 decimal places) between vectors \\(\\vec{a} = \\langle $(a1), $(a2), $(a3) \\rangle\\) and \\(\\vec{b} = \\langle $(b1), $(b2), $(b3) \\rangle\\).",
            answer=theta_deg,
            difficulty=(1800, 2000),
            solution=steps(
                "Use the formula \\(\\cos(\\theta) = \\frac{\\vec{a} \\cdot \\vec{b}}{\\|\\vec{a}\\| \\|\\vec{b}\\|}\\)",
                sol("\\vec{a} \\cdot \\vec{b}", dot_prod),
                sol("\\|\\vec{a}\\|", "\\sqrt{$(a1^2 + a2^2 + a3^2)} = $(round(mag_a, digits=3))"),
                sol("\\|\\vec{b}\\|", "\\sqrt{$(b1^2 + b2^2 + b3^2)} = $(round(mag_b, digits=3))"),
                sol("\\cos(\\theta)", round(cos_theta, digits=4)),
                sol("\\theta", "$(theta_deg)^\\circ")
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == :cross_product_area
        # Area of parallelogram using cross product
        a1, a2, a3 = randint(-6, 6), randint(-6, 6), nonzero(-6, 6)
        b1, b2, b3 = randint(-6, 6), randint(-6, 6), nonzero(-6, 6)
        
        cross_i = a2*b3 - a3*b2
        cross_j = a3*b1 - a1*b3
        cross_k = a1*b2 - a2*b1
        
        area = sqrt(cross_i^2 + cross_j^2 + cross_k^2)
        area_rounded = round(area, digits=2)
        
        problem(
            question="Find the area of the parallelogram spanned by vectors \\(\\vec{u} = \\langle $(a1), $(a2), $(a3) \\rangle\\) and \\(\\vec{v} = \\langle $(b1), $(b2), $(b3) \\rangle\\). Round to 2 decimal places.",
            answer=area_rounded,
            difficulty=(1900, 2100),
            solution=steps(
                "Area = \\(\\|\\vec{u} \\times \\vec{v}\\|\\)",
                sol("\\vec{u} \\times \\vec{v}", "\\langle $(cross_i), $(cross_j), $(cross_k) \\rangle"),
                sol("\\|\\vec{u} \\times \\vec{v}\\|", "\\sqrt{$(cross_i^2) + $(cross_j^2) + $(cross_k^2)}"),
                sol("Area", area_rounded)
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == :projection
        # Vector projection
        a1, a2 = randint(-10, 10), nonzero(-10, 10)
        b1, b2 = nonzero(-10, 10), randint(-10, 10)
        
        dot_ab = a1*b1 + a2*b2
        dot_bb = b1^2 + b2^2
        scalar = dot_ab // dot_bb
        
        proj1 = scalar * b1
        proj2 = scalar * b2
        
        ans = "\\langle $(tex(proj1)), $(tex(proj2)) \\rangle"
        
        problem(
            question="Find the projection of \\(\\vec{a} = \\langle $(a1), $(a2) \\rangle\\) onto \\(\\vec{b} = \\langle $(b1), $(b2) \\rangle\\). Express as \\(\\langle x, y \\rangle\\) with rational components.",
            answer=ans,
            difficulty=(1850, 2050),
            answer_type="vector",
            solution=steps(
                "Use formula \\(\\text{proj}_{\\vec{b}}\\vec{a} = \\frac{\\vec{a} \\cdot \\vec{b}}{\\vec{b} \\cdot \\vec{b}} \\vec{b}\\)",
                sol("\\vec{a} \\cdot \\vec{b}", dot_ab),
                sol("\\vec{b} \\cdot \\vec{b}", dot_bb),
                sol("\\frac{\\vec{a} \\cdot \\vec{b}}{\\vec{b} \\cdot \\vec{b}}", tex(scalar)),
                sol("\\text{proj}_{\\vec{b}}\\vec{a}", ans)
            ),
            time=150
        )
        
    elseif problem_type == :perpendicular_vector
        # Find vector perpendicular to given vector in 3D
        a, b, c = nonzero(-8, 8), randint(-8, 8), nonzero(-8, 8)
        
        # Choose a simple perpendicular vector
        if b != 0
            v1, v2, v3 = 1, 0, -a//c
        else
            v1, v2, v3 = 0, 1, 0
        end
        
        problem(
            question="Find a non-zero vector perpendicular to \\(\\vec{v} = \\langle $(a), $(b), $(c) \\rangle\\). Express your answer as \\(\\langle x, y, z \\rangle\\).",
            answer="\\langle $(tex(v1)), $(tex(v2)), $(tex(v3)) \\rangle",
            difficulty=(1800, 2000),
            answer_type="vector",
            solution=steps(
                "A vector \\(\\vec{u} = \\langle x, y, z \\rangle\\) is perpendicular to \\(\\vec{v}\\) if \\(\\vec{u} \\cdot \\vec{v} = 0\\)",
                sol("Condition", "$(a)x + $(b)y + $(c)z = 0"),
                "One solution (many possible): set \\(x=$(tex(v1)), y=$(tex(v2))\\), solve for \\(z\\)",
                sol("Answer", "\\langle $(tex(v1)), $(tex(v2)), $(tex(v3)) \\rangle")
            ),
            time=120
        )
        
    elseif problem_type == :triple_scalar_product
        # Triple scalar product for volume
        a1, a2, a3 = randint(-5, 5), randint(-5, 5), nonzero(-5, 5)
        b1, b2, b3 = randint(-5, 5), nonzero(-5, 5), randint(-5, 5)
        c1, c2, c3 = nonzero(-5, 5), randint(-5, 5), randint(-5, 5)
        
        cross_i = b2*c3 - b3*c2
        cross_j = b3*c1 - b1*c3
        cross_k = b1*c2 - b2*c1
        
        triple = a1*cross_i + a2*cross_j + a3*cross_k
        volume = abs(triple)
        
        problem(
            question="Find the volume of the parallelepiped determined by vectors \\(\\vec{a} = \\langle $(a1), $(a2), $(a3) \\rangle\\), \\(\\vec{b} = \\langle $(b1), $(b2), $(b3) \\rangle\\), and \\(\\vec{c} = \\langle $(c1), $(c2), $(c3) \\rangle\\).",
            answer=volume,
            difficulty=(2000, 2200),
            solution=steps(
                "Volume = \\(|\\vec{a} \\cdot (\\vec{b} \\times \\vec{c})|\\)",
                sol("\\vec{b} \\times \\vec{c}", "\\langle $(cross_i), $(cross_j), $(cross_k) \\rangle"),
                sol("\\vec{a} \\cdot (\\vec{b} \\times \\vec{c})", triple),
                sol("Volume", volume)
            ),
            time=200
        )
        
    elseif problem_type == :angle_between_vectors
        # More challenging angle problem with constraint
        # Vectors in 2D where angle is special
        mag_a = randint(3, 8)
        mag_b = randint(3, 8)
        angle_deg = choice([30, 45, 60, 120, 135, 150])
        
        a1, a2 = mag_a, 0
        angle_rad = angle_deg * π / 180
        b1 = round(Int, mag_b * cos(angle_rad))
        b2 = round(Int, mag_b * sin(angle_rad))
        
        dot_prod = a1*b1 + a2*b2
        
        problem(
            question="Vectors \\(\\vec{u} = \\langle $(a1), $(a2) \\rangle\\) and \\(\\vec{v} = \\langle $(b1), $(b2) \\rangle\\) are given. Find \\(\\vec{u} \\cdot \\vec{v}\\).",
            answer=dot_prod,
            difficulty=(1800, 1950),
            solution=steps(
                sol("\\vec{u} \\cdot \\vec{v}", "$(a1)($(b1)) + $(a2)($(b2))"),
                "Compute each term",
                sol("Answer", dot_prod)
            ),
            time=90
        )
        
    elseif problem_type == :orthogonal_decomposition
        # Decompose vector into parallel and perpendicular components
        v1, v2 = randint(-8, 8), nonzero(-8, 8)
        w1, w2 = nonzero(-6, 6), randint(-6, 6)
        
        dot_vw = v1*w1 + v2*w2
        dot_ww = w1^2 + w2^2
        scalar = dot_vw // dot_ww
        
        para1 = scalar * w1
        para2 = scalar * w2
        
        perp1 = v1 - para1
        perp2 = v2 - para2
        
        problem(
            question="Decompose \\(\\vec{v} = \\langle $(v1), $(v2) \\rangle\\) into components parallel and perpendicular to \\(\\vec{w} = \\langle $(w1), $(w2) \\rangle\\). Find the perpendicular component \\(\\vec{v}_\\perp\\).",
            answer="\\langle $(tex(perp1)), $(tex(perp2)) \\rangle",
            difficulty=(2000, 2200),
            answer_type="vector",
            solution=steps(
                "\\(\\vec{v}_{\\parallel} = \\text{proj}_{\\vec{w}}\\vec{v} = \\frac{\\vec{v} \\cdot \\vec{w}}{\\vec{w} \\cdot \\vec{w}} \\vec{w}\\)",
                sol("\\vec{v}_{\\parallel}", "\\langle $(tex(para1)), $(tex(para2)) \\rangle"),
                "\\(\\vec{v}_{\\perp} = \\vec{v} - \\vec{v}_{\\parallel}\\)",
                sol("\\vec{v}_{\\perp}", "\\langle $(tex(perp1)), $(tex(perp2)) \\rangle")
            ),
            time=180
        )
        
    else # :cross_product_magnitude
        # Given magnitude of cross product, find parameter
        a = nonzero(-6, 6)
        b = randint(-6, 6)
        c = nonzero(-6, 6)
        
        # Vector <a, b, c> × <2, k, 1> has given magnitude
        target_mag_sq = randint(100, 400)
        
        # |<a,b,c> × <2,k,1>|² = (b-ck)² + (2c-a)² + (ak-2b)²
        # This is quadratic in k
        
        k_val = randint(-8, 8)
        cross_i = b - c*k_val
        cross_j = 2*c - a
        cross_k = a*k_val - 2*b
        
        actual_mag_sq = cross_i^2 + cross_j^2 + cross_k^2
        
        problem(
            question="Find the magnitude of \\(\\vec{u} \\times \\vec{v}\\) where \\(\\vec{u} = \\langle $(a), $(b), $(c) \\rangle\\) and \\(\\vec{v} = \\langle 2, $(k_val), 1 \\rangle\\). Round to 2 decimal places.",
            answer=round(sqrt(actual_mag_sq), digits=2),
            difficulty=(1850, 2050),
            solution=steps(
                "Compute \\(\\vec{u} \\times \\vec{v}\\) using determinant formula",
                sol("\\vec{u} \\times \\vec{v}", "\\langle $(cross_i), $(cross_j), $(cross_k) \\rangle"),
                sol("\\|\\vec{u} \\times \\vec{v}\\|", "\\sqrt{$(actual_mag_sq)} = $(round(sqrt(actual_mag_sq), digits=2))"),
                sol("Answer", round(sqrt(actual_mag_sq), digits=2))
            ),
            time=150,
            calculator="scientific"
        )
    end
end