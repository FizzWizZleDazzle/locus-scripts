# precalculus - vector_operations (very_easy)
# Generated: 2026-03-08T20:34:52.614172

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = choice([
        :vector_addition_2d,
        :vector_subtraction_2d,
        :scalar_multiplication,
        :magnitude_2d,
        :unit_vector,
        :dot_product_2d,
        :vector_addition_3d,
        :magnitude_3d,
        :component_form,
        :parallel_check
    ])
    
    if problem_type == :vector_addition_2d
        # Simple 2D vector addition (ELO 300-500)
        v1x, v1y = randint(-8, 8), randint(-8, 8)
        v2x, v2y = randint(-8, 8), randint(-8, 8)
        ans_x = v1x + v2x
        ans_y = v1y + v2y
        
        problem(
            question="Find the sum of vectors \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\).",
            answer=fmt_tuple([ans_x, ans_y]),
            difficulty=(300, 500),
            answer_type="tuple",
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\)",
                "Add corresponding components: \\(\\vec{v} + \\vec{w} = \\langle $(v1x) + $(v2x), $(v1y) + $(v2y) \\rangle\\)",
                "Answer: \\(\\langle $(ans_x), $(ans_y) \\rangle\\)"
            ),
            time=45
        )
        
    elseif problem_type == :vector_subtraction_2d
        # Simple 2D vector subtraction (ELO 350-550)
        v1x, v1y = randint(-10, 10), randint(-10, 10)
        v2x, v2y = randint(-10, 10), randint(-10, 10)
        ans_x = v1x - v2x
        ans_y = v1y - v2y
        
        problem(
            question="Find \\(\\vec{v} - \\vec{w}\\) where \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\).",
            answer=fmt_tuple([ans_x, ans_y]),
            difficulty=(350, 550),
            answer_type="tuple",
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\)",
                "Subtract corresponding components: \\(\\vec{v} - \\vec{w} = \\langle $(v1x) - $(v2x), $(v1y) - $(v2y) \\rangle\\)",
                "Answer: \\(\\langle $(ans_x), $(ans_y) \\rangle\\)"
            ),
            time=45
        )
        
    elseif problem_type == :scalar_multiplication
        # Scalar multiplication (ELO 250-450)
        k = nonzero(-6, 6)
        vx, vy = randint(-8, 8), randint(-8, 8)
        ans_x = k * vx
        ans_y = k * vy
        
        problem(
            question="Find \\($(k)\\vec{v}\\) where \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\).",
            answer=fmt_tuple([ans_x, ans_y]),
            difficulty=(250, 450),
            answer_type="tuple",
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\) and scalar \\(k = $(k)\\)",
                "Multiply each component by $(k): \\($(k)\\vec{v} = \\langle $(k) \\cdot $(vx), $(k) \\cdot $(vy) \\rangle\\)",
                "Answer: \\(\\langle $(ans_x), $(ans_y) \\rangle\\)"
            ),
            time=40
        )
        
    elseif problem_type == :magnitude_2d
        # Magnitude of 2D vector (ELO 400-600)
        vx, vy = randint(-12, 12), randint(-12, 12)
        mag_sq = vx^2 + vy^2
        ans = sqrt(mag_sq)
        
        problem(
            question="Find the magnitude of \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\).",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\)",
                "Use the formula \\(\\|\\vec{v}\\| = \\sqrt{$(vx)^2 + $(vy)^2} = \\sqrt{$(vx^2) + $(vy^2)} = \\sqrt{$(mag_sq)}\\)",
                "Answer: \\($(ans)\\)"
            ),
            time=60
        )
        
    elseif problem_type == :unit_vector
        # Find unit vector (ELO 550-700)
        vx, vy = nonzero(-8, 8), nonzero(-8, 8)
        mag = sqrt(vx^2 + vy^2)
        ans_x = vx / mag
        ans_y = vy / mag
        
        problem(
            question="Find the unit vector in the direction of \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\). Give your answer as a tuple with decimal components rounded to three decimal places.",
            answer=fmt_tuple([round(ans_x, digits=3), round(ans_y, digits=3)]),
            difficulty=(550, 700),
            answer_type="tuple",
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\)",
                "Find magnitude: \\(\\|\\vec{v}\\| = \\sqrt{$(vx)^2 + $(vy)^2} = \\sqrt{$(vx^2 + vy^2)} \\approx $(round(mag, digits=3))\\)",
                "Unit vector: \\(\\hat{v} = \\frac{1}{\\|\\vec{v}\\|}\\vec{v} = \\langle $(round(ans_x, digits=3)), $(round(ans_y, digits=3)) \\rangle\\)"
            ),
            time=90,
            calculator="scientific"
        )
        
    elseif problem_type == :dot_product_2d
        # Dot product (ELO 450-650)
        v1x, v1y = randint(-10, 10), randint(-10, 10)
        v2x, v2y = randint(-10, 10), randint(-10, 10)
        ans = v1x * v2x + v1y * v2y
        
        problem(
            question="Calculate the dot product \\(\\vec{v} \\cdot \\vec{w}\\) where \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\).",
            answer=ans,
            difficulty=(450, 650),
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(v1x), $(v1y) \\rangle\\) and \\(\\vec{w} = \\langle $(v2x), $(v2y) \\rangle\\)",
                "Use dot product formula: \\(\\vec{v} \\cdot \\vec{w} = ($(v1x))($(v2x)) + ($(v1y))($(v2y))\\)",
                "Calculate: \\($(v1x * v2x) + $(v1y * v2y) = $(ans)\\)"
            ),
            time=60
        )
        
    elseif problem_type == :vector_addition_3d
        # 3D vector addition (ELO 400-600)
        v1x, v1y, v1z = randint(-12, 12), randint(-12, 12), randint(-12, 12)
        v2x, v2y, v2z = randint(-12, 12), randint(-12, 12), randint(-12, 12)
        ans_x = v1x + v2x
        ans_y = v1y + v2y
        ans_z = v1z + v2z
        
        problem(
            question="Find \\(\\vec{a} + \\vec{b}\\) where \\(\\vec{a} = \\langle $(v1x), $(v1y), $(v1z) \\rangle\\) and \\(\\vec{b} = \\langle $(v2x), $(v2y), $(v2z) \\rangle\\).",
            answer=fmt_tuple([ans_x, ans_y, ans_z]),
            difficulty=(400, 600),
            answer_type="tuple",
            solution=steps(
                "Given: \\(\\vec{a} = \\langle $(v1x), $(v1y), $(v1z) \\rangle\\) and \\(\\vec{b} = \\langle $(v2x), $(v2y), $(v2z) \\rangle\\)",
                "Add corresponding components: \\(\\vec{a} + \\vec{b} = \\langle $(v1x) + $(v2x), $(v1y) + $(v2y), $(v1z) + $(v2z) \\rangle\\)",
                "Answer: \\(\\langle $(ans_x), $(ans_y), $(ans_z) \\rangle\\)"
            ),
            time=60
        )
        
    elseif problem_type == :magnitude_3d
        # Magnitude of 3D vector (ELO 500-650)
        vx, vy, vz = randint(-10, 10), randint(-10, 10), randint(-10, 10)
        mag_sq = vx^2 + vy^2 + vz^2
        ans = sqrt(mag_sq)
        
        problem(
            question="Find the magnitude of \\(\\vec{v} = \\langle $(vx), $(vy), $(vz) \\rangle\\).",
            answer=ans,
            difficulty=(500, 650),
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(vx), $(vy), $(vz) \\rangle\\)",
                "Use the formula \\(\\|\\vec{v}\\| = \\sqrt{$(vx)^2 + $(vy)^2 + $(vz)^2} = \\sqrt{$(vx^2) + $(vy^2) + $(vz^2)}\\)",
                "Answer: \\(\\sqrt{$(mag_sq)} = $(ans)\\)"
            ),
            time=75
        )
        
    elseif problem_type == :component_form
        # Convert from initial and terminal points (ELO 350-550)
        p1x, p1y = randint(-15, 15), randint(-15, 15)
        p2x, p2y = randint(-15, 15), randint(-15, 15)
        ans_x = p2x - p1x
        ans_y = p2y - p1y
        
        problem(
            question="Find the component form of the vector with initial point \\(P_1 = ($(p1x), $(p1y))\\) and terminal point \\(P_2 = ($(p2x), $(p2y))\\).",
            answer=fmt_tuple([ans_x, ans_y]),
            difficulty=(350, 550),
            answer_type="tuple",
            solution=steps(
                "Given: Initial point \\(P_1 = ($(p1x), $(p1y))\\) and terminal point \\(P_2 = ($(p2x), $(p2y))\\)",
                "Component form: \\(\\vec{v} = \\langle x_2 - x_1, y_2 - y_1 \\rangle = \\langle $(p2x) - $(p1x), $(p2y) - $(p1y) \\rangle\\)",
                "Answer: \\(\\langle $(ans_x), $(ans_y) \\rangle\\)"
            ),
            time=50
        )
        
    else  # :parallel_check
        # Check if vectors are parallel (ELO 600-700)
        k = nonzero(-5, 5)
        vx, vy = nonzero(-8, 8), nonzero(-8, 8)
        parallel = choice([true, false])
        
        if parallel
            wx, wy = k * vx, k * vy
            ans = "yes"
        else
            wx = k * vx + nonzero(-3, 3)
            wy = k * vy + nonzero(-3, 3)
            ans = "no"
        end
        
        problem(
            question="Are the vectors \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\) and \\(\\vec{w} = \\langle $(wx), $(wy) \\rangle\\) parallel? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(600, 700),
            answer_type="text",
            solution=steps(
                "Given: \\(\\vec{v} = \\langle $(vx), $(vy) \\rangle\\) and \\(\\vec{w} = \\langle $(wx), $(wy) \\rangle\\)",
                "Two vectors are parallel if one is a scalar multiple of the other. Check if \\(\\frac{$(wx)}{$(vx)} = \\frac{$(wy)}{$(vy)}\\)",
                parallel ? "Since \\(\\frac{$(wx)}{$(vx)} = $(k)\\) and \\(\\frac{$(wy)}{$(vy)} = $(k)\\), the vectors are parallel." : "The ratios are not equal, so the vectors are not parallel."
            ),
            time=90
        )
    end
end