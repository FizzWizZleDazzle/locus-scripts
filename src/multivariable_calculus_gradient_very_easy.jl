# multivariable_calculus - gradient (very_easy)
# Generated: 2026-03-08T20:58:26.633393

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Compute gradient of simple linear function (200-400 ELO)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-15, 15)
        f = a*x + b*y + c
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        answer = fmt_list([grad_x, grad_y])
        
        problem(
            question="Find the gradient \\(\\nabla f\\) of \\(f(x,y) = $(tex(f))\\)",
            answer=answer,
            difficulty=(200, 400),
            answer_type="vector",
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Gradient: \\(\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle\\)"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Type 2: Compute gradient of quadratic function (400-600 ELO)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        d = randint(-10, 10)
        e = randint(-20, 20)
        f = a*x^2 + b*y^2 + c*x + d*y + e
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        answer = fmt_list([grad_x, grad_y])
        
        problem(
            question="Compute the gradient \\(\\nabla f\\) of \\(f(x,y) = $(tex(f))\\)",
            answer=answer,
            difficulty=(400, 600),
            answer_type="vector",
            solution=steps(
                sol("Given", f),
                "Take partial derivatives:",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Gradient: \\(\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle\\)"
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Type 3: Evaluate gradient at a point (500-700 ELO)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(-8, 8)
        d = randint(-8, 8)
        f = a*x^2 + b*y^2 + c*x + d*y
        
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_at = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_at = substitute(grad_y, Dict(x => x0, y => y0))
        
        answer = fmt_list([grad_x_at, grad_y_at])
        
        problem(
            question="Find the gradient \\(\\nabla f($(x0), $(y0))\\) of \\(f(x,y) = $(tex(f))\\) at the point \\(($(x0), $(y0))\\)",
            answer=answer,
            difficulty=(500, 700),
            answer_type="vector",
            solution=steps(
                sol("Given", f),
                "Compute partial derivatives:",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Evaluate at \\(($(x0), $(y0))\\):",
                sol("\\frac{\\partial f}{\\partial x}($(x0), $(y0))", grad_x_at),
                sol("\\frac{\\partial f}{\\partial y}($(x0), $(y0))", grad_y_at),
                "Gradient at point: \\(\\nabla f($(x0), $(y0)) = \\langle $(tex(grad_x_at)), $(tex(grad_y_at)) \\rangle\\)"
            ),
            time=120
        )
        
    else
        # Type 4: Simple polynomial with xy term (600-700 ELO)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        f = a*x*y + b*x + c*y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        answer = fmt_list([grad_x, grad_y])
        
        problem(
            question="Find the gradient \\(\\nabla f\\) of \\(f(x,y) = $(tex(f))\\)",
            answer=answer,
            difficulty=(600, 700),
            answer_type="vector",
            solution=steps(
                sol("Given", f),
                "Compute partial derivatives using product rule where needed:",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Gradient: \\(\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle\\)"
            ),
            time=90
        )
    end
end