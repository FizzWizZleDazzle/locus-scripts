# geometry - right_triangle_trig (medium)
# Generated: 2026-03-08T20:13:01.942700

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("geometry/right_triangle_trig")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Find missing side using trig ratio
        angle_deg = choice([25, 30, 35, 40, 45, 50, 55, 60])
        known_side = randint(5, 20)
        side_type = choice(["adjacent", "opposite", "hypotenuse"])
        
        d = DiagramObj(300, 250)
        
        if side_type == "adjacent"
            # Given adjacent, find opposite or hypotenuse
            find_type = choice(["opposite", "hypotenuse"])
            
            polygon!(d, [(50, 200), (250, 200), (250, 50)], fill="none", stroke="black", stroke_width=2)
            point!(d, 50, 200, "A", :left)
            point!(d, 250, 200, "B", :below)
            point!(d, 250, 50, "C", :above)
            right_angle!(d, 250, 200, 15)
            angle_arc!(d, 50, 200, 250, 200, 250, 50, 30, "$(angle_deg)°")
            segment_label!(d, 50, 200, 250, 200, "$(known_side)", :below)
            
            if find_type == "opposite"
                segment_label!(d, 250, 200, 250, 50, "?", :right)
                ans = known_side * tan(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the adjacent side AB = $(known_side). Find the length of the opposite side BC. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and adjacent side AB = $(known_side)",
                    sol("Use tangent ratio", "\\tan($(angle_deg)°) = \\frac{\\text{opposite}}{\\text{adjacent}} = \\frac{BC}{$(known_side)}"),
                    sol("Solve for BC", "BC = $(known_side) \\cdot \\tan($(angle_deg)°) \\approx $(answer)")
                )
            else
                segment_label!(d, 50, 200, 250, 50, "?", :above)
                ans = known_side / cos(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the adjacent side AB = $(known_side). Find the length of the hypotenuse AC. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and adjacent side AB = $(known_side)",
                    sol("Use cosine ratio", "\\cos($(angle_deg)°) = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = \\frac{$(known_side)}{AC}"),
                    sol("Solve for AC", "AC = \\frac{$(known_side)}{\\cos($(angle_deg)°)} \\approx $(answer)")
                )
            end
            
        elseif side_type == "opposite"
            # Given opposite, find adjacent or hypotenuse
            find_type = choice(["adjacent", "hypotenuse"])
            
            polygon!(d, [(50, 200), (250, 200), (250, 50)], fill="none", stroke="black", stroke_width=2)
            point!(d, 50, 200, "A", :left)
            point!(d, 250, 200, "B", :below)
            point!(d, 250, 50, "C", :above)
            right_angle!(d, 250, 200, 15)
            angle_arc!(d, 50, 200, 250, 200, 250, 50, 30, "$(angle_deg)°")
            segment_label!(d, 250, 200, 250, 50, "$(known_side)", :right)
            
            if find_type == "adjacent"
                segment_label!(d, 50, 200, 250, 200, "?", :below)
                ans = known_side / tan(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the opposite side BC = $(known_side). Find the length of the adjacent side AB. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and opposite side BC = $(known_side)",
                    sol("Use tangent ratio", "\\tan($(angle_deg)°) = \\frac{\\text{opposite}}{\\text{adjacent}} = \\frac{$(known_side)}{AB}"),
                    sol("Solve for AB", "AB = \\frac{$(known_side)}{\\tan($(angle_deg)°)} \\approx $(answer)")
                )
            else
                segment_label!(d, 50, 200, 250, 50, "?", :above)
                ans = known_side / sin(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the opposite side BC = $(known_side). Find the length of the hypotenuse AC. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and opposite side BC = $(known_side)",
                    sol("Use sine ratio", "\\sin($(angle_deg)°) = \\frac{\\text{opposite}}{\\text{hypotenuse}} = \\frac{$(known_side)}{AC}"),
                    sol("Solve for AC", "AC = \\frac{$(known_side)}{\\sin($(angle_deg)°)} \\approx $(answer)")
                )
            end
            
        else  # hypotenuse
            # Given hypotenuse, find adjacent or opposite
            find_type = choice(["adjacent", "opposite"])
            
            polygon!(d, [(50, 200), (250, 200), (250, 50)], fill="none", stroke="black", stroke_width=2)
            point!(d, 50, 200, "A", :left)
            point!(d, 250, 200, "B", :below)
            point!(d, 250, 50, "C", :above)
            right_angle!(d, 250, 200, 15)
            angle_arc!(d, 50, 200, 250, 200, 250, 50, 30, "$(angle_deg)°")
            segment_label!(d, 50, 200, 250, 50, "$(known_side)", :above)
            
            if find_type == "adjacent"
                segment_label!(d, 50, 200, 250, 200, "?", :below)
                ans = known_side * cos(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the hypotenuse AC = $(known_side). Find the length of the adjacent side AB. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and hypotenuse AC = $(known_side)",
                    sol("Use cosine ratio", "\\cos($(angle_deg)°) = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = \\frac{AB}{$(known_side)}"),
                    sol("Solve for AB", "AB = $(known_side) \\cdot \\cos($(angle_deg)°) \\approx $(answer)")
                )
            else
                segment_label!(d, 250, 200, 250, 50, "?", :right)
                ans = known_side * sin(deg2rad(angle_deg))
                answer = round(ans, digits=2)
                
                question = "In the right triangle shown, angle A = $(angle_deg)° and the hypotenuse AC = $(known_side). Find the length of the opposite side BC. Round to 2 decimal places."
                
                solution = steps(
                    "We know angle A = $(angle_deg)° and hypotenuse AC = $(known_side)",
                    sol("Use sine ratio", "\\sin($(angle_deg)°) = \\frac{\\text{opposite}}{\\text{hypotenuse}} = \\frac{BC}{$(known_side)}"),
                    sol("Solve for BC", "BC = $(known_side) \\cdot \\sin($(angle_deg)°) \\approx $(answer)")
                )
            end
        end
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1200, 1400),
            solution=solution,
            image=render(d),
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == 2
        # Find angle given two sides
        a = randint(6, 15)
        b = randint(6, 15)
        
        d = DiagramObj(300, 250)
        polygon!(d, [(50, 200), (250, 200), (250, 50)], fill="none", stroke="black", stroke_width=2)
        point!(d, 50, 200, "A", :left)
        point!(d, 250, 200, "B", :below)
        point!(d, 250, 50, "C", :above)
        right_angle!(d, 250, 200, 15)
        angle_arc!(d, 50, 200, 250, 200, 250, 50, 30, "θ")
        segment_label!(d, 50, 200, 250, 200, "$(a)", :below)
        segment_label!(d, 250, 200, 250, 50, "$(b)", :right)
        
        angle_rad = atan(b / a)
        answer = round(rad2deg(angle_rad), digits=1)
        
        question = "In the right triangle shown, the adjacent side AB = $(a) and the opposite side BC = $(b). Find the measure of angle θ in degrees. Round to 1 decimal place."
        
        solution = steps(
            "We know adjacent = $(a) and opposite = $(b)",
            sol("Use inverse tangent", "\\theta = \\tan^{-1}\\left(\\frac{\\text{opposite}}{\\text{adjacent}}\\right) = \\tan^{-1}\\left(\\frac{$(b)}{$(a)}\\right)"),
            sol("Calculate", "\\theta \\approx $(answer)°")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1300, 1500),
            solution=solution,
            image=render(d),
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == 3
        # Word problem: angle of elevation
        distance = randint(20, 50)
        height = randint(15, 40)
        
        d = DiagramObj(350, 280)
        line!(d, 50, 230, 300, 230, stroke="black", stroke_width=2)
        line!(d, 300, 230, 300, 80, stroke="black", stroke_width=2)
        line!(d, 50, 230, 300, 80, stroke="black", stroke_width=1.5, stroke_dasharray="5,5")
        point!(d, 50, 230, "Observer", :below)
        point!(d, 300, 230, "", :none)
        point!(d, 300, 80, "Top", :above)
        angle_arc!(d, 50, 230, 300, 230, 300, 80, 35, "θ")
        segment_label!(d, 50, 230, 300, 230, "$(distance) m", :below)
        segment_label!(d, 300, 230, 300, 80, "$(height) m", :right)
        right_angle!(d, 300, 230, 15)
        
        angle_rad = atan(height / distance)
        answer = round(rad2deg(angle_rad), digits=1)
        
        question = "An observer is standing $(distance) meters away from the base of a building. The building is $(height) meters tall. What is the angle of elevation θ from the observer to the top of the building? Round to 1 decimal place."
        
        solution = steps(
            "This forms a right triangle with opposite = $(height) m and adjacent = $(distance) m",
            sol("Use inverse tangent", "\\theta = \\tan^{-1}\\left(\\frac{$(height)}{$(distance)}\\right)"),
            sol("Calculate", "\\theta \\approx $(answer)°")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1400, 1600),
            solution=solution,
            image=render(d),
            calculator="scientific",
            time=150
        )
        
    elseif problem_type == 4
        # Two-step problem: find one side then another
        angle_deg = choice([30, 35, 40, 45, 50, 55, 60])
        hyp = randint(15, 30)
        
        d = DiagramObj(300, 250)
        polygon!(d, [(50, 200), (250, 200), (250, 50)], fill="none", stroke="black", stroke_width=2)
        point!(d, 50, 200, "A", :left)
        point!(d, 250, 200, "B", :below)
        point!(d, 250, 50, "C", :above)
        right_angle!(d, 250, 200, 15)
        angle_arc!(d, 50, 200, 250, 200, 250, 50, 30, "$(angle_deg)°")
        segment_label!(d, 50, 200, 250, 50, "$(hyp)", :above)
        segment_label!(d, 50, 200, 250, 200, "x", :below)
        segment_label!(d, 250, 200, 250, 50, "y", :right)
        
        adj = hyp * cos(deg2rad(angle_deg))
        opp = hyp * sin(deg2rad(angle_deg))
        answer_adj = round(adj, digits=2)
        answer_opp = round(opp, digits=2)
        perimeter = round(hyp + adj + opp, digits=2)
        
        question = "In the right triangle shown, angle A = $(angle_deg)° and hypotenuse AC = $(hyp). Find the perimeter of the triangle. Round to 2 decimal places."
        
        solution = steps(
            "First find the two legs using trig ratios",
            sol("Adjacent side", "x = $(hyp) \\cdot \\cos($(angle_deg)°) \\approx $(answer_adj)"),
            sol("Opposite side", "y = $(hyp) \\cdot \\sin($(angle_deg)°) \\approx $(answer_opp)"),
            sol("Perimeter", "P = $(hyp) + $(answer_adj) + $(answer_opp) = $(perimeter)")
        )
        
        problem(
            question=question,
            answer=perimeter,
            difficulty=(1500, 1700),
            solution=solution,
            image=render(d),
            calculator="scientific",
            time=180
        )
        
    else  # problem_type == 5
        # Application        # Application
        dist = randint(20, 100)
        angle = choice([30, 45, 60])
        height = round(dist * tan(deg2rad(angle)), digits=2)

        d = DiagramObj(400, 300)
        polygon!(d, [(50, 250), (350, 250), (350, 50)], fill="none", stroke="black", stroke_width=2)
        right_angle!(d, 350, 250, 15)

        problem(
            question="From $(dist) meters from a building base, the angle of elevation to the top is $(angle) degrees. Find the building height. Round to 2 decimal places.",
            answer=height,
            difficulty=(1200, 1400),
            solution=steps(
                "tan($(angle)) = h/$(dist)",
                sol("Answer", "h = $(height) meters")
            ),
            image=render(d),
            calculator="scientific",
            time=120
        )
    end
end
