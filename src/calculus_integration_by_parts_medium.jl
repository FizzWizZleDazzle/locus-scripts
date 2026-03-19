# calculus - integration_by_parts (medium)
# Generated: 2026-03-08T20:46:23.998933

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/integration_by_parts")
    
    # Choose problem type randomly
    problem_type = choice(1:5)
    
    if problem_type == 1
        # x * e^(ax) type - DEVELOPING level
        a = nonzero(-3, 3)
        integrand = x * exp(a*x)
        
        # Integration by parts: u = x, dv = e^(ax)dx
        # du = dx, v = (1/a)e^(ax)
        # ∫x*e^(ax)dx = x*(1/a)e^(ax) - ∫(1/a)e^(ax)dx
        # = (x/a)e^(ax) - (1/a²)e^(ax) + C
        # = e^(ax)(x/a - 1/a²) + C
        
        answer = exp(a*x) * (x/a - 1/(a^2))
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=answer,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", integrand),
                "Use integration by parts: Let \\(u = x\\), \\(dv = e^{$(a)x}dx\\)",
                "Then \\(du = dx\\), \\(v = \\frac{1}{$(a)}e^{$(a)x}\\)",
                "Apply formula: \\(\\int u\\,dv = uv - \\int v\\,du\\)",
                sol("Answer", answer, " + C")
            ),
            time=180,
            calculator="none"
        )
        
    elseif problem_type == 2
        # x * sin(ax) or x * cos(ax) - DEVELOPING to COMPETENT
        trig_choice = choice([:sin, :cos])
        a = nonzero(-4, 4)
        
        if trig_choice == :sin
            integrand = x * sin(a*x)
            # u = x, dv = sin(ax)dx
            # du = dx, v = -(1/a)cos(ax)
            # = -(x/a)cos(ax) + (1/a)∫cos(ax)dx
            # = -(x/a)cos(ax) + (1/a²)sin(ax) + C
            answer = -(x/a)*cos(a*x) + (1/(a^2))*sin(a*x)
        else
            integrand = x * cos(a*x)
            # u = x, dv = cos(ax)dx
            # du = dx, v = (1/a)sin(ax)
            # = (x/a)sin(ax) - (1/a)∫sin(ax)dx
            # = (x/a)sin(ax) + (1/a²)cos(ax) + C
            answer = (x/a)*sin(a*x) + (1/(a^2))*cos(a*x)
        end
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=answer,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", integrand),
                "Use integration by parts: Let \\(u = x\\), \\(dv = $(trig_choice)($(a)x)dx\\)",
                "Compute \\(du\\) and \\(v\\), then apply \\(\\int u\\,dv = uv - \\int v\\,du\\)",
                "Integrate the remaining term",
                sol("Answer", answer, " + C")
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 3
        # x^2 * e^x - COMPETENT level
        integrand = x^2 * exp(x)
        
        # First integration by parts: u = x², dv = e^x dx
        # du = 2x dx, v = e^x
        # = x²e^x - 2∫x*e^x dx
        # Second integration by parts on ∫x*e^x: u = x, dv = e^x dx
        # du = dx, v = e^x
        # = x*e^x - e^x
        # Final: x²e^x - 2(x*e^x - e^x) = x²e^x - 2x*e^x + 2e^x = e^x(x² - 2x + 2)
        
        answer = exp(x) * (x^2 - 2*x + 2)
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=answer,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", integrand),
                "First integration by parts: Let \\(u = x^2\\), \\(dv = e^x dx\\)",
                "This gives \\(x^2 e^x - 2\\int x e^x dx\\)",
                "Second integration by parts on \\(\\int x e^x dx\\): Let \\(u = x\\), \\(dv = e^x dx\\)",
                "Combine results: \\(x^2 e^x - 2(x e^x - e^x)\\)",
                sol("Answer", answer, " + C")
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 4
        # ln(x) - classic DEVELOPING level
        integrand = log(x)
        
        # u = ln(x), dv = dx
        # du = (1/x)dx, v = x
        # = x*ln(x) - ∫x*(1/x)dx = x*ln(x) - ∫1 dx = x*ln(x) - x + C
        
        answer = x * log(x) - x
        
        problem(
            question="Evaluate \\int \\ln(x) \\, dx",
            answer=answer,
            difficulty=(1200, 1400),
            solution=steps(
                "Use integration by parts: Let \\(u = \\ln(x)\\), \\(dv = dx\\)",
                "Then \\(du = \\frac{1}{x}dx\\), \\(v = x\\)",
                "Apply formula: \\(x\\ln(x) - \\int x \\cdot \\frac{1}{x} dx = x\\ln(x) - \\int 1 dx\\)",
                sol("Answer", answer, " + C")
            ),
            time=150,
            calculator="none"
        )
        
    else
        # x * ln(x) - COMPETENT level
        integrand = x * log(x)
        
        # u = ln(x), dv = x dx
        # du = (1/x)dx, v = x²/2
        # = (x²/2)*ln(x) - ∫(x²/2)*(1/x)dx
        # = (x²/2)*ln(x) - ∫x/2 dx
        # = (x²/2)*ln(x) - x²/4 + C
        
        answer = (x^2/2) * log(x) - x^2/4
        
        problem(
            question="Evaluate \\int x\\ln(x) \\, dx",
            answer=answer,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", integrand),
                "Use integration by parts: Let \\(u = \\ln(x)\\), \\(dv = x dx\\)",
                "Then \\(du = \\frac{1}{x}dx\\), \\(v = \\frac{x^2}{2}\\)",
                "Apply formula: \\(\\frac{x^2}{2}\\ln(x) - \\int \\frac{x^2}{2} \\cdot \\frac{1}{x} dx\\)",
                "Simplify: \\(\\frac{x^2}{2}\\ln(x) - \\int \\frac{x}{2} dx\\)",
                sol("Answer", answer, " + C")
            ),
            time=210,
            calculator="none"
        )
    end
end