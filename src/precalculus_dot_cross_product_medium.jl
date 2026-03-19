# precalculus - dot_cross_product (medium)
# Generated: 2026-03-08T20:35:57.781909

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/dot_cross_product")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Dot product computation (1200-1400)
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        
        dot_prod = a1*b1 + a2*b2 + a3*b3
        
        problem(
            question="Compute the dot product of \\(\\mathbf{a} = \\langle $a1, $a2, $a3 \\rangle\\) and \\(\\mathbf{b} = \\langle $b1, $b2, $b3 \\rangle\\).",
            answer=dot_prod,
            difficulty=(1200, 1400),
            solution=steps(
                "\\(\\mathbf{a} \\cdot \\mathbf{b} = a_1 b_1 + a_2 b_2 + a_3 b_3\\)",
                "\\(= ($a1)($b1) + ($a2)($b2) + ($a3)($b3)\\)",
                "\\(= $(a1*b1) + $(a2*b2) + $(a3*b3)\\)",
                sol("Answer", dot_prod)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Cross product computation (1300-1500)
        a1, a2, a3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        b1, b2, b3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        
        c1 = a2*b3 - a3*b2
        c2 = a3*b1 - a1*b3
        c3 = a1*b2 - a2*b1
        
        ans = fmt_tuple([c1, c2, c3])
        
        problem(
            question="Compute the cross product \\(\\mathbf{a} \\times \\mathbf{b}\\) where \\(\\mathbf{a} = \\langle $a1, $a2, $a3 \\rangle\\) and \\(\\mathbf{b} = \\langle $b1, $b2, $b3 \\rangle\\).",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="tuple",
            solution=steps(
                "\\(\\mathbf{a} \\times \\mathbf{b} = \\langle a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1 \\rangle\\)",
                "First component: \\(($a2)($b3) - ($a3)($b2) = $c1\\)",
                "Second component: \\(($a3)($b1) - ($a1)($b3) = $c2\\)",
                "Third component: \\(($a1)($b2) - ($a2)($b1) = $c3\\)",
                sol("Answer", "\\(\\langle $c1, $c2, $c3 \\rangle\\)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Angle between vectors using dot product (1400-1600)
        a1, a2 = randint(-5, 5), randint(-5, 5)
        b1, b2 = randint(-5, 5), randint(-5, 5)
        
        # Ensure non-zero vectors
        while a1^2 + a2^2 == 0
            a1, a2 = randint(-5, 5), randint(-5, 5)
        end
        while b1^2 + b2^2 == 0
            b1, b2 = randint(-5, 5), randint(-5, 5)
        end
        
        dot_prod = a1*b1 + a2*b2
        mag_a = sqrt(a1^2 + a2^2)
        mag_b = sqrt(b1^2 + b2^2)
        cos_theta = dot_prod / (mag_a * mag_b)
        
        # Clamp to avoid numerical issues
        cos_theta = max(-1, min(1, cos_theta))
        theta_rad = acos(cos_theta)
        theta_deg = round(theta_rad * 180 / π, digits=2)
        
        problem(
            question="Find the angle (in degrees) between vectors \\(\\mathbf{a} = \\langle $a1, $a2 \\rangle\\) and \\(\\mathbf{b} = \\langle $b1, $b2 \\rangle\\). Round to two decimal places.",
            answer=theta_deg,
            difficulty=(1400, 1600),
            calculator="scientific",
            solution=steps(
                "\\(\\cos \\theta = \\frac{\\mathbf{a} \\cdot \\mathbf{b}}{\\|\\mathbf{a}\\| \\|\\mathbf{b}\\|}\\)",
                "\\(\\mathbf{a} \\cdot \\mathbf{b} = $(a1*b1) + $(a2*b2) = $dot_prod\\)",
                "\\(\\|\\mathbf{a}\\| = \\sqrt{$(a1^2) + $(a2^2)} = $(round(mag_a, digits=3))\\)",
                "\\(\\|\\mathbf{b}\\| = \\sqrt{$(b1^2) + $(b2^2)} = $(round(mag_b, digits=3))\\)",
                "\\(\\cos \\theta = $(round(cos_theta, digits=4))\\)",
                "\\(\\theta = \\arccos($(round(cos_theta, digits=4))) \\approx $(theta_deg)^\\circ\\)"
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Orthogonal vectors check (1200-1400)
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        # Create b perpendicular to a
        b1 = randint(-8, 8)
        b2 = randint(-8, 8)
        b3 = -(a1*b1 + a2*b2) // a3
        
        if rand() < 0.5
            # Make them orthogonal
            dot_prod = 0
            answer = "yes"
        else
            # Add random component to make non-orthogonal
            b3 += nonzero(-5, 5)
            dot_prod = a1*b1 + a2*b2 + a3*b3
            answer = "no"
        end
        
        problem(
            question="Are the vectors \\(\\mathbf{a} = \\langle $a1, $a2, $a3 \\rangle\\) and \\(\\mathbf{b} = \\langle $b1, $b2, $b3 \\rangle\\) orthogonal? Answer 'yes' or 'no'.",
            answer=answer,
            difficulty=(1200, 1400),
            answer_type="text",
            solution=steps(
                "Two vectors are orthogonal if their dot product is zero",
                "\\(\\mathbf{a} \\cdot \\mathbf{b} = ($a1)($b1) + ($a2)($b2) + ($a3)($b3)\\)",
                "\\(= $(a1*b1) + $(a2*b2) + $(a3*b3) = $dot_prod\\)",
                dot_prod == 0 ? "Since the dot product is 0, the vectors are orthogonal" : "Since the dot product is not 0, the vectors are not orthogonal",
                sol("Answer", answer)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Area of parallelogram using cross product (1500-1700)
        a1, a2, a3 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        b1, b2, b3 = randint(-5, 5), randint(-5, 5), randint(-5, 5)
        
        c1 = a2*b3 - a3*b2
        c2 = a3*b1 - a1*b3
        c3 = a1*b2 - a2*b1
        
        area = sqrt(c1^2 + c2^2 + c3^2)
        area_rounded = round(area, digits=2)
        
        problem(
            question="Find the area of the parallelogram determined by vectors \\(\\mathbf{a} = \\langle $a1, $a2, $a3 \\rangle\\) and \\(\\mathbf{b} = \\langle $b1, $b2, $b3 \\rangle\\). Round to two decimal places.",
            answer=area_rounded,
            difficulty=(1500, 1700),
            calculator="scientific",
            solution=steps(
                "Area = \\(\\|\\mathbf{a} \\times \\mathbf{b}\\|\\)",
                "\\(\\mathbf{a} \\times \\mathbf{b} = \\langle $c1, $c2, $c3 \\rangle\\)",
                "\\(\\|\\mathbf{a} \\times \\mathbf{b}\\| = \\sqrt{$(c1)^2 + $(c2)^2 + $(c3)^2}\\)",
                "\\(= \\sqrt{$(c1^2) + $(c2^2) + $(c3^2)} = \\sqrt{$(c1^2 + c2^2 + c3^2)}\\)",
                sol("Answer", area_rounded)
            ),
            time=150
        )
        
    else
        # Projection of vector onto another (1500-1800)
        a1, a2 = randint(-8, 8), randint(-8, 8)
        b1, b2 = nonzero(-8, 8), nonzero(-8, 8)
        
        # Ensure non-zero vectors
        while a1^2 + a2^2 == 0
            a1, a2 = randint(-8, 8), randint(-8, 8)
        end
        
        dot_ab = a1*b1 + a2*b2
        dot_bb = b1^2 + b2^2
        
        proj_scalar = dot_ab // dot_bb
        proj1 = proj_scalar * b1
        proj2 = proj_scalar * b2
        
        # Simplify for cleaner answer
        proj1_simplified = simplify(proj1)
        proj2_simplified = simplify(proj2)
        
        ans = fmt_tuple([proj1_simplified, proj2_simplified])
        
        problem(
            question="Find the projection of vector \\(\\mathbf{a} = \\langle $a1, $a2 \\rangle\\) onto vector \\(\\mathbf{b} = \\langle $b1, $b2 \\rangle\\). Express as an ordered pair.",
            answer=ans,
            difficulty=(1500, 1800),
            answer_type="tuple",
            solution=steps(
                "\\(\\text{proj}_{\\mathbf{b}} \\mathbf{a} = \\frac{\\mathbf{a} \\cdot \\mathbf{b}}{\\mathbf{b} \\cdot \\mathbf{b}} \\mathbf{b}\\)",
                "\\(\\mathbf{a} \\cdot \\mathbf{b} = $(a1*b1) + $(a2*b2) = $dot_ab\\)",
                "\\(\\mathbf{b} \\cdot \\mathbf{b} = $(b1^2) + $(b2^2) = $dot_bb\\)",
                "\\(\\text{proj}_{\\mathbf{b}} \\mathbf{a} = \\frac{$dot_ab}{$dot_bb} \\langle $b1, $b2 \\rangle\\)",
                "\\(= \\langle $(tex(proj1_simplified)), $(tex(proj2_simplified)) \\rangle\\)"
            ),
            time=180
        )
    end
end