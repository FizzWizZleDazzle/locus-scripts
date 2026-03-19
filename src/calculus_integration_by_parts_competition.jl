# calculus - integration_by_parts (competition)
# Generated: 2026-03-08T20:46:55.023568

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("calculus/integration_by_parts")
    
    # Generate olympiad/research-level integration by parts problems
    # ELO 3500-5000: require multiple applications, creative substitutions, or novel insights
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Multiple applications with logarithmic or inverse trig functions
        # Requires 3+ applications of IBP
        n_val = randint(3, 5)
        coeff = nonzero(-3, 3)
        
        # Problem: ∫ x^n * ln(x) dx or ∫ x^n * arctan(x) dx
        func_choice = rand(1:2)
        if func_choice == 1
            func_name = "\\ln(x)"
            # Answer: x^(n+1)/(n+1) * ln(x) - x^(n+1)/(n+1)^2
            ans_term1 = "\\frac{x^{$(n_val+1)}}{$(n_val+1)} \\ln(x)"
            ans_term2 = "\\frac{x^{$(n_val+1)}}{$((n_val+1)^2)}"
            ans_str = ans_term1 * " - " * ans_term2 * " + C"
        else
            func_name = "\\arctan(x)"
            ans_str = "\\text{Complex expression involving } x^{$(n_val+1)}, \\arctan(x), \\text{ and logarithmic terms} + C"
        end
        
        problem(
            question="Evaluate \\(\\displaystyle \\int x^{$(n_val)} $(func_name) \\, dx\\)",
            answer=ans_str,
            difficulty=(3500, 4000),
            answer_type="expression",
            solution=steps(
                "Set \\(u = $(func_name)\\) and \\(dv = x^{$(n_val)} dx\\)",
                "Then \\(du = $(func_choice == 1 ? "\\frac{1}{x}" : "\\frac{1}{1+x^2}") dx\\) and \\(v = \\frac{x^{$(n_val+1)}}{$(n_val+1)}\\)",
                "Apply integration by parts: \\(\\int u \\, dv = uv - \\int v \\, du\\)",
                "The resulting integral requires $(func_choice == 1 ? "direct evaluation" : "further applications of IBP or reduction formulas")",
                sol("Answer", ans_str)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Reduction formula derivation - recursive integration
        # ∫ sin^n(x) dx or ∫ cos^n(x) dx or ∫ sec^n(x) dx
        n_val = randint(5, 8)
        trig_choice = choice(["\\sin", "\\cos", "\\sec"])
        
        reduction_formula = if trig_choice == "\\sin"
            "I_n = -\\frac{1}{n}$(trig_choice)^{$(n_val-1)}(x)\\cos(x) + \\frac{$(n_val-1)}{$(n_val)} I_{$(n_val-2)}"
        elseif trig_choice == "\\cos"
            "I_n = \\frac{1}{n}$(trig_choice)^{$(n_val-1)}(x)\\sin(x) + \\frac{$(n_val-1)}{$(n_val)} I_{$(n_val-2)}"
        else
            "I_n = \\frac{1}{$(n_val-1)}$(trig_choice)^{$(n_val-2)}(x)\\tan(x) + \\frac{$(n_val-2)}{$(n_val-1)} I_{$(n_val-2)}"
        end
        
        problem(
            question="Derive a reduction formula for \\(I_n = \\displaystyle \\int $(trig_choice)^{$(n_val)}(x) \\, dx\\) and use it to evaluate the integral.",
            answer=reduction_formula,
            difficulty=(3800, 4300),
            answer_type="expression",
            solution=steps(
                "Use integration by parts with \\(u = $(trig_choice)^{$(n_val-1)}(x)\\) and \\(dv = $(trig_choice)(x) dx\\)",
                "Apply IBP formula and use trigonometric identities to express in terms of \\(I_n\\) and \\(I_{n-2}\\)",
                "Solve the resulting equation for \\(I_n\\)",
                "Apply the reduction formula recursively until reaching base cases",
                sol("Reduction formula", reduction_formula)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Integration with exponential and polynomial - requires pattern recognition
        n_val = randint(4, 7)
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        
        # ∫ x^n * e^(ax) dx - requires n applications
        problem(
            question="Evaluate \\(\\displaystyle \\int x^{$(n_val)} e^{$(a)x} \\, dx\\) using integration by parts.",
            answer="\\frac{e^{$(a)x}}{$(a)^{$(n_val+1)}} P_{$(n_val)}(x) + C \\text{ where } P_{$(n_val)} \\text{ is a polynomial of degree $(n_val)}",
            difficulty=(3600, 4100),
            answer_type="expression",
            solution=steps(
                "Apply integration by parts $(n_val) times with \\(u = x^k\\) and \\(dv = e^{$(a)x} dx\\) at each step",
                "Each application reduces the power of \\(x\\) by 1 and introduces a factor of \\(\\frac{1}{$(a)}\\)",
                "The pattern leads to: \\(\\int x^{$(n_val)} e^{$(a)x} dx = \\frac{e^{$(a)x}}{$(a)} \\left( x^{$(n_val)} - \\frac{$(n_val)}{$(a)} x^{$(n_val-1)} + \\cdots \\right) + C\\)",
                "Final answer involves a polynomial of degree $(n_val) multiplied by \\(\\frac{e^{$(a)x}}{$(a)^{$(n_val+1)}}\\)",
                sol("Answer", "\\frac{e^{$(a)x}}{$(a)^{$(n_val+1)}} P_{$(n_val)}(x) + C")
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Definite integral with special limits requiring creative approach
        a = nonzero(2, 8)
        n_val = randint(3, 6)
        
        # ∫₀^π x^n * sin(ax) dx or similar
        problem(
            question="Evaluate \\(\\displaystyle \\int_0^{\\pi} x^{$(n_val)} \\sin($(a)x) \\, dx\\) exactly.",
            answer="\\frac{\\pi^{$(n_val)}}{$(a)^{$(n_val+1)}} \\cdot (\\text{integer combination involving factorials and powers of } $(a))",
            difficulty=(4000, 4500),
            answer_type="expression",
            solution=steps(
                "Apply integration by parts repeatedly with \\(u = x^{$(n_val)}\\) and \\(dv = \\sin($(a)x) dx\\)",
                "After $(n_val) applications, the integral reduces to evaluation at boundaries",
                "Note that \\(\\sin($(a)\\pi) = 0\\) and \\(\\cos($(a)\\pi) = (-1)^{$(a)}\\), simplifying boundary terms",
                "Each IBP introduces alternating signs and factorial-like patterns",
                "The definite integral evaluates to a rational multiple of \\(\\pi^{$(n_val)}\\)",
                sol("Answer", "\\frac{\\pi^{$(n_val)}}{$(a)^{$(n_val+1)}} \\cdot (\\text{specific integer combination})")
            ),
            time=300
        )
        
    else  # problem_type == 5
        # Challenging substitution combined with IBP
        # ∫ arcsin(x) / √(1-x²) dx or ∫ ln(x + √(1+x²)) dx
        func_choice = rand(1:2)
        
        if func_choice == 1
            integrand = "\\frac{\\arcsin(x)}{\\sqrt{1-x^2}}"
            ans = "\\frac{1}{2} (\\arcsin(x))^2 + C"
            hint = "Substitute \\(u = \\arcsin(x)\\), then \\(du = \\frac{1}{\\sqrt{1-x^2}} dx\\)"
        else
            integrand = "\\ln(x + \\sqrt{1+x^2})"
            ans = "x \\ln(x + \\sqrt{1+x^2}) - \\sqrt{1+x^2} + C"
            hint = "Use IBP with \\(u = \\ln(x + \\sqrt{1+x^2})\\) and \\(dv = dx\\), then rationalize"
        end
        
        problem(
            question="Evaluate \\(\\displaystyle \\int $(integrand) \\, dx\\). This requires recognizing a clever substitution or applying IBP with insight.",
            answer=ans,
            difficulty=(3700, 4400),
            answer_type="expression",
            solution=steps(
                hint,
                "After substitution or IBP, the resulting integral simplifies significantly",
                "Use algebraic manipulation and inverse function properties",
                "Combine terms and simplify using hyperbolic or algebraic identities",
                sol("Answer", ans)
            ),
            time=300
        )
    end
end