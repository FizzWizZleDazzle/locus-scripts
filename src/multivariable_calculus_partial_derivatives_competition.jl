# multivariable_calculus - partial_derivatives (competition)
# Generated: 2026-03-08T20:58:40.121863

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad-level: Mixed partial derivatives equality with exotic functions
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(2, 6)
        e = nonzero(2, 6)
        
        # Create f(x,y) = a*x^d * y^e + b*x^e * y^d + c*x*y
        f = a * x^d * y^e + b * x^e * y^d + c * x * y
        
        # Compute mixed partials
        fx = diff(f, x)
        fy = diff(f, y)
        fxy = diff(fx, y)
        fyx = diff(fy, x)
        
        # They should be equal by Schwarz theorem
        diff_expr = simplify(expand(fxy - fyx))
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Verify Schwarz's theorem by computing \$\\frac{\\partial^2 f}{\\partial x \\partial y}\$ and \$\\frac{\\partial^2 f}{\\partial y \\partial x}\$, then find their difference.",
            answer=diff_expr,
            difficulty=(3500, 3800),
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial f}{\\partial x}", fx),
                sol("\\frac{\\partial^2 f}{\\partial y \\partial x}", fyx),
                sol("\\frac{\\partial f}{\\partial y}", fy),
                sol("\\frac{\\partial^2 f}{\\partial x \\partial y}", fxy),
                "By Schwarz's theorem (continuity of second partials), these are equal.",
                sol("Difference", diff_expr)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Research-adjacent: Directional derivative optimization
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(2, 5)
        d = nonzero(2, 5)
        
        # f(x,y) = a*x^c + b*y^d
        f = a * x^c + b * y^d
        
        # Gradient at point (1,1)
        fx = diff(f, x)
        fy = diff(f, y)
        fx_at_1 = substitute(fx, Dict(x => 1, y => 1))
        fy_at_1 = substitute(fy, Dict(x => 1, y => 1))
        
        # Maximum directional derivative is ||grad f||
        max_dir_deriv = sqrt(fx_at_1^2 + fy_at_1^2)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the maximum value of the directional derivative of \$f\$ at the point \$(1,1)\$.",
            answer=simplify(max_dir_deriv),
            difficulty=(3800, 4200),
            solution=steps(
                sol("Given", f),
                sol("\\nabla f", (fx, fy)),
                "Evaluate gradient at (1,1):",
                sol("\\nabla f(1,1)", (fx_at_1, fy_at_1)),
                "The maximum directional derivative equals the magnitude of the gradient:",
                sol("\\max D_u f(1,1)", max_dir_deriv)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Implicit differentiation with constraint
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(2, 8)
        k = nonzero(5, 30)
        
        # Constraint: a*x^3 + b*y^3 = k, find dy/dx at special point
        x0 = 1
        y0_cubed = (k - a * x0^3) // b
        
        # Make sure y0 is rational
        if denominator(y0_cubed) != 1 || y0_cubed <= 0
            y0 = 1
            x0_cubed = (k - b * y0^3) // a
            if denominator(x0_cubed) != 1 || x0_cubed <= 0
                k = a + b  # Adjust k
                x0 = 1
                y0 = 1
            else
                x0 = round(Int, cbrt(float(x0_cubed)))
                y0 = 1
            end
        else
            y0 = round(Int, cbrt(float(y0_cubed)))
            x0 = 1
        end
        
        # Recalculate with integer point
        x0 = 1
        y0 = 1
        k = a * x0^3 + b * y0^3
        
        # dy/dx = -(∂F/∂x)/(∂F/∂y) where F(x,y) = a*x^3 + b*y^3 - k
        Fx = 3 * a * x^2
        Fy = 3 * b * y^2
        dydx = -Fx // Fy
        dydx_at_point = substitute(dydx, Dict(x => x0, y => y0))
        
        problem(
            question="Given the constraint \$$(tex(a*x^3 + b*y^3)) = $(k)\$, find \$\\frac{dy}{dx}\$ at the point \$($(x0), $(y0))\$ using implicit differentiation.",
            answer=simplify(dydx_at_point),
            difficulty=(3600, 4000),
            solution=steps(
                "Differentiate both sides with respect to \$x\$:",
                sol("", "$(3*a)x^2 + $(3*b)y^2 \\frac{dy}{dx} = 0"),
                "Solve for \$\\frac{dy}{dx}\$:",
                sol("\\frac{dy}{dx}", dydx),
                "Substitute \$($(x0), $(y0))\$:",
                sol("Answer", dydx_at_point)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Research-adjacent: Higher order partial derivative pattern
        n = rand(4:6)
        a = nonzero(-3, 3)
        
        # f(x,y,z) = a * x^n * y^n * z^n
        f_expr = a * x^n * y^n * z^n
        
        # Find ∂^(3n) f / (∂x^n ∂y^n ∂z^n)
        result = f_expr
        for i in 1:n
            result = diff(result, x)
        end
        for i in 1:n
            result = diff(result, y)
        end
        for i in 1:n
            result = diff(result, z)
        end
        
        # Simplify: should be a * n!^3
        factorial_n = factorial(n)
        ans = a * factorial_n^3
        
        problem(
            question="Let \$f(x,y,z) = $(tex(f_expr))\$. Compute \$\\frac{\\partial^{$(3*n)} f}{\\partial x^{$(n)} \\partial y^{$(n)} \\partial z^{$(n)}}\$.",
            answer=ans,
            difficulty=(4000, 4500),
            solution=steps(
                sol("Given", f_expr),
                "Each partial derivative of order \$n\$ with respect to one variable brings down \$n!\$ and eliminates that variable's power.",
                "Apply \$\\frac{\\partial^{$(n)}}{\\partial x^{$(n)}}\$: coefficient multiplied by \$($(n))! = $(factorial_n)\$",
                "Apply \$\\frac{\\partial^{$(n)}}{\\partial y^{$(n)}}\$: coefficient multiplied by another \$$(factorial_n)\$",
                "Apply \$\\frac{\\partial^{$(n)}}{\\partial z^{$(n)}}\$: coefficient multiplied by another \$$(factorial_n)\$",
                sol("Answer", ans)
            ),
            time=300
        )
        
    else
        # Olympiad: Critical point classification with complex function
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(2, 5)
        
        # f(x,y) = a*x^4 + b*y^4 - c*x^2*y^2
        f = a * x^4 + b * y^4 - c * x^2 * y^2
        
        fx = diff(f, x)
        fy = diff(f, y)
        fxx = diff(fx, x)
        fyy = diff(fy, y)
        fxy = diff(fx, y)
        
        # At critical point (0,0)
        fxx_00 = substitute(fxx, Dict(x => 0, y => 0))
        fyy_00 = substitute(fyy, Dict(x => 0, y => 0))
        fxy_00 = substitute(fxy, Dict(x => 0, y => 0))
        
        # Hessian determinant D = fxx*fyy - fxy^2
        D = fxx_00 * fyy_00 - fxy_00^2
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Compute the discriminant \$D = f_{xx}f_{yy} - (f_{xy})^2\$ of the Hessian matrix at the critical point \$(0,0)\$.",
            answer=simplify(D),
            difficulty=(3700, 4100),
            solution=steps(
                sol("Given", f),
                sol("f_x", fx),
                sol("f_y", fy),
                "Verify (0,0) is critical: both partials vanish.",
                sol("f_{xx}(0,0)", fxx_00),
                sol("f_{yy}(0,0)", fyy_00),
                sol("f_{xy}(0,0)", fxy_00),
                sol("D", D)
            ),
            time=280
        )
    end
end