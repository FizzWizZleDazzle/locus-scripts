# multivariable_calculus - lagrange_multipliers (very_hard)
# Generated: 2026-03-08T21:00:46.315908

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Optimize distance from origin subject to constraint (ELO 2500-2800)
        # Pick a clean critical point first
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        
        # Constraint: ax + by = c
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = a*x0 + b*y0
        
        # Objective: minimize x^2 + y^2
        # At critical point: ∇f = λ∇g
        # 2x = λa, 2y = λb
        # λ = 2x/a = 2y/b
        
        min_dist_sq = x0^2 + y0^2
        min_dist = sqrt(min_dist_sq)
        
        constraint_str = "$a x + $b y = $c"
        if a == 1
            constraint_str = "x + $b y = $c"
        elseif a == -1
            constraint_str = "-x + $b y = $c"
        end
        if b == 1
            constraint_str = a == 1 ? "x + y = $c" : "$a x + y = $c"
        elseif b == -1
            constraint_str = a == 1 ? "x - y = $c" : "$a x - y = $c"
        end
        
        problem(
            question="Use Lagrange multipliers to find the minimum distance from the origin to the line \$$(constraint_str)\$. Enter your answer as an exact value.",
            answer=min_dist,
            difficulty=(2500, 2800),
            solution=steps(
                "We minimize \$f(x,y) = x^2 + y^2\$ subject to \$g(x,y) = $(a)x + $(b)y - $(c) = 0\$",
                "Set up Lagrange conditions: \$\\nabla f = \\lambda \\nabla g\$",
                "\$2x = \\lambda \\cdot $(a)\$ and \$2y = \\lambda \\cdot $(b)\$",
                "From these: \$x = \\frac{$(a)\\lambda}{2}\$ and \$y = \\frac{$(b)\\lambda}{2}\$",
                "Substitute into constraint: \$$(a) \\cdot \\frac{$(a)\\lambda}{2} + $(b) \\cdot \\frac{$(b)\\lambda}{2} = $(c)\$",
                "\$\\frac{$(a^2 + b^2)\\lambda}{2} = $(c)\$, so \$\\lambda = \\frac{$(2c)}{$(a^2 + b^2)}\$",
                sol("Critical point", "x = $(x0), y = $(y0)"),
                sol("Minimum distance", "\\sqrt{$(x0)^2 + $(y0)^2} = $(min_dist)")
            ),
            time=300
        )
    elseif problem_type == 2
        # Maximize product xyz subject to x + y + z = constant (ELO 2600-3000)
        # By AM-GM, maximum occurs when x = y = z
        total = randint(6, 18)
        opt_val = total // 3
        max_product = opt_val^3
        
        problem(
            question="Use Lagrange multipliers to find the maximum value of \$f(x,y,z) = xyz\$ subject to the constraint \$x + y + z = $(total)\$ where \$x, y, z > 0\$.",
            answer=max_product,
            difficulty=(2600, 3000),
            solution=steps(
                "Maximize \$f(x,y,z) = xyz\$ subject to \$g(x,y,z) = x + y + z - $(total) = 0\$",
                "Lagrange conditions: \$\\nabla f = \\lambda \\nabla g\$",
                "\$yz = \\lambda\$, \$xz = \\lambda\$, \$xy = \\lambda\$",
                "From first two equations: \$yz = xz\$, so \$y = x\$ (since \$z > 0\$)",
                "From second and third: \$xz = xy\$, so \$z = y\$ (since \$x > 0\$)",
                "Therefore \$x = y = z\$",
                "Substituting into constraint: \$3x = $(total)\$, so \$x = y = z = $(opt_val)\$",
                sol("Maximum value", "f($(opt_val), $(opt_val), $(opt_val)) = $(opt_val)^3 = $(max_product)")
            ),
            time=300
        )
    elseif problem_type == 3
        # Optimize f(x,y) = x^2 + y^2 + axy subject to x^2 + y^2 = r^2 (ELO 2800-3200)
        r_sq = rand([9, 16, 25, 36])
        r = Int(sqrt(r_sq))
        a = nonzero(-3, 3)
        
        # Critical points on circle via Lagrange
        # At critical point: (2x + ay, 2y + ax) = λ(2x, 2y)
        # This gives: 2x + ay = 2λx and 2y + ax = 2λy
        # Rearranging: ay = 2x(λ-1) and ax = 2y(λ-1)
        # Multiply: a²xy = 4xy(λ-1)²
        # If xy ≠ 0: a² = 4(λ-1)²
        
        # Check critical points: (±r, 0), (0, ±r), and potentially others
        candidates = [
            (r, 0, r^2),
            (-r, 0, r^2),
            (0, r, r^2),
            (0, -r, r^2)
        ]
        
        max_val = maximum([x^2 + y^2 + a*x*y for (x, y, _) in candidates])
        min_val = minimum([x^2 + y^2 + a*x*y for (x, y, _) in candidates])
        
        problem(
            question="Find the maximum value of \$f(x,y) = x^2 + y^2 + $(a)xy\$ subject to the constraint \$x^2 + y^2 = $(r_sq)\$.",
            answer=max_val,
            difficulty=(2800, 3200),
            solution=steps(
                "Set up Lagrange multiplier: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y) = x^2 + y^2 - $(r_sq)\$",
                "\$(2x + $(a)y, 2y + $(a)x) = \\lambda(2x, 2y)\$",
                "This gives: \$2x + $(a)y = 2\\lambda x\$ and \$2y + $(a)x = 2\\lambda y\$",
                "Check boundary critical points: \$(\\pm $(r), 0)\$ and \$(0, \\pm $(r))\$",
                "Evaluate \$f\$ at critical points:",
                "At \$($(r), 0)\$: \$f = $(r^2)\$",
                "At \$(0, $(r))\$: \$f = $(r^2)\$",
                sol("Maximum value", max_val)
            ),
            time=300
        )
    else
        # Minimize surface area of box with fixed volume (ELO 2700-3100)
        volume = rand([64, 125, 216, 343])
        side = Int(round(volume^(1/3)))
        min_area = 6 * side^2
        
        problem(
            question="Use Lagrange multipliers to find the minimum surface area of a rectangular box with sides parallel to the coordinate planes, with volume \$V = $(volume)\$. (Hint: For a box with dimensions \$x \\times y \\times z\$, surface area is \$S = 2(xy + xz + yz)\$.)",
            answer=min_area,
            difficulty=(2700, 3100),
            solution=steps(
                "Minimize \$S(x,y,z) = 2(xy + xz + yz)\$ subject to \$xyz = $(volume)\$",
                "Lagrange conditions: \$\\nabla S = \\lambda \\nabla g\$ where \$g = xyz - $(volume)\$",
                "\$2(y+z) = \\lambda yz\$, \$2(x+z) = \\lambda xz\$, \$2(x+y) = \\lambda xy\$",
                "Divide first equation by second: \$\\frac{y+z}{x+z} = \\frac{y}{x}\$",
                "Cross-multiply: \$x(y+z) = y(x+z)\$, which gives \$xz = yz\$, so \$x = y\$",
                "Similarly, comparing other equations gives \$y = z\$",
                "Therefore \$x = y = z\$, a cube minimizes surface area",
                "From \$x^3 = $(volume)\$: \$x = $(side)\$",
                sol("Minimum surface area", "S = 6 \\cdot $(side)^2 = $(min_area)")
            ),
            time=300
        )
    end
end