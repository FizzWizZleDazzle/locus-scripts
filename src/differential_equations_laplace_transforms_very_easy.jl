# differential_equations - laplace_transforms (very_easy)
# Generated: 2026-03-08T20:56:04.536587

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script s begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Basic Laplace transform definition recognition
        n = rand(0:3)
        
        question = "What is the Laplace transform of \$t^{$n}\$?"
        answer = "\\frac{$(factorial(n))}{s^{$(n+1)}}"
        
        solution_steps = steps(
            "Recall the Laplace transform definition: \$\\mathcal{L}\\{f(t)\\} = \\int_0^\\infty e^{-st} f(t) \\, dt\$",
            "For \$f(t) = t^{$n}\$, use the formula: \$\\mathcal{L}\\{t^n\\} = \\frac{n!}{s^{n+1}}\$",
            sol("Answer", "\\frac{$(factorial(n))}{s^{$(n+1)}}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(200, 500),
            solution=solution_steps,
            time=45
        )
        
    elseif problem_type == 2
        # Laplace transform of exponential
        a = randint(-5, 5)
        
        if a == 0
            question = "What is the Laplace transform of \$e^{0 \\cdot t} = 1\$?"
            answer = "\\frac{1}{s}"
            explanation = "For a constant function \$f(t) = 1\$"
        else
            question = "What is the Laplace transform of \$e^{$(a)t}\$?"
            answer = "\\frac{1}{s - $(a)}"
            explanation = "For \$f(t) = e^{at}\$"
        end
        
        solution_steps = steps(
            "Recall: \$\\mathcal{L}\\{e^{at}\\} = \\frac{1}{s-a}\$ for \$s > a\$",
            explanation,
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(300, 600),
            solution=solution_steps,
            time=60
        )
        
    elseif problem_type == 3
        # Laplace transform of sine or cosine
        trig_choice = rand(["sin", "cos"])
        omega = nonzero(1, 5)
        
        if trig_choice == "sin"
            question = "What is the Laplace transform of \$\\sin($(omega)t)\$?"
            answer = "\\frac{$(omega)}{s^2 + $(omega^2)}"
            formula = "\\mathcal{L}\\{\\sin(\\omega t)\\} = \\frac{\\omega}{s^2 + \\omega^2}"
        else
            question = "What is the Laplace transform of \$\\cos($(omega)t)\$?"
            answer = "\\frac{s}{s^2 + $(omega^2)}"
            formula = "\\mathcal{L}\\{\\cos(\\omega t)\\} = \\frac{s}{s^2 + \\omega^2}"
        end
        
        solution_steps = steps(
            "Recall the formula: \$$(formula)\$",
            "Here \$\\omega = $(omega)\$",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(400, 700),
            solution=solution_steps,
            time=75
        )
        
    else
        # Linearity property - sum of two simple functions
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        question = "Using linearity of the Laplace transform, find \$\\mathcal{L}\\{$(a) + $(b)t\\}\$"
        answer = "\\frac{$(a)}{s} + \\frac{$(b)}{s^2}"
        
        solution_steps = steps(
            "Use linearity: \$\\mathcal{L}\\{af(t) + bg(t)\\} = a\\mathcal{L}\\{f(t)\\} + b\\mathcal{L}\\{g(t)\\}\$",
            "\$\\mathcal{L}\\{1\\} = \\frac{1}{s}\$ and \$\\mathcal{L}\\{t\\} = \\frac{1}{s^2}\$",
            sol("Answer", "$(a) \\cdot \\frac{1}{s} + $(b) \\cdot \\frac{1}{s^2} = \\frac{$(a)}{s} + \\frac{$(b)}{s^2}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(500, 700),
            solution=solution_steps,
            time=90
        )
    end
end