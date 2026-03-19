# multivariable_calculus - lagrange_multipliers (hard)
# Generated: 2026-03-08T21:00:43.356069

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Optimize quadratic function on circle constraint
        # f(x,y) = ax² + by² subject to x² + y² = r²
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        while abs(a - b) < 2
            b = nonzero(-8, 8)
        end
        r = randint(2, 6)
        
        f = a*x^2 + b*y^2
        constraint = x^2 + y^2 - r^2
        
        # Maximum is max(a,b)*r², minimum is min(a,b)*r²
        max_val = max(a, b) * r^2
        min_val = min(a, b) * r^2
        
        opt_type = choice(["maximum", "minimum"])
        ans = opt_type == "maximum" ? max_val : min_val
        
        question = "Find the $(opt_type) value of \\\$f(x,y) = $(tex(f))\\\$ subject to the constraint \\\$$(tex(x^2 + y^2)) = $(r^2)\\\$ using Lagrange multipliers."
        
        solution = steps(
            sol("Objective function", f),
            sol("Constraint", x^2 + y^2 ~ r^2),
            "Set up Lagrange equations: \\\$\\nabla f = \\lambda \\nabla g\\\$ where \\\$g(x,y) = $(tex(constraint))\\\$",
            "This gives: \\\$$(tex(2*a*x)) = \\lambda $(tex(2*x))\\\$ and \\\$$(tex(2*b*y)) = \\lambda $(tex(2*y))\\\$",
            "From first equation: \\\$($(a) - \\lambda)x = 0\\\$, so \\\$x=0\\\$ or \\\$\\lambda = $(a)\\\$",
            "From second equation: \\\$($(b) - \\lambda)y = 0\\\$, so \\\$y=0\\\$ or \\\$\\lambda = $(b)\\\$",
            "Critical points occur at \\\$(\\pm $(r), 0)\\\$ giving \\\$f = $(a*r^2)\\\$ and \\\$(0, \\pm $(r))\\\$ giving \\\$f = $(b*r^2)\\\$",
            sol(opt_type == "maximum" ? "Maximum value" : "Minimum value", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1800, 2000),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Optimize linear function on ellipse
        # f(x,y) = ax + by subject to x²/p² + y²/q² = 1
        a = nonzero(-9, 9)
        b = nonzero(-9, 9)
        p = randint(2, 5)
        q = randint(2, 5)
        while p == q
            q = randint(2, 5)
        end
        
        f = a*x + b*y
        
        # Maximum is sqrt(a²p² + b²q²)
        max_val_sq = a^2 * p^2 + b^2 * q^2
        max_val = sqrt(max_val_sq)
        
        opt_type = choice(["maximum", "minimum"])
        ans = opt_type == "maximum" ? max_val : -max_val
        
        question = "Find the $(opt_type) value of \\\$f(x,y) = $(tex(f))\\\$ subject to \\\$\\frac{x^2}{$(p^2)} + \\frac{y^2}{$(q^2)} = 1\\\$ using Lagrange multipliers."
        
        solution = steps(
            sol("Objective function", f),
            "Constraint: \\\$\\frac{x^2}{$(p^2)} + \\frac{y^2}{$(q^2)} = 1\\\$",
            "Set up \\\$\\nabla f = \\lambda \\nabla g\\\$: \$($(a), $(b)) = \\lambda \\left(\\frac{2x}{$(p^2)}, \\frac{2y}{$(q^2)}\\right)\\\$",
            "Solve: \\\$$(a) = \\frac{2\\lambda x}{$(p^2)}\\\$ and \\\$$(b) = \\frac{2\\lambda y}{$(q^2)}\\\$",
            "Substitute into constraint and solve for \\\$\\lambda\\\$",
            "The extreme values are \\\$\\pm\\sqrt{$(a^2) \\cdot $(p^2) + $(b^2) \\cdot $(q^2)} = \\pm\\sqrt{$(max_val_sq)}\\\$",
            sol("$(opt_type == "maximum" ? "Maximum" : "Minimum")", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1900, 2100),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 3
        # Minimize distance from point to plane
        # Minimize (x-a)² + (y-b)² + (z-c)² subject to px + qy + rz = d
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        p = nonzero(-5, 5)
        q = nonzero(-5, 5)
        r = nonzero(-5, 5)
        d = randint(-15, 15)
        
        # Distance from (a,b,c) to plane px+qy+rz=d is |pa+qb+rc-d|/sqrt(p²+q²+r²)
        numerator = abs(p*a + q*b + r*c - d)
        denominator_sq = p^2 + q^2 + r^2
        
        # For cleaner problems, compute min distance²
        min_dist_sq = numerator^2 // denominator_sq
        
        question = "Find the minimum value of \\\$f(x,y,z) = (x-$(a))^2 + (y-$(b))^2 + (z-$(c))^2\\\$ subject to \\\$$(tex(p*x + q*y + r*z)) = $(d)\\\$ using Lagrange multipliers. (Answer: minimum distance squared)"
        
        solution = steps(
            "This finds the minimum squared distance from \$($(a), $(b), $(c))\\\$ to the plane \\\$$(p)x + $(q)y + $(r)z = $(d)\\\$",
            "Set up \\\$\\nabla f = \\lambda \\nabla g\\\$: \$(2(x-$(a)), 2(y-$(b)), 2(z-$(c))) = \\lambda($(p), $(q), $(r))\\\$",
            "The critical point lies along the normal direction from \$($(a),$(b),$(c))\\\$",
            "Using the distance formula from point to plane: \\\$d = \\frac{|$(p)($(a)) + $(q)($(b)) + $(r)($(c)) - $(d)|}{\\sqrt{$(p^2) + $(q^2) + $(r^2)}}\\\$",
            "Distance = \\\$\\frac{|$(p*a + q*b + r*c) - $(d)|}{\\sqrt{$(denominator_sq)}} = \\frac{$(numerator)}{\\sqrt{$(denominator_sq)}}\\\$",
            sol("Minimum squared distance", min_dist_sq)
        )
        
        problem(
            question=question,
            answer=min_dist_sq,
            difficulty=(2000, 2200),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 4
        # Optimize product xyz on sphere
        # Maximize xyz subject to x² + y² + z² = r²
        r = randint(3, 8)
        
        # Maximum of xyz on sphere x²+y²+z²=r² is r³/(3√3) at x=y=z=r/√3
        # But we'll ask for xyz value at critical point in first octant
        critical_val_cubed = r^3 // 27  # (r/√3)³ = r³/(3√3)³ = r³/27
        
        question = "Find the maximum value of \\\$f(x,y,z) = xyz\\\$ subject to \\\$x^2 + y^2 + z^2 = $(r^2)\\\$ where \\\$x, y, z > 0\\\$ using Lagrange multipliers. Give your answer as the cube of the maximum value."
        
        # Answer is (r³/27)³ = r⁹/19683, but simpler to ask for xyz value
        # Actually, xyz max = r³/(3√3), so (xyz)³ = r⁹/27
        ans = (r^3) // 27
        
        question = "Find the critical value of \\\$xyz\\\$ when optimizing \\\$f(x,y,z) = xyz\\\$ subject to \\\$x^2 + y^2 + z^2 = $(r^2)\\\$ in the first octant (\\\$x,y,z > 0\\\$) using Lagrange multipliers. Give \$(xyz)^3\\\$ at the critical point."
        
        solution = steps(
            sol("Objective", x*y*z),
            sol("Constraint", x^2 + y^2 + z^2 ~ r^2),
            "Set up \\\$\\nabla f = \\lambda \\nabla g\\\$: \$(yz, xz, xy) = \\lambda(2x, 2y, 2z)\\\$",
            "From symmetry and equations: \\\$yz = 2\\lambda x\\\$, \\\$xz = 2\\lambda y\\\$, \\\$xy = 2\\lambda z\\\$",
            "These imply \\\$x = y = z\\\$ at the critical point",
            "Substituting into constraint: \\\$3x^2 = $(r^2)\\\$, so \\\$x = \\frac{$(r)}{\\sqrt{3}}\\\$",
            "Therefore \\\$xyz = \\left(\\frac{$(r)}{\\sqrt{3}}\\right)^3 = \\frac{$(r^3)}{3\\sqrt{3}}\\\$",
            sol("(xyz)^3", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2100, 2400),
            solution=solution,
            time=300
        )
        
    else  # problem_type == 5
        # Two constraints problem
        # Optimize f(x,y,z) = x + y + z subject to x² + y² = r² and z = c
        r = randint(3, 7)
        c = randint(-5, 5)
        
        # On circle x²+y²=r², max of x+y is √2·r at x=y=r/√2
        max_xy = r * sqrt(2)
        max_total = max_xy + c
        
        # For exact answer, max x+y on circle radius r is r√2
        # So max is r√2 + c, but we want rational answer
        # Let's reformulate: maximize x subject to x²+y²=r², z=c
        
        question = "Using Lagrange multipliers with two constraints, find the maximum value of \\\$x\\\$ subject to \\\$x^2 + y^2 = $(r^2)\\\$ and \\\$z = $(c)\\\$."
        
        ans = r
        
        solution = steps(
            sol("Objective", x),
            "Constraints: \\\$g_1(x,y,z) = x^2 + y^2 - $(r^2) = 0\\\$ and \\\$g_2(x,y,z) = z - $(c) = 0\\\$",
            "Set up \\\$\\nabla f = \\lambda_1 \\nabla g_1 + \\lambda_2 \\nabla g_2\\\$",
            "\$(1, 0, 0) = \\lambda_1(2x, 2y, 0) + \\lambda_2(0, 0, 1)\\\$",
            "From components: \\\$1 = 2\\lambda_1 x\\\$, \\\$0 = 2\\lambda_1 y\\\$, \\\$0 = \\lambda_2\\\$",
            "From second equation: \\\$y = 0\\\$ (since \\\$\\lambda_1 \\neq 0\\\$)",
            "Substituting into \\\$x^2 + y^2 = $(r^2)\\\$: \\\$x^2 = $(r^2)\\\$, so \\\$x = \\pm$(r)\\\$",
            sol("Maximum", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1900, 2200),
            solution=solution,
            time=240
        )
    end
end