# multivariable_calculus - gradient (hard)
# Generated: 2026-03-08T20:58:56.179015

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Gradient of polynomial function (1800-2000)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = randint(-15, 15)
        e = randint(-15, 15)
        f = randint(-15, 15)
        
        f_expr = a*x^2 + b*y^2 + c*x*y + d*x + e*y + f
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        
        problem(
            question="Find the gradient \\(\\nabla f\\) of \\(f(x,y) = $(tex(f_expr))\\)",
            answer="$(tex(grad_x))i + $(tex(grad_y))j",
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", f_expr),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                sol("\\nabla f", "$(tex(grad_x))\\mathbf{i} + $(tex(grad_y))\\mathbf{j}")
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Gradient at a point (1900-2100)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-5, 5)
        
        f_expr = a*x^3 + b*y^2 + c*x*y
        
        x0 = nonzero(-4, 4)
        y0 = nonzero(-4, 4)
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        problem(
            question="Find \\(\\nabla f($(x0), $(y0))\\) where \\(f(x,y) = $(tex(f_expr))\\)",
            answer="$(grad_x_val)i + $(grad_y_val)j",
            difficulty=(1900, 2100),
            solution=steps(
                sol("f(x,y)", f_expr),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Evaluate at \\(($(x0), $(y0))\\)",
                sol("\\nabla f($(x0), $(y0))", "$(grad_x_val)\\mathbf{i} + $(grad_y_val)\\mathbf{j}")
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Directional derivative (2000-2200)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        f_expr = a*x^2 + b*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        u_x = nonzero(-3, 3)
        u_y = nonzero(-3, 3)
        
        mag = sqrt(u_x^2 + u_y^2)
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        dir_deriv = (grad_x_val * u_x + grad_y_val * u_y) / mag
        
        problem(
            question="Find the directional derivative of \\(f(x,y) = $(tex(f_expr))\\) at \\(($(x0), $(y0))\\) in the direction of \\(\\mathbf{v} = \\langle $(u_x), $(u_y) \\rangle\\)",
            answer=dir_deriv,
            difficulty=(2000, 2200),
            solution=steps(
                sol("\\nabla f", "$(tex(grad_x))\\mathbf{i} + $(tex(grad_y))\\mathbf{j}"),
                sol("\\nabla f($(x0), $(y0))", "\\langle $(grad_x_val), $(grad_y_val) \\rangle"),
                "Unit vector: \\(\\mathbf{u} = \\frac{1}{$(tex(mag))}\\langle $(u_x), $(u_y) \\rangle\\)",
                sol("D_{\\mathbf{u}}f", dir_deriv)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Maximum rate of increase (2100-2300)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        f_expr = a*x*y + b*x + c*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        max_rate = sqrt(grad_x_val^2 + grad_y_val^2)
        
        problem(
            question="Find the maximum rate of change of \\(f(x,y) = $(tex(f_expr))\\) at the point \\(($(x0), $(y0))\\)",
            answer=max_rate,
            difficulty=(2100, 2300),
            solution=steps(
                sol("\\nabla f", "\\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"),
                sol("\\nabla f($(x0), $(y0))", "\\langle $(grad_x_val), $(grad_y_val) \\rangle"),
                "Maximum rate = \\(\\|\\nabla f\\|\\)",
                sol("\\text{Answer}", max_rate)
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Gradient perpendicular to level curve (2000-2200)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        f_expr = a*x^2 - b*y^2
        
        x0 = nonzero(-4, 4)
        y0 = nonzero(-4, 4)
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        tangent_slope = -grad_x_val / grad_y_val
        
        problem(
            question="Find the slope of the tangent line to the level curve of \\(f(x,y) = $(tex(f_expr))\\) at the point \\(($(x0), $(y0))\\)",
            answer=tangent_slope,
            difficulty=(2000, 2200),
            solution=steps(
                sol("\\nabla f", "\\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"),
                sol("\\nabla f($(x0), $(y0))", "\\langle $(grad_x_val), $(grad_y_val) \\rangle"),
                "Tangent is perpendicular to gradient",
                sol("\\text{Slope}", -grad_x_val / grad_y_val)
            ),
            time=180
        )
        
    else
        # Three variable gradient (2100-2400)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        f_expr = a*x*y + b*y*z + c*x*z
        
        grad_x = diff(f_expr, x)
        grad_y = diff(f_expr, y)
        grad_z = diff(f_expr, z)
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        z0 = nonzero(-3, 3)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0, z => z0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0, z => z0))
        grad_z_val = substitute(grad_z, Dict(x => x0, y => y0, z => z0))
        
        problem(
            question="Find \\(\\nabla f($(x0), $(y0), $(z0))\\) where \\(f(x,y,z) = $(tex(f_expr))\\)",
            answer="$(grad_x_val)i + $(grad_y_val)j + $(grad_z_val)k",
            difficulty=(2100, 2400),
            solution=steps(
                sol("f(x,y,z)", f_expr),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                sol("\\frac{\\partial f}{\\partial z}", grad_z),
                "Evaluate at \\(($(x0), $(y0), $(z0))\\)",
                sol("\\nabla f", "\\langle $(grad_x_val), $(grad_y_val), $(grad_z_val) \\rangle")
            ),
            time=200
        )
    end
end