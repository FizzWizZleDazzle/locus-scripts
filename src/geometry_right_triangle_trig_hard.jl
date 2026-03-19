# geometry - right_triangle_trig (hard)
# Generated: 2026-03-08T20:13:27.436787

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/right_triangle_trig")
    
    problem_type = choice([
        :angle_of_elevation,
        :ladder_problem,
        :shadow_problem,
        :nested_triangles,
        :trig_equation_triangle
    ])
    
    if problem_type == :angle_of_elevation
        # Person standing distance d from building, looks up at angle θ to see top
        d = randint(40, 120)
        angle_deg = randint(35, 65)
        height = round(d * tand(angle_deg), digits=1)
        
        # Create diagram
        diag = DiagramObj(400, 350)
        # Ground
        line!(diag, 50, 300, 350, 300, stroke="black", stroke_width=2)
        # Building
        line!(diag, 300, 300, 300, 300 - height * 1.5, stroke="black", stroke_width=3)
        # Person
        circle!(diag, 50, 295, 5, fill="blue")
        # Line of sight
        line!(diag, 50, 295, 300, 300 - height * 1.5, stroke="red", stroke_width=2, stroke_dasharray="5,5")
        # Right angle marker
        right_angle!(diag, 300, 300, size=15)
        # Labels
        segment_label!(diag, 50, 305, 300, 305, "$(d) m", offset=-15)
        segment_label!(diag, 310, 300 - height * 0.75, 310, 300, "h", offset=10)
        angle_arc!(diag, 50, 295, 70, 0, angle_deg, label="$(angle_deg)°")
        
        img = render(diag)
        
        problem(
            question="A person stands $(d) meters from the base of a building and looks up at an angle of $(angle_deg)° to see the top. What is the height of the building? Round to the nearest tenth of a meter.",
            answer=height,
            difficulty=(1800, 2000),
            solution=steps(
                "Set up: We have a right triangle where the adjacent side is $(d) m and we need the opposite side (height).",
                sol("Use tangent", "\\tan($(angle_deg)°) = \\frac{h}{$(d)}"),
                sol("Solve for h", "h = $(d) \\cdot \\tan($(angle_deg)°) = $(height) \\text{ m}")
            ),
            image=img,
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == :ladder_problem
        # Ladder of length L leans against wall at angle θ, find height reached
        L = randint(15, 30)
        angle_deg = randint(55, 75)
        height = round(L * sind(angle_deg), digits=2)
        base_dist = round(L * cosd(angle_deg), digits=2)
        
        # Create diagram
        diag = DiagramObj(400, 400)
        # Ground
        line!(diag, 50, 350, 350, 350, stroke="black", stroke_width=2)
        # Wall
        line!(diag, 300, 350, 300, 100, stroke="black", stroke_width=3)
        # Ladder
        line!(diag, 50, 350, 300, 350 - height * 2, stroke="brown", stroke_width=4)
        # Right angle
        right_angle!(diag, 300, 350, size=15)
        # Labels
        segment_label!(diag, 175, 350 - height, 175, 350 - height - 30, "$(L) ft", offset=-40)
        segment_label!(diag, 310, 225, 310, 225, "h", offset=10)
        angle_arc!(diag, 50, 350, 60, 0, angle_deg, label="$(angle_deg)°")
        
        img = render(diag)
        
        problem(
            question="A $(L)-foot ladder leans against a wall, making an angle of $(angle_deg)° with the ground. How high up the wall does the ladder reach? Round to the nearest hundredth of a foot.",
            answer=height,
            difficulty=(1850, 2050),
            solution=steps(
                "Set up: The ladder is the hypotenuse ($(L) ft), and we need the opposite side (height) for angle $(angle_deg)°.",
                sol("Use sine", "\\sin($(angle_deg)°) = \\frac{h}{$(L)}"),
                sol("Solve for h", "h = $(L) \\cdot \\sin($(angle_deg)°) = $(height) \\text{ ft}")
            ),
            image=img,
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == :shadow_problem
        # Tree casts shadow, sun at angle θ, find tree height
        shadow_length = randint(25, 60)
        angle_deg = randint(40, 70)
        tree_height = round(shadow_length * tand(angle_deg), digits=1)
        
        # Create diagram
        diag = DiagramObj(450, 350)
        # Ground
        line!(diag, 50, 300, 400, 300, stroke="black", stroke_width=2)
        # Tree
        line!(diag, 80, 300, 80, 300 - tree_height * 1.8, stroke="green", stroke_width=5)
        polygon!(diag, [70, 90, 80], [300 - tree_height * 1.8 - 20, 300 - tree_height * 1.8 - 20, 300 - tree_height * 1.8 - 35], fill="green")
        # Sun ray
        line!(diag, 80, 300 - tree_height * 1.8, 80 + shadow_length * 3, 300, stroke="orange", stroke_width=2, stroke_dasharray="5,5")
        # Shadow
        line!(diag, 80, 300, 80 + shadow_length * 3, 300, stroke="gray", stroke_width=6, opacity=0.4)
        # Right angle
        right_angle!(diag, 80, 300, size=15)
        # Labels
        segment_label!(diag, 80 + shadow_length * 1.5, 310, 80 + shadow_length * 1.5, 310, "$(shadow_length) m", offset=-15)
        segment_label!(diag, 65, 300 - tree_height * 0.9, 65, 300 - tree_height * 0.9, "h", offset=-10)
        angle_arc!(diag, 80 + shadow_length * 3, 300, 70, 180, 180 - angle_deg, label="$(angle_deg)°")
        
        img = render(diag)
        
        problem(
            question="A tree casts a shadow that is $(shadow_length) meters long. The angle of elevation from the tip of the shadow to the top of the tree is $(angle_deg)°. How tall is the tree? Round to the nearest tenth of a meter.",
            answer=tree_height,
            difficulty=(1900, 2100),
            solution=steps(
                "Set up: Right triangle with shadow as adjacent side ($(shadow_length) m) and tree height as opposite side.",
                sol("Use tangent", "\\tan($(angle_deg)°) = \\frac{h}{$(shadow_length)}"),
                sol("Solve for h", "h = $(shadow_length) \\cdot \\tan($(angle_deg)°) = $(tree_height) \\text{ m}")
            ),
            image=img,
            calculator="scientific",
            time=150
        )
        
    elseif problem_type == :nested_triangles
        # Two observers at different distances see top of tower at different angles
        d1 = randint(50, 100)
        d2 = d1 + randint(30, 80)
        angle1_deg = randint(45, 65)
        height = round(d1 * tand(angle1_deg), digits=1)
        angle2_deg = round(atand(height / d2), digits=1)
        
        # Create diagram
        diag = DiagramObj(500, 350)
        # Ground
        line!(diag, 30, 300, 450, 300, stroke="black", stroke_width=2)
        # Tower
        line!(diag, 400, 300, 400, 300 - height * 1.5, stroke="black", stroke_width=4)
        # Observer 1
        circle!(diag, 30, 295, 5, fill="blue")
        line!(diag, 30, 295, 400, 300 - height * 1.5, stroke="red", stroke_width=1.5, stroke_dasharray="4,4")
        # Observer 2
        circle!(diag, 150, 295, 5, fill="green")
        line!(diag, 150, 295, 400, 300 - height * 1.5, stroke="green", stroke_width=1.5, stroke_dasharray="4,4")
        # Right angle
        right_angle!(diag, 400, 300, size=15)
        # Labels
        segment_label!(diag, 215, 310, 215, 310, "$(d1) m", offset=-15)
        segment_label!(diag, 90, 320, 90, 320, "$(d2) m", offset=-20)
        segment_label!(diag, 415, 300 - height * 0.75, 415, 300 - height * 0.75, "h", offset=10)
        angle_arc!(diag, 30, 295, 50, 0, angle1_deg, label="$(angle1_deg)°")
        text!(diag, 30, 330, "A", font_size=14, fill="blue")
        text!(diag, 150, 330, "B", font_size=14, fill="green")
        
        img = render(diag)
        
        problem(
            question="Two observers A and B stand on level ground $(d2) m and $(d1) m from the base of a tower, respectively. Observer B (closer to the tower) measures the angle of elevation to the top as $(angle1_deg)°. What is the angle of elevation for observer A? Round to the nearest tenth of a degree.",
            answer=angle2_deg,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Find height using observer B", "h = $(d1) \\cdot \\tan($(angle1_deg)°) = $(height) \\text{ m}"),
                sol("Use height to find angle for observer A", "\\tan(\\theta) = \\frac{$(height)}{$(d2)}"),
                sol("Solve for θ", "\\theta = \\arctan\\left(\\frac{$(height)}{$(d2)}\\right) = $(angle2_deg)°")
            ),
            image=img,
            calculator="scientific",
            time=180
        )
        
    else # :trig_equation_triangle
        # Given triangle with specific measurements, find unknown using law of sines or cosines variant
        # Right triangle where one leg and one acute angle are known, find hypotenuse
        leg = randint(12, 35)
        angle_deg = randint(25, 65)
        
        # Determine which leg we're given
        if choice([true, false])
            # Given adjacent, find hypotenuse
            hyp = round(leg / cosd(angle_deg), digits=2)
            leg_type = "adjacent"
            formula = "\\cos"
        else
            # Given opposite, find hypotenuse
            hyp = round(leg / sind(angle_deg), digits=2)
            leg_type = "opposite"
            formula = "\\sin"
        end
        
        # Create diagram
        diag = DiagramObj(400, 350)
        if leg_type == "adjacent"
            # Horizontal leg
            line!(diag, 50, 280, 50 + leg * 5, 280, stroke="black", stroke_width=2)
            # Vertical leg
            vert_leg = leg * tand(angle_deg)
            line!(diag, 50 + leg * 5, 280, 50 + leg * 5, 280 - vert_leg * 5, stroke="black", stroke_width=2)
            # Hypotenuse
            line!(diag, 50, 280, 50 + leg * 5, 280 - vert_leg * 5, stroke="blue", stroke_width=2.5)
            # Right angle
            right_angle!(diag, 50 + leg * 5, 280, size=15)
            # Labels
            segment_label!(diag, 50 + leg * 2.5, 290, 50 + leg * 2.5, 290, "$(leg)", offset=-15)
            segment_label!(diag, 50 + leg * 2.5 - 20, 280 - vert_leg * 2.5 + 10, 50 + leg * 2.5 - 20, 280 - vert_leg * 2.5 + 10, "c", offset=-10)
            angle_arc!(diag, 50, 280, 40, 0, angle_deg, label="$(angle_deg)°")
        else
            # Vertical leg
            line!(diag, 50, 280, 50, 280 - leg * 5, stroke="black", stroke_width=2)
            # Horizontal leg
            horiz_leg = leg / tand(angle_deg)
            line!(diag, 50, 280, 50 + horiz_leg * 5, 280, stroke="black", stroke_width=2)
            # Hypotenuse
            line!(diag, 50, 280 - leg * 5, 50 + horiz_leg * 5, 280, stroke="blue", stroke_width=2.5)
            # Right angle
            right_angle!(diag, 50, 280, size=15)
            # Labels
            segment_label!(diag, 35, 280 - leg * 2.5, 35, 280 - leg * 2.5, "$(leg)", offset=-10)
            segment_label!(diag, 50 + horiz_leg * 2.5 - 20, 280 - leg * 2.5 - 10, 50 + horiz_leg * 2.5 - 20, 280 - leg * 2.5 - 10, "c", offset=-10)
            angle_arc!(diag, 50 + horiz_leg * 5, 280, 40, 180, 180 - angle_deg, label="$(angle_deg)°")
        end
        
        img = render(diag)
        
        problem(
            question="In a right triangle, one acute angle measures $(angle_deg)° and the $(leg_type) leg to this angle has length $(leg). Find the length of the hypotenuse c. Round to the nearest hundredth.",
            answer=hyp,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Set up relationship", "$(formula)($(angle_deg)°) = \\frac{$(leg)}{c}"),
                sol("Solve for c", "c = \\frac{$(leg)}{$(formula)($(angle_deg)°)}"),
                sol("Calculate", "c = $(hyp)")
            ),
            image=img,
            calculator="scientific",
            time=150
        )
    end
end