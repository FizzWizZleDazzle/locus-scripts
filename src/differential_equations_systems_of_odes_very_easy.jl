# differential_equations - systems_of_odes (very_easy)
# Generated: 2026-03-08T20:56:47.684049

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # ELO 200-400: Recognize if a pair of functions is a solution to a simple system
        a = randint(1, 5)
        b = randint(1, 5)
        
        x_sol = "$(a)e^{t}"
        y_sol = "$(b)e^{t}"
        
        is_solution = choice([true, false])
        
        if is_solution
            question = "Is \\(x(t) = $(x_sol)\\) and \\(y(t) = $(y_sol)\\) a solution to the system \\(\\frac{dx}{dt} = x\\) and \\(\\frac{dy}{dt} = y\\)?"
            answer = "Yes"
            solution_text = steps(
                "Compute \\(\\frac{dx}{dt} = $(a)e^{t}\\) and check if it equals \\(x = $(a)e^{t}\\). Yes.",
                "Compute \\(\\frac{dy}{dt} = $(b)e^{t}\\) and check if it equals \\(y = $(b)e^{t}\\). Yes.",
                sol("Answer", "Yes, it is a solution")
            )
        else
            question = "Is \\(x(t) = $(x_sol)\\) and \\(y(t) = $(y_sol)\\) a solution to the system \\(\\frac{dx}{dt} = 2x\\) and \\(\\frac{dy}{dt} = y\\)?"
            answer = "No"
            solution_text = steps(
                "Compute \\(\\frac{dx}{dt} = $(a)e^{t}\\) and check if it equals \\(2x = $(2*a)e^{t}\\). No (unless $(a) = $(2*a)).",
                "Since the first equation fails, the pair is not a solution.",
                sol("Answer", "No")
            )
        end
        
        problem(
            question=question,
            answer=answer,
            difficulty=(150, 350),
            answer_type="text",
            solution=solution_text,
            time=60
        )
        
    elseif problem_type == 2
        # ELO 300-500: Identify the form of a 2x2 system
        a11 = randint(-3, 3)
        a12 = randint(-3, 3)
        a21 = randint(-3, 3)
        a22 = randint(-3, 3)
        
        question = "How many equations are in the system: \\(\\frac{dx}{dt} = $(a11)x + $(a12)y\\), \\(\\frac{dy}{dt} = $(a21)x + $(a22)y\\)?"
        answer = 2
        
        problem(
            question=question,
            answer=answer,
            difficulty=(200, 400),
            solution=steps(
                "Count the number of differential equations in the system.",
                "First equation: \\(\\frac{dx}{dt} = $(a11)x + $(a12)y\\)",
                "Second equation: \\(\\frac{dy}{dt} = $(a21)x + $(a22)y\\)",
                sol("Answer", 2)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # ELO 400-600: Evaluate a solution at a specific time
        a = randint(2, 8)
        t_val = randint(0, 3)
        x_val = a * exp(t_val)
        
        question = "If \\(x(t) = $(a)e^{t}\\) is a solution to \\(\\frac{dx}{dt} = x\\), what is \\(x($(t_val))\\)?"
        answer = round(x_val, digits=2)
        
        problem(
            question=question,
            answer=answer,
            difficulty=(350, 550),
            solution=steps(
                sol("Given", "x(t) = $(a)e^{t}"),
                "Substitute \\(t = $(t_val)\\): \\(x($(t_val)) = $(a)e^{$(t_val)}\\)",
                sol("Answer", "$(round(x_val, digits=2))")
            ),
            time=60,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # ELO 500-700: Verify one equation of a system by differentiation
        a = randint(2, 6)
        b = randint(2, 6)
        
        question = "Given \\(x(t) = $(a)e^{$(b)t}\\), compute \\(\\frac{dx}{dt}\\)."
        answer_expr = "$(a*b)e^{$(b)t}"
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(500, 700),
            answer_type="expression",
            solution=steps(
                sol("Given", "x(t) = $(a)e^{$(b)t}"),
                "Apply the chain rule: \\(\\frac{d}{dt}[e^{$(b)t}] = $(b)e^{$(b)t}\\)",
                sol("Answer", "\\frac{dx}{dt} = $(a*b)e^{$(b)t}")
            ),
            time=75
        )
        
    else
        # ELO 600-700: Check if constants solve a decoupled system
        k1 = randint(2, 5)
        k2 = randint(2, 5)
        c1 = randint(1, 8)
        c2 = randint(1, 8)
        
        question = "Does \\(x(t) = $(c1)e^{$(k1)t}\\) and \\(y(t) = $(c2)e^{$(k2)t}\\) solve the decoupled system \\(\\frac{dx}{dt} = $(k1)x\\), \\(\\frac{dy}{dt} = $(k2)y\\)?"
        answer = "Yes"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(600, 700),
            answer_type="text",
            solution=steps(
                "Check first equation: \\(\\frac{dx}{dt} = $(c1 * k1)e^{$(k1)t} = $(k1) \\cdot $(c1)e^{$(k1)t} = $(k1)x\\). ✓",
                "Check second equation: \\(\\frac{dy}{dt} = $(c2 * k2)e^{$(k2)t} = $(k2) \\cdot $(c2)e^{$(k2)t} = $(k2)y\\). ✓",
                sol("Answer", "Yes")
            ),
            time=90
        )
    end
end