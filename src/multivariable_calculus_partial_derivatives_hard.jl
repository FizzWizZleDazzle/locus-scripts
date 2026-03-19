# multivariable_calculus - partial_derivatives (hard)
# Generated: 2026-03-08T20:58:26.595617

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Chain rule with partial derivatives
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        m = rand(2:4)
        n = rand(2:4)
        
        f_expr = a*x^m + b*y^n
        x_of_t = c*z^2 + d
        y_of_t = nonzero(-8, 8)*z
        
        dfdx = diff(f_expr, x)
        dfdy = diff(f_expr, y)
        dxdz = diff(x_of_t, z)
        dydz = diff(y_of_t, z)
        
        dfdt_val = expand(dfdx * dxdz + dfdy * dydz)
        
        problem(
            question="Let \$f(x,y) = $(tex(f_expr))\$ where \$x = $(tex(x_of_t))\$ and \$y = $(tex(y_of_t))\$. Find \$\\frac{df}{dz}\$ using the chain rule.",
            answer=dfdt_val,
            difficulty=(1800, 2000),
            solution=steps(
                sol("f(x,y)", f_expr),
                sol("\\frac{\\partial f}{\\partial x}", dfdx),
                sol("\\frac{\\partial f}{\\partial y}", dfdy),
                sol("\\frac{dx}{dz}", dxdz),
                sol("\\frac{dy}{dz}", dydz),
                "Apply chain rule: \$\\frac{df}{dz} = \\frac{\\partial f}{\\partial x}\\frac{dx}{dz} + \\frac{\\partial f}{\\partial y}\\frac{dy}{dz}\$",
                sol("Answer", dfdt_val)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Second-order mixed partial derivatives (Clairaut's theorem)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        m = rand(2:3)
        n = rand(2:3)
        
        f_expr = a*x^m*y^n + b*x*y^2 + c*y
        
        fxy = diff(diff(f_expr, x), y)
        fyx = diff(diff(f_expr, y), x)
        
        problem(
            question="For \$f(x,y) = $(tex(f_expr))\$, compute \$f_{xy}\$ and verify that \$f_{xy} = f_{yx}\$.",
            answer=fxy,
            difficulty=(1800, 2100),
            solution=steps(
                sol("f(x,y)", f_expr),
                sol("f_x", diff(f_expr, x)),
                sol("f_{xy}", fxy),
                sol("f_y", diff(f_expr, y)),
                sol("f_{yx}", fyx),
                "By Clairaut's theorem, \$f_{xy} = f_{yx}\$ (verified)",
                sol("Answer", fxy)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Directional derivative
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        
        vx = nonzero(-4, 4)
        vy = nonzero(-4, 4)
        v_mag = sqrt(vx^2 + vy^2)
        
        f_expr = a*x^2 + b*x*y + c*y^2
        
        fx = diff(f_expr, x)
        fy = diff(f_expr, y)
        
        fx_val = substitute(fx, Dict([x => x0, y => y0]))
        fy_val = substitute(fy, Dict([x => x0, y => y0]))
        
        D_u = (fx_val * vx + fy_val * vy) / v_mag
        
        problem(
            question="Find the directional derivative of \$f(x,y) = $(tex(f_expr))\$ at the point \$($(x0), $(y0))\$ in the direction of the vector \$\\langle $(vx), $(vy) \\rangle\$.",
            answer=D_u,
            difficulty=(2000, 2300),
            solution=steps(
                sol("f(x,y)", f_expr),
                sol("\\nabla f", "\\langle $(tex(fx)), $(tex(fy)) \\rangle"),
                sol("\\nabla f($(x0), $(y0))", "\\langle $(fx_val), $(fy_val) \\rangle"),
                "Unit vector: \$\\mathbf{u} = \\frac{1}{$(tex(v_mag))}\\langle $(vx), $(vy) \\rangle\$",
                "Directional derivative: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u}\$",
                sol("Answer", D_u)
            ),
            time=210
        )
        
    elseif problem_type == 4
        # Tangent plane equation
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        f_expr = a*x^2 + b*y^2 + c*x*y
        
        fx = diff(f_expr, x)
        fy = diff(f_expr, y)
        
        z0 = substitute(f_expr, Dict([x => x0, y => y0]))
        fx_val = substitute(fx, Dict([x => x0, y => y0]))
        fy_val = substitute(fy, Dict([x => x0, y => y0]))
        
        tangent = z0 + fx_val*(x - x0) + fy_val*(y - y0)
        
        problem(
            question="Find the equation of the tangent plane to \$z = $(tex(f_expr))\$ at the point \$($(x0), $(y0), $(z0))\$.",
            answer=expand(tangent),
            difficulty=(1900, 2200),
            solution=steps(
                sol("z", f_expr),
                sol("\\frac{\\partial z}{\\partial x}", fx),
                sol("\\frac{\\partial z}{\\partial y}", fy),
                "At \$($(x0), $(y0))\$: \$\\frac{\\partial z}{\\partial x} = $(fx_val)\$, \$\\frac{\\partial z}{\\partial y} = $(fy_val)\$",
                "Tangent plane: \$z - $(z0) = $(fx_val)(x - $(x0)) + $(fy_val)(y - $(y0))\$",
                sol("Answer", expand(tangent))
            ),
            time=240
        )
        
    elseif problem_type == 5
        # Implicit differentiation for partial derivatives
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        F_expr = a*x^2 + b*y^2 + c*x*y*z
        
        Fx = diff(F_expr, x)
        Fz = diff(F_expr, z)
        
        dzdx = -Fx / Fz
        
        problem(
            question="Given the implicit equation \$$(tex(F_expr)) = 0\$, find \$\\frac{\\partial z}{\\partial x}\$ using implicit differentiation.",
            answer=simplify(dzdx),
            difficulty=(2100, 2400),
            solution=steps(
                sol("F(x,y,z)", F_expr ~ 0),
                "Differentiate implicitly with respect to \$x\$",
                sol("F_x", Fx),
                sol("F_z", Fz),
                "By implicit function theorem: \$\\frac{\\partial z}{\\partial x} = -\\frac{F_x}{F_z}\$",
                sol("Answer", simplify(dzdx))
            ),
            time=270
        )
        
    else
        # Critical points and second derivative test
        a = choice([-2, -1, 1, 2])
        b = choice([-2, -1, 1, 2])
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        f_expr = a*x^2 + b*y^2 + c*x + d*y
        
        fx = diff(f_expr, x)
        fy = diff(f_expr, y)
        
        crit_x = -c // (2*a)
        crit_y = -d // (2*b)
        
        fxx = diff(fx, x)
        fyy = diff(fy, y)
        fxy = diff(fx, y)
        
        D_val = fxx * fyy - fxy^2
        
        if D_val > 0 && a > 0
            classification = "local minimum"
        elseif D_val > 0 && a < 0
            classification = "local maximum"
        else
            classification = "saddle point"
        end
        
        ans_point = "$(fmt_tuple([crit_x, crit_y]))"
        
        problem(
            question="Find and classify all critical points of \$f(x,y) = $(tex(f_expr))\$. Give your answer as an ordered pair.",
            answer=ans_point,
            difficulty=(2000, 2400),
            solution=steps(
                sol("f(x,y)", f_expr),
                sol("f_x", fx),
                sol("f_y", fy),
                "Set \$f_x = 0\$ and \$f_y = 0\$",
                sol("Critical point", ans_point),
                "Second derivative test: \$f_{xx} = $(fxx)\$, \$f_{yy} = $(fyy)\$, \$f_{xy} = $(fxy)\$",
                "Discriminant: \$D = f_{xx}f_{yy} - (f_{xy})^2 = $(D_val)\$",
                "Classification: $(classification)",
                sol("Answer", ans_point)
            ),
            time=300
        )
    end
end