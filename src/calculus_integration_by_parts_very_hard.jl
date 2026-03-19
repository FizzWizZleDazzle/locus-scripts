# calculus - integration_by_parts (very_hard)
# Generated: 2026-03-08T20:46:39.540785

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("calculus/integration_by_parts")
    
    # Competition to Olympiad level integration by parts (2500-3500 ELO)
    # These require multiple applications of IBP, creative substitutions, or reduction formulas
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Multiple IBP applications with polynomial times trig
        # ∫ x^n sin(ax) dx or ∫ x^n cos(ax) dx
        n_val = randint(3, 5)
        a = nonzero(-3, 3)
        trig_choice = rand(["sin", "cos"])
        
        if trig_choice == "sin"
            integrand = x^n_val * sin(a*x)
            question_str = "Evaluate \\int $(tex(integrand)) \\, dx"
        else
            integrand = x^n_val * cos(a*x)
            question_str = "Evaluate \\int $(tex(integrand)) \\, dx"
        end
        
        problem(
            question=question_str,
            answer=integrand,  # Symbolic answer
            difficulty=(2500, 3000),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", integrand),
                "Apply integration by parts repeatedly with u = $(tex(x^n_val)) and dv = $(tex(trig_choice == "sin" ? sin(a*x) : cos(a*x))) dx",
                "Each application reduces the polynomial degree by 1",
                "After $(n_val) applications, obtain the final antiderivative (plus constant C)"
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Type 2: Reduction formula for ∫ x^n e^(ax) dx
        n_val = randint(4, 6)
        a = nonzero(-4, 4)
        
        integrand = x^n_val * exp(a*x)
        question_str = "Evaluate \\int $(tex(integrand)) \\, dx"
        
        problem(
            question=question_str,
            answer=integrand,
            difficulty=(2600, 3200),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", integrand),
                "Use integration by parts with u = $(tex(x^n_val)), dv = $(tex(exp(a*x))) dx",
                "Derive and apply the reduction formula: I_n = \\frac{x^n e^{$(a)x}}{$(a)} - \\frac{$(n_val)}{$(a)} I_{$(n_val-1)}",
                "Recursively compute I_$(n_val-1), I_$(n_val-2), ..., I_0",
                "Combine all terms to get the final answer (plus constant C)"
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Type 3: Logarithmic integrals requiring IBP
        # ∫ x^n ln^m(x) dx
        n_val = randint(2, 4)
        m_val = randint(2, 3)
        
        if m_val == 1
            integrand = x^n_val * log(x)
        else
            integrand = x^n_val * log(x)^m_val
        end
        
        question_str = "Evaluate \\int $(tex(integrand)) \\, dx"
        
        problem(
            question=question_str,
            answer=integrand,
            difficulty=(2700, 3300),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", integrand),
                "Use integration by parts with u = $(tex(log(x)^m_val)), dv = $(tex(x^n_val)) dx",
                "Compute du = $(tex(m_val * log(x)^(m_val-1) / x)) dx, v = $(tex(x^(n_val+1) / (n_val+1)))",
                m_val > 1 ? "Apply IBP again to reduce the power of ln(x)" : "Simplify to obtain final answer",
                "Final answer (plus constant C)"
            ),
            time=270,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Type 4: Products requiring cyclic IBP (e.g., ∫ e^(ax) sin(bx) dx)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        trig_choice = rand(["sin", "cos"])
        
        if trig_choice == "sin"
            integrand = exp(a*x) * sin(b*x)
        else
            integrand = exp(a*x) * cos(b*x)
        end
        
        question_str = "Evaluate \\int $(tex(integrand)) \\, dx"
        
        problem(
            question=question_str,
            answer=integrand,
            difficulty=(2800, 3400),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", integrand),
                "Apply integration by parts twice to create a cyclic equation",
                "First: u = $(tex(trig_choice == "sin" ? sin(b*x) : cos(b*x))), dv = $(tex(exp(a*x))) dx",
                "Second application returns to original integral with coefficient",
                "Solve algebraically: I = ... yields I = \\frac{e^{$(a)x}[$(a)$(trig_choice)($(b)x) - $(b)$(trig_choice == "sin" ? "cos" : "sin")($(b)x)]}{$(a^2 + b^2)} + C"
            ),
            time=300,
            calculator="none"
        )
        
    else  # problem_type == 5
        # Type 5: Inverse trig with polynomial requiring multiple IBP
        # ∫ x^n arctan(ax) dx or ∫ x^n arcsin(ax) dx
        n_val = randint(2, 4)
        a = nonzero(-3, 3)
        inv_trig = rand(["arctan", "arcsin"])
        
        if inv_trig == "arctan"
            integrand = x^n_val * atan(a*x)
            inv_str = "\\arctan($(a)x)"
        else
            integrand = x^n_val * asin(a*x)
            inv_str = "\\arcsin($(a)x)"
        end
        
        question_str = "Evaluate \\int x^{$(n_val)} $(inv_str) \\, dx"
        
        problem(
            question=question_str,
            answer=integrand,
            difficulty=(2900, 3500),
            grading_mode="symbolic",
            solution=steps(
                "Given: \\int x^{$(n_val)} $(inv_str) \\, dx",
                "Use integration by parts with u = $(inv_str), dv = x^{$(n_val)} dx",
                "Compute du and v, then simplify the resulting integral",
                inv_trig == "arctan" ? "The remaining integral may require polynomial long division and partial fractions" : "The remaining integral involves \\sqrt{1-($(a)x)^2} and may require substitution",
                "Combine all terms to obtain the final antiderivative (plus constant C)"
            ),
            time=300,
            calculator="none"
        )
    end
end