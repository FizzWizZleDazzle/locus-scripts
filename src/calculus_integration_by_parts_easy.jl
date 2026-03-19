# calculus - integration_by_parts (easy)
# Generated: 2026-03-08T20:46:08.834849

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/integration_by_parts")
    
    # Choose problem type
    problem_type = choice(1:4)
    
    if problem_type == 1
        # ∫ x·e^(ax) dx where a is small integer
        a = nonzero(-3, 3)
        integrand = x * exp(a*x)
        
        # Integration by parts: u = x, dv = e^(ax)dx
        # du = dx, v = (1/a)e^(ax)
        # Answer: (x/a)e^(ax) - (1/a²)e^(ax) + C = e^(ax)(x/a - 1/a²) + C
        
        if a == 1
            answer_expr = expand(x * exp(x) - exp(x))
            answer_str = tex(answer_expr) * " + C"
        elseif a == -1
            answer_expr = expand(-x * exp(-x) - exp(-x))
            answer_str = tex(answer_expr) * " + C"
        else
            answer_str = "\\frac{e^{$(a)x}}{$(a)}(x - \\frac{1}{$(a)}) + C"
        end
        
        problem(
            question = "Evaluate \\\$\\int $(tex(integrand)) \\, dx\\\$",
            answer = answer_str,
            difficulty = (750, 950),
            solution = steps(
                sol("Given", "\\int $(tex(integrand)) \\, dx"),
                "Let \\\$u = x\\\$, \\\$dv = e^{$(a)x}dx\\\$",
                "Then \\\$du = dx\\\$, \\\$v = \\frac{1}{$(a)}e^{$(a)x}\\\$",
                "Apply integration by parts: \\\$\\int u \\, dv = uv - \\int v \\, du\\\$",
                sol("Answer", answer_str)
            ),
            time = 120,
            calculator = "none"
        )
        
    elseif problem_type == 2
        # ∫ x·sin(ax) dx or ∫ x·cos(ax) dx where a is small integer
        a = nonzero(-3, 3)
        trig_choice = choice([:sin, :cos])
        
        if trig_choice == :sin
            integrand = x * sin(a*x)
            # Answer: -(x/a)cos(ax) + (1/a²)sin(ax) + C
            if a == 1
                answer_str = "-x\\cos(x) + \\sin(x) + C"
            elseif a == -1
                answer_str = "x\\cos(x) + \\sin(x) + C"
            else
                answer_str = "-\\frac{x}{$(a)}\\cos($(a)x) + \\frac{1}{$(a^2)}\\sin($(a)x) + C"
            end
            v_expr = "-\\frac{1}{$(a)}\\cos($(a)x)"
        else
            integrand = x * cos(a*x)
            # Answer: (x/a)sin(ax) + (1/a²)cos(ax) + C
            if a == 1
                answer_str = "x\\sin(x) + \\cos(x) + C"
            elseif a == -1
                answer_str = "-x\\sin(x) + \\cos(x) + C"
            else
                answer_str = "\\frac{x}{$(a)}\\sin($(a)x) + \\frac{1}{$(a^2)}\\cos($(a)x) + C"
            end
            v_expr = "\\frac{1}{$(a)}\\sin($(a)x)"
        end
        
        dv_str = trig_choice == :sin ? "\\sin($(a)x)dx" : "\\cos($(a)x)dx"
        
        problem(
            question = "Evaluate \\\$\\int $(tex(integrand)) \\, dx\\\$",
            answer = answer_str,
            difficulty = (800, 1000),
            solution = steps(
                sol("Given", "\\int $(tex(integrand)) \\, dx"),
                "Let \\\$u = x\\\$, \\\$dv = $(dv_str)\\\$",
                "Then \\\$du = dx\\\$, \\\$v = $(v_expr)\\\$",
                "Apply integration by parts formula",
                sol("Answer", answer_str)
            ),
            time = 150,
            calculator = "none"
        )
        
    elseif problem_type == 3
        # ∫ x² e^x dx (requires two applications of IBP)
        integrand = x^2 * exp(x)
        answer_str = "e^{x}(x^2 - 2x + 2) + C"
        
        problem(
            question = "Evaluate \\\$\\int $(tex(integrand)) \\, dx\\\$",
            answer = answer_str,
            difficulty = (950, 1150),
            solution = steps(
                sol("Given", "\\int x^2 e^x \\, dx"),
                "First IBP: Let \\\$u = x^2\\\$, \\\$dv = e^x dx\\\$, so \\\$du = 2x dx\\\$, \\\$v = e^x\\\$",
                "Get \\\$x^2 e^x - \\int 2x e^x \\, dx\\\$",
                "Second IBP on \\\$\\int 2x e^x dx\\\$: Let \\\$u = 2x\\\$, \\\$dv = e^x dx\\\$",
                "This gives \\\$2x e^x - 2e^x\\\$",
                "Combine: \\\$x^2 e^x - 2x e^x + 2e^x + C = e^x(x^2 - 2x + 2) + C\\\$",
                sol("Answer", answer_str)
            ),
            time = 180,
            calculator = "none"
        )
        
    else
        # ∫ ln(x) dx (classic IBP with ln)
        integrand = "\\ln(x)"
        answer_str = "x\\ln(x) - x + C"
        
        problem(
            question = "Evaluate \\\$\\int \\ln(x) \\, dx\\\$",
            answer = answer_str,
            difficulty = (700, 900),
            solution = steps(
                sol("Given", "\\int \\ln(x) \\, dx"),
                "Let \\\$u = \\ln(x)\\\$, \\\$dv = dx\\\$",
                "Then \\\$du = \\frac{1}{x}dx\\\$, \\\$v = x\\\$",
                "Apply IBP: \\\$x\\ln(x) - \\int x \\cdot \\frac{1}{x} \\, dx = x\\ln(x) - \\int 1 \\, dx\\\$",
                sol("Answer", answer_str)
            ),
            time = 120,
            calculator = "none"
        )
    end
end