# precalculus - unit_circle (easy)
# Generated: 2026-03-08T20:27:22.776203

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script θ begin
    set_topic!("precalculus/unit_circle")
    
    # Choose problem type randomly
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find exact trig value at standard angle (700-900 ELO)
        angles_deg = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle = choice(angles_deg)
        func = choice(["sin", "cos", "tan"])
        
        # Calculate exact answer
        angle_rad = angle * π / 180
        if func == "sin"
            if angle == 0 || angle == 180
                ans = 0
            elseif angle == 30 || angle == 150
                ans = 1//2
            elseif angle == 45 || angle == 135
                ans = "\\frac{\\sqrt{2}}{2}"
            elseif angle == 60 || angle == 120
                ans = "\\frac{\\sqrt{3}}{2}"
            elseif angle == 90
                ans = 1
            elseif angle == 210 || angle == 330
                ans = -1//2
            elseif angle == 225 || angle == 315
                ans = "-\\frac{\\sqrt{2}}{2}"
            elseif angle == 240 || angle == 300
                ans = "-\\frac{\\sqrt{3}}{2}"
            elseif angle == 270
                ans = -1
            end
        elseif func == "cos"
            if angle == 0
                ans = 1
            elseif angle == 30 || angle == 330
                ans = "\\frac{\\sqrt{3}}{2}"
            elseif angle == 45 || angle == 315
                ans = "\\frac{\\sqrt{2}}{2}"
            elseif angle == 60 || angle == 300
                ans = 1//2
            elseif angle == 90 || angle == 270
                ans = 0
            elseif angle == 120 || angle == 240
                ans = -1//2
            elseif angle == 135 || angle == 225
                ans = "-\\frac{\\sqrt{2}}{2}"
            elseif angle == 150 || angle == 210
                ans = "-\\frac{\\sqrt{3}}{2}"
            elseif angle == 180
                ans = -1
            end
        else  # tan
            if angle == 0 || angle == 180
                ans = 0
            elseif angle == 30 || angle == 210
                ans = "\\frac{\\sqrt{3}}{3}"
            elseif angle == 45 || angle == 225
                ans = 1
            elseif angle == 60 || angle == 240
                ans = "\\sqrt{3}"
            elseif angle == 120 || angle == 300
                ans = "-\\sqrt{3}"
            elseif angle == 135 || angle == 315
                ans = -1
            elseif angle == 150 || angle == 330
                ans = "-\\frac{\\sqrt{3}}{3}"
            else
                ans = "\\text{undefined}"
            end
        end
        
        problem(
            question="Find the exact value: \\\$\\\$(func)($(angle)^\\circ)\\\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Locate \\\$$(angle)^\\circ\\\$ on the unit circle",
                "Identify the $(func == "sin" ? "y" : func == "cos" ? "x" : "y/x")-coordinate$(func == "tan" ? " ratio" : "")",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Convert between radians and degrees (700-900 ELO)
        direction = choice(["deg_to_rad", "rad_to_deg"])
        
        if direction == "deg_to_rad"
            deg_values = [30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360]
            deg = choice(deg_values)
            
            # Simplify to nice fraction
            if deg == 30
                ans = "\\frac{\\pi}{6}"
            elseif deg == 45
                ans = "\\frac{\\pi}{4}"
            elseif deg == 60
                ans = "\\frac{\\pi}{3}"
            elseif deg == 90
                ans = "\\frac{\\pi}{2}"
            elseif deg == 120
                ans = "\\frac{2\\pi}{3}"
            elseif deg == 135
                ans = "\\frac{3\\pi}{4}"
            elseif deg == 150
                ans = "\\frac{5\\pi}{6}"
            elseif deg == 180
                ans = "\\pi"
            elseif deg == 210
                ans = "\\frac{7\\pi}{6}"
            elseif deg == 225
                ans = "\\frac{5\\pi}{4}"
            elseif deg == 240
                ans = "\\frac{4\\pi}{3}"
            elseif deg == 270
                ans = "\\frac{3\\pi}{2}"
            elseif deg == 300
                ans = "\\frac{5\\pi}{3}"
            elseif deg == 315
                ans = "\\frac{7\\pi}{4}"
            elseif deg == 330
                ans = "\\frac{11\\pi}{6}"
            elseif deg == 360
                ans = "2\\pi"
            end
            
            problem(
                question="Convert \\\$$(deg)^\\circ\\\$ to radians.",
                answer=ans,
                difficulty=(700, 850),
                solution=steps(
                    "Use the conversion: \\\$\\text{radians} = \\text{degrees} \\times \\frac{\\pi}{180}\\\$",
                    "Calculate: \\\$$(deg) \\times \\frac{\\pi}{180}\\\$",
                    sol("Answer", ans)
                ),
                time=60
            )
        else
            rad_values = [(1,6), (1,4), (1,3), (1,2), (2,3), (3,4), (5,6), (1,1), (7,6), (5,4), (4,3), (3,2), (5,3), (7,4), (11,6), (2,1)]
            num, den = choice(rad_values)
            
            deg = 180 * num // den
            
            problem(
                question="Convert \\\$\\frac{$(num)\\pi}{$(den)}\\\$ radians to degrees.",
                answer=deg,
                difficulty=(700, 850),
                solution=steps(
                    "Use the conversion: \\\$\\text{degrees} = \\text{radians} \\times \\frac{180}{\\pi}\\\$",
                    "Calculate: \\\$\\frac{$(num)\\pi}{$(den)} \\times \\frac{180}{\\pi}\\\$",
                    sol("Answer", "$(deg)^\\circ")
                ),
                time=60
            )
        end
        
    elseif problem_type == 3
        # Find angle given trig value (800-1000 ELO)
        func = choice(["sin", "cos"])
        quadrant = choice([1, 2, 3, 4])
        
        ref_angles = [30, 45, 60]
        ref = choice(ref_angles)
        
        if func == "sin"
            if ref == 30
                val = "\\frac{1}{2}"
            elseif ref == 45
                val = "\\frac{\\sqrt{2}}{2}"
            else
                val = "\\frac{\\sqrt{3}}{2}"
            end
            
            if quadrant == 1
                angle = ref
            elseif quadrant == 2
                angle = 180 - ref
            elseif quadrant == 3
                angle = 180 + ref
                val = "-" * val
            else
                angle = 360 - ref
                val = "-" * val
            end
        else  # cos
            if ref == 30
                val = "\\frac{\\sqrt{3}}{2}"
            elseif ref == 45
                val = "\\frac{\\sqrt{2}}{2}"
            else
                val = "\\frac{1}{2}"
            end
            
            if quadrant == 1
                angle = ref
            elseif quadrant == 2
                angle = 180 - ref
                val = "-" * val
            elseif quadrant == 3
                angle = 180 + ref
                val = "-" * val
            else
                angle = 360 - ref
            end
        end
        
        problem(
            question="Find the angle \\\$\\theta\\\$ in \\\$[0^\\circ, 360^\\circ)\\\$ where \\\$\\\$(func)(\\theta) = $(val)\\\$ and \\\$\\theta\\\$ is in quadrant $(quadrant).",
            answer=angle,
            difficulty=(900, 1100),
            solution=steps(
                "Reference angle: \\\$$(ref)^\\circ\\\$ (since \\\$|$(func)(\\theta)| = $(replace(val, "-" => ""))\\\$)",
                "In quadrant $(quadrant), adjust the reference angle",
                sol("Answer", "$(angle)^\\circ")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Find coordinate on unit circle (800-1000 ELO)
        angles_deg = [30, 45, 60, 120, 135, 150, 210, 225, 240, 300, 315, 330]
        angle = choice(angles_deg)
        
        # Calculate coordinates
        if angle == 30
            coords = "\\left(\\frac{\\sqrt{3}}{2}, \\frac{1}{2}\\right)"
        elseif angle == 45
            coords = "\\left(\\frac{\\sqrt{2}}{2}, \\frac{\\sqrt{2}}{2}\\right)"
        elseif angle == 60
            coords = "\\left(\\frac{1}{2}, \\frac{\\sqrt{3}}{2}\\right)"
        elseif angle == 120
            coords = "\\left(-\\frac{1}{2}, \\frac{\\sqrt{3}}{2}\\right)"
        elseif angle == 135
            coords = "\\left(-\\frac{\\sqrt{2}}{2}, \\frac{\\sqrt{2}}{2}\\right)"
        elseif angle == 150
            coords = "\\left(-\\frac{\\sqrt{3}}{2}, \\frac{1}{2}\\right)"
        elseif angle == 210
            coords = "\\left(-\\frac{\\sqrt{3}}{2}, -\\frac{1}{2}\\right)"
        elseif angle == 225
            coords = "\\left(-\\frac{\\sqrt{2}}{2}, -\\frac{\\sqrt{2}}{2}\\right)"
        elseif angle == 240
            coords = "\\left(-\\frac{1}{2}, -\\frac{\\sqrt{3}}{2}\\right)"
        elseif angle == 300
            coords = "\\left(\\frac{1}{2}, -\\frac{\\sqrt{3}}{2}\\right)"
        elseif angle == 315
            coords = "\\left(\\frac{\\sqrt{2}}{2}, -\\frac{\\sqrt{2}}{2}\\right)"
        elseif angle == 330
            coords = "\\left(\\frac{\\sqrt{3}}{2}, -\\frac{1}{2}\\right)"
        end
        
        problem(
            question="Find the coordinates \$(x, y)\\\$ of the point on the unit circle at angle \\\$$(angle)^\\circ\\\$.",
            answer=coords,
            difficulty=(850, 1050),
            solution=steps(
                "On the unit circle, \\\$x = \\cos(\\theta)\\\$ and \\\$y = \\sin(\\theta)\\\$",
                "Calculate \\\$\\cos($(angle)^\\circ)\\\$ and \\\$\\sin($(angle)^\\circ)\\\$",
                sol("Answer", coords)
            ),
            time=75
        )
        
    else  # problem_type == 5
        # Solve simple trig equation (1000-1200 ELO)
        func = choice(["sin", "cos"])
        
        ref_angles = [30, 45, 60]
        ref = choice(ref_angles)
        
        if func == "sin"
            if ref == 30
                val = 1//2
                val_str = "\\frac{1}{2}"
            elseif ref == 45
                val = "sqrt2/2"
                val_str = "\\frac{\\sqrt{2}}{2}"
            else
                val = "sqrt3/2"
                val_str = "\\frac{\\sqrt{3}}{2}"
            end
            
            # sin is positive in Q1 and Q2
            angle1 = ref
            angle2 = 180 - ref
        else  # cos
            if ref == 30
                val = "sqrt3/2"
                val_str = "\\frac{\\sqrt{3}}{2}"
            elseif ref == 45
                val = "sqrt2/2"
                val_str = "\\frac{\\sqrt{2}}{2}"
            else
                val = 1//2
                val_str = "\\frac{1}{2}"
            end
            
            # cos is positive in Q1 and Q4
            angle1 = ref
            angle2 = 360 - ref
        end
        
        ans = fmt_set(Set([angle1, angle2]))
        
        problem(
            question="Solve for \\\$\\theta\\\$ in \\\$[0^\\circ, 360^\\circ)\\\$: \\\$\\\$(func)(\\theta) = $(val_str)\\\$",
            answer=ans,
            difficulty=(1000, 1200),
            answer_type="set",
            solution=steps(
                "Reference angle is \\\$$(ref)^\\circ\\\$",
                "$(func) is positive in $(func == "sin" ? "quadrants I and II" : "quadrants I and IV")",
                "Solutions: \\\$\\theta = $(angle1)^\\circ\\\$ and \\\$\\theta = $(angle2)^\\circ\\\$",
                sol("Answer", "\\{$(angle1)^\\circ, $(angle2)^\\circ\\}")
            ),
            time=120
        )
    end
end