# precalculus - inverse_trig_functions (very_easy)
# Generated: 2026-03-08T20:30:48.183690

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/inverse_trig_functions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Evaluate arcsin of simple values
        values = [(-1, -90), (-1//2, -30), (0, 0), (1//2, 30), (1, 90)]
        val, ans_deg = choice(values)
        
        problem(
            question="Evaluate \\\$\\arcsin($(val))\\\$ in degrees.",
            answer=ans_deg,
            difficulty=(200, 400),
            solution=steps(
                "Recall that \\\$\\arcsin(x)\\\$ returns the angle whose sine equals \\\$x\\\$",
                "The range of \\\$\\arcsin\\\$ is \\\$[-90°, 90°]\\\$",
                sol("Answer", "$(ans_deg)°")
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Evaluate arccos of simple values
        values = [(-1, 180), (-1//2, 120), (0, 90), (1//2, 60), (1, 0)]
        val, ans_deg = choice(values)
        
        problem(
            question="Evaluate \\\$\\arccos($(val))\\\$ in degrees.",
            answer=ans_deg,
            difficulty=(200, 400),
            solution=steps(
                "Recall that \\\$\\arccos(x)\\\$ returns the angle whose cosine equals \\\$x\\\$",
                "The range of \\\$\\arccos\\\$ is \\\$[0°, 180°]\\\$",
                sol("Answer", "$(ans_deg)°")
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Evaluate arctan of simple values
        values = [(-1, -45), (0, 0), (1, 45)]
        val, ans_deg = choice(values)
        
        problem(
            question="Evaluate \\\$\\arctan($(val))\\\$ in degrees.",
            answer=ans_deg,
            difficulty=(200, 400),
            solution=steps(
                "Recall that \\\$\\arctan(x)\\\$ returns the angle whose tangent equals \\\$x\\\$",
                "The range of \\\$\\arctan\\\$ is \\\$(-90°, 90°)\\\$",
                sol("Answer", "$(ans_deg)°")
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Simple composition: sin(arcsin(x))
        val = randint(-10, 10) // randint(2, 12)
        if abs(val) <= 1
            ans = val
            
            problem(
                question="Evaluate \\\$\\sin(\\arcsin($(val)))\\\$.",
                answer=ans,
                difficulty=(400, 600),
                solution=steps(
                    "Recognize that \\\$\\sin(\\arcsin(x)) = x\\\$ for \\\$x \\in [-1, 1]\\\$",
                    "Since \\\$|$(val)| \\leq 1\\\$, the identity applies",
                    sol("Answer", ans)
                ),
                time=60
            )
        else
            # Regenerate with valid range
            val = randint(-8, 8) // 10
            ans = val
            
            problem(
                question="Evaluate \\\$\\sin(\\arcsin($(val)))\\\$.",
                answer=ans,
                difficulty=(400, 600),
                solution=steps(
                    "Recognize that \\\$\\sin(\\arcsin(x)) = x\\\$ for \\\$x \\in [-1, 1]\\\$",
                    "Since \\\$|$(val)| \\leq 1\\\$, the identity applies",
                    sol("Answer", ans)
                ),
                time=60
            )
        end
        
    elseif problem_type == 5
        # Simple composition: cos(arccos(x))
        val = randint(-8, 8) // 10
        ans = val
        
        problem(
            question="Evaluate \\\$\\cos(\\arccos($(val)))\\\$.",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Recognize that \\\$\\cos(\\arccos(x)) = x\\\$ for \\\$x \\in [-1, 1]\\\$",
                "Since \\\$|$(val)| \\leq 1\\\$, the identity applies",
                sol("Answer", ans)
            ),
            time=60
        )
        
    else
        # Domain identification
        func_type = rand(1:3)
        
        if func_type == 1
            problem(
                question="What is the domain of \\\$\\arcsin(x)\\\$?",
                answer=fmt_interval(-1, 1, false, false),
                difficulty=(500, 700),
                answer_type="interval",
                solution=steps(
                    "The function \\\$\\arcsin(x)\\\$ is defined when \\\$-1 \\leq x \\leq 1\\\$",
                    "This is because sine values range from \\\$-1\\\$ to \\\$1\\\$",
                    sol("Answer", "\\\$[-1, 1]\\\$")
                ),
                time=60
            )
        elseif func_type == 2
            problem(
                question="What is the range of \\\$\\arcsin(x)\\\$ in degrees?",
                answer=fmt_interval(-90, 90, false, false),
                difficulty=(500, 700),
                answer_type="interval",
                solution=steps(
                    "The range of \\\$\\arcsin(x)\\\$ is the set of output angles",
                    "By definition, \\\$\\arcsin\\\$ returns angles in \\\$[-90°, 90°]\\\$",
                    sol("Answer", "\\\$[-90°, 90°]\\\$")
                ),
                time=60
            )
        else
            problem(
                question="What is the domain of \\\$\\arccos(x)\\\$?",
                answer=fmt_interval(-1, 1, false, false),
                difficulty=(500, 700),
                answer_type="interval",
                solution=steps(
                    "The function \\\$\\arccos(x)\\\$ is defined when \\\$-1 \\leq x \\leq 1\\\$",
                    "This is because cosine values range from \\\$-1\\\$ to \\\$1\\\$",
                    sol("Answer", "\\\$[-1, 1]\\\$")
                ),
                time=60
            )
        end
    end
end