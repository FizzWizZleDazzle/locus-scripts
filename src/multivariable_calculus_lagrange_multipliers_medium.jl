# multivariable_calculus - lagrange_multipliers (medium)
# Generated: 2026-03-08T21:00:19.235843

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    prob_type = choice(1:4)
    
    if prob_type == 1
        # Optimize f(x,y) = x² + y² subject to x + y = k (1200-1400)
        k = randint(4, 12)
        ans_x = k // 2
        ans_y = k // 2
        ans_val = 2 * (k // 2)^2
        
        problem(
            question="Use Lagrange multipliers to find the minimum value of \$f(x,y) = x^2 + y^2\$ subject to the constraint \$x + y = $k\$. Enter the minimum value.",
            answer=ans_val,
            difficulty=(1200, 1400),
            solution=steps(
                "Set up Lagrange equations: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y) = x + y - $k\$",
                sol("Equations", "2x = \\lambda, \\quad 2y = \\lambda, \\quad x + y = $k"),
                "From first two equations: \$2x = 2y\$, so \$x = y\$",
                "Substitute into constraint: \$2x = $k\$, giving \$x = y = $(k//2)\$",
                sol("Minimum value", "f($(k//2), $(k//2)) = $(ans_val)")
            ),
            time=180
        )
        
    elseif prob_type == 2
        # Optimize f(x,y) = ax² + by² subject to cx + dy = k (1300-1500)
        a = randint(1, 4)
        b = randint(1, 4)
        c = randint(2, 5)
        d = randint(2, 5)
        k = randint(6, 15)
        
        # From gradient equations: 2ax = λc, 2by = λd
        # So x = λc/(2a), y = λd/(2b)
        # Constraint: c(λc/(2a)) + d(λd/(2b)) = k
        # λ(c²/(2a) + d²/(2b)) = k
        lambda_val = k / (c^2/(2*a) + d^2/(2*b))
        ans_x = lambda_val * c / (2*a)
        ans_y = lambda_val * d / (2*b)
        ans_val = a * ans_x^2 + b * ans_y^2
        
        problem(
            question="Use Lagrange multipliers to find the minimum value of \$f(x,y) = $(a)x^2 + $(b)y^2\$ subject to \$$(c)x + $(d)y = $k\$. Round to two decimal places.",
            answer=round(ans_val, digits=2),
            difficulty=(1300, 1500),
            solution=steps(
                "Set up: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y) = $(c)x + $(d)y - $k\$",
                sol("System", "$(2*a)x = $(c)\\lambda, \\quad $(2*b)y = $(d)\\lambda, \\quad $(c)x + $(d)y = $k"),
                "Express x and y in terms of λ: \$x = \\frac{$(c)\\lambda}{$(2*a)}\$, \$y = \\frac{$(d)\\lambda}{$(2*b)}\$",
                "Substitute into constraint and solve for λ, then find x, y",
                sol("Minimum value", "\\approx $(round(ans_val, digits=2))")
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif prob_type == 3
        # Optimize f(x,y,z) = x + y + z subject to x² + y² + z² = r² (1400-1600)
        r = randint(5, 12)
        ans_coord = r / sqrt(3)
        ans_val = 3 * ans_coord
        
        problem(
            question="Use Lagrange multipliers to find the maximum value of \$f(x,y,z) = x + y + z\$ subject to \$x^2 + y^2 + z^2 = $(r^2)\$. Round to two decimal places.",
            answer=round(ans_val, digits=2),
            difficulty=(1400, 1600),
            solution=steps(
                "Set up: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y,z) = x^2 + y^2 + z^2 - $(r^2)\$",
                sol("System", "1 = 2\\lambda x, \\quad 1 = 2\\lambda y, \\quad 1 = 2\\lambda z, \\quad x^2 + y^2 + z^2 = $(r^2)"),
                "From first three equations: \$x = y = z = \\frac{1}{2\\lambda}\$",
                "Substitute into constraint: \$3\\left(\\frac{1}{2\\lambda}\\right)^2 = $(r^2)\$",
                "Solve: \$x = y = z = \\frac{$r}{\\sqrt{3}}\$ (for maximum)",
                sol("Maximum value", "$(round(ans_val, digits=2))")
            ),
            time=240,
            calculator="scientific"
        )
        
    else
        # Optimize f(x,y,z) = xyz subject to x + y + z = s (1500-1700)
        s = randint(12, 24)
        ans_coord = s // 3
        ans_val = (s // 3)^3
        
        problem(
            question="Use Lagrange multipliers to find the maximum value of \$f(x,y,z) = xyz\$ subject to \$x + y + z = $s\$ where \$x, y, z > 0\$. Enter the exact value.",
            answer=ans_val,
            difficulty=(1500, 1700),
            solution=steps(
                "Set up: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y,z) = x + y + z - $s\$",
                sol("System", "yz = \\lambda, \\quad xz = \\lambda, \\quad xy = \\lambda, \\quad x + y + z = $s"),
                "From \$yz = xz\$: either \$z = 0\$ or \$y = x\$. Since \$z > 0\$, we have \$y = x\$",
                "Similarly from \$yz = xy\$: \$z = x\$. Thus \$x = y = z\$",
                "Substitute: \$3x = $s\$, so \$x = y = z = $(s//3)\$",
                sol("Maximum value", "$(ans_val)")
            ),
            time=240
        )
    end
end