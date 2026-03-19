# precalculus - dot_cross_product (very_hard)
# Generated: 2026-03-08T20:36:25.788998

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/dot_cross_product")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Competition: Prove vector identity involving dot and cross products
        # e.g., show that a·(b×c) = b·(c×a) = c·(a×b) (scalar triple product cyclic property)
        
        identity_type = choice(1:3)
        
        if identity_type == 1
            # Scalar triple product cyclic identity
            question = "Let \\mathbf{a}, \\mathbf{b}, \\mathbf{c} be vectors in \\mathbb{R}^3. Prove that \\mathbf{a} \\cdot (\\mathbf{b} \\times \\mathbf{c}) = \\mathbf{b} \\cdot (\\mathbf{c} \\times \\mathbf{a}) = \\mathbf{c} \\cdot (\\mathbf{a} \\times \\mathbf{b})."
            
            answer = "proven"
            
            solution = steps(
                "Let \\mathbf{a} = (a_1, a_2, a_3), \\mathbf{b} = (b_1, b_2, b_3), \\mathbf{c} = (c_1, c_2, c_3)",
                "Compute \\mathbf{b} \\times \\mathbf{c} = (b_2c_3 - b_3c_2, b_3c_1 - b_1c_3, b_1c_2 - b_2c_1)",
                "Then \\mathbf{a} \\cdot (\\mathbf{b} \\times \\mathbf{c}) = a_1(b_2c_3 - b_3c_2) + a_2(b_3c_1 - b_1c_3) + a_3(b_1c_2 - b_2c_1)",
                "This equals the determinant: \\begin{vmatrix} a_1 & a_2 & a_3 \\\\ b_1 & b_2 & b_3 \\\\ c_1 & c_2 & c_3 \\end{vmatrix}",
                "Cyclic permutation of rows preserves determinant value (up to sign changes that cancel)",
                "Therefore \\mathbf{a} \\cdot (\\mathbf{b} \\times \\mathbf{c}) = \\mathbf{b} \\cdot (\\mathbf{c} \\times \\mathbf{a}) = \\mathbf{c} \\cdot (\\mathbf{a} \\times \\mathbf{b})"
            )
            
            diff = (2600, 3000)
            time_val = 240
            
        elseif identity_type == 2
            # Lagrange identity: |a×b|² = |a|²|b|² - (a·b)²
            question = "Prove Lagrange's identity: For vectors \\mathbf{a}, \\mathbf{b} in \\mathbb{R}^3, prove that \\|\\mathbf{a} \\times \\mathbf{b}\\|^2 = \\|\\mathbf{a}\\|^2 \\|\\mathbf{b}\\|^2 - (\\mathbf{a} \\cdot \\mathbf{b})^2."
            
            answer = "proven"
            
            solution = steps(
                "Let \\mathbf{a} = (a_1, a_2, a_3) and \\mathbf{b} = (b_1, b_2, b_3)",
                "LHS: \\|\\mathbf{a} \\times \\mathbf{b}\\|^2 = (a_2b_3 - a_3b_2)^2 + (a_3b_1 - a_1b_3)^2 + (a_1b_2 - a_2b_1)^2",
                "RHS: \\|\\mathbf{a}\\|^2 \\|\\mathbf{b}\\|^2 - (\\mathbf{a} \\cdot \\mathbf{b})^2 = (a_1^2 + a_2^2 + a_3^2)(b_1^2 + b_2^2 + b_3^2) - (a_1b_1 + a_2b_2 + a_3b_3)^2",
                "Expand RHS: a_1^2b_2^2 + a_1^2b_3^2 + a_2^2b_1^2 + a_2^2b_3^2 + a_3^2b_1^2 + a_3^2b_2^2 - 2a_1a_2b_1b_2 - 2a_1a_3b_1b_3 - 2a_2a_3b_2b_3",
                "Expand LHS and verify all terms match, proving the identity"
            )
            
            diff = (2800, 3200)
            time_val = 300
            
        else
            # BAC-CAB rule: a×(b×c) = b(a·c) - c(a·b)
            question = "Prove the BAC-CAB rule: For vectors \\mathbf{a}, \\mathbf{b}, \\mathbf{c} in \\mathbb{R}^3, show that \\mathbf{a} \\times (\\mathbf{b} \\times \\mathbf{c}) = \\mathbf{b}(\\mathbf{a} \\cdot \\mathbf{c}) - \\mathbf{c}(\\mathbf{a} \\cdot \\mathbf{b})."
            
            answer = "proven"
            
            solution = steps(
                "Let \\mathbf{a} = (a_1, a_2, a_3), \\mathbf{b} = (b_1, b_2, b_3), \\mathbf{c} = (c_1, c_2, c_3)",
                "First compute \\mathbf{b} \\times \\mathbf{c} = (b_2c_3 - b_3c_2, b_3c_1 - b_1c_3, b_1c_2 - b_2c_1)",
                "Then \\mathbf{a} \\times (\\mathbf{b} \\times \\mathbf{c}) has i-component: a_2(b_1c_2 - b_2c_1) - a_3(b_3c_1 - b_1c_3)",
                "Simplify: a_2b_1c_2 - a_2b_2c_1 - a_3b_3c_1 + a_3b_1c_3 = b_1(a_2c_2 + a_3c_3) - c_1(a_2b_2 + a_3b_3)",
                "Add and subtract a_1b_1c_1: b_1(a_1c_1 + a_2c_2 + a_3c_3) - c_1(a_1b_1 + a_2b_2 + a_3b_3) = b_1(\\mathbf{a} \\cdot \\mathbf{c}) - c_1(\\mathbf{a} \\cdot \\mathbf{b})",
                "Similarly verify j and k components to complete the proof"
            )
            
            diff = (3000, 3400)
            time_val = 300
        end

        problem(
            question=question,
            answer=answer,
            difficulty=diff,
            solution=solution,
            time=time_val
        )

    elseif problem_type == 2
        # Competition: Find angle between vectors using dot product with algebraic constraints
        a1 = randint(-15, 15)
        a2 = randint(-15, 15)
        a3 = randint(-15, 15)
        
        # Create b with specific angle relationship
        k = randint(2, 5)
        b1 = k * a1 + randint(-8, 8)
        b2 = k * a2 + randint(-8, 8)
        b3 = k * a3 + randint(-8, 8)
        
        dot_prod = a1*b1 + a2*b2 + a3*b3
        norm_a = sqrt(a1^2 + a2^2 + a3^2)
        norm_b = sqrt(b1^2 + b2^2 + b3^2)
        
        cos_theta = dot_prod / (norm_a * norm_b)
        
        question = "Find the angle (in degrees, rounded to one decimal place) between vectors \\mathbf{a} = ($a1, $a2, $a3) and \\mathbf{b} = ($b1, $b2, $b3)."
        
        answer = round(acosd(cos_theta), digits=1)
        
        solution = steps(
            "Compute \\mathbf{a} \\cdot \\mathbf{b} = $(a1)($(b1)) + $(a2)($(b2)) + $(a3)($(b3)) = $dot_prod",
            "Compute \\|\\mathbf{a}\\| = \\sqrt{$(a1)^2 + $(a2)^2 + $(a3)^2} = $(round(norm_a, digits=3))",
            "Compute \\|\\mathbf{b}\\| = \\sqrt{$(b1)^2 + $(b2)^2 + $(b3)^2} = $(round(norm_b, digits=3))",
            "Use \\cos\\theta = \\frac{\\mathbf{a} \\cdot \\mathbf{b}}{\\|\\mathbf{a}\\| \\|\\mathbf{b}\\|} = $(round(cos_theta, digits=4))",
            "Therefore \\theta = \\arccos($(round(cos_theta, digits=4))) ≈ $(answer)°"
        )
        
        diff = (2400, 2700)
        time_val = 180
        calc = "scientific"

        problem(
            question=question,
            answer=answer,
            difficulty=diff,
            solution=solution,
            time=time_val,
            calculator=calc
        )

    elseif problem_type == 3
        # Olympiad: Volume of parallelepiped and geometric interpretation
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        c1, c2, c3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        
        # Compute scalar triple product
        cross_bc = (b2*c3 - b3*c2, b3*c1 - b1*c3, b1*c2 - b2*c1)
        volume = abs(a1*cross_bc[1] + a2*cross_bc[2] + a3*cross_bc[3])
        
        question = "Find the volume of the parallelepiped determined by vectors \\mathbf{a} = ($a1, $a2, $a3), \\mathbf{b} = ($b1, $b2, $b3), and \\mathbf{c} = ($c1, $c2, $c3)."
        
        answer = volume
        
        solution = steps(
            "Volume = |\\mathbf{a} \\cdot (\\mathbf{b} \\times \\mathbf{c})|",
            "Compute \\mathbf{b} \\times \\mathbf{c} = ($(cross_bc[1]), $(cross_bc[2]), $(cross_bc[3]))",
            "Compute \\mathbf{a} \\cdot (\\mathbf{b} \\times \\mathbf{c}) = $(a1)($(cross_bc[1])) + $(a2)($(cross_bc[2])) + $(a3)($(cross_bc[3]))",
            "= $(a1*cross_bc[1] + a2*cross_bc[2] + a3*cross_bc[3])",
            "Volume = |$(a1*cross_bc[1] + a2*cross_bc[2] + a3*cross_bc[3])| = $volume"
        )
        
        diff = (2700, 3100)
        time_val = 240
        calc = "none"

        problem(
            question=question,
            answer=answer,
            difficulty=diff,
            solution=solution,
            time=time_val
        )

    elseif problem_type == 4
        # Competition: Find vector perpendicular to two given vectors with constraint
        a1, a2, a3 = randint(-12, 12), randint(-12, 12), randint(-12, 12)
        b1, b2, b3 = randint(-12, 12), randint(-12, 12), randint(-12, 12)
        
        # Cross product gives perpendicular vector
        c1 = a2*b3 - a3*b2
        c2 = a3*b1 - a1*b3
        c3 = a1*b2 - a2*b1
        
        # Require specific magnitude
        target_mag = randint(10, 30)
        norm_c = sqrt(c1^2 + c2^2 + c3^2)
        
        if norm_c > 0
            scale = target_mag / norm_c
            ans1 = round(scale * c1, digits=2)
            ans2 = round(scale * c2, digits=2)
            ans3 = round(scale * c3, digits=2)
        else
            ans1, ans2, ans3 = 0, 0, 0
        end
        
        question = "Find a vector \\mathbf{v} perpendicular to both \\mathbf{a} = ($a1, $a2, $a3) and \\mathbf{b} = ($b1, $b2, $b3) with magnitude $target_mag. Express components rounded to two decimal places as an ordered triple."
        
        answer = "($ans1, $ans2, $ans3)"
        
        solution = steps(
            "A vector perpendicular to both is \\mathbf{a} \\times \\mathbf{b}",
            "Compute \\mathbf{a} \\times \\mathbf{b} = ($c1, $c2, $c3)",
            "Magnitude: \\|\\mathbf{a} \\times \\mathbf{b}\\| = $(round(norm_c, digits=3))",
            "Scale to magnitude $target_mag: multiply by $(round(scale, digits=4))",
            "Answer: ($ans1, $ans2, $ans3)"
        )
        
        diff = (2500, 2900)
        time_val = 200
        calc = "scientific"

        problem(
            question=question,
            answer=answer,
            difficulty=diff,
            answer_type="tuple",
            solution=solution,
            time=time_val,
            calculator=calc
        )

    else
        # Olympiad: Prove geometric property using vector methods
        property_type = choice(1:2)
        
        if property_type == 1
            question = "Using vector methods, prove that the diagonals of a parallelogram bisect each other. (Let the vertices be O, A, B, and C where \\vec{OA} = \\mathbf{a} and \\vec{OB} = \\mathbf{b}.)"

            answer = "proven"

            solution = steps(
                "The diagonals of a parallelogram bisect each other, which can be verified using vectors"
            )

            diff = (2800, 3200)
            time_val = 240
        else
            question = "Using vector methods, prove that the medians of a triangle are concurrent. (Let the vertices be A, B, and C with position vectors \\mathbf{a}, \\mathbf{b}, and \\mathbf{c}.)"

            answer = "proven"

            solution = steps(
                "The midpoint of BC is M = (\\mathbf{b} + \\mathbf{c})/2",
                "The median from A goes from \\mathbf{a} to M, parametrized as \\mathbf{a} + t(M - \\mathbf{a})",
                "At t = 2/3, the point is (\\mathbf{a} + \\mathbf{b} + \\mathbf{c})/3",
                "By symmetry, all three medians pass through the centroid G = (\\mathbf{a} + \\mathbf{b} + \\mathbf{c})/3"
            )

            diff = (2900, 3300)
            time_val = 240
        end

        problem(
            question=question,
            answer=answer,
            difficulty=diff,
            solution=solution,
            time=time_val
        )
    end
end
