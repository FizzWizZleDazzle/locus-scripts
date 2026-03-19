# calculus - integration_by_parts (hard)
# Generated: 2026-03-08T20:46:38.442870

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/integration_by_parts")
    
    # Choose problem type randomly
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Type 1: ∫ x^n * e^(ax) dx
        n = randint(1, 3)
        a = nonzero(-3, 3)
        
        integrand = x^n * exp(a*x)
        
        # Build answer by integration by parts repeatedly
        # For ∫ x^n e^(ax) dx, we get (1/a)[x^n e^(ax) - n∫x^(n-1)e^(ax)dx]
        if n == 1
            antideriv = (1//a) * (x * exp(a*x) - (1//a) * exp(a*x))
        elseif n == 2
            antideriv = (1//a) * (x^2 * exp(a*x) - (2//a) * (x * exp(a*x) - (1//a) * exp(a*x)))
        else  # n == 3
            antideriv = (1//a) * (x^3 * exp(a*x) - (3//a) * (x^2 * exp(a*x) - (2//a) * (x * exp(a*x) - (1//a) * exp(a*x))))
        end
        
        antideriv = simplify(expand(antideriv))
        
        solution_text = steps(
            sol("Given", integrand),
            "Use integration by parts with u = \$$(tex(x^n))\$, dv = \$$(tex(exp(a*x)))dx\$",
            "Then du = \$$(tex(diff(x^n, x)))dx\$, v = \$$(tex(simplify(exp(a*x)/a)))\$",
            n > 1 ? "Apply integration by parts $(n) times" : "Apply integration by parts formula",
            sol("Answer (plus C)", antideriv)
        )
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(1800, 2100),
            solution=solution_text,
            time=240,
            grading_mode="symbolic"
        )
        
    elseif problem_type == 2
        # Type 2: ∫ x^n * ln(x) dx
        n = randint(1, 4)
        
        integrand = x^n * log(x)
        
        # ∫ x^n ln(x) dx = x^(n+1)/(n+1) * ln(x) - x^(n+1)/(n+1)^2
        antideriv = (x^(n+1) / (n+1)) * log(x) - x^(n+1) / (n+1)^2
        antideriv = simplify(antideriv)
        
        solution_text = steps(
            sol("Given", integrand),
            "Use integration by parts with u = \$\\ln(x)\$, dv = \$$(tex(x^n))dx\$",
            "Then du = \$\\frac{1}{x}dx\$, v = \$$(tex(x^(n+1)/(n+1)))\$",
            "Apply formula: uv - ∫v du",
            sol("Answer (plus C)", antideriv)
        )
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(1900, 2200),
            solution=solution_text,
            time=210,
            grading_mode="symbolic"
        )
        
    elseif problem_type == 3
        # Type 3: ∫ x^n * sin(ax) or cos(ax) dx
        n = randint(1, 2)
        a = nonzero(-4, 4)
        use_sin = choice([true, false])
        
        if use_sin
            trig_part = sin(a*x)
            if n == 1
                antideriv = -(x/a) * cos(a*x) + (1/a^2) * sin(a*x)
            else  # n == 2
                antideriv = -(x^2/a) * cos(a*x) + (2*x/a^2) * sin(a*x) + (2/a^3) * cos(a*x)
            end
        else
            trig_part = cos(a*x)
            if n == 1
                antideriv = (x/a) * sin(a*x) + (1/a^2) * cos(a*x)
            else  # n == 2
                antideriv = (x^2/a) * sin(a*x) + (2*x/a^2) * cos(a*x) - (2/a^3) * sin(a*x)
            end
        end
        
        integrand = x^n * trig_part
        antideriv = simplify(antideriv)
        
        solution_text = steps(
            sol("Given", integrand),
            "Use integration by parts with u = \$$(tex(x^n))\$, dv = \$$(tex(trig_part))dx\$",
            n == 2 ? "Apply integration by parts twice" : "Apply integration by parts once",
            "Simplify the result",
            sol("Answer (plus C)", antideriv)
        )
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(1900, 2300),
            solution=solution_text,
            time=270,
            grading_mode="symbolic"
        )
        
    elseif problem_type == 4
        # Type 4: ∫ e^(ax) * sin(bx) or cos(bx) dx (requires two applications)
        a = nonzero(-3, 3)
        b = nonzero(-4, 4)
        use_sin = choice([true, false])
        
        if use_sin
            integrand = exp(a*x) * sin(b*x)
            # Result: e^(ax)[a*sin(bx) - b*cos(bx)] / (a^2 + b^2)
            antideriv = exp(a*x) * (a*sin(b*x) - b*cos(b*x)) / (a^2 + b^2)
        else
            integrand = exp(a*x) * cos(b*x)
            # Result: e^(ax)[a*cos(bx) + b*sin(bx)] / (a^2 + b^2)
            antideriv = exp(a*x) * (a*cos(b*x) + b*sin(b*x)) / (a^2 + b^2)
        end
        
        antideriv = simplify(antideriv)
        
        solution_text = steps(
            sol("Given", integrand),
            "Use integration by parts twice with u = \$e^{$(a)x}\$ first, then u = \$$(tex(use_sin ? sin(b*x) : cos(b*x)))\$",
            "After two applications, solve for the original integral",
            "Combine terms and simplify",
            sol("Answer (plus C)", antideriv)
        )
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(2100, 2500),
            solution=solution_text,
            time=300,
            grading_mode="symbolic"
        )
        
    else  # problem_type == 5
        # Type 5: Definite integral requiring parts
        n = randint(1, 2)
        a = nonzero(-2, 2)
        lower = 0
        upper = choice([1, 2])
        
        integrand = x^n * exp(a*x)
        
        # Compute antiderivative
        if n == 1
            antideriv = (1//a) * (x * exp(a*x) - (1//a) * exp(a*x))
        else  # n == 2
            antideriv = (1//a) * (x^2 * exp(a*x) - (2//a) * (x * exp(a*x) - (1//a) * exp(a*x)))
        end
        
        # Evaluate definite integral
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        answer = simplify(upper_val - lower_val)
        
        solution_text = steps(
            sol("Given", integrand),
            "Use integration by parts with u = \$$(tex(x^n))\$, dv = \$$(tex(exp(a*x)))dx\$",
            n == 2 ? "Apply integration by parts twice" : "Apply integration by parts once",
            sol("Antiderivative", antideriv),
            "Evaluate from $(lower) to $(upper): [$(tex(upper_val))] - [$(tex(lower_val))]",
            sol("Answer", answer)
        )
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} $(tex(integrand)) \\, dx",
            answer=answer,
            difficulty=(2000, 2400),
            solution=solution_text,
            time=270,
            grading_mode="symbolic"
        )
    end
end