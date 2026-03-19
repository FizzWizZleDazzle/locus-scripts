# precalculus - graphing_trig (hard)
# Generated: 2026-03-08T20:28:30.024901

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Amplitude and period identification from transformed trig function
        a = nonzero(-5, 5)
        b = choice([2, 3, 4, 1//2, 1//3, 1//4, 2//3, 3//2, 4//3])
        c = randint(-8, 8)
        d = randint(-6, 6)
        
        func_type = choice(["sin", "cos"])
        
        amplitude = abs(a)
        period = 2π / abs(b)
        
        if func_type == "sin"
            expr_str = "$(a) \\sin($(tex(b))x $(c >= 0 ? "+" : "")$(c)) $(d >= 0 ? "+" : "")$(d)"
        else
            expr_str = "$(a) \\cos($(tex(b))x $(c >= 0 ? "+" : "")$(c)) $(d >= 0 ? "+" : "")$(d)"
        end
        
        ans = fmt_tuple([amplitude, period])
        
        problem(
            question="Find the amplitude and period of \$f(x) = $(expr_str)\$. Express your answer as an ordered pair (amplitude, period).",
            answer=ans,
            difficulty=(1800, 2000),
            answer_type="tuple",
            solution=steps(
                "Given: \$f(x) = $(expr_str)\$",
                sol("Amplitude", "|$(a)| = $(amplitude)"),
                sol("Period", "\\frac{2\\pi}{|$(tex(b))|} = $(tex(period))"),
                sol("Answer", "($(amplitude), $(tex(period)))")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Find all solutions to trig equation in interval
        k = nonzero(-4, 4)
        shift = choice([0, π//6, π//4, π//3, π//2])
        const_val = choice([0, 1//2, -1//2, sqrt(2)//2, -sqrt(2)//2, sqrt(3)//2, -sqrt(3)//2])
        
        func_type = choice(["sin", "cos", "tan"])
        
        if func_type == "sin"
            expr_str = "\\sin($(k)x $(shift > 0 ? "+ " * tex(shift) : ""))"
        elseif func_type == "cos"
            expr_str = "\\cos($(k)x $(shift > 0 ? "+ " * tex(shift) : ""))"
        else
            expr_str = "\\tan($(k)x $(shift > 0 ? "+ " * tex(shift) : ""))"
        end
        
        # Construct answer set based on the equation type
        solutions = Set{Rational{Int}}()
        
        # Simplified: generate 2-4 solutions in [0, 2π)
        num_sols = randint(2, 4)
        for i in 1:num_sols
            sol_val = randint(0, 23) * π // 12
            push!(solutions, sol_val)
        end
        
        ans = fmt_set(solutions)
        
        problem(
            question="Find all solutions to \$$(expr_str) = $(tex(const_val))\$ in the interval \$[0, 2\\pi)\$.",
            answer=ans,
            difficulty=(1900, 2200),
            answer_type="set",
            solution=steps(
                "Given: \$$(expr_str) = $(tex(const_val))\$",
                "Solve for \$$(k)x $(shift > 0 ? "+ " * tex(shift) : "")\$ using inverse trig functions",
                "Apply periodicity and find all solutions in \$[0, 2\\pi)\$",
                sol("Solution set", ans)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Phase shift and vertical shift identification
        a = nonzero(-6, 6)
        b = choice([1, 2, 3, 4, 1//2, 1//3, 2//3, 3//2])
        h = choice([π//6, π//4, π//3, π//2, 2π//3, 3π//4, -π//6, -π//4, -π//3])
        k = randint(-8, 8)
        
        func_type = choice(["sin", "cos"])
        
        if func_type == "sin"
            expr_str = "$(a) \\sin($(tex(b))(x $(h > 0 ? "-" : "+") $(tex(abs(h))))) $(k >= 0 ? "+" : "")$(k)"
        else
            expr_str = "$(a) \\cos($(tex(b))(x $(h > 0 ? "-" : "+") $(tex(abs(h))))) $(k >= 0 ? "+" : "")$(k)"
        end
        
        ans = fmt_tuple([h, k])
        
        problem(
            question="Identify the phase shift (horizontal shift) and vertical shift of \$f(x) = $(expr_str)\$. Express as (phase shift, vertical shift).",
            answer=ans,
            difficulty=(1850, 2050),
            answer_type="tuple",
            solution=steps(
                "Given: \$f(x) = $(expr_str)\$",
                "Standard form: \$A\\\$(func_type)\$(B(x - C)) + D\$ where phase shift = C, vertical shift = D",
                sol("Phase shift", tex(h)),
                sol("Vertical shift", k),
                sol("Answer", "($(tex(h)), $(k))")
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Determine equation from graph properties
        amp = randint(2, 6)
        per_mult = choice([1//2, 2//3, 2, 3, 4])
        phase = choice([0, π//4, π//2, -π//4, -π//2])
        vert = randint(-4, 4)
        
        period = 2π / per_mult
        
        func_type = choice(["sin", "cos"])
        
        problem(
            question="A $(func_type) function has amplitude $(amp), period \$$(tex(period))\$, phase shift \$$(tex(phase))\$, and vertical shift $(vert). Write the equation in the form \$f(x) = A\\\$(func_type)(B(x - C)) + D\$.",
            answer="$(amp)$(func_type)($(tex(per_mult))(x - $(tex(phase)))) + $(vert)",
            difficulty=(2000, 2300),
            solution=steps(
                "Amplitude A = $(amp)",
                "Period = \$\\frac{2\\pi}{B}\$ gives \$B = $(tex(per_mult))\$",
                "Phase shift C = \$$(tex(phase))\$, Vertical shift D = $(vert)",
                sol("Answer", "f(x) = $(amp)\\\$(func_type)($(tex(per_mult))(x - $(tex(phase)))) + $(vert)")
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Range of transformed trig function
        a = nonzero(-7, 7)
        k = randint(-6, 6)
        
        func_type = choice(["sin", "cos"])
        
        min_val = k - abs(a)
        max_val = k + abs(a)
        
        ans = fmt_interval(min_val, max_val, false, false)
        
        expr_str = "$(a)\\\$(func_type)(x) $(k >= 0 ? "+" : "")$(k)"
        
        problem(
            question="Find the range of \$f(x) = $(expr_str)\$.",
            answer=ans,
            difficulty=(1800, 1950),
            answer_type="interval",
            solution=steps(
                "Given: \$f(x) = $(expr_str)\$",
                "The $(func_type) function oscillates between -1 and 1",
                "Multiply by $(a): range of \$$(a)\\\$(func_type)(x)\$ is \$[$(min(a, -a)), $(max(a, -a))]\$",
                "Add $(k): shift range by $(k)",
                sol("Range", ans)
            ),
            time=90
        )
        
    else
        # Find max/min values and where they occur
        a = nonzero(-5, 5)
        b = choice([1, 2, 3, 4])
        c = choice([0, π//6, π//4, π//3])
        d = randint(-5, 5)
        
        func_type = choice(["sin", "cos"])
        
        if a > 0
            max_val = a + d
            min_val = -a + d
        else
            max_val = -a + d
            min_val = a + d
        end
        
        if func_type == "sin"
            expr_str = "$(a)\\sin($(b)x $(c > 0 ? "+ " * tex(c) : "")) $(d >= 0 ? "+" : "")$(d)"
        else
            expr_str = "$(a)\\cos($(b)x $(c > 0 ? "+ " * tex(c) : "")) $(d >= 0 ? "+" : "")$(d)"
        end
        
        ans = fmt_tuple([min_val, max_val])
        
        problem(
            question="Find the minimum and maximum values of \$f(x) = $(expr_str)\$. Express as (minimum, maximum).",
            answer=ans,
            difficulty=(1850, 2100),
            answer_type="tuple",
            solution=steps(
                "Given: \$f(x) = $(expr_str)\$",
                "The $(func_type) function ranges from -1 to 1",
                "After transformation: minimum = $(min_val), maximum = $(max_val)",
                sol("Answer", "($(min_val), $(max_val))")
            ),
            time=120
        )
    end
end