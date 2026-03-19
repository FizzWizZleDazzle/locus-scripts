# multivariable_calculus - gradient (easy)
# Generated: 2026-03-08T20:58:42.180678

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Basic gradient computation of polynomial
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        d = randint(-15, 15)
        e = randint(-20, 20)
        
        f = a*x^2 + b*y^2 + c*x + d*y + e
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        ans = "\\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"
        
        problem(
            question="Find the gradient \\(\\nabla f\\) of \\(f(x,y) = $(tex(f))\\)",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "\\(\\nabla f = $(ans)\\)"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Gradient with mixed terms
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-5, 5)
        
        f = a*x*y + b*x + c*y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        ans = "\\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"
        
        problem(
            question="Compute the gradient \\(\\nabla f\\) where \\(f(x,y) = $(tex(f))\\)",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                sol("Given", f),
                "Apply partial derivative with respect to \\(x\\), treating \\(y\\) as constant",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                "Apply partial derivative with respect to \\(y\\), treating \\(x\\) as constant",
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "\\(\\nabla f = $(ans)\\)"
            ),
            time=100
        )
        
    elseif problem_type == 3
        # Evaluate gradient at a point
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        
        f = a*x^2 + b*y^2 + c
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        ans = "\\langle $(grad_x_val), $(grad_y_val) \\rangle"
        
        problem(
            question="Find the gradient of \\(f(x,y) = $(tex(f))\\) at the point \\(($(x0), $(y0))\\)",
            answer=ans,
            difficulty=(850, 1050),
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Evaluate at \\(($(x0), $(y0))\\)",
                sol("\\frac{\\partial f}{\\partial x}\\Big|_{($(x0),$(y0))}", grad_x_val),
                sol("\\frac{\\partial f}{\\partial y}\\Big|_{($(x0),$(y0))}", grad_y_val),
                "\\(\\nabla f($(x0), $(y0)) = $(ans)\\)"
            ),
            time=120
        )
        
    else
        # Gradient with exponential or product
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        use_exp = choice([true, false])
        
        if use_exp
            f = a*x^2 + b*x*y + c*y
        else
            f = a*x*y + b*x^2 + c*y^2
        end
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        ans = "\\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"
        
        problem(
            question="Calculate \\(\\nabla f\\) for \\(f(x,y) = $(tex(f))\\)",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", f),
                "Compute partial derivatives",
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "The gradient is \\(\\nabla f = $(ans)\\)"
            ),
            time=100
        )
    end
end