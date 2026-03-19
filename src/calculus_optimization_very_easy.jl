# calculus - optimization (very_easy)
# Generated: 2026-03-08T20:42:37.914647

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/optimization")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Find critical points of a simple linear function (foundational)
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        expr = a*x + b
        
        problem(
            question="Find all critical points of f(x) = $(tex(expr))",
            answer="none",
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                sol("Given", expr),
                "Take derivative: f'(x) = $(a)",
                "Since f'(x) = $(a) ≠ 0 everywhere, there are no critical points"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Find where derivative equals zero for a quadratic (elementary)
        a = nonzero(-6, 6)
        b = nonzero(-12, 12)
        c = randint(-20, 20)
        expr = a*x^2 + b*x + c
        deriv = 2*a*x + b
        critical = -b // (2*a)
        
        problem(
            question="Find the value of x where f'(x) = 0 for f(x) = $(tex(expr))",
            answer=critical,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", expr),
                sol("Derivative", deriv),
                "Set f'(x) = 0 and solve: $(tex(deriv)) = 0",
                sol("Answer", critical)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Identify max or min from derivative sign (elementary)
        a = choice([-3, -2, -1, 1, 2, 3])
        critical = randint(-8, 8)
        b = -2*a*critical
        c = randint(-15, 15)
        expr = a*x^2 + b*x + c
        
        if a > 0
            ans = "minimum"
        else
            ans = "maximum"
        end
        
        problem(
            question="Does f(x) = $(tex(expr)) have a maximum or minimum at its critical point?",
            answer=ans,
            difficulty=(500, 700),
            answer_type="text",
            solution=steps(
                sol("Given", expr),
                "Take second derivative: f''(x) = $(2*a)",
                "Since f''(x) = $(2*a) $(a > 0 ? "> 0" : "< 0"), the function is $(a > 0 ? "concave up" : "concave down")",
                "Answer: The critical point is a $(ans)"
            ),
            time=75
        )
        
    else
        # Find the y-value at a critical point (elementary)
        a = nonzero(-5, 5)
        critical = randint(-6, 6)
        b = -2*a*critical
        c = randint(-10, 10)
        expr = a*x^2 + b*x + c
        y_val = a*critical^2 + b*critical + c
        
        problem(
            question="Find f($(critical)) where f(x) = $(tex(expr)). (Note: x = $(critical) is a critical point)",
            answer=y_val,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", expr),
                "Substitute x = $(critical) into f(x)",
                "f($(critical)) = $(a)($(critical))² + $(b)($(critical)) + $(c)",
                sol("Answer", y_val)
            ),
            time=60
        )
    end
end