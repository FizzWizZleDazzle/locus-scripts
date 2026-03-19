# multivariable_calculus - lagrange_multipliers (very_easy)
# Generated: 2026-03-08T20:59:55.070765

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we focus on:
    # - Recognizing constraint equations
    # - Computing gradients (basic partial derivatives)
    # - Setting up the Lagrange system (without solving)
    # - Evaluating functions at given points
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 200-400: Identify the constraint equation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-20, 20)
        constraint = a*x + b*y - c
        
        problem(
            question = "In a Lagrange multiplier problem, you want to optimize \$f(x,y)\$ subject to the constraint \$$(tex(a*x + b*y)) = $(c)\$. What is the constraint equation \$g(x,y) = 0\$?",
            answer = constraint,
            difficulty = (200, 400),
            solution = steps(
                "The constraint is given as \$$(tex(a*x + b*y)) = $(c)\$",
                "Move all terms to one side to get \$g(x,y) = 0\$ form",
                sol("Answer", constraint ~ 0)
            ),
            time = 45
        )
        
    elseif problem_type == 2
        # ELO 400-600: Compute gradient of a simple function
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        f = a*x + b*y + c
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        problem(
            question = "Find the gradient \$\\nabla f\$ of the function \$f(x,y) = $(tex(f))\$.",
            answer = fmt_tuple([grad_x, grad_y]),
            difficulty = (400, 600),
            answer_type = "tuple",
            solution = steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Answer: \$\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle\$"
            ),
            time = 60
        )
        
    elseif problem_type == 3
        # ELO 500-700: Compute gradient of quadratic function
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = randint(-10, 10)
        f = a*x^2 + b*y^2 + c*x*y + d
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        problem(
            question = "Compute the gradient \$\\nabla f(x,y)\$ for \$f(x,y) = $(tex(f))\$.",
            answer = fmt_tuple([grad_x, grad_y]),
            difficulty = (500, 700),
            answer_type = "tuple",
            solution = steps(
                sol("Given", f),
                "Apply partial derivatives",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Answer: \$\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle\$"
            ),
            time = 90
        )
        
    else
        # ELO 300-500: Evaluate function at a point (checking critical point)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        x0 = randint(-8, 8)
        y0 = randint(-8, 8)
        f = a*x^2 + b*y^2
        val = substitute(f, Dict(x => x0, y => y0))
        
        problem(
            question = "Evaluate the function \$f(x,y) = $(tex(f))\$ at the point \$($(x0), $(y0))\$.",
            answer = val,
            difficulty = (300, 500),
            solution = steps(
                sol("Given", f),
                "Substitute \$x = $(x0)\$ and \$y = $(y0)\$",
                sol("f($(x0), $(y0))", val)
            ),
            time = 45
        )
    end
end