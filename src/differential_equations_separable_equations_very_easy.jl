# differential_equations - separable_equations (very_easy)
# Generated: 2026-03-08T20:49:22.488565

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: dy/dx = k (constant) - ELO ~200-400
        k = nonzero(-8, 8)
        C = randint(-15, 15)
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} = $(k)\$",
            answer=tex(k*x + C),
            difficulty=(200, 400),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(k)"),
                "Integrate both sides with respect to x",
                sol("Answer", k*x + C),
                "where C is an arbitrary constant"
            ),
            time=45,
        )
        
    elseif problem_type == 2
        # Type 2: dy/dx = ky (simple exponential) - ELO ~400-600
        k = nonzero(-5, 5)
        C_var = "C"
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} = $(k)y\$",
            answer="Ce^{$(k)x}",
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(k)y"),
                "Separate variables: \$\\frac{dy}{y} = $(k)dx\$",
                "Integrate both sides: \$\\ln|y| = $(k)x + C_1\$",
                sol("Answer", "y = Ce^{$(k)x}"),
                "where C is an arbitrary constant"
            ),
            time=60,
        )
        
    elseif problem_type == 3
        # Type 3: Recognize if equation is separable - ELO ~300-500
        is_separable = rand([true, false])
        
        if is_separable
            a = nonzero(-6, 6)
            b = nonzero(-6, 6)
            eq_str = "\\frac{dy}{dx} = $(a)x + $(b)"
            ans = "Yes"
            explanation = "can be written as dy = ($(a)x + $(b))dx"
        else
            eq_str = "\\frac{dy}{dx} = xy + y^2"
            ans = "No"
            explanation = "cannot be written in the form g(y)dy = h(x)dx"
        end
        
        problem(
            question="Is the differential equation \$$(eq_str)\$ separable? Answer Yes or No.",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", eq_str),
                "Check if we can separate variables",
                "The equation $(explanation)",
                sol("Answer", ans)
            ),
            time=30,
        )
        
    else
        # Type 4: dy/dx = f(x) with polynomial - ELO ~500-700
        q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-10,10))
        integral_expr = expand(q.a*x^3//3 + q.b*x^2//2 + q.c*x)
        C_sym = "C"
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} = $(tex(q.expr))\$",
            answer=tex(integral_expr) * " + C",
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(tex(q.expr))"),
                "Integrate both sides with respect to x",
                "Apply power rule: \$\\int x^n dx = \\frac{x^{n+1}}{n+1} + C\$",
                sol("Answer", tex(integral_expr) * " + C"),
                "where C is an arbitrary constant"
            ),
            time=75,
        )
    end
end