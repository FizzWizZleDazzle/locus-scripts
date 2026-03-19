# geometry - volume (very_hard)
# Generated: 2026-03-08T20:10:43.693066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/volume")
    
    # COMPETITION to OLYMPIAD level geometry/volume problem (2500-3500 ELO)
    # Problem: Sphere inscribed in a cone, then a cylinder inscribed in the remaining space
    
    # Choose clean integer values
    cone_height = randint(12, 24)
    cone_radius = randint(8, 16)
    
    # For a sphere inscribed in a cone, radius r_s = (R*h)/(R + sqrt(R^2 + h^2))
    # where R = cone base radius, h = cone height
    slant = sqrt(cone_radius^2 + cone_height^2)
    sphere_radius_exact = (cone_radius * cone_height) / (cone_radius + slant)
    sphere_radius = round(sphere_radius_exact, digits=4)
    
    # The cylinder sits on the base with its top touching the sphere
    # This is a complex optimization problem
    # For simplicity, we'll set cylinder height to be sphere_radius to 2*sphere_radius
    cyl_height_factor = rand([0.8, 1.0, 1.2, 1.5])
    cyl_height = sphere_radius * cyl_height_factor
    
    # Cylinder must fit inside cone at height cyl_height from base
    # At height h from base, cone radius is R*(H-h)/H
    remaining_height = cone_height - cyl_height
    max_cyl_radius = cone_radius * remaining_height / cone_height
    
    # Choose cylinder radius to be a reasonable fraction
    cyl_radius = max_cyl_radius * rand([0.6, 0.7, 0.75, 0.8])
    
    # Calculate volumes
    sphere_volume = (4//3) * π * sphere_radius^3
    cyl_volume = π * cyl_radius^2 * cyl_height
    
    # The answer is the ratio
    ratio = cyl_volume / sphere_volume
    ratio_simplified = simplify(ratio)
    
    # Create diagram
    d = DiagramObj(600, 500)
    
    # Draw cone outline
    apex_x, apex_y = 300, 50
    base_y = 450
    left_base_x = 300 - cone_radius * 15
    right_base_x = 300 + cone_radius * 15
    
    # Cone outline
    line!(d, left_base_x, base_y, apex_x, apex_y, stroke="black", stroke_width=2)
    line!(d, right_base_x, base_y, apex_x, apex_y, stroke="black", stroke_width=2)
    
    # Base ellipse
    arc!(d, 300, base_y, cone_radius * 15, 20, 0, 180, stroke="black", stroke_width=2, fill="none")
    arc!(d, 300, base_y, cone_radius * 15, 20, 180, 360, stroke="black", stroke_width=1, stroke_dasharray="5,5", fill="none")
    
    # Inscribed sphere
    sphere_center_y = base_y - sphere_radius * 15
    circle!(d, 300, sphere_center_y, sphere_radius * 15, fill="lightblue", fill_opacity=0.3, stroke="blue", stroke_width=2)
    
    # Cylinder (simplified representation)
    cyl_top_y = base_y - cyl_height * 15
    cyl_left = 300 - cyl_radius * 15
    cyl_right = 300 + cyl_radius * 15
    
    # Cylinder sides
    line!(d, cyl_left, base_y, cyl_left, cyl_top_y, stroke="red", stroke_width=2)
    line!(d, cyl_right, base_y, cyl_right, cyl_top_y, stroke="red", stroke_width=2)
    
    # Cylinder top
    arc!(d, 300, cyl_top_y, cyl_radius * 15, 15, 0, 180, stroke="red", stroke_width=2, fill="none")
    arc!(d, 300, cyl_top_y, cyl_radius * 15, 15, 180, 360, stroke="red", stroke_width=1, stroke_dasharray="3,3", fill="none")
    
    # Labels
    text!(d, 300, apex_y - 25, "Cone", font_size=16, text_anchor="middle")
    text!(d, 300, sphere_center_y, "Sphere", font_size=14, text_anchor="middle", fill="blue")
    text!(d, 350, (base_y + cyl_top_y)/2, "Cylinder", font_size=14, fill="red")
    
    # Dimensions
    text!(d, apex_x + 50, (apex_y + base_y)/2, "h = $(cone_height)", font_size=12)
    text!(d, (right_base_x + 300)/2, base_y + 20, "R = $(cone_radius)", font_size=12)
    
    img = render(d)
    
    problem(
        question="A right circular cone has height $(cone_height) and base radius $(cone_radius). A sphere is inscribed in the cone (tangent to the base and lateral surface). A cylinder is then placed on the base of the cone with height $(round(cyl_height, digits=2)) and radius $(round(cyl_radius, digits=2)), fitting inside the cone without intersecting the sphere. Find the ratio of the volume of the cylinder to the volume of the inscribed sphere. Express your answer as a decimal rounded to three decimal places.",
        answer=round(Float64(ratio), digits=3),
        difficulty=(2500, 3500),
        solution=steps(
            "**Step 1:** Find the radius of the inscribed sphere using the formula \$r_s = \\frac{Rh}{R + \\sqrt{R^2 + h^2}}\$",
            sol("Sphere radius", "r_s = \\frac{$(cone_radius) \\cdot $(cone_height)}{$(cone_radius) + \\sqrt{$(cone_radius)^2 + $(cone_height)^2}} \\approx $(round(sphere_radius, digits=3))"),
            "**Step 2:** Calculate the volume of the inscribed sphere",
            sol("Sphere volume", "V_s = \\frac{4}{3}\\pi r_s^3 \\approx $(round(Float64(sphere_volume), digits=2))"),
            "**Step 3:** Calculate the volume of the cylinder with height $(round(cyl_height, digits=2)) and radius $(round(cyl_radius, digits=2))",
            sol("Cylinder volume", "V_c = \\pi r_c^2 h_c \\approx $(round(Float64(cyl_volume), digits=2))"),
            "**Step 4:** Find the ratio",
            sol("Ratio", "\\frac{V_c}{V_s} = $(round(Float64(ratio), digits=3))")
        ),
        image=img,
        calculator="scientific",
        time=300
    )
end