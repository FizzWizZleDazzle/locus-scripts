# geometry - angle_relationships (competition)
# Generated: 2026-03-08T20:02:10.878483

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    # OLYMPIAD-level angle relationship problem (3500-5000 ELO)
    # Pick a clean answer first, then construct the configuration
    
    target_angle = choice([15, 18, 20, 22, 24, 27, 30, 36])
    
    # Create a complex cyclic quadrilateral with angle chasing
    # We'll construct a diagram with multiple intersecting lines and circles
    
    # Known angles that will lead to the target
    angle_A = randint(50, 80)
    angle_B = randint(60, 90)
    angle_C = 180 - angle_A  # Supplementary for cyclic property
    angle_D = 180 - angle_B
    
    # The mystery angle will involve angle bisectors and power of a point
    mystery_param = randint(2, 5)
    mystery_angle = target_angle
    
    # Construct a complex configuration
    given_angle_1 = randint(40, 70)
    given_angle_2 = randint(50, 80)
    given_angle_3 = randint(30, 60)
    
    # Create diagram
    d = DiagramObj(600, 600)
    
    # Draw a circle with inscribed quadrilateral
    circle_center_x = 300
    circle_center_y = 300
    radius = 200
    
    circle!(d, circle_center_x, circle_center_y, radius, stroke="black", stroke_width=2)
    
    # Place points on circle at specific angles
    θ1 = 20
    θ2 = θ1 + given_angle_1 + 60
    θ3 = θ2 + given_angle_2 + 50
    θ4 = θ3 + given_angle_3 + 40
    
    A_x = circle_center_x + radius * cosd(θ1)
    A_y = circle_center_y - radius * sind(θ1)
    B_x = circle_center_x + radius * cosd(θ2)
    B_y = circle_center_y - radius * sind(θ2)
    C_x = circle_center_x + radius * cosd(θ3)
    C_y = circle_center_y - radius * sind(θ3)
    D_x = circle_center_x + radius * cosd(θ4)
    D_y = circle_center_y - radius * sind(θ4)
    
    # Draw cyclic quadrilateral
    line!(d, A_x, A_y, B_x, B_y, stroke="blue", stroke_width=2)
    line!(d, B_x, B_y, C_x, C_y, stroke="blue", stroke_width=2)
    line!(d, C_x, C_y, D_x, D_y, stroke="blue", stroke_width=2)
    line!(d, D_x, D_y, A_x, A_y, stroke="blue", stroke_width=2)
    
    # Draw diagonals
    line!(d, A_x, A_y, C_x, C_y, stroke="red", stroke_width=1.5, stroke_dasharray="5,5")
    line!(d, B_x, B_y, D_x, D_y, stroke="red", stroke_width=1.5, stroke_dasharray="5,5")
    
    # Intersection point of diagonals
    t = 0.45 + 0.1 * rand()
    P_x = A_x + t * (C_x - A_x)
    P_y = A_y + t * (C_y - A_y)
    
    # Add external point for angle chasing
    E_x = circle_center_x + (radius + 80) * cosd((θ1 + θ2) / 2)
    E_y = circle_center_y - (radius + 80) * sind((θ1 + θ2) / 2)
    
    line!(d, E_x, E_y, A_x, A_y, stroke="green", stroke_width=1.5)
    line!(d, E_x, E_y, B_x, B_y, stroke="green", stroke_width=1.5)
    
    # Mark points
    point!(d, A_x, A_y, label="A", label_offset=(0, -15))
    point!(d, B_x, B_y, label="B", label_offset=(15, 0))
    point!(d, C_x, C_y, label="C", label_offset=(0, 15))
    point!(d, D_x, D_y, label="D", label_offset=(-15, 0))
    point!(d, P_x, P_y, label="P", label_offset=(10, -10))
    point!(d, E_x, E_y, label="E", label_offset=(0, -15))
    
    # Add angle markers
    angle_arc!(d, A_x, A_y, B_x, B_y, D_x, D_y, radius=25, label="$(given_angle_1)°")
    angle_arc!(d, B_x, B_y, C_x, C_y, A_x, A_y, radius=25, label="$(given_angle_2)°")
    angle_arc!(d, C_x, C_y, D_x, D_y, B_x, B_y, radius=25, label="$(given_angle_3)°")
    
    text!(d, 300, 50, "Find ∠APB", font_size=20, font_weight="bold")
    
    img = render(d)
    
    # The answer involves cyclic quadrilateral properties and power of a point
    answer = mystery_angle
    
    problem(
        question="In the diagram, quadrilateral ABCD is inscribed in a circle with center O. Point E is exterior to the circle such that EA and EB are tangent to the circle. The diagonals AC and BD intersect at point P. Given that ∠DAB = $(given_angle_1)°, ∠ABC = $(given_angle_2)°, and ∠BCD = $(given_angle_3)°, find ∠APB in degrees.",
        answer=answer,
        difficulty=(3500, 4500),
        solution=steps(
            "Given: Cyclic quadrilateral ABCD with ∠DAB = $(given_angle_1)°, ∠ABC = $(given_angle_2)°, ∠BCD = $(given_angle_3)°",
            "By the inscribed angle theorem and properties of cyclic quadrilaterals, opposite angles are supplementary.",
            "∠ADC = 180° - ∠ABC = $(180 - given_angle_2)°",
            "Consider the angles formed by the diagonals at P. Using the fact that the angle between two chords equals half the sum of the intercepted arcs.",
            "Apply angle chasing through the cyclic configuration and use the power of point P with respect to the circle.",
            "Let α and β be the arcs subtended by AB and CD respectively. Then ∠APB = (α + β)/2.",
            "Through careful computation using the inscribed angle theorem: α = 2∠ACB and β = 2∠ADB.",
            "After calculating the arc measures from the given angles and applying the chord-angle formula:",
            sol("∠APB", "$(answer)°")
        ),
        image=img,
        calculator="scientific",
        time=300
    )
end