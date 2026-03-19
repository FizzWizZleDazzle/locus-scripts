# calculus - integration_by_parts (very_easy)
# Generated: 2026-03-08T20:45:58.449547

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/integration_by_parts")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we need very simple integration by parts
    # At this level, students are just learning the formula and applying it to basic cases
    
    prob_type = rand(1:3)
    
    if prob_type == 1
        # Type 1: ∫ x * e^x dx (simplest possible)
        # ELO 400-600: recognize the formula, one clear application
        
        problem(
            question="Use integration by parts to evaluate \\(\\int x e^x \\, dx\\). Choose \\(u = x\\) and \\(dv = e^x \\, dx\\).",
            answer="x*exp(x) - exp(x) + C",
            difficulty=(400, 600),
            solution=steps(
                "Given: \\(\\int x e^x \\, dx\\)",
                "Let \\(u = x\\), so \\(du = dx\\)<br>Let \\(dv = e^x \\, dx\\), so \\(v = e^x\\)",
                "Integration by parts formula: \\(\\int u \\, dv = uv - \\int v \\, du\\)",
                "Substitute: \\(xe^x - \\int e^x \\, dx\\)",
                "Evaluate: \\(xe^x - e^x + C\\)"
            ),
            time=120,
            calculator="none"
        )
        
    elseif prob_type == 2
        # Type 2: Identify u and dv correctly (recognition problem)
        # ELO 200-400: pure recognition, no computation
        
        funcs = [
            ("x \\sin(x)", "x", "\\sin(x) \\, dx"),
            ("x \\cos(x)", "x", "\\cos(x) \\, dx"),
            ("x e^{2x}", "x", "e^{2x} \\, dx"),
            ("x^2 e^x", "x^2", "e^x \\, dx")
        ]
        
        selected = rand(funcs)
        integral_expr, correct_u, correct_dv = selected
        
        problem(
            question="For the integral \\(\\int $(integral_expr) \\, dx\\), which choice for \\(u\\) is best when using integration by parts?",
            answer=correct_u,
            difficulty=(200, 400),
            solution=steps(
                "Integration by parts: \\(\\int u \\, dv = uv - \\int v \\, du\\)",
                "We want \\(du\\) to be simpler than \\(u\\)",
                "For \\(\\int $(integral_expr) \\, dx\\), choose \\(u = $(correct_u)\\)",
                "This makes \\(du\\) simpler (lower degree or same complexity)"
            ),
            time=60,
            calculator="none"
        )
        
    else
        # Type 3: State the integration by parts formula (pure recall)
        # ELO 100-300: recognition and recall
        
        problem(
            question="State the integration by parts formula. (Write your answer as an equation involving \\(\\int u \\, dv\\))",
            answer="∫u*dv = u*v - ∫v*du",
            difficulty=(100, 300),
            solution=steps(
                "The integration by parts formula is derived from the product rule",
                "Product rule: \\(\\frac{d}{dx}[uv] = u\\frac{dv}{dx} + v\\frac{du}{dx}\\)",
                "Integrating both sides and rearranging gives:",
                "\\(\\int u \\, dv = uv - \\int v \\, du\\)"
            ),
            time=45,
            calculator="none"
        )
    end
end