# calculus - implicit_differentiation (very_easy)
# Generated: 2026-03-08T20:40:11.488542

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # ELO 200-400: Recognize implicit vs explicit form
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        expr = a*x + b
        
        problem(
            question="Is the equation \\\$y = $(tex(expr))\\\$ written in implicit or explicit form?",
            answer="explicit",
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                sol("Given equation", y ~ expr),
                "In explicit form, y is isolated on one side: y = f(x)",
                "In implicit form, x and y are mixed together",
                "This equation has y isolated, so it is explicit"
            ),
            time=45
        )
        
    elseif prob_type == 2
        # ELO 300-500: Identify which equation requires implicit differentiation
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        
        choices = [
            "y = $(a)x + $(b)",
            "x^2 + y^2 = $(abs(a*10))",
            "y = $(a)x^2",
            "y = \\frac{1}{x}"
        ]
        
        problem(
            question="Which equation would require implicit differentiation to find dy/dx?<br><br>A) $(choices[1])<br>B) $(choices[2])<br>C) $(choices[3])<br>D) $(choices[4])",
            answer="B",
            difficulty=(300, 500),
            answer_type="text",
            solution=steps(
                "Implicit differentiation is needed when y cannot be easily isolated",
                "Option A, C, D all have y explicitly in terms of x",
                "Option B: \\\$x^2 + y^2 = $(abs(a*10))\\\$ has x and y mixed together",
                "Answer: B"
            ),
            time=60
        )
        
    elseif prob_type == 3
        # ELO 400-600: Basic derivative of y with respect to x
        n = rand(2:4)
        
        problem(
            question="Using implicit differentiation, what is \\frac{d}{dx}[y^{$(n)}]?",
            answer="$(n)y^{$(n-1)}\\frac{dy}{dx}",
            difficulty=(400, 600),
            answer_type="text",
            solution=steps(
                sol("Given", y^n),
                "Apply the chain rule: \\frac{d}{dx}[y^{$(n)}] = $(n)y^{$(n-1)} \\cdot \\frac{dy}{dx}",
                "We multiply by dy/dx because y is a function of x",
                sol("Answer", "$(n)y^{$(n-1)}\\frac{dy}{dx}")
            ),
            time=90
        )
        
    else
        # ELO 500-700: Simple implicit differentiation of x + y = constant
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        
        # x + y = c, so dy/dx = -1
        # ax + by = c, so dy/dx = -a/b
        
        ans_num = -a
        ans_den = b
        
        if ans_den == 1
            ans_str = "$(ans_num)"
        elseif ans_den == -1
            ans_str = "$(-ans_num)"
        else
            ans_str = "\\frac{$(ans_num)}{$(ans_den)}"
        end
        
        problem(
            question="Use implicit differentiation to find \\frac{dy}{dx} for the equation \\\$$(a)x + $(b)y = $(c)\\\$",
            answer=ans_num // ans_den,
            difficulty=(500, 700),
            solution=steps(
                sol("Given equation", a*x + b*y ~ c),
                "Differentiate both sides with respect to x: \\\$$(a) + $(b)\\frac{dy}{dx} = 0\\\$",
                "Solve for dy/dx: \\\$$(b)\\frac{dy}{dx} = $(-a)\\\$",
                sol("Answer", "\\frac{dy}{dx} = $(ans_str)")
            ),
            time=120
        )
    end
end