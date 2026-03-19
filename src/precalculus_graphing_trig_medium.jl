# precalculus - graphing_trig (medium)
# Generated: 2026-03-08T20:28:12.767213

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Amplitude and period from y = A*sin(Bx) or y = A*cos(Bx)
        A = nonzero(-5, 5)
        B = nonzero(-4, 4)
        func = choice(["sin", "cos"])
        period = 2π / abs(B)
        
        if func == "sin"
            expr_str = A == 1 ? "\\sin($(B)x)" : A == -1 ? "-\\sin($(B)x)" : "$(A)\\sin($(B)x)"
        else
            expr_str = A == 1 ? "\\cos($(B)x)" : A == -1 ? "-\\cos($(B)x)" : "$(A)\\cos($(B)x)"
        end
        
        question_part = rand(1:2)
        if question_part == 1
            problem(
                question="What is the amplitude of \$y = $(expr_str)\$?",
                answer=abs(A),
                difficulty=(1200, 1400),
                solution=steps(
                    "The function is \$y = $(expr_str)\$",
                    "For \$y = A$(func)(Bx)\$, the amplitude is \$|A|\$",
                    sol("Amplitude", abs(A))
                ),
                time=60
            )
        else
            problem(
                question="What is the period of \$y = $(expr_str)\$?",
                answer=period,
                difficulty=(1200, 1400),
                solution=steps(
                    "The function is \$y = $(expr_str)\$",
                    "For \$y = A$(func)(Bx)\$, the period is \$\\frac{2\\pi}{|B|}\$",
                    sol("Period", "\\frac{2\\pi}{$(abs(B))} = $(tex(period))")
                ),
                time=90
            )
        end
        
    elseif problem_type == 2
        # Phase shift and vertical shift from y = A*sin(B(x-C)) + D
        A = nonzero(-4, 4)
        B = nonzero(-3, 3)
        C = nonzero(-8, 8)
        D = randint(-6, 6)
        func = choice(["sin", "cos"])
        
        phase_shift = C
        vertical_shift = D
        
        if func == "sin"
            if A == 1
                base = "\\sin"
            elseif A == -1
                base = "-\\sin"
            else
                base = "$(A)\\sin"
            end
        else
            if A == 1
                base = "\\cos"
            elseif A == -1
                base = "-\\cos"
            else
                base = "$(A)\\cos"
            end
        end
        
        if C > 0
            shift_str = "$(B)(x - $(C))"
        else
            shift_str = "$(B)(x + $(abs(C)))"
        end
        
        if D > 0
            expr_str = "$(base)($(shift_str)) + $(D)"
        elseif D < 0
            expr_str = "$(base)($(shift_str)) - $(abs(D))"
        else
            expr_str = "$(base)($(shift_str))"
        end
        
        question_part = rand(1:2)
        if question_part == 1
            problem(
                question="What is the phase shift of \$y = $(expr_str)\$?",
                answer=phase_shift,
                difficulty=(1300, 1500),
                solution=steps(
                    "The function is \$y = $(expr_str)\$",
                    "For \$y = A$(func)(B(x - C)) + D\$, the phase shift is \$C\$",
                    sol("Phase shift", phase_shift)
                ),
                time=90
            )
        else
            problem(
                question="What is the vertical shift of \$y = $(expr_str)\$?",
                answer=vertical_shift,
                difficulty=(1300, 1500),
                solution=steps(
                    "The function is \$y = $(expr_str)\$",
                    "For \$y = A$(func)(B(x - C)) + D\$, the vertical shift is \$D\$",
                    sol("Vertical shift", vertical_shift)
                ),
                time=90
            )
        end
        
    elseif problem_type == 3
        # Find equation given amplitude and period
        amp = randint(2, 6)
        B = nonzero(-4, 4)
        period = 2π / abs(B)
        func = choice(["sin", "cos"])
        
        if func == "sin"
            if amp == 1
                answer_str = "\\sin($(B)x)"
            else
                answer_str = "$(amp)\\sin($(B)x)"
            end
        else
            if amp == 1
                answer_str = "\\cos($(B)x)"
            else
                answer_str = "$(amp)\\cos($(B)x)"
            end
        end
        
        problem(
            question="Write an equation of the form \$y = A$(func)(Bx)\$ with amplitude $(amp) and period \$$(tex(period))\$ where \$B > 0\$. Give your answer in the form A*$(func)(B*x).",
            answer=answer_str,
            difficulty=(1400, 1600),
            solution=steps(
                "Amplitude is $(amp), so \$A = $(amp)\$",
                "Period is \$$(tex(period)) = \\frac{2\\pi}{B}\$, so \$B = $(abs(B))\$",
                sol("Equation", "y = $(answer_str)")
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Range of y = A*sin(Bx) + D or y = A*cos(Bx) + D
        A = nonzero(-5, 5)
        B = nonzero(-4, 4)
        D = randint(-8, 8)
        func = choice(["sin", "cos"])
        
        min_val = D - abs(A)
        max_val = D + abs(A)
        
        if func == "sin"
            expr_str = A == 1 ? "\\sin($(B)x)" : A == -1 ? "-\\sin($(B)x)" : "$(A)\\sin($(B)x)"
        else
            expr_str = A == 1 ? "\\cos($(B)x)" : A == -1 ? "-\\cos($(B)x)" : "$(A)\\cos($(B)x)"
        end
        
        if D > 0
            full_expr = "$(expr_str) + $(D)"
        elseif D < 0
            full_expr = "$(expr_str) - $(abs(D))"
        else
            full_expr = expr_str
        end
        
        answer = fmt_interval(min_val, max_val, false, false)
        
        problem(
            question="What is the range of \$y = $(full_expr)\$?",
            answer=answer,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                "The function is \$y = $(full_expr)\$",
                "The range of $(func) is \$[-1, 1]\$",
                "Multiply by \$$(A)\$: \$[$(min(-abs(A), abs(A))), $(max(-abs(A), abs(A)))]\$",
                "Add \$$(D)\$: \$[$(min_val), $(max_val)]\$"
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Identify transformation sequence
        A = nonzero(-4, 4)
        B = choice([2, 3, 4])
        C = nonzero(-6, 6)
        D = nonzero(-5, 5)
        func = choice(["sin", "cos"])
        
        if func == "sin"
            base = A == 1 ? "\\sin" : A == -1 ? "-\\sin" : "$(A)\\sin"
        else
            base = A == 1 ? "\\cos" : A == -1 ? "-\\cos" : "$(A)\\cos"
        end
        
        if C > 0
            shift_str = "$(B)(x - $(C))"
            h_shift = "right"
            h_amount = C
        else
            shift_str = "$(B)(x + $(abs(C)))"
            h_shift = "left"
            h_amount = abs(C)
        end
        
        if D > 0
            expr_str = "$(base)($(shift_str)) + $(D)"
            v_shift = "up"
            v_amount = D
        else
            expr_str = "$(base)($(shift_str)) - $(abs(D))"
            v_shift = "down"
            v_amount = abs(D)
        end
        
        period = 2π / B
        
        problem(
            question="The graph of \$y = $(expr_str)\$ is obtained by applying transformations to \$y = $(func)(x)\$. What is the period of the transformed function?",
            answer=period,
            difficulty=(1400, 1600),
            solution=steps(
                "The function is \$y = $(expr_str)\$",
                "The coefficient of \$x\$ inside the $(func) is \$B = $(B)\$",
                "Period = \$\\frac{2\\pi}{B} = \\frac{2\\pi}{$(B)}\$",
                sol("Period", tex(period))
            ),
            time=120
        )
        
    else
        # Find midline of y = A*sin(Bx) + D
        A = nonzero(-5, 5)
        B = nonzero(-3, 3)
        D = randint(-10, 10)
        func = choice(["sin", "cos"])
        
        if func == "sin"
            expr_str = A == 1 ? "\\sin($(B)x)" : A == -1 ? "-\\sin($(B)x)" : "$(A)\\sin($(B)x)"
        else
            expr_str = A == 1 ? "\\cos($(B)x)" : A == -1 ? "-\\cos($(B)x)" : "$(A)\\cos($(B)x)"
        end
        
        if D > 0
            full_expr = "$(expr_str) + $(D)"
        elseif D < 0
            full_expr = "$(expr_str) - $(abs(D))"
        else
            full_expr = expr_str
        end
        
        problem(
            question="What is the equation of the midline of \$y = $(full_expr)\$?",
            answer="y = $(D)",
            difficulty=(1200, 1400),
            solution=steps(
                "The function is \$y = $(full_expr)\$",
                "For \$y = A$(func)(Bx) + D\$, the midline is \$y = D\$",
                sol("Midline", "y = $(D)")
            ),
            time=75
        )
    end
end