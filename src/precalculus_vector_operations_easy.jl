# precalculus - vector_operations (easy)
# Generated: 2026-03-08T20:34:44.654156

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = choice([:magnitude, :addition, :scalar_mult, :dot_product, :component])
    
    if problem_type == :magnitude
        # Vector magnitude calculation
        x = randint(-12, 12)
        y = randint(-12, 12)
        z = rand() < 0.5 ? 0 : randint(-12, 12)
        
        if z == 0
            mag_sq = x^2 + y^2
            mag = sqrt(mag_sq)
            vec_str = "\\langle $x, $y \\rangle"
            calc_str = "\\sqrt{($x)^2 + ($y)^2} = \\sqrt{$mag_sq}"
        else
            mag_sq = x^2 + y^2 + z^2
            mag = sqrt(mag_sq)
            vec_str = "\\langle $x, $y, $z \\rangle"
            calc_str = "\\sqrt{($x)^2 + ($y)^2 + ($z)^2} = \\sqrt{$mag_sq}"
        end
        
        problem(
            question="Find the magnitude of the vector \$\\mathbf{v} = $vec_str\$.",
            answer=mag,
            difficulty=(700, 900),
            solution=steps(
                "Given: \$\\mathbf{v} = $vec_str\$",
                "Use the magnitude formula: \$\\|\\mathbf{v}\\| = $calc_str\$",
                sol("Answer", mag)
            ),
            time=60
        )
        
    elseif problem_type == :addition
        # Vector addition
        x1, y1 = randint(-10, 10), randint(-10, 10)
        x2, y2 = randint(-10, 10), randint(-10, 10)
        
        use_3d = rand() < 0.3
        if use_3d
            z1, z2 = randint(-10, 10), randint(-10, 10)
            vec1 = "\\langle $x1, $y1, $z1 \\rangle"
            vec2 = "\\langle $x2, $y2, $z2 \\rangle"
            result_x, result_y, result_z = x1 + x2, y1 + y2, z1 + z2
            ans = "\\langle $result_x, $result_y, $result_z \\rangle"
            calc = "\\langle $(x1) + $(x2), $(y1) + $(y2), $(z1) + $(z2) \\rangle"
        else
            vec1 = "\\langle $x1, $y1 \\rangle"
            vec2 = "\\langle $x2, $y2 \\rangle"
            result_x, result_y = x1 + x2, y1 + y2
            ans = "\\langle $result_x, $result_y \\rangle"
            calc = "\\langle $(x1) + $(x2), $(y1) + $(y2) \\rangle"
        end
        
        problem(
            question="Find \$\\mathbf{u} + \\mathbf{v}\$ where \$\\mathbf{u} = $vec1\$ and \$\\mathbf{v} = $vec2\$.",
            answer=ans,
            difficulty=(700, 850),
            answer_type="vector",
            solution=steps(
                "Given: \$\\mathbf{u} = $vec1\$ and \$\\mathbf{v} = $vec2\$",
                "Add corresponding components: \$\\mathbf{u} + \\mathbf{v} = $calc\$",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == :scalar_mult
        # Scalar multiplication
        k = nonzero(-8, 8)
        x, y = randint(-10, 10), randint(-10, 10)
        
        use_3d = rand() < 0.3
        if use_3d
            z = randint(-10, 10)
            vec = "\\langle $x, $y, $z \\rangle"
            result_x, result_y, result_z = k*x, k*y, k*z
            ans = "\\langle $result_x, $result_y, $result_z \\rangle"
            calc = "\\langle $(k) \\cdot $(x), $(k) \\cdot $(y), $(k) \\cdot $(z) \\rangle"
        else
            vec = "\\langle $x, $y \\rangle"
            result_x, result_y = k*x, k*y
            ans = "\\langle $result_x, $result_y \\rangle"
            calc = "\\langle $(k) \\cdot $(x), $(k) \\cdot $(y) \\rangle"
        end
        
        problem(
            question="Find \$$k \\mathbf{v}\$ where \$\\mathbf{v} = $vec\$.",
            answer=ans,
            difficulty=(700, 850),
            answer_type="vector",
            solution=steps(
                "Given: \$\\mathbf{v} = $vec\$ and scalar \$k = $k\$",
                "Multiply each component by $k: \$$k \\mathbf{v} = $calc\$",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == :dot_product
        # Dot product
        x1, y1 = randint(-10, 10), randint(-10, 10)
        x2, y2 = randint(-10, 10), randint(-10, 10)
        
        use_3d = rand() < 0.4
        if use_3d
            z1, z2 = randint(-10, 10), randint(-10, 10)
            vec1 = "\\langle $x1, $y1, $z1 \\rangle"
            vec2 = "\\langle $x2, $y2, $z2 \\rangle"
            ans = x1*x2 + y1*y2 + z1*z2
            calc = "($x1)($x2) + ($y1)($y2) + ($z1)($z2) = $(x1*x2) + $(y1*y2) + $(z1*z2)"
        else
            vec1 = "\\langle $x1, $y1 \\rangle"
            vec2 = "\\langle $x2, $y2 \\rangle"
            ans = x1*x2 + y1*y2
            calc = "($x1)($x2) + ($y1)($y2) = $(x1*x2) + $(y1*y2)"
        end
        
        problem(
            question="Find the dot product \$\\mathbf{u} \\cdot \\mathbf{v}\$ where \$\\mathbf{u} = $vec1\$ and \$\\mathbf{v} = $vec2\$.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Given: \$\\mathbf{u} = $vec1\$ and \$\\mathbf{v} = $vec2\$",
                "Compute dot product: \$\\mathbf{u} \\cdot \\mathbf{v} = $calc\$",
                sol("Answer", ans)
            ),
            time=75
        )
        
    else  # component
        # Find a component given magnitude and another component
        mag = randint(5, 20)
        x = randint(-mag+1, mag-1)
        y_sq = mag^2 - x^2
        y_pos = sqrt(y_sq)
        y = choice([y_pos, -y_pos])
        
        problem(
            question="A vector \$\\mathbf{v} = \\langle $x, y \\rangle\$ has magnitude $mag. Find the value of \$y\$ (give the positive value if two solutions exist).",
            answer=abs(y),
            difficulty=(900, 1100),
            solution=steps(
                "Given: \$\\|\\mathbf{v}\\| = $mag\$ and \$\\mathbf{v} = \\langle $x, y \\rangle\$",
                "Use magnitude formula: \$\\sqrt{($x)^2 + y^2} = $mag\$",
                "Square both sides: \$$(x^2) + y^2 = $(mag^2)\$",
                "Solve for \$y^2\$: \$y^2 = $(mag^2) - $(x^2) = $y_sq\$",
                sol("Answer", abs(y))
            ),
            time=90
        )
    end
end