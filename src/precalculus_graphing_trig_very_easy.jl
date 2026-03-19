# precalculus - graphing_trig (very_easy)
# Generated: 2026-03-08T20:27:51.944149

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Identify amplitude (ELO 200-400)
        a = nonzero(-5, 5)
        func_choice = choice(["sin", "cos"])
        if func_choice == "sin"
            expr_str = a > 0 ? "$(a)\\sin(x)" : "($(a))\\sin(x)"
        else
            expr_str = a > 0 ? "$(a)\\cos(x)" : "($(a))\\cos(x)"
        end
        amp = abs(a)
        
        problem(
            question="What is the amplitude of \\(y = $expr_str\\)?",
            answer=amp,
            difficulty=(200, 400),
            solution=steps(
                "The amplitude is the absolute value of the coefficient in front of the trig function",
                sol("Given", "y = $expr_str"),
                sol("Amplitude", amp)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Identify period (ELO 300-500)
        b = nonzero(-4, 4)
        func_choice = choice(["sin", "cos"])
        period = 2 * π / abs(b)
        
        if func_choice == "sin"
            expr_str = b == 1 ? "\\sin(x)" : (b == -1 ? "\\sin(-x)" : "\\sin($(b)x)")
        else
            expr_str = b == 1 ? "\\cos(x)" : (b == -1 ? "\\cos(-x)" : "\\cos($(b)x)")
        end
        
        if abs(b) == 1
            period_str = "2\\pi"
        elseif abs(b) == 2
            period_str = "\\pi"
        else
            period_str = "\\frac{2\\pi}{$(abs(b))}"
        end
        
        problem(
            question="What is the period of \\(y = $expr_str\\)?",
            answer=period_str,
            difficulty=(300, 500),
            answer_type="expression",
            solution=steps(
                "The period of \\(\\sin(bx)\\) and \\(\\cos(bx)\\) is \\(\\frac{2\\pi}{|b|}\\)",
                sol("Given", "y = $expr_str"),
                sol("Period", period_str)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Identify midline/vertical shift (ELO 250-450)
        k = randint(-8, 8)
        func_choice = choice(["sin", "cos"])
        
        if func_choice == "sin"
            if k >= 0
                expr_str = "\\sin(x) + $k"
            else
                expr_str = "\\sin(x) - $(abs(k))"
            end
        else
            if k >= 0
                expr_str = "\\cos(x) + $k"
            else
                expr_str = "\\cos(x) - $(abs(k))"
            end
        end
        
        problem(
            question="What is the midline (vertical shift) of \\(y = $expr_str\\)?",
            answer=k,
            difficulty=(250, 450),
            solution=steps(
                "The midline is the vertical shift \\(k\\) in \\(y = \\sin(x) + k\\) or \\(y = \\cos(x) + k\\)",
                sol("Given", "y = $expr_str"),
                sol("Midline: y", k)
            ),
            time=40
        )
        
    elseif problem_type == 4
        # Find maximum value (ELO 400-600)
        a = nonzero(-6, 6)
        k = randint(-10, 10)
        func_choice = choice(["sin", "cos"])
        
        max_val = abs(a) + k
        
        if func_choice == "sin"
            if k >= 0
                expr_str = a > 0 ? "$(a)\\sin(x) + $k" : "($(a))\\sin(x) + $k"
            else
                expr_str = a > 0 ? "$(a)\\sin(x) - $(abs(k))" : "($(a))\\sin(x) - $(abs(k))"
            end
        else
            if k >= 0
                expr_str = a > 0 ? "$(a)\\cos(x) + $k" : "($(a))\\cos(x) + $k"
            else
                expr_str = a > 0 ? "$(a)\\cos(x) - $(abs(k))" : "($(a))\\cos(x) - $(abs(k))"
            end
        end
        
        problem(
            question="What is the maximum value of \\(y = $expr_str\\)?",
            answer=max_val,
            difficulty=(400, 600),
            solution=steps(
                "Maximum value = amplitude + midline = \\(|a| + k\\)",
                sol("Amplitude", abs(a)),
                sol("Midline", k),
                sol("Maximum", max_val)
            ),
            time=50
        )
        
    elseif problem_type == 5
        # Find minimum value (ELO 400-600)
        a = nonzero(-6, 6)
        k = randint(-10, 10)
        func_choice = choice(["sin", "cos"])
        
        min_val = -abs(a) + k
        
        if func_choice == "sin"
            if k >= 0
                expr_str = a > 0 ? "$(a)\\sin(x) + $k" : "($(a))\\sin(x) + $k"
            else
                expr_str = a > 0 ? "$(a)\\sin(x) - $(abs(k))" : "($(a))\\sin(x) - $(abs(k))"
            end
        else
            if k >= 0
                expr_str = a > 0 ? "$(a)\\cos(x) + $k" : "($(a))\\cos(x) + $k"
            else
                expr_str = a > 0 ? "$(a)\\cos(x) - $(abs(k))" : "($(a))\\cos(x) - $(abs(k))"
            end
        end
        
        problem(
            question="What is the minimum value of \\(y = $expr_str\\)?",
            answer=min_val,
            difficulty=(400, 600),
            solution=steps(
                "Minimum value = -amplitude + midline = \\(-|a| + k\\)",
                sol("Amplitude", abs(a)),
                sol("Midline", k),
                sol("Minimum", min_val)
            ),
            time=50
        )
        
    else
        # Identify phase shift (ELO 500-700)
        c = nonzero(-8, 8)
        b = nonzero(1, 3)
        func_choice = choice(["sin", "cos"])
        
        phase_shift = -c // b
        
        if func_choice == "sin"
            if c > 0
                expr_str = b == 1 ? "\\sin(x - $c)" : "\\sin($(b)x - $c)"
            else
                expr_str = b == 1 ? "\\sin(x + $(abs(c)))" : "\\sin($(b)x + $(abs(c)))"
            end
        else
            if c > 0
                expr_str = b == 1 ? "\\cos(x - $c)" : "\\cos($(b)x - $c)"
            else
                expr_str = b == 1 ? "\\cos(x + $(abs(c)))" : "\\cos($(b)x + $(abs(c)))"
            end
        end
        
        problem(
            question="What is the phase shift of \\(y = $expr_str\\)?",
            answer=phase_shift,
            difficulty=(500, 700),
            solution=steps(
                "For \\(y = \\sin(bx - c)\\) or \\(y = \\cos(bx - c)\\), phase shift = \\(\\frac{c}{b}\\)",
                "Rewrite in form: $(func_choice)($(b)x - $(c))",
                sol("Phase shift", phase_shift)
            ),
            time=60
        )
    end
end