# multivariable_calculus - partial_derivatives (very_hard)
# Generated: 2026-03-08T20:58:24.699171

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Mixed partial derivatives equality verification (Schwarz's theorem)
        # ELO: 2500-3000
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        m = rand(3:6)
        n = rand(3:6)
        p = rand(2:5)
        
        f = a*x^m*y^n + b*x*y^p*z + c*sin(x*y)
        
        fxy = diff(diff(f, x), y)
        fyx = diff(diff(f, y), x)
        fxyz = diff(diff(diff(f, x), y), z)
        
        problem(
            question="Let \\\$f(x,y,z) = $(tex(f))\\\$. Compute the mixed partial derivative \\\$\\frac{\\partial^3 f}{\\partial x \\partial y \\partial z}\\\$.",
            answer=fxyz,
            difficulty=(2500, 3000),
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", diff(f, x)),
                sol("\\frac{\\partial^2 f}{\\partial y \\partial x}", diff(diff(f, x), y)),
                sol("\\frac{\\partial^3 f}{\\partial z \\partial y \\partial x}", fxyz),
                "By Schwarz's theorem, mixed partials are equal regardless of order."
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Gradient critical point analysis with constraints
        # ELO: 2800-3500
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = randint(1, 5)
        
        f = a*x^4 + b*y^4 - c*x^2*y^2
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        # Critical points include (0,0) and solutions to the system
        crit_x = 0
        crit_y = 0
        
        fxx = diff(fx, x)
        fyy = diff(fy, y)
        fxy = diff(fx, y)
        
        D_at_origin = substitute(fxx*fyy - fxy^2, [x => 0, y => 0])
        fxx_at_origin = substitute(fxx, [x => 0, y => 0])
        
        problem(
            question="Find all critical points of \\\$f(x,y) = $(tex(f))\\\$ and classify the nature of the critical point at the origin using the second derivative test.",
            answer="saddle point",
            difficulty=(2800, 3500),
            answer_type="string",
            solution=steps(
                sol("Given", f),
                sol("\\nabla f = 0 \\Rightarrow \\frac{\\partial f}{\\partial x}", fx),
                sol("\\frac{\\partial f}{\\partial y}", fy),
                "Set both partial derivatives to zero. One critical point is \$(0, 0)\\\$.",
                sol("f_{xx}", fxx),
                sol("f_{yy}", fyy),
                sol("f_{xy}", fxy),
                "At \$(0,0)\\\$: \\\$D = f_{xx}f_{yy} - (f_{xy})^2 = $(tex(D_at_origin))\\\$",
                "Since \\\$D < 0\\\$, the origin is a saddle point."
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Directional derivative in direction of maximum increase
        # ELO: 2600-3200
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        f = a*x^2*y + b*x*y^2 + c*exp(x + y)
        
        x0 = randint(-2, 2)
        y0 = randint(-2, 2)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        grad_x = substitute(fx, [x => x0, y => y0])
        grad_y = substitute(fy, [x => x0, y => y0])
        
        mag = sqrt(grad_x^2 + grad_y^2)
        
        max_rate = simplify(mag)
        
        problem(
            question="For \\\$f(x,y) = $(tex(f))\\\$, find the maximum rate of change of \\\$f\\\$ at the point \$($(x0), $(y0))\\\$.",
            answer=max_rate,
            difficulty=(2600, 3200),
            solution=steps(
                sol("Given", f),
                sol("\\nabla f = \\left(\\frac{\\partial f}{\\partial x}, \\frac{\\partial f}{\\partial y}\\right)", (fx, fy)),
                "At \\\$($(x0), $(y0))\\\$: \\\$\\nabla f($(x0), $(y0)) = ($(tex(grad_x)), $(tex(grad_y)))\\\$",
                "Maximum rate of change is \\\$\\|\\nabla f\\|\\\$",
                sol("Answer", max_rate)
            ),
            time=220
        )
        
    elseif problem_type == 4
        # Implicit differentiation with partial derivatives
        # ELO: 2700-3300
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 8)
        
        F = x^3 + a*y^3 + b*x*y - c
        
        Fx = diff(F, x)
        Fy = diff(F, y)
        
        dydx = simplify(-Fx / Fy)
        
        problem(
            question="The equation \\\$$(tex(F)) = 0\\\$ defines \\\$y\\\$ implicitly as a function of \\\$x\\\$. Find \\\$\\frac{dy}{dx}\\\$ in terms of \\\$x\\\$ and \\\$y\\\$.",
            answer=dydx,
            difficulty=(2700, 3300),
            solution=steps(
                sol("Given", F ~ 0),
                "Differentiate implicitly with respect to \\\$x\\\$:",
                sol("\\frac{\\partial F}{\\partial x}", Fx),
                sol("\\frac{\\partial F}{\\partial y}", Fy),
                "By implicit differentiation: \\\$\\frac{\\partial F}{\\partial x} + \\frac{\\partial F}{\\partial y}\\frac{dy}{dx} = 0\\\$",
                sol("\\frac{dy}{dx}", dydx)
            ),
            time=250
        )
        
    else
        # Chain rule with composition (multivariable)
        # ELO: 2500-3100
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        m = rand(2:4)
        n = rand(2:4)
        
        @variables t
        u_expr = a*cos(t)
        v_expr = b*sin(t)
        
        f = x^m + y^n
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        dudt = diff(u_expr, t)
        dvdt = diff(v_expr, t)
        
        # Substitute x = u(t), y = v(t)
        dfdt_symbolic = substitute(fx, x => u_expr) * dudt + substitute(fy, y => v_expr) * dvdt
        dfdt = simplify(dfdt_symbolic)
        
        problem(
            question="Let \\\$f(x,y) = $(tex(f))\\\$ and suppose \\\$x = $(tex(u_expr))\\\$ and \\\$y = $(tex(v_expr))\\\$. Find \\\$\\frac{df}{dt}\\\$ using the chain rule.",
            answer=dfdt,
            difficulty=(2500, 3100),
            solution=steps(
                sol("Given f(x,y)", f),
                sol("\\frac{\\partial f}{\\partial x}", fx),
                sol("\\frac{\\partial f}{\\partial y}", fy),
                "Chain rule: \\\$\\frac{df}{dt} = \\frac{\\partial f}{\\partial x}\\frac{dx}{dt} + \\frac{\\partial f}{\\partial y}\\frac{dy}{dt}\\\$",
                sol("\\frac{dx}{dt}", dudt),
                sol("\\frac{dy}{dt}", dvdt),
                sol("\\frac{df}{dt}", dfdt)
            ),
            time=280
        )
    end
end