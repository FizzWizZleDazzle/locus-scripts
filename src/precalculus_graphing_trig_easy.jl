# precalculus - graphing_trig (easy)
# Generated: 2026-03-08T20:28:06.627028

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = choice([
        :amplitude_period,
        :phase_shift,
        :vertical_shift,
        :identify_params,
        :write_equation,
        :domain_range
    ])
    
    if problem_type == :amplitude_period
        # Given equation, find amplitude and period
        func = choice([:sin, :cos])
        A = nonzero(-5, 5)
        B = nonzero(-4, 4)
        C = randint(-8, 8)
        D = randint(-6, 6)
        
        if func == :sin
            expr = A * sin(B * x + C) + D
            func_name = "\\sin"
        else
            expr = A * cos(B * x + C) + D
            func_name = "\\cos"
        end
        
        amplitude = abs(A)
        period = abs(2π / B)
        
        question = "Find the amplitude and period of \\\$f(x) = $(tex(expr))\\\$. Give your answer as an ordered pair (amplitude, period). Express the period as a multiple of π if applicable."
        
        # Format period nicely
        if period == π
            period_str = "\\pi"
        elseif period == 2π
            period_str = "2\\pi"
        elseif denominator(rationalize(period / π)) in [1, 2, 3, 4, 6, 8]
            rat = rationalize(period / π)
            if numerator(rat) == 1
                period_str = "\\frac{\\pi}{$(denominator(rat))}"
            else
                period_str = "\\frac{$(numerator(rat))\\pi}{$(denominator(rat))}"
            end
        else
            period_str = "$(period)"
        end
        
        answer = fmt_tuple([amplitude, period])
        
        problem(
            question=question,
            answer=answer,
            difficulty=(800, 1000),
            answer_type="tuple",
            solution=steps(
                sol("Given", expr),
                "Amplitude = |A| = |$(A)| = $(amplitude)",
                "Period = \\frac{2\\pi}{|B|} = \\frac{2\\pi}{|$(B)|} = $(period_str)",
                sol("Answer", fmt_tuple([amplitude, period_str]))
            ),
            time=90
        )
        
    elseif problem_type == :phase_shift
        # Find phase shift and vertical shift
        func = choice([:sin, :cos])
        A = nonzero(-4, 4)
        B = nonzero(-3, 3)
        C = nonzero(-12, 12)
        D = nonzero(-8, 8)
        
        if func == :sin
            expr = A * sin(B * x + C) + D
            func_name = "\\sin"
        else
            expr = A * cos(B * x + C) + D
            func_name = "\\cos"
        end
        
        phase_shift = -C / B
        vertical_shift = D
        
        question = "Find the phase shift and vertical shift of \\\$f(x) = $(tex(expr))\\\$. Give your answer as an ordered pair (phase shift, vertical shift)."
        
        answer = fmt_tuple([phase_shift, vertical_shift])
        
        problem(
            question=question,
            answer=answer,
            difficulty=(850, 1050),
            answer_type="tuple",
            solution=steps(
                sol("Given", expr),
                "Phase shift = -\\frac{C}{B} = -\\frac{$(C)}{$(B)} = $(phase_shift)",
                "Vertical shift = D = $(D)",
                sol("Answer", fmt_tuple([phase_shift, vertical_shift]))
            ),
            time=90
        )
        
    elseif problem_type == :vertical_shift
        # Simple: find max and min values
        func = choice([:sin, :cos])
        A = nonzero(-6, 6)
        B = nonzero(-3, 3)
        D = randint(-10, 10)
        
        if func == :sin
            expr = A * sin(B * x) + D
        else
            expr = A * cos(B * x) + D
        end
        
        max_val = D + abs(A)
        min_val = D - abs(A)
        
        question = "Find the maximum and minimum values of \\\$f(x) = $(tex(expr))\\\$. Give your answer as an ordered pair (maximum, minimum)."
        
        answer = fmt_tuple([max_val, min_val])
        
        problem(
            question=question,
            answer=answer,
            difficulty=(750, 950),
            answer_type="tuple",
            solution=steps(
                sol("Given", expr),
                "Amplitude = |$(A)| = $(abs(A)), Vertical shift = $(D)",
                "Maximum = $(D) + $(abs(A)) = $(max_val)",
                "Minimum = $(D) - $(abs(A)) = $(min_val)",
                sol("Answer", fmt_tuple([max_val, min_val]))
            ),
            time=75
        )
        
    elseif problem_type == :identify_params
        # Given description, identify A, B, C, D
        func = choice([:sin, :cos])
        A = nonzero(-5, 5)
        period_denom = choice([1, 2, 3, 4, 6])
        B = 2 * period_denom
        D = nonzero(-7, 7)
        
        if func == :sin
            func_name = "sine"
            func_tex = "\\sin"
        else
            func_name = "cosine"
            func_tex = "\\cos"
        end
        
        period = 2π / abs(B)
        amplitude = abs(A)
        
        question = "A $(func_name) function has amplitude $(amplitude), period \\(\\frac{\\pi}{$(period_denom)}\\), and vertical shift $(D). Write the function in the form \\\$f(x) = A$(func_tex)(Bx) + D\\\$ where A > 0."
        
        answer = abs(A) * (func == :sin ? sin(B * x) : cos(B * x)) + D
        
        problem(
            question=question,
            answer=answer,
            difficulty=(900, 1100),
            solution=steps(
                "Amplitude = |A| = $(amplitude), so A = $(abs(A))",
                "Period = \\frac{2\\pi}{|B|} = \\frac{\\pi}{$(period_denom)}, so B = $(B)",
                "Vertical shift D = $(D)",
                sol("Answer", answer)
            ),
            time=120
        )
        
    elseif problem_type == :write_equation
        # Given graph description with key points
        func = choice([:sin, :cos])
        A = choice([2, 3, 4, 5])
        D = randint(-5, 5)
        period_mult = choice([1, 2, 4])
        B = period_mult
        
        max_val = D + A
        min_val = D - A
        period = 2π / B
        
        if func == :sin
            func_name = "sine"
            func_tex = "\\sin"
            answer = A * sin(B * x) + D
        else
            func_name = "cosine"
            func_tex = "\\cos"
            answer = A * cos(B * x) + D
        end
        
        if period == π
            period_str = "\\pi"
        elseif period == 2π
            period_str = "2\\pi"
        else
            period_str = "\\frac{2\\pi}{$(B)}"
        end
        
        question = "A $(func_name) curve has maximum value $(max_val), minimum value $(min_val), and period $(period_str). Write an equation of the form \\\$f(x) = A$(func_tex)(Bx) + D\\\$ with A > 0."
        
        problem(
            question=question,
            answer=answer,
            difficulty=(950, 1150),
            solution=steps(
                "Amplitude A = \\frac{\\text{max} - \\text{min}}{2} = \\frac{$(max_val) - ($(min_val))}{2} = $(A)",
                "Vertical shift D = \\frac{\\text{max} + \\text{min}}{2} = \\frac{$(max_val) + ($(min_val))}{2} = $(D)",
                "Period = $(period_str) = \\frac{2\\pi}{B}, so B = $(B)",
                sol("Answer", answer)
            ),
            time=150
        )
        
    else  # domain_range
        # Find range of a trig function
        func = choice([:sin, :cos])
        A = nonzero(-5, 5)
        B = nonzero(-3, 3)
        D = randint(-8, 8)
        
        if func == :sin
            expr = A * sin(B * x) + D
        else
            expr = A * cos(B * x) + D
        end
        
        max_val = D + abs(A)
        min_val = D - abs(A)
        
        range_answer = fmt_interval(min_val, max_val, true, true)
        
        question = "Find the range of \\\$f(x) = $(tex(expr))\\\$."
        
        problem(
            question=question,
            answer=range_answer,
            difficulty=(800, 1000),
            answer_type="interval",
            solution=steps(
                sol("Given", expr),
                "The amplitude is |$(A)| = $(abs(A))",
                "Vertical shift is $(D)",
                "Minimum value: $(D) - $(abs(A)) = $(min_val)",
                "Maximum value: $(D) + $(abs(A)) = $(max_val)",
                sol("Range", range_answer)
            ),
            time=90
        )
    end
end