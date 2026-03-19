# multivariable_calculus - lagrange_multipliers (competition)
# Generated: 2026-03-08T21:00:58.743087

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Extreme optimization with geometric constraint (OLYMPIAD level)
        a = nonzero(2, 8)
        b = nonzero(2, 8)
        c = nonzero(2, 8)
        k = randint(10, 50)
        
        # Optimize x^a * y^b * z^c subject to x + y + z = k
        # Critical point: x = ak/(a+b+c), y = bk/(a+b+c), z = ck/(a+b+c)
        denom = a + b + c
        x_opt = a * k // denom
        y_opt = b * k // denom
        z_opt = c * k // denom
        
        max_val = simplify(x_opt^a * y_opt^b * z_opt^c)
        
        question = "Find the maximum value of \$f(x,y,z) = x^{$a} y^{$b} z^{$c}\$ subject to the constraint \$x + y + z = $k\$ where \$x, y, z > 0\$. Express your answer as an exact simplified expression."
        
        solution = steps(
            "Set up Lagrange multiplier equations: \$\\nabla f = \\lambda \\nabla g\$ where \$g(x,y,z) = x + y + z - $k\$",
            sol("∇f", "\\langle $(a)x^{$(a-1)}y^{$b}z^{$c}, $(b)x^{$a}y^{$(b-1)}z^{$c}, $(c)x^{$a}y^{$b}z^{$(c-1)} \\rangle"),
            "This gives: \$$(a)x^{$(a-1)}y^{$b}z^{$c} = \\lambda\$, \$$(b)x^{$a}y^{$(b-1)}z^{$c} = \\lambda\$, \$$(c)x^{$a}y^{$b}z^{$(c-1)} = \\lambda\$",
            "From the first two equations: \$\\frac{$a}{x} = \\frac{$b}{y}\$, so \$y = \\frac{$(b)x}{$a}\$",
            "From the first and third: \$\\frac{$a}{x} = \\frac{$c}{z}\$, so \$z = \\frac{$(c)x}{$a}\$",
            "Substitute into constraint: \$x + \\frac{$(b)x}{$a} + \\frac{$(c)x}{$a} = $k\$",
            "Solving: \$x = \\frac{$(a * k)}{$(denom)}\$, \$y = \\frac{$(b * k)}{$(denom)}\$, \$z = \\frac{$(c * k)}{$(denom)}\$",
            sol("Maximum value", max_val)
        )
        
        problem(
            question=question,
            answer=max_val,
            difficulty=(3500, 4200),
            solution=solution,
            time=420
        )
        
    elseif problem_type == 2
        # Minimize distance with nonlinear constraint (OLYMPIAD level)
        a = nonzero(2, 6)
        b = nonzero(2, 6)
        c = randint(10, 40)
        
        # Minimize x^2 + y^2 subject to x^a + y^b = c
        # At critical point: x^(a-2) / y^(b-2) = ratio determined by a,b
        
        p_x = randint(1, 5)
        p_y = randint(1, 5)
        target = p_x^a + p_y^b
        
        min_dist_sq = p_x^2 + p_y^2
        
        question = "Find the minimum value of \$x^2 + y^2\$ subject to the constraint \$x^{$a} + y^{$b} = $target\$ where \$x, y \\geq 0\$."
        
        solution = steps(
            "Use Lagrange multipliers: minimize \$f(x,y) = x^2 + y^2\$ subject to \$g(x,y) = x^{$a} + y^{$b} - $target = 0\$",
            "Set \$\\nabla f = \\lambda \\nabla g\$: \$\\langle 2x, 2y \\rangle = \\lambda \\langle $(a)x^{$(a-1)}, $(b)y^{$(b-1)} \\rangle\$",
            "This gives: \$2x = \\lambda $(a) x^{$(a-1)}\$ and \$2y = \\lambda $(b) y^{$(b-1)}\$",
            "From these: \$\\frac{2}{$(a)x^{$(a-2)}} = \\frac{2}{$(b)y^{$(b-2)}}\$",
            "Testing critical points and boundary conditions",
            sol("Critical point", "($p_x, $p_y)"),
            sol("Minimum distance²", min_dist_sq)
        )
        
        problem(
            question=question,
            answer=min_dist_sq,
            difficulty=(3800, 4500),
            solution=solution,
            time=480
        )
        
    elseif problem_type == 3
        # Optimization with multiple constraints (RESEARCH-ADJACENT)
        k1 = randint(5, 15)
        k2 = randint(5, 15)
        
        # Maximize xyz subject to x + y = k1, x + z = k2
        # From constraints: y = k1 - x, z = k2 - x
        # Maximize x(k1-x)(k2-x)
        
        x_vals = []
        for test_x in 1:min(k1, k2)
            push!(x_vals, (test_x, test_x * (k1 - test_x) * (k2 - test_x)))
        end
        
        x_opt = 1
        max_prod = 0
        for (x_val, prod) in x_vals
            if prod > max_prod
                max_prod = prod
                x_opt = x_val
            end
        end
        
        y_opt = k1 - x_opt
        z_opt = k2 - x_opt
        
        question = "Find the maximum value of \$xyz\$ subject to the constraints \$x + y = $k1\$ and \$x + z = $k2\$ where \$x, y, z > 0\$."
        
        solution = steps(
            "Set up Lagrange multipliers with two constraints: \$\\nabla f = \\lambda_1 \\nabla g_1 + \\lambda_2 \\nabla g_2\$",
            "Where \$f(x,y,z) = xyz\$, \$g_1(x,y,z) = x + y - $k1\$, \$g_2(x,y,z) = x + z - $k2\$",
            "\$\\nabla f = \\langle yz, xz, xy \\rangle\$, \$\\nabla g_1 = \\langle 1, 1, 0 \\rangle\$, \$\\nabla g_2 = \\langle 1, 0, 1 \\rangle\$",
            "System: \$yz = \\lambda_1 + \\lambda_2\$, \$xz = \\lambda_1\$, \$xy = \\lambda_2\$",
            "From constraints: \$y = $(k1) - x\$, \$z = $(k2) - x\$",
            "Substitute and optimize: \$f(x) = x($(k1)-x)($(k2)-x)\$",
            sol("Critical point", "($x_opt, $y_opt, $z_opt)"),
            sol("Maximum value", max_prod)
        )
        
        problem(
            question=question,
            answer=max_prod,
            difficulty=(4000, 4800),
            solution=solution,
            time=540
        )
        
    else
        # Constrained optimization with symmetry breaking (RESEARCH-ADJACENT)
        n = rand([3, 4, 5])
        S = randint(15, 40)
        
        # Maximize x₁^p₁ * x₂^p₂ * ... * xₙ^pₙ subject to x₁ + x₂ + ... + xₙ = S
        powers = [nonzero(1, 4) for _ in 1:n]
        sum_powers = sum(powers)
        
        x_opts = [p * S // sum_powers for p in powers]
        
        prod_expr = join(["x_$i^{$(powers[i])}" for i in 1:n], " \\cdot ")
        constraint_expr = join(["x_$i" for i in 1:n], " + ")
        
        max_val_num = prod([float(x_opts[i])^powers[i] for i in 1:n])
        max_val = round(Int, max_val_num)
        
        question = "Find the maximum value of \$$prod_expr\$ subject to \$$constraint_expr = $S\$ where all \$x_i > 0\$. Round to the nearest integer."
        
        solution = steps(
            "Apply generalized AM-GM with Lagrange multipliers",
            "Set up: \$\\nabla(\\prod x_i^{p_i}) = \\lambda \\nabla(\\sum x_i - $S)\$",
            "For weighted products, critical point satisfies: \$\\frac{p_i}{x_i}\$ is constant for all \$i\$",
            "This gives: \$x_i = \\frac{p_i \\cdot $S}{\\sum p_j} = \\frac{$(powers[1]) \\cdot $S}{$sum_powers}\$ (for first variable)",
            "Similarly for all variables using their respective powers",
            "Compute product at critical point",
            sol("Maximum value", max_val)
        )
        
        problem(
            question=question,
            answer=max_val,
            difficulty=(4200, 5000),
            solution=solution,
            time=600
        )
    end
end