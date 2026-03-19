# geometry - angle_relationships (very_hard)
# Generated: 2026-03-08T20:02:15.040097

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Complex angle chasing in a configuration with multiple intersecting lines
        d = DiagramObj(600, 400)
        
        # Create a configuration with interesting angle relationships
        # Point positions
        A = (100, 300)
        B = (500, 300)
        C = (300, 100)
        D = (200, 200)
        E = (400, 200)
        P = (300, 250)
        
        # Draw lines creating multiple intersection points
        line!(d, A, B, :black)
        line!(d, C, P, :black)
        line!(d, D, E, :black)
        line!(d, A, C, :black)
        line!(d, B, C, :black)
        
        # Mark points
        point!(d, A, "A", :below)
        point!(d, B, "B", :below)
        point!(d, C, "C", :above)
        point!(d, D, "D", :left)
        point!(d, E, "E", :right)
        point!(d, P, "P", :below)
        
        # Generate angles with constraints
        angle1 = randint(25, 45)
        angle2 = randint(30, 50)
        angle3 = 180 - angle1 - angle2  # Triangle angle sum
        
        # Mark some angles
        text!(d, 120, 280, "$(angle1)°", 16)
        text!(d, 280, 120, "$(angle2)°", 16)
        text!(d, 220, 210, "x", 18, :blue)
        
        answer = angle3
        
        problem(
            question="In the diagram, lines intersect at various points forming triangles. If one angle measures $(angle1)° and another measures $(angle2)°, find the value of x (the third angle in the triangle they form).",
            answer=answer,
            difficulty=(2600, 2900),
            solution=steps(
                "Identify that the three angles form a triangle at the intersection points",
                "Apply the triangle angle sum theorem: the sum of angles in a triangle equals 180°",
                sol("Setup", "$(angle1) + $(angle2) + x = 180"),
                sol("Solve", "x = 180 - $(angle1) - $(angle2) = $(answer)°")
            ),
            image=render(d),
            time=240
        )
        
    elseif problem_type == 2
        # Cyclic quadrilateral with angle chasing
        d = DiagramObj(500, 500)
        
        # Create a circle with inscribed quadrilateral
        center = (250, 250)
        radius = 150
        
        circle!(d, center[1], center[2], radius, :black)
        
        # Four points on circle
        θ1, θ2, θ3, θ4 = 20, 100, 200, 290
        A = (center[1] + radius * cosd(θ1), center[2] + radius * sind(θ1))
        B = (center[1] + radius * cosd(θ2), center[2] + radius * sind(θ2))
        C = (center[1] + radius * cosd(θ3), center[2] + radius * sind(θ3))
        D = (center[1] + radius * cosd(θ4), center[2] + radius * sind(θ4))
        
        # Draw quadrilateral
        polygon!(d, [A, B, C, D], :none, :black, 2)
        
        # Mark points
        point!(d, A, "A", :right)
        point!(d, B, "B", :above)
        point!(d, C, "C", :left)
        point!(d, D, "D", :below)
        
        # Generate angles - cyclic quadrilateral property: opposite angles sum to 180
        angleA = randint(70, 110)
        angleB = randint(80, 100)
        angleC = 180 - angleA
        angleD = 180 - angleB
        
        text!(d, A[1] - 30, A[2], "$(angleA)°", 14)
        text!(d, B[1], B[2] + 25, "$(angleB)°", 14)
        text!(d, C[1] + 30, C[2], "x", 16, :blue)
        
        answer = angleC
        
        problem(
            question="Quadrilateral ABCD is inscribed in a circle. If ∠A = $(angleA)° and ∠B = $(angleB)°, find x = ∠C.",
            answer=answer,
            difficulty=(2700, 3100),
            solution=steps(
                "Recognize that ABCD is a cyclic quadrilateral (inscribed in a circle)",
                "Apply the cyclic quadrilateral theorem: opposite angles are supplementary",
                sol("Property", "∠A + ∠C = 180° and ∠B + ∠D = 180°"),
                sol("Solve", "x = ∠C = 180° - ∠A = 180° - $(angleA)° = $(answer)°")
            ),
            image=render(d),
            time=220
        )
        
    elseif problem_type == 3
        # Complex configuration with parallel lines and transversals
        d = DiagramObj(600, 500)
        
        # Two parallel lines with multiple transversals
        line!(d, (50, 150), (550, 150), :black, 2)
        line!(d, (50, 350), (550, 350), :black, 2)
        
        # Transversals
        line!(d, (150, 50), (200, 450), :black)
        line!(d, (400, 50), (350, 450), :black)
        line!(d, (250, 100), (300, 400), :black)
        
        # Mark parallel lines
        text!(d, 560, 150, "ℓ₁", 16)
        text!(d, 560, 350, "ℓ₂", 16)
        text!(d, 50, 140, "||", 14)
        text!(d, 50, 340, "||", 14)
        
        # Generate angles
        angle1 = randint(35, 75)
        angle2 = randint(40, 70)
        angle3 = 180 - angle1  # Supplementary on transversal
        answer = angle1 + angle2  # Exterior angle theorem application
        
        text!(d, 170, 200, "$(angle1)°", 14)
        text!(d, 270, 250, "$(angle2)°", 14)
        text!(d, 350, 300, "x", 16, :blue)
        
        problem(
            question="Two parallel lines ℓ₁ and ℓ₂ are cut by three transversals. If the angles shown measure $(angle1)° and $(angle2)°, find x using properties of parallel lines, alternate interior angles, and the exterior angle theorem.",
            answer=answer,
            difficulty=(2800, 3300),
            solution=steps(
                "Identify corresponding angles and alternate interior angles created by parallel lines",
                "Use the property that alternate interior angles are equal when a transversal cuts parallel lines",
                "Apply exterior angle theorem: an exterior angle equals the sum of the two non-adjacent interior angles",
                sol("Calculation", "x = $(angle1)° + $(angle2)° = $(answer)°")
            ),
            image=render(d),
            time=270
        )
        
    else
        # Star polygon with angle sum problem
        d = DiagramObj(500, 500)
        
        # Create a 5-pointed star
        center = (250, 250)
        outer_radius = 180
        inner_radius = 70
        
        points_outer = []
        points_inner = []
        for i in 0:4
            θ_outer = 90 + i * 72
            θ_inner = 90 + 36 + i * 72
            push!(points_outer, (center[1] + outer_radius * cosd(θ_outer), 
                                 center[2] - outer_radius * sind(θ_outer)))
            push!(points_inner, (center[1] + inner_radius * cosd(θ_inner), 
                                center[2] - inner_radius * sind(θ_inner)))
        end
        
        # Draw star by connecting outer points through inner points
        for i in 1:5
            j = mod1(i + 2, 5)
            line!(d, points_outer[i], points_outer[j], :black, 2)
        end
        
        # Mark vertices
        for i in 1:5
            point!(d, points_outer[i], "$(Char(64+i))", :above)
        end
        
        # The sum of angles at the five points of a star
        # Each point angle can be calculated using the formula
        sum_of_point_angles = 180
        
        # Generate specific angle values
        angle_vals = [randint(30, 40), randint(32, 42), randint(28, 38), randint(35, 45)]
        angle_sum = sum(angle_vals)
        answer = sum_of_point_angles - angle_sum
        
        text!(d, points_outer[1][1], points_outer[1][2] - 20, "$(angle_vals[1])°", 14)
        text!(d, points_outer[2][1] + 20, points_outer[2][2], "$(angle_vals[2])°", 14)
        text!(d, points_outer[3][1] + 20, points_outer[3][2] + 20, "$(angle_vals[3])°", 14)
        text!(d, points_outer[4][1] - 20, points_outer[4][2] + 20, "$(angle_vals[4])°", 14)
        text!(d, points_outer[5][1] - 20, points_outer[5][2], "x", 16, :blue)
        
        problem(
            question="In a regular 5-pointed star, the sum of the angles at the five tips equals 180°. If four of the tip angles measure $(angle_vals[1])°, $(angle_vals[2])°, $(angle_vals[3])°, and $(angle_vals[4])°, find x.",
            answer=answer,
            difficulty=(3000, 3400),
            solution=steps(
                "Recall the theorem: the sum of the angles at the tips of a 5-pointed star is 180°",
                sol("Setup equation", "$(angle_vals[1]) + $(angle_vals[2]) + $(angle_vals[3]) + $(angle_vals[4]) + x = 180"),
                sol("Simplify", "$(angle_sum) + x = 180"),
                sol("Solve", "x = 180 - $(angle_sum) = $(answer)°")
            ),
            image=render(d),
            time=300
        )
    end
end