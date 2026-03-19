# multivariable_calculus - gradient (medium)
# Generated: 2026-03-08T20:58:51.836681

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compute gradient of polynomial function (1200-1400)
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
            question="Find the gradient \\nabla f of the function \$f(x,y) = $(tex(f))\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="expression",
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Evaluate gradient at a point (1300-1500)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        f = a*x*y + b*x^2 + c*y^2 + d
        
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_val = substitute(grad_x, [x => x0, y => y0])
        grad_y_val = substitute(grad_y, [x => x0, y => y0])
        
        ans = "\\langle $(grad_x_val), $(grad_y_val) \\rangle"
        
        problem(
            question="Find \\nabla f($(x0), $(y0)) where \$f(x,y) = $(tex(f))\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="expression",
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Evaluate at ($(x0), $(y0))",
                sol("\\nabla f($(x0), $(y0))", "\\langle $(grad_x_val), $(grad_y_val) \\rangle")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Directional derivative (1400-1600)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        
        f = a*x^2 + b*y^2 + c*x*y
        
        x0 = randint(-4, 4)
        y0 = randint(-4, 4)
        
        # Unit vector direction
        u1 = choice([1, -1, 2, -2, 3, -3])
        u2 = choice([1, -1, 2, -2, 3, -3])
        norm = sqrt(u1^2 + u2^2)
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_val = substitute(grad_x, [x => x0, y => y0])
        grad_y_val = substitute(grad_y, [x => x0, y => y0])
        
        dir_deriv = (grad_x_val * u1 + grad_y_val * u2) / norm
        
        ans = simplify(dir_deriv)
        
        problem(
            question="Find the directional derivative of \$f(x,y) = $(tex(f))\$ at the point ($(x0), $(y0)) in the direction of the vector \\langle $(u1), $(u2) \\rangle",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", f),
                "Compute gradient: \\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)) \\rangle",
                "At ($(x0), $(y0)): \\nabla f = \\langle $(grad_x_val), $(grad_y_val) \\rangle",
                "Unit vector: \\mathbf{u} = \\frac{1}{$(tex(norm))} \\langle $(u1), $(u2) \\rangle",
                sol("D_{\\mathbf{u}} f", ans)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Find where gradient equals zero (critical points) (1500-1700)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        # Construct so critical point is at nice values
        x_crit = randint(-6, 6)
        y_crit = randint(-6, 6)
        
        f = a*(x - x_crit)^2 + b*(y - y_crit)^2 + c*x + d*y
        f_expanded = expand(f)
        
        ans = "($(x_crit), $(y_crit))"
        
        grad_x = diff(f_expanded, x)
        grad_y = diff(f_expanded, y)
        
        problem(
            question="Find the critical point(s) of \$f(x,y) = $(tex(f_expanded))\$ by setting \\nabla f = \\mathbf{0}",
            answer=ans,
            difficulty=(1500, 1700),
            answer_type="expression",
            solution=steps(
                sol("Given", f_expanded),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                "Set both partial derivatives equal to zero and solve",
                sol("Critical point", "($(x_crit), $(y_crit))")
            ),
            time=180
        )
        
    else
        # Gradient in three variables (1400-1600)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = randint(-10, 10)
        
        f = a*x^2 + b*y^2 + c*z^2 + d*x*y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        grad_z = diff(f, z)
        
        ans = "\\langle $(tex(grad_x)), $(tex(grad_y)), $(tex(grad_z)) \\rangle"
        
        problem(
            question="Find the gradient \\nabla f of the function \$f(x,y,z) = $(tex(f))\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="expression",
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", grad_x),
                sol("\\frac{\\partial f}{\\partial y}", grad_y),
                sol("\\frac{\\partial f}{\\partial z}", grad_z),
                "\\nabla f = \\langle $(tex(grad_x)), $(tex(grad_y)), $(tex(grad_z)) \\rangle"
            ),
            time=120
        )
    end
end