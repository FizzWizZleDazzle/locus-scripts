# geometry - right_triangle_trig (competition)
# Generated: 2026-03-08T20:13:33.630054

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/right_triangle_trig")
    
    # Olympiad/Research-level right triangle trigonometry problem
    # We'll create a problem involving a complex configuration with multiple right triangles
    
    # Generate a configuration: Triangle ABC with altitude from C to AB at D
    # This creates two right triangles ACD and BCD
    # We'll ask for a sophisticated relationship involving trigonometric identities
    
    # Pick clean angles that lead to interesting relationships
    angle_A_deg = choice([15, 18, 22, 24, 27, 36])
    angle_B_deg = choice([15, 18, 22, 24, 27, 36])
    
    # Ensure angles work (sum < 90 for acute triangle)
    while angle_A_deg + angle_B_deg >= 90
        angle_B_deg = choice([15, 18, 22, 24, 27, 36])
    end
    
    angle_C_deg = 180 - angle_A_deg - angle_B_deg
    
    # For the diagram, place triangle with specific dimensions
    # Let AB = base, scale = 200 for good visibility
    base_length = 240
    
    # Use law of sines relationship
    # Place A at origin, B at (base_length, 0)
    # Calculate C position using angles
    
    # Height can be derived from the configuration
    # Using angle at A: height = AD * tan(angle_A)
    # Using angle at B: height = BD * tan(angle_B)
    # AD + BD = base_length
    
    # Solve for AD: AD * tan(angle_A) = (base_length - AD) * tan(angle_B)
    tan_A = tan(deg2rad(angle_A_deg))
    tan_B = tan(deg2rad(angle_B_deg))
    
    AD = base_length * tan_B / (tan_A + tan_B)
    height = AD * tan_A
    
    d = DiagramObj(300, 280)
    
    # Draw the triangle
    point_A = (30, 240)
    point_B = (270, 240)
    point_C = (30 + AD, 240 - height)
    point_D = (30 + AD, 240)
    
    # Draw triangle ABC
    polygon!(d, [point_A, point_B, point_C], stroke="black", fill="none", stroke_width=2)
    
    # Draw altitude CD
    line!(d, point_C, point_D, stroke="blue", stroke_width=2, stroke_dasharray="5,5")
    
    # Mark right angle at D
    right_angle!(d, point_A, point_D, point_C, size=12, stroke="blue")
    
    # Label points
    text!(d, "A", point_A[1] - 15, point_A[2] + 5, font_size=16)
    text!(d, "B", point_B[1] + 10, point_B[2] + 5, font_size=16)
    text!(d, "C", point_C[1], point_C[2] - 15, font_size=16)
    text!(d, "D", point_D[1], point_D[2] + 20, font_size=16)
    
    # Mark the points
    point!(d, point_A[1], point_A[2], radius=3, fill="black")
    point!(d, point_B[1], point_B[2], radius=3, fill="black")
    point!(d, point_C[1], point_C[2], radius=3, fill="black")
    point!(d, point_D[1], point_D[2], radius=3, fill="black")
    
    # Label angles
    angle_arc!(d, point_B, point_A, point_C, radius=25, stroke="red")
    text!(d, "α", point_A[1] + 20, point_A[2] - 8, font_size=14, fill="red")
    
    angle_arc!(d, point_C, point_B, point_A, radius=25, stroke="red")
    text!(d, "β", point_B[1] - 25, point_B[2] - 8, font_size=14, fill="red")
    
    # Label the altitude
    segment_label!(d, point_C, point_D, "h", offset=10, font_size=14, fill="blue")
    
    # Label base segments
    segment_label!(d, point_A, point_D, "x", offset=-15, font_size=14)
    segment_label!(d, point_D, point_B, "y", offset=-15, font_size=14)
    
    # Create the challenging problem
    # Given: α and β, find relationship involving h, x, y
    # Use the identity: 1/x + 1/y = 1/h * (tan(α) + tan(β)) / (tan(α) * tan(β))
    # This simplifies to: h = xy/(x+y) * (tan(α) + tan(β))
    
    # For Olympiad level, ask them to prove an identity
    # tan(α) + tan(β) = h(x + y)/(xy)
    
    alpha_sym = "\\alpha"
    beta_sym = "\\beta"
    
    # The answer involves proving the relationship
    # tan(α) * tan(β) = h²/(xy)
    
    question_text = "In triangle ABC, altitude CD is drawn from C to side AB at point D, " *
                   "forming right triangles ACD and BCD. Let ∠CAD = $(alpha_sym) = $(angle_A_deg)°, " *
                   "∠CBD = $(beta_sym) = $(angle_B_deg)°, AD = x, BD = y, and CD = h. " *
                   "Prove that \\tan($(alpha_sym)) \\cdot \\tan($(beta_sym)) = \\frac{h^2}{xy}, " *
                   "and find the numerical value of this product for the given angles."
    
    # Calculate numerical answer
    tan_product = tan_A * tan_B
    answer_value = round(tan_product, digits=6)
    
    solution_text = steps(
        "From right triangle ACD: \\tan($(alpha_sym)) = \\frac{h}{x}",
        "From right triangle BCD: \\tan($(beta_sym)) = \\frac{h}{y}",
        "Multiply the two equations:",
        sol("\\tan($(alpha_sym)) \\cdot \\tan($(beta_sym)) = \\frac{h}{x} \\cdot \\frac{h}{y} = \\frac{h^2}{xy}"),
        "This proves the required identity.",
        "For $(alpha_sym) = $(angle_A_deg)° and $(beta_sym) = $(angle_B_deg)°:",
        "\\tan($(angle_A_deg)°) \\approx $(round(tan_A, digits=6))",
        "\\tan($(angle_B_deg)°) \\approx $(round(tan_B, digits=6))",
        sol("Product", answer_value)
    )
    
    problem(
        question=question_text,
        answer=answer_value,
        difficulty=(3500, 4200),
        solution=solution_text,
        image=render(d),
        time=420,
        calculator="scientific"
    )
end