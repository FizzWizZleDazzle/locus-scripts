# multivariable_calculus - gradient (very_hard)
# Generated: 2026-03-08T20:59:21.408183

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Gradient and level curves with constrained optimization flavor
        # ELO 2500-3000
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        k = randint(10, 40)
        
        f = a*x^2 + b*y^2 + c*x*y
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        # Find critical point
        crit_x = solve(grad_f_x ~ 0, x)[1]
        crit_y = solve(substitute(grad_f_y, x => crit_x) ~ 0, y)[1]
        
        # Evaluate gradient at a different point
        pt_x = nonzero(-4, 4)
        pt_y = nonzero(-4, 4)
        
        grad_at_pt_x = substitute(grad_f_x, [x => pt_x, y => pt_y])
        grad_at_pt_y = substitute(grad_f_y, [x => pt_x, y => pt_y])
        
        # Magnitude of gradient
        grad_mag = sqrt(grad_at_pt_x^2 + grad_at_pt_y^2)
        ans = simplify(grad_mag)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. The gradient of \$f\$ at the point \$($(pt_x), $(pt_y))\$ is \$\\nabla f($(pt_x), $(pt_y)) = \\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$. Find the magnitude \$\\|\\nabla f($(pt_x), $(pt_y))\\|\$.",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Function", f),
                sol("\\nabla f = \\langle f_x, f_y \\rangle", "\\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                "Evaluate at \$($(pt_x), $(pt_y))\$: \$\\nabla f($(pt_x), $(pt_y)) = \\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$",
                sol("Magnitude", "\\sqrt{($(tex(grad_at_pt_x)))^2 + ($(tex(grad_at_pt_y)))^2} = $(tex(ans))"),
            ),
            time=240,
        )
        
    elseif problem_type == 2
        # Olympiad: Directional derivative and gradient optimization
        # ELO 3000-3500
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        m = nonzero(-4, 4)
        n = nonzero(-4, 4)
        
        f = a*x^3 + b*y^3 + m*x*y
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        pt_x = nonzero(-3, 3)
        pt_y = nonzero(-3, 3)
        
        grad_at_pt_x = substitute(grad_f_x, [x => pt_x, y => pt_y])
        grad_at_pt_y = substitute(grad_f_y, [x => pt_x, y => pt_y])
        
        # Unit vector direction
        u_x = nonzero(-5, 5)
        u_y = nonzero(-5, 5)
        u_norm = sqrt(u_x^2 + u_y^2)
        
        # Directional derivative = grad · u
        dir_deriv = (grad_at_pt_x * u_x + grad_at_pt_y * u_y) / u_norm
        ans = simplify(dir_deriv)
        
        problem(
            question="Consider \$f(x,y) = $(tex(f))\$. At the point \$P = ($(pt_x), $(pt_y))\$, compute the directional derivative of \$f\$ in the direction of the vector \$\\mathbf{v} = \\langle $(u_x), $(u_y) \\rangle\$. Simplify your answer.",
            answer=ans,
            difficulty=(3000, 3400),
            solution=steps(
                sol("Gradient", "\\nabla f = \\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                "At \$P = ($(pt_x), $(pt_y))\$: \$\\nabla f(P) = \\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$",
                "Unit vector: \$\\mathbf{u} = \\frac{1}{$(tex(u_norm))}\\langle $(u_x), $(u_y) \\rangle\$",
                sol("Directional derivative", "D_{\\mathbf{u}}f(P) = \\nabla f(P) \\cdot \\mathbf{u} = \\frac{1}{$(tex(u_norm))}($(tex(grad_at_pt_x)) \\cdot $(u_x) + $(tex(grad_at_pt_y)) \\cdot $(u_y))"),
                sol("Simplified", ans),
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Competition: Maximum rate of change
        # ELO 2600-3000
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        f = a*x^2 + b*x*y + c*y^2
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        pt_x = nonzero(-5, 5)
        pt_y = nonzero(-5, 5)
        
        grad_at_pt_x = substitute(grad_f_x, [x => pt_x, y => pt_y])
        grad_at_pt_y = substitute(grad_f_y, [x => pt_x, y => pt_y])
        
        max_rate = sqrt(grad_at_pt_x^2 + grad_at_pt_y^2)
        ans = simplify(max_rate)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the maximum rate of change of \$f\$ at the point \$($(pt_x), $(pt_y))\$.",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "The maximum rate of change equals \$\\|\\nabla f\\|\$ at the point",
                sol("Gradient", "\\nabla f = \\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                "At \$($(pt_x), $(pt_y))\$: \$\\nabla f = \\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$",
                sol("Maximum rate", "\\|\\nabla f\\| = \\sqrt{($(tex(grad_at_pt_x)))^2 + ($(tex(grad_at_pt_y)))^2} = $(tex(ans))"),
            ),
            time=240,
        )
        
    else
        # Olympiad: Gradient perpendicular to level curve with algebra
        # ELO 3200-3500
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        f = a*x^2 + b*y^2 + c*x*y
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        # Tangent vector to level curve
        tan_x = nonzero(-6, 6)
        tan_y = nonzero(-6, 6)
        
        # At point (x0, y0), gradient perpendicular to tangent means grad · tangent = 0
        # This gives us: grad_f_x(x0,y0) * tan_x + grad_f_y(x0,y0) * tan_y = 0
        
        # Choose a point
        pt_x = nonzero(-4, 4)
        # Solve for pt_y such that perpendicularity holds
        grad_at_x = substitute(grad_f_x, x => pt_x)
        grad_at_y = substitute(grad_f_y, x => pt_x)
        
        # grad_at_x * tan_x + grad_at_y * tan_y = 0
        # Solve for y
        eq = grad_at_x * tan_x + grad_at_y * tan_y ~ 0
        sols = solve(eq, y)
        
        if length(sols) > 0
            pt_y = sols[1]
            if typeof(pt_y) <: Number && abs(pt_y) < 20
                f_val = substitute(f, [x => pt_x, y => pt_y])
                ans = simplify(f_val)
                
                problem(
                    question="Let \$f(x,y) = $(tex(f))\$. At the point \$($(pt_x), y_0)\$ on a level curve of \$f\$, the gradient \$\\nabla f\$ is perpendicular to the tangent vector \$\\langle $(tan_x), $(tan_y) \\rangle\$. Find the value of \$f($(pt_x), y_0)\$ given that this perpendicularity condition determines \$y_0 = $(tex(pt_y))\$.",
                    answer=ans,
                    difficulty=(3200, 3500),
                    solution=steps(
                        sol("Gradient", "\\nabla f = \\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                        "Perpendicularity: \$\\nabla f \\cdot \\langle $(tan_x), $(tan_y) \\rangle = 0\$",
                        "At \$x = $(pt_x)\$: \$($(tex(grad_at_x))) \\cdot $(tan_x) + ($(tex(grad_at_y))) \\cdot $(tan_y) = 0\$",
                        "Solving gives \$y_0 = $(tex(pt_y))\$",
                        sol("Function value", "f($(pt_x), $(tex(pt_y))) = $(tex(ans))"),
                    ),
                    time=300,
                )
            else
                # Fallback to simpler problem
                pt_y = nonzero(-3, 3)
                grad_at_pt_x = substitute(grad_f_x, [x => pt_x, y => pt_y])
                grad_at_pt_y = substitute(grad_f_y, [x => pt_x, y => pt_y])
                ans = simplify(sqrt(grad_at_pt_x^2 + grad_at_pt_y^2))
                
                problem(
                    question="For \$f(x,y) = $(tex(f))\$, find \$\\|\\nabla f($(pt_x), $(pt_y))\\|\$.",
                    answer=ans,
                    difficulty=(2700, 3000),
                    solution=steps(
                        sol("Gradient", "\\nabla f = \\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                        "At \$($(pt_x), $(pt_y))\$: \$\\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$",
                        sol("Magnitude", ans),
                    ),
                    time=240,
                )
            end
        else
            # Another fallback
            pt_y = nonzero(-3, 3)
            grad_at_pt_x = substitute(grad_f_x, [x => pt_x, y => pt_y])
            grad_at_pt_y = substitute(grad_f_y, [x => pt_x, y => pt_y])
            ans = simplify(sqrt(grad_at_pt_x^2 + grad_at_pt_y^2))
            
            problem(
                question="For \$f(x,y) = $(tex(f))\$, compute the magnitude of the gradient at \$($(pt_x), $(pt_y))\$.",
                answer=ans,
                difficulty=(2600, 2900),
                solution=steps(
                    sol("Gradient", "\\nabla f = \\langle $(tex(grad_f_x)), $(tex(grad_f_y)) \\rangle"),
                    "Evaluate at the point: \$\\langle $(tex(grad_at_pt_x)), $(tex(grad_at_pt_y)) \\rangle\$",
                    sol("Magnitude", ans),
                ),
                time=210,
            )
        end
    end
end