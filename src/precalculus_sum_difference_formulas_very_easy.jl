# precalculus - sum_difference_formulas (very_easy)
# Generated: 2026-03-08T20:29:49.156149

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/sum_difference_formulas")
    
    # Choose problem type
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Simple sin(A + B) or sin(A - B) with standard angles
        angle1 = choice([30, 45, 60])
        angle2 = choice([30, 45, 60])
        op = choice(["+", "-"])
        
        if op == "+"
            question_str = "Using the sum formula, find \\sin($(angle1)° + $(angle2)°)"
        else
            question_str = "Using the difference formula, find \\sin($(angle1)° - $(angle2)°)"
        end
        
        # Calculate answer
        if op == "+"
            result_angle = angle1 + angle2
        else
            result_angle = angle1 - angle2
        end
        
        # Map angles to exact values
        exact_values = Dict(
            0 => "0", 15 => "\\frac{\\sqrt{6} - \\sqrt{2}}{4}", 
            30 => "\\frac{1}{2}", 45 => "\\frac{\\sqrt{2}}{2}",
            60 => "\\frac{\\sqrt{3}}{2}", 75 => "\\frac{\\sqrt{6} + \\sqrt{2}}{4}",
            90 => "1", -15 => "\\frac{\\sqrt{2} - \\sqrt{6}}{4}",
            -30 => "-\\frac{1}{2}", 105 => "\\frac{\\sqrt{6} + \\sqrt{2}}{4}"
        )
        
        ans = get(exact_values, result_angle, string(sind(result_angle)))
        
        solution_text = steps(
            "Use the formula: \\sin(A $(op) B) = \\sin A \\cos B $(op) \\cos A \\sin B",
            "Substitute A = $(angle1)°, B = $(angle2)°",
            "Calculate using standard angle values",
            sol("Answer", ans)
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(300, 600),
            solution=solution_text,
            time=90,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Type 2: Simple cos(A + B) or cos(A - B) with standard angles
        angle1 = choice([30, 45, 60])
        angle2 = choice([30, 45, 60])
        op = choice(["+", "-"])
        
        if op == "+"
            question_str = "Using the sum formula, find \\cos($(angle1)° + $(angle2)°)"
        else
            question_str = "Using the difference formula, find \\cos($(angle1)° - $(angle2)°)"
        end
        
        # Calculate answer
        if op == "+"
            result_angle = angle1 + angle2
        else
            result_angle = angle1 - angle2
        end
        
        # Map angles to exact values for cosine
        exact_values = Dict(
            0 => "1", 15 => "\\frac{\\sqrt{6} + \\sqrt{2}}{4}",
            30 => "\\frac{\\sqrt{3}}{2}", 45 => "\\frac{\\sqrt{2}}{2}",
            60 => "\\frac{1}{2}", 75 => "\\frac{\\sqrt{6} - \\sqrt{2}}{4}",
            90 => "0", -15 => "\\frac{\\sqrt{6} + \\sqrt{2}}{4}",
            -30 => "\\frac{\\sqrt{3}}{2}", 105 => "\\frac{\\sqrt{2} - \\sqrt{6}}{4}"
        )
        
        ans = get(exact_values, result_angle, string(cosd(result_angle)))
        
        solution_text = steps(
            "Use the formula: \\cos(A $(op) B) = \\cos A \\cos B $( op == "+" ? "-" : "+") \\sin A \\sin B",
            "Substitute A = $(angle1)°, B = $(angle2)°",
            "Calculate using standard angle values",
            sol("Answer", ans)
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(300, 600),
            solution=solution_text,
            time=90,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Type 3: Identify which formula to use
        angle1 = choice([30, 45, 60])
        angle2 = choice([30, 45, 60])
        op = choice(["+", "-"])
        func = choice(["sin", "cos"])
        
        question_str = "Which formula should be used to expand \\\$(func)($(angle1)° $(op) $(angle2)°)?"
        
        if func == "sin"
            if op == "+"
                ans = "\\sin A \\cos B + \\cos A \\sin B"
            else
                ans = "\\sin A \\cos B - \\cos A \\sin B"
            end
        else
            if op == "+"
                ans = "\\cos A \\cos B - \\sin A \\sin B"
            else
                ans = "\\cos A \\cos B + \\sin A \\sin B"
            end
        end
        
        solution_text = steps(
            "Identify the function: $(func)",
            "Identify the operation: $(op)",
            "Apply the appropriate $(func) $(op == "+" ? "sum" : "difference") formula",
            sol("Answer", ans)
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(200, 500),
            solution=solution_text,
            time=60,
            calculator="none"
        )
        
    else
        # Type 4: Fill in the blank in a formula
        func = choice(["sin", "cos"])
        op = choice(["+", "-"])
        
        if func == "sin" && op == "+"
            question_str = "Complete the sum formula: \\sin(A + B) = \\sin A \\cos B + \\underline{\\hspace{2cm}}"
            ans = "\\cos A \\sin B"
        elseif func == "sin" && op == "-"
            question_str = "Complete the difference formula: \\sin(A - B) = \\sin A \\cos B - \\underline{\\hspace{2cm}}"
            ans = "\\cos A \\sin B"
        elseif func == "cos" && op == "+"
            question_str = "Complete the sum formula: \\cos(A + B) = \\cos A \\cos B - \\underline{\\hspace{2cm}}"
            ans = "\\sin A \\sin B"
        else
            question_str = "Complete the difference formula: \\cos(A - B) = \\cos A \\cos B + \\underline{\\hspace{2cm}}"
            ans = "\\sin A \\sin B"
        end
        
        solution_text = steps(
            "Recall the $(func) $(op == "+" ? "sum" : "difference") formula",
            "Identify the missing term",
            sol("Answer", ans)
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(150, 400),
            solution=solution_text,
            time=45,
            calculator="none"
        )
    end
end