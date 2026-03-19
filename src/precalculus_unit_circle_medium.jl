# precalculus - unit_circle (medium)
# Generated: 2026-03-08T20:27:27.689255

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script θ begin
    set_topic!("precalculus/unit_circle")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Find exact trig value at special angle
        angle_deg = choice([30, 45, 60, 120, 135, 150, 210, 225, 240, 300, 315, 330])
        angle_rad = angle_deg * π / 180
        trig_func = choice([:sin, :cos, :tan])
        
        if trig_func == :sin
            if angle_deg == 30 || angle_deg == 150
                ans = 1//2
            elseif angle_deg == 45 || angle_deg == 135
                ans = "\\frac{\\sqrt{2}}{2}"
            elseif angle_deg == 60 || angle_deg == 120
                ans = "\\frac{\\sqrt{3}}{2}"
            elseif angle_deg == 210 || angle_deg == 330
                ans = -1//2
            elseif angle_deg == 225 || angle_deg == 315
                ans = "-\\frac{\\sqrt{2}}{2}"
            elseif angle_deg == 240 || angle_deg == 300
                ans = "-\\frac{\\sqrt{3}}{2}"
            end
            question_text = "Find the exact value of \\sin($(angle_deg)^\\circ)"
        elseif trig_func == :cos
            if angle_deg == 60 || angle_deg == 120
                ans = angle_deg == 60 ? 1//2 : -1//2
            elseif angle_deg == 45 || angle_deg == 135
                ans = angle_deg == 45 ? "\\frac{\\sqrt{2}}{2}" : "-\\frac{\\sqrt{2}}{2}"
            elseif angle_deg == 30 || angle_deg == 150
                ans = angle_deg == 30 ? "\\frac{\\sqrt{3}}{2}" : "-\\frac{\\sqrt{3}}{2}"
            elseif angle_deg == 240 || angle_deg == 300
                ans = angle_deg == 300 ? 1//2 : -1//2
            elseif angle_deg == 225 || angle_deg == 315
                ans = angle_deg == 315 ? "\\frac{\\sqrt{2}}{2}" : "-\\frac{\\sqrt{2}}{2}"
            elseif angle_deg == 210 || angle_deg == 330
                ans = angle_deg == 330 ? "\\frac{\\sqrt{3}}{2}" : "-\\frac{\\sqrt{3}}{2}"
            end
            question_text = "Find the exact value of \\cos($(angle_deg)^\\circ)"
        else
            if angle_deg == 30 || angle_deg == 210
                ans = angle_deg == 30 ? "\\frac{\\sqrt{3}}{3}" : "\\frac{\\sqrt{3}}{3}"
            elseif angle_deg == 45 || angle_deg == 225
                ans = 1
            elseif angle_deg == 60 || angle_deg == 240
                ans = "\\sqrt{3}"
            elseif angle_deg == 120
                ans = "-\\sqrt{3}"
            elseif angle_deg == 135 || angle_deg == 315
                ans = -1
            elseif angle_deg == 150 || angle_deg == 330
                ans = angle_deg == 150 ? "-\\frac{\\sqrt{3}}{3}" : "-\\frac{\\sqrt{3}}{3}"
            elseif angle_deg == 300
                ans = "-\\sqrt{3}"
            end
            question_text = "Find the exact value of \\tan($(angle_deg)^\\circ)"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Convert $(angle_deg)° to radians: \\frac{$(angle_deg)\\pi}{180}",
                "Identify reference angle and quadrant",
                "Apply sign based on quadrant",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Given trig value and quadrant, find angle in [0, 2π)
        quad = choice(1:4)
        ref_angle_deg = choice([30, 45, 60])
        trig_func = choice([:sin, :cos])
        
        if ref_angle_deg == 30
            val_str = "\\frac{1}{2}"
        elseif ref_angle_deg == 45
            val_str = "\\frac{\\sqrt{2}}{2}"
        else
            val_str = "\\frac{\\sqrt{3}}{2}"
        end
        
        if trig_func == :sin
            if quad == 1
                ans_deg = ref_angle_deg
                sign = ""
            elseif quad == 2
                ans_deg = 180 - ref_angle_deg
                sign = ""
            elseif quad == 3
                ans_deg = 180 + ref_angle_deg
                sign = "-"
            else
                ans_deg = 360 - ref_angle_deg
                sign = "-"
            end
            question_text = "Find \\theta in [0, 2\\pi) if \\sin(\\theta) = $(sign)$(val_str) and \\theta is in Quadrant $(quad)"
        else
            if quad == 1
                ans_deg = ref_angle_deg
                sign = ""
            elseif quad == 2
                ans_deg = 180 - ref_angle_deg
                sign = "-"
            elseif quad == 3
                ans_deg = 180 + ref_angle_deg
                sign = "-"
            else
                ans_deg = 360 - ref_angle_deg
                sign = ""
            end
            question_text = "Find \\theta in [0, 2\\pi) if \\cos(\\theta) = $(sign)$(val_str) and \\theta is in Quadrant $(quad)"
        end
        
        ans = "\\frac{$(ans_deg)\\pi}{180}"
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Reference angle has absolute value $(val_str)",
                "Reference angle is $(ref_angle_deg)°",
                "Place in Quadrant $(quad)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Solve trig equation in [0, 2π)
        angle_deg = choice([30, 45, 60, 120, 135, 150])
        trig_func = choice([:sin, :cos])
        
        if trig_func == :sin
            if angle_deg == 30 || angle_deg == 150
                val = 1//2
                sol1_deg = 30
                sol2_deg = 150
            elseif angle_deg == 45 || angle_deg == 135
                val = "\\frac{\\sqrt{2}}{2}"
                sol1_deg = 45
                sol2_deg = 135
            else
                val = "\\frac{\\sqrt{3}}{2}"
                sol1_deg = 60
                sol2_deg = 120
            end
            question_text = "Solve \\sin(\\theta) = $(val) for \\theta in [0, 2\\pi)"
            ans = fmt_set(Set(["\\frac{$(sol1_deg)\\pi}{180}", "\\frac{$(sol2_deg)\\pi}{180}"]))
        else
            if angle_deg == 60 || angle_deg == 120
                val = 1//2
                sol1_deg = 60
                sol2_deg = 300
            elseif angle_deg == 45 || angle_deg == 135
                val = "\\frac{\\sqrt{2}}{2}"
                sol1_deg = 45
                sol2_deg = 315
            else
                val = "\\frac{\\sqrt{3}}{2}"
                sol1_deg = 30
                sol2_deg = 330
            end
            question_text = "Solve \\cos(\\theta) = $(val) for \\theta in [0, 2\\pi)"
            ans = fmt_set(Set(["\\frac{$(sol1_deg)\\pi}{180}", "\\frac{$(sol2_deg)\\pi}{180}"]))
        end
        
        problem(
            question=question_text,
            answer=ans,
            answer_type="set",
            difficulty=(1400, 1600),
            solution=steps(
                "Find reference angle from unit circle values",
                "Determine quadrants where $(trig_func) is positive",
                "Find both solutions in [0, 2\\pi)",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Convert between degrees and radians
        if choice([true, false])
            deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330])
            ans = "\\frac{$(deg)\\pi}{180}"
            question_text = "Convert $(deg)^\\circ to radians in exact form"
            sol_steps = steps(
                "Use conversion: radians = degrees × \\frac{\\pi}{180}",
                "$(deg)^\\circ \\times \\frac{\\pi}{180} = \\frac{$(deg)\\pi}{180}",
                "Simplify the fraction",
                sol("Answer", ans)
            )
        else
            num = choice([1, 2, 3, 4, 5, 7])
            denom = choice([3, 4, 6])
            rad_str = num == 1 ? "\\frac{\\pi}{$(denom)}" : "\\frac{$(num)\\pi}{$(denom)}"
            ans = (num * 180) // denom
            question_text = "Convert $(rad_str) radians to degrees"
            sol_steps = steps(
                "Use conversion: degrees = radians × \\frac{180}{\\pi}",
                "$(rad_str) \\times \\frac{180}{\\pi} = \\frac{$(num) \\times 180}{$(denom)}",
                "Evaluate",
                sol("Answer", ans)
            )
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(1200, 1400),
            solution=sol_steps,
            time=90
        )
        
    elseif problem_type == 5
        # Reference angle problem
        angle_deg = choice([120, 135, 150, 210, 225, 240, 300, 315, 330])
        
        if angle_deg in [120, 150]
            ref = 180 - angle_deg
        elseif angle_deg in [210, 240]
            ref = angle_deg - 180
        else
            ref = 360 - angle_deg
        end
        
        ans = ref
        
        problem(
            question="Find the reference angle for $(angle_deg)^\\circ",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Identify the quadrant: $(angle_deg)° is in Quadrant $( angle_deg <= 180 ? 2 : (angle_deg <= 270 ? 3 : 4))",
                "Use appropriate formula for reference angle",
                "Reference angle = $(ref)°",
                sol("Answer", ans)
            ),
            time=60
        )
        
    else
        # Find coordinates on unit circle
        angle_deg = choice([0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330])
        
        if angle_deg == 0
            x, y = 1, 0
        elseif angle_deg == 30
            x, y = "\\frac{\\sqrt{3}}{2}", "\\frac{1}{2}"
        elseif angle_deg == 45
            x, y = "\\frac{\\sqrt{2}}{2}", "\\frac{\\sqrt{2}}{2}"
        elseif angle_deg == 60
            x, y = "\\frac{1}{2}", "\\frac{\\sqrt{3}}{2}"
        elseif angle_deg == 90
            x, y = 0, 1
        elseif angle_deg == 120
            x, y = "-\\frac{1}{2}", "\\frac{\\sqrt{3}}{2}"
        elseif angle_deg == 135
            x, y = "-\\frac{\\sqrt{2}}{2}", "\\frac{\\sqrt{2}}{2}"
        elseif angle_deg == 150
            x, y = "-\\frac{\\sqrt{3}}{2}", "\\frac{1}{2}"
        elseif angle_deg == 180
            x, y = -1, 0
        elseif angle_deg == 210
            x, y = "-\\frac{\\sqrt{3}}{2}", "-\\frac{1}{2}"
        elseif angle_deg == 225
            x, y = "-\\frac{\\sqrt{2}}{2}", "-\\frac{\\sqrt{2}}{2}"
        elseif angle_deg == 240
            x, y = "-\\frac{1}{2}", "-\\frac{\\sqrt{3}}{2}"
        elseif angle_deg == 270
            x, y = 0, -1
        elseif angle_deg == 300
            x, y = "\\frac{1}{2}", "-\\frac{\\sqrt{3}}{2}"
        elseif angle_deg == 315
            x, y = "\\frac{\\sqrt{2}}{2}", "-\\frac{\\sqrt{2}}{2}"
        else
            x, y = "\\frac{\\sqrt{3}}{2}", "-\\frac{1}{2}"
        end
        
        ans = "($(x), $(y))"
        
        problem(
            question="Find the coordinates (x, y) on the unit circle for the angle $(angle_deg)^\\circ",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Recall that x = \\cos($(angle_deg)°) and y = \\sin($(angle_deg)°)",
                "Find reference angle and determine signs based on quadrant",
                "Evaluate using special angle values",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end