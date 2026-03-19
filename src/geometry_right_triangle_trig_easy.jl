# geometry - right_triangle_trig (easy)
# Generated: 2026-03-08T20:12:33.399910

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/right_triangle_trig")
    
    # Choose problem type
    prob_type = choice([:solve_side, :solve_angle, :find_trig_ratio])
    
    if prob_type == :solve_side
        # Given angle and one side, find another side
        angle_deg = choice([30, 45, 60])
        side_type = choice([:opp_given, :adj_given, :hyp_given])
        
        if angle_deg == 30
            # Use 30-60-90 triangle ratios
            if side_type == :opp_given
                opp = randint(3, 12)
                adj = round(Int, opp * sqrt(3))
                hyp = 2 * opp
                given_side = opp
                given_label = "opposite"
                find_side = "hypotenuse"
                answer = hyp
            elseif side_type == :adj_given
                adj = randint(3, 12)
                opp = round(Int, adj / sqrt(3))
                hyp = round(Int, 2 * adj / sqrt(3))
                given_side = adj
                given_label = "adjacent"
                find_side = "opposite"
                answer = opp
            else
                hyp = randint(6, 24)
                opp = hyp ÷ 2
                adj = round(Int, opp * sqrt(3))
                given_side = hyp
                given_label = "hypotenuse"
                find_side = "adjacent"
                answer = adj
            end
        elseif angle_deg == 45
            # Use 45-45-90 triangle ratios
            if side_type == :opp_given
                opp = randint(4, 15)
                adj = opp
                hyp = round(Int, opp * sqrt(2))
                given_side = opp
                given_label = "opposite"
                find_side = "hypotenuse"
                answer = hyp
            elseif side_type == :adj_given
                adj = randint(4, 15)
                opp = adj
                hyp = round(Int, adj * sqrt(2))
                given_side = adj
                given_label = "adjacent"
                find_side = "opposite"
                answer = opp
            else
                hyp = randint(8, 20)
                opp = round(Int, hyp / sqrt(2))
                adj = opp
                given_side = hyp
                given_label = "hypotenuse"
                find_side = "adjacent"
                answer = adj
            end
        else  # 60 degrees
            # Use 30-60-90 triangle ratios (60° is the larger acute angle)
            if side_type == :opp_given
                opp = randint(4, 15)
                adj = round(Int, opp / sqrt(3))
                hyp = round(Int, 2 * opp / sqrt(3))
                given_side = opp
                given_label = "opposite"
                find_side = "adjacent"
                answer = adj
            elseif side_type == :adj_given
                adj = randint(3, 12)
                opp = round(Int, adj * sqrt(3))
                hyp = 2 * adj
                given_side = adj
                given_label = "adjacent"
                find_side = "hypotenuse"
                answer = hyp
            else
                hyp = randint(6, 24)
                adj = hyp ÷ 2
                opp = round(Int, adj * sqrt(3))
                given_side = hyp
                given_label = "hypotenuse"
                find_side = "opposite"
                answer = opp
            end
        end
        
        # Create diagram
        d = DiagramObj(width=300, height=300)
        # Draw right triangle
        polygon!(d, [(50, 250), (250, 250), (50, 100)], fill="lightblue", stroke="black", stroke_width=2)
        # Mark right angle
        right_angle!(d, (50, 250), (250, 250), (50, 100), size=15)
        # Mark the given angle
        if angle_deg != 90
            angle_arc!(d, 50, 100, 270, 270+angle_deg, 30, label="$(angle_deg)°")
        end
        # Label sides
        opp_label = given_label == "opposite" ? string(given_side) : find_side == "opposite" ? "?" : ""
        adj_label = given_label == "adjacent" ? string(given_side) : find_side == "adjacent" ? "?" : ""
        hyp_label = given_label == "hypotenuse" ? string(given_side) : find_side == "hypotenuse" ? "?" : ""
        segment_label!(d, 50, 175, opp_label)
        segment_label!(d, 150, 260, adj_label)
        segment_label!(d, 150, 170, hyp_label)
        
        question = "In a right triangle, one angle measures $(angle_deg)°. The side $(given_label) to this angle has length $(given_side). Find the length of the $(find_side)."
        
        if angle_deg == 30 || angle_deg == 60
            trig_ratio = angle_deg == 30 ? (side_type == :opp_given ? "sin" : side_type == :adj_given ? "cos" : "sin") : (side_type == :opp_given ? "sin" : side_type == :adj_given ? "tan" : "cos")
        else
            trig_ratio = side_type == :opp_given ? "sin" : side_type == :adj_given ? "cos" : "sin"
        end
        
        solution_text = steps(
            "Given: angle = $(angle_deg)°, $(given_label) = $(given_side)",
            "Use the appropriate trigonometric ratio for a $(angle_deg)° angle in a right triangle",
            "Apply special triangle ratios or trigonometric functions",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(800, 1000),
            solution=solution_text,
            image=render(d),
            time=90
        )
        
    elseif prob_type == :solve_angle
        # Given two sides, find an angle
        opp = randint(3, 12)
        adj = randint(3, 12)
        hyp = round(Int, sqrt(opp^2 + adj^2))
        
        # Create diagram
        d = DiagramObj(width=300, height=300)
        polygon!(d, [(50, 250), (250, 250), (50, 100)], fill="lightblue", stroke="black", stroke_width=2)
        right_angle!(d, (50, 250), (250, 250), (50, 100), size=15)
        segment_label!(d, 50, 175, "$(opp)")
        segment_label!(d, 150, 260, "$(adj)")
        angle_arc!(d, 50, 100, 270, 315, 30, label="θ")
        
        # Calculate angle using arctan
        angle_rad = atan(opp / adj)
        angle_deg = round(angle_rad * 180 / π, digits=1)
        
        question = "In a right triangle, the opposite side has length $(opp) and the adjacent side has length $(adj). Find the angle θ (in degrees, rounded to one decimal place)."
        
        solution_text = steps(
            "Given: opposite = $(opp), adjacent = $(adj)",
            "Use tan(θ) = opposite/adjacent = $(opp)/$(adj)",
            "θ = arctan($(opp)/$(adj))",
            sol("Answer", "$(angle_deg)°")
        )
        
        problem(
            question=question,
            answer=angle_deg,
            difficulty=(900, 1100),
            solution=solution_text,
            image=render(d),
            calculator="scientific",
            time=120
        )
        
    else  # find_trig_ratio
        # Given a right triangle with sides, find a trigonometric ratio
        a = randint(3, 12)
        b = randint(3, 12)
        c = round(Int, sqrt(a^2 + b^2))
        
        # Create diagram
        d = DiagramObj(width=300, height=300)
        polygon!(d, [(50, 250), (250, 250), (50, 100)], fill="lightblue", stroke="black", stroke_width=2)
        right_angle!(d, (50, 250), (250, 250), (50, 100), size=15)
        segment_label!(d, 50, 175, "$(a)")
        segment_label!(d, 150, 260, "$(b)")
        segment_label!(d, 150, 170, "$(c)")
        angle_arc!(d, 50, 100, 270, 315, 30, label="θ")
        
        trig_func = choice(["sin", "cos", "tan"])
        
        if trig_func == "sin"
            answer = a // c
            ratio_text = "opposite/hypotenuse = $(a)/$(c)"
        elseif trig_func == "cos"
            answer = b // c
            ratio_text = "adjacent/hypotenuse = $(b)/$(c)"
        else
            answer = a // b
            ratio_text = "opposite/adjacent = $(a)/$(b)"
        end
        
        question = "In the right triangle shown, the sides have lengths $(a), $(b), and $(c). Find $(trig_func)(θ) as a fraction in lowest terms."
        
        solution_text = steps(
            "Identify the sides relative to angle θ: opposite = $(a), adjacent = $(b), hypotenuse = $(c)",
            "$(trig_func)(θ) = $(ratio_text)",
            "Simplify the fraction if possible",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(700, 900),
            solution=solution_text,
            image=render(d),
            time=90
        )
    end
end