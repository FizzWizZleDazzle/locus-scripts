# geometry - right_triangle_trig (very_easy)
# Generated: 2026-03-08T20:12:18.076029

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/right_triangle_trig")
    
    # Pick a problem type randomly
    problem_type = choice(["identify_side", "find_sin", "find_cos", "find_tan", "simple_ratio"])
    
    if problem_type == "identify_side"
        # FOUNDATIONAL: Identify opposite/adjacent/hypotenuse
        angle_name = choice(["A", "B", "C"])
        side_type = choice(["opposite", "adjacent", "hypotenuse"])
        
        d = DiagramObj(600, 400)
        
        # Draw right triangle
        polygon!(d, [(100, 300), (400, 300), (400, 100)], stroke="black", fill="none", stroke_width=2)
        
        # Mark right angle
        right_angle!(d, (400, 300), (100, 300), (400, 100), size=20)
        
        # Label vertices
        text!(d, "A", 90, 310, font_size=20)
        text!(d, "B", 410, 310, font_size=20)
        text!(d, "C", 410, 90, font_size=20)
        
        # Label sides
        segment_label!(d, (100, 300), (400, 300), "a", offset=15)
        segment_label!(d, (400, 300), (400, 100), "b", offset=15)
        segment_label!(d, (100, 300), (400, 100), "c", offset=-15)
        
        if angle_name == "A"
            if side_type == "opposite"
                answer = "b"
                explanation = "Side b is across from angle A"
            elseif side_type == "adjacent"
                answer = "a"
                explanation = "Side a is next to angle A (not the hypotenuse)"
            else
                answer = "c"
                explanation = "Side c is the hypotenuse (across from the right angle)"
            end
        elseif angle_name == "B"
            if side_type == "opposite"
                answer = "a"
                explanation = "Side a is across from angle B"
            elseif side_type == "adjacent"
                answer = "b"
                explanation = "Side b is next to angle B (not the hypotenuse)"
            else
                answer = "c"
                explanation = "Side c is the hypotenuse (across from the right angle)"
            end
        else  # angle_name == "C"
            if side_type == "opposite"
                answer = "c"
                explanation = "The side opposite the right angle is the hypotenuse c"
            elseif side_type == "adjacent"
                answer_options = ["a", "b"]
                answer = choice(answer_options)
                explanation = "Both a and b are adjacent to the right angle, either could be considered adjacent"
            else
                answer = "c"
                explanation = "Side c is the hypotenuse"
            end
        end
        
        problem(
            question="In the right triangle shown, which side is the $(side_type) to angle $(angle_name)?",
            answer=answer,
            difficulty=(100, 300),
            solution=steps(
                "Identify angle $(angle_name) in the triangle",
                "Locate the $(side_type) side relative to this angle",
                explanation
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == "find_sin"
        # ELEMENTARY: Find sin of an angle given sides
        opp = randint(3, 12)
        hyp = randint(opp + 1, 20)
        
        d = DiagramObj(600, 400)
        
        # Draw right triangle
        polygon!(d, [(100, 300), (400, 300), (400, 100)], stroke="black", fill="none", stroke_width=2)
        right_angle!(d, (400, 300), (100, 300), (400, 100), size=20)
        
        # Label vertices
        text!(d, "A", 90, 310, font_size=20)
        text!(d, "B", 410, 310, font_size=20)
        text!(d, "C", 410, 90, font_size=20)
        
        # Label sides with values
        segment_label!(d, (400, 300), (400, 100), string(opp), offset=15)
        segment_label!(d, (100, 300), (400, 100), string(hyp), offset=-15)
        
        answer = opp // hyp
        
        problem(
            question="In the right triangle shown, find sin(A). Express your answer as a fraction.",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                "Recall: sin(θ) = opposite/hypotenuse",
                "The side opposite angle A has length $(opp)",
                sol("sin(A) = \\frac{$(opp)}{$(hyp)}")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == "find_cos"
        # ELEMENTARY: Find cos of an angle given sides
        adj = randint(3, 12)
        hyp = randint(adj + 1, 20)
        
        d = DiagramObj(600, 400)
        
        # Draw right triangle
        polygon!(d, [(100, 300), (400, 300), (400, 100)], stroke="black", fill="none", stroke_width=2)
        right_angle!(d, (400, 300), (100, 300), (400, 100), size=20)
        
        # Label vertices
        text!(d, "A", 90, 310, font_size=20)
        text!(d, "B", 410, 310, font_size=20)
        text!(d, "C", 410, 90, font_size=20)
        
        # Label sides with values
        segment_label!(d, (100, 300), (400, 300), string(adj), offset=15)
        segment_label!(d, (100, 300), (400, 100), string(hyp), offset=-15)
        
        answer = adj // hyp
        
        problem(
            question="In the right triangle shown, find cos(A). Express your answer as a fraction.",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                "Recall: cos(θ) = adjacent/hypotenuse",
                "The side adjacent to angle A has length $(adj)",
                sol("cos(A) = \\frac{$(adj)}{$(hyp)}")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == "find_tan"
        # ELEMENTARY: Find tan of an angle given sides
        opp = randint(3, 12)
        adj = randint(3, 12)
        
        d = DiagramObj(600, 400)
        
        # Draw right triangle
        polygon!(d, [(100, 300), (400, 300), (400, 100)], stroke="black", fill="none", stroke_width=2)
        right_angle!(d, (400, 300), (100, 300), (400, 100), size=20)
        
        # Label vertices
        text!(d, "A", 90, 310, font_size=20)
        text!(d, "B", 410, 310, font_size=20)
        text!(d, "C", 410, 90, font_size=20)
        
        # Label sides with values
        segment_label!(d, (100, 300), (400, 300), string(adj), offset=15)
        segment_label!(d, (400, 300), (400, 100), string(opp), offset=15)
        
        answer = opp // adj
        
        problem(
            question="In the right triangle shown, find tan(A). Express your answer as a fraction.",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                "Recall: tan(θ) = opposite/adjacent",
                "The side opposite angle A has length $(opp), adjacent has length $(adj)",
                sol("tan(A) = \\frac{$(opp)}{$(adj)}")
            ),
            image=render(d),
            time=60
        )
        
    else  # simple_ratio
        # FOUNDATIONAL: Identify which ratio represents sin/cos/tan
        ratio_type = choice(["sin", "cos", "tan"])
        
        d = DiagramObj(600, 400)
        
        # Draw right triangle
        polygon!(d, [(100, 300), (400, 300), (400, 100)], stroke="black", fill="none", stroke_width=2)
        right_angle!(d, (400, 300), (100, 300), (400, 100), size=20)
        
        # Label vertices
        text!(d, "θ", 120, 285, font_size=20)
        text!(d, "opp", 420, 200, font_size=16)
        text!(d, "adj", 250, 320, font_size=16)
        text!(d, "hyp", 230, 180, font_size=16)
        
        if ratio_type == "sin"
            answer = "opp/hyp"
            definition = "sin(θ) = opposite/hypotenuse"
        elseif ratio_type == "cos"
            answer = "adj/hyp"
            definition = "cos(θ) = adjacent/hypotenuse"
        else
            answer = "opp/adj"
            definition = "tan(θ) = opposite/adjacent"
        end
        
        problem(
            question="Which ratio represents $(ratio_type)(θ) in the triangle shown? Write your answer as a ratio using the labels shown (e.g., opp/hyp).",
            answer=answer,
            difficulty=(200, 500),
            solution=steps(
                "Recall the definition of $(ratio_type)",
                definition,
                sol("Answer: " * answer)
            ),
            image=render(d),
            time=45
        )
    end
end