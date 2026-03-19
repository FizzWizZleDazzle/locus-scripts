# algebra1 - systems_substitution (competition)
# Generated: 2026-03-08T19:58:06.130072

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # For OLYMPIAD to RESEARCH-ADJACENT (3500-5000), we need highly non-standard systems
    # that require deep insight, creative substitution strategies, and multiple layers
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Symmetric system with high-degree terms requiring substitution of sum/product
        # Example: x + y = s, xy = p form with constraints
        s = randint(-8, 8)
        p = randint(-20, 20)
        
        # Create a system where x + y and xy appear in complex ways
        # x^3 + y^3 = (x+y)^3 - 3xy(x+y)
        # x^2 + y^2 = (x+y)^2 - 2xy
        
        val1 = s^3 - 3*p*s
        val2 = s^2 - 2*p
        
        # Find actual solutions
        # x and y are roots of t^2 - s*t + p = 0
        disc = s^2 - 4*p
        
        if disc >= 0
            sqrt_disc = sqrt(disc)
            x_sol = (s + sqrt_disc) / 2
            y_sol = (s - sqrt_disc) / 2
            
            ans = fmt_set(Set([(x_sol, y_sol), (y_sol, x_sol)]))
            
            problem(
                question="Solve the system:\n\$\$\\begin{cases} x^3 + y^3 = $(val1) \\\\ x^2 + y^2 = $(val2) \\end{cases}\$\$",
                answer=ans,
                difficulty=(3500, 3800),
                answer_type="set",
                solution=steps(
                    "Let \$s = x + y\$ and \$p = xy\$",
                    "Note that \$x^3 + y^3 = (x+y)^3 - 3xy(x+y) = s^3 - 3ps\$ and \$x^2 + y^2 = (x+y)^2 - 2xy = s^2 - 2p\$",
                    "From the second equation: \$s^2 - 2p = $(val2)\$, so \$p = \\frac{s^2 - $(val2)}{2}\$",
                    "Substitute into first: \$s^3 - 3s \\cdot \\frac{s^2 - $(val2)}{2} = $(val1)\$",
                    "Simplify: \$2s^3 - 3s^3 + $(3*val2)s = $(2*val1)\$, which gives \$-s^3 + $(3*val2)s = $(2*val1)\$",
                    "Solving yields \$s = $(s)\$ and \$p = $(p)\$",
                    "Thus \$x\$ and \$y\$ are roots of \$t^2 - $(s)t + $(p) = 0\$",
                    sol("Solutions", ans)
                ),
                time=300
            )
        else
            # Complex case - create different problem
            a = nonzero(-5, 5)
            b = nonzero(-5, 5)
            c = randint(-15, 15)
            
            x_sol = randint(-10, 10)
            y_sol = randint(-10, 10)
            
            rhs1 = a*x_sol^2 + b*y_sol^2
            rhs2 = x_sol * y_sol
            
            ans = fmt_set(Set([(x_sol, y_sol), (-x_sol, -y_sol)]))
            
            problem(
                question="Solve the system:\n\$\$\\begin{cases} $(a)x^2 + $(b)y^2 = $(rhs1) \\\\ xy = $(rhs2) \\end{cases}\$\$",
                answer=ans,
                difficulty=(3600, 3900),
                answer_type="set",
                solution=steps(
                    "From the second equation: \$y = \\frac{$(rhs2)}{x}\$",
                    "Substitute into first equation: \$$(a)x^2 + $(b)\\left(\\frac{$(rhs2)}{x}\\right)^2 = $(rhs1)\$",
                    "Multiply by \$x^2\$: \$$(a)x^4 + $(b*rhs2^2) = $(rhs1)x^2\$",
                    "This is a quartic in \$x\$, but symmetric, so let \$u = x^2\$",
                    "Solve \$$(a)u^2 - $(rhs1)u + $(b*rhs2^2) = 0\$ to get \$u = $(x_sol^2)\$",
                    "Thus \$x = \\pm$(abs(x_sol))\$ and \$y = \\pm$(abs(y_sol))\$",
                    sol("Solutions", ans)
                ),
                time=300
            )
        end
        
    elseif problem_type == 2
        # Exponential substitution system
        # Let u = a^x, v = b^y
        base_a = choice([2, 3, 5])
        base_b = choice([2, 3, 5])
        
        x_val = randint(2, 5)
        y_val = randint(2, 5)
        
        u_val = base_a^x_val
        v_val = base_b^y_val
        
        coef1 = nonzero(-3, 3)
        coef2 = nonzero(-3, 3)
        
        rhs1 = coef1 * u_val + coef2 * v_val
        rhs2 = u_val * v_val
        
        ans = fmt_tuple((x_val, y_val))
        
        problem(
            question="Solve the system:\n\$\$\\begin{cases} $(coef1) \\cdot $(base_a)^x + $(coef2) \\cdot $(base_b)^y = $(rhs1) \\\\ $(base_a)^x \\cdot $(base_b)^y = $(rhs2) \\end{cases}\$\$",
            answer=ans,
            difficulty=(3700, 4100),
            answer_type="tuple",
            solution=steps(
                "Let \$u = $(base_a)^x\$ and \$v = $(base_b)^y\$",
                "System becomes: \$$(coef1)u + $(coef2)v = $(rhs1)\$ and \$uv = $(rhs2)\$",
                "From second equation: \$v = \\frac{$(rhs2)}{u}\$",
                "Substitute: \$$(coef1)u + $(coef2) \\cdot \\frac{$(rhs2)}{u} = $(rhs1)\$",
                "Solve the resulting equation to get \$u = $(u_val)\$ and \$v = $(v_val)\$",
                "Therefore \$x = \\log_{$(base_a)}($(u_val)) = $(x_val)\$ and \$y = \\log_{$(base_b)}($(v_val)) = $(y_val)\$",
                sol("Answer", ans)
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Parametric circle/ellipse intersection requiring substitution
        r1 = randint(3, 8)
        r2 = randint(3, 8)
        h = randint(-5, 5)
        k = randint(-5, 5)
        
        # Create solutions
        x_sol = randint(-r1, r1)
        y_from_circle = sqrt(r1^2 - x_sol^2)
        
        # Check if point is on ellipse
        if abs(x_sol - h) <= r2
            y_sol_candidate = sqrt(r2^2 - (x_sol - h)^2) + k
            
            if abs(y_sol_candidate - y_from_circle) < 0.5
                y_sol = round(Int, y_from_circle)
            else
                y_sol = randint(-r1, r1)
            end
        else
            y_sol = randint(-r1, r1)
        end
        
        ans = "Multiple solutions require numerical methods"
        
        problem(
            question="Find all real solutions to:\n\$\$\\begin{cases} x^2 + y^2 = $(r1^2) \\\\ (x - $(h))^2 + (y - $(k))^2 = $(r2^2) \\end{cases}\$\$",
            answer="Use substitution and radical simplification",
            difficulty=(3800, 4200),
            answer_type="expression",
            solution=steps(
                "From first equation: \$y^2 = $(r1^2) - x^2\$",
                "Expand second: \$x^2 - $(2*h)x + $(h^2) + y^2 - $(2*k)y + $(k^2) = $(r2^2)\$",
                "Substitute \$y^2 = $(r1^2) - x^2\$: \$x^2 - $(2*h)x + $(h^2) + $(r1^2) - x^2 - $(2*k)y + $(k^2) = $(r2^2)\$",
                "Simplify to linear in \$y\$: \$-$(2*k)y = $(r2^2 - h^2 - k^2 - r1^2) + $(2*h)x\$",
                "Solve for \$y\$, substitute back into circle equation",
                "This yields a quartic that factors based on geometric intersection points",
                "Solutions represent circle-circle intersection points"
            ),
            time=300
        )
        
    else
        # Radical system requiring nested substitution
        a = randint(2, 6)
        b = randint(2, 6)
        c = randint(10, 30)
        d = randint(5, 20)
        
        # Work backward from clean solution
        x_sol = randint(4, 16)
        y_sol = randint(4, 16)
        
        # Create system: sqrt(ax + by) and sqrt terms
        inner1 = a*x_sol + b*y_sol
        inner2 = x_sol - y_sol
        
        if inner1 > 0 && inner2 > 0
            sqrt1 = round(Int, sqrt(inner1))
            sqrt2 = round(Int, sqrt(abs(inner2)))
            
            rhs1 = sqrt1^2
            rhs2 = sqrt2^2
            
            ans = fmt_tuple((x_sol, y_sol))
            
            problem(
                question="Solve the system for positive \$x, y\$:\n\$\$\\begin{cases} $(a)x + $(b)y = $(rhs1) \\\\ x - y = $(rhs2) \\end{cases}\$\$\n\nwhere both equations must hold under the constraint that \$\\sqrt{$(a)x + $(b)y} + \\sqrt{x - y} = $(sqrt1 + sqrt2)\$",
                answer=ans,
                difficulty=(3900, 4400),
                answer_type="tuple",
                solution=steps(
                    "Let \$u = \\sqrt{$(a)x + $(b)y}\$ and \$v = \\sqrt{x - y}\$",
                    "We have \$u + v = $(sqrt1 + sqrt2)\$, \$u^2 = $(rhs1)\$, \$v^2 = $(rhs2)\$",
                    "From \$u^2 = $(rhs1)\$: \$u = $(sqrt1)\$; from \$v^2 = $(rhs2)\$: \$v = $(sqrt2)\$",
                    "Verify: \$$(sqrt1) + $(sqrt2) = $(sqrt1 + sqrt2)\$ ✓",
                    "Now solve: \$$(a)x + $(b)y = $(rhs1)\$ and \$x - y = $(rhs2)\$",
                    "From second: \$x = y + $(rhs2)\$. Substitute: \$$(a)(y + $(rhs2)) + $(b)y = $(rhs1)\$",
                    "Solve: \$y = $(y_sol)\$, then \$x = $(x_sol)\$",
                    sol("Answer", ans)
                ),
                time=300
            )
        else
            # Fallback to high-degree polynomial system
            x_sol = randint(2, 6)
            y_sol = randint(2, 6)
            
            rhs1 = x_sol^3 + y_sol^3
            rhs2 = x_sol^2 * y_sol + x_sol * y_sol^2
            
            ans = fmt_tuple((x_sol, y_sol))
            
            problem(
                question="Solve for positive integers:\n\$\$\\begin{cases} x^3 + y^3 = $(rhs1) \\\\ x^2y + xy^2 = $(rhs2) \\end{cases}\$\$",
                answer=ans,
                difficulty=(4000, 4500),
                answer_type="tuple",
                solution=steps(
                    "Factor second equation: \$xy(x + y) = $(rhs2)\$",
                    "Let \$s = x + y\$ and \$p = xy\$. Then \$ps = $(rhs2)\$",
                    "First equation: \$x^3 + y^3 = (x+y)^3 - 3xy(x+y) = s^3 - 3ps = $(rhs1)\$",
                    "Substitute \$p = \\frac{$(rhs2)}{s}\$: \$s^3 - 3s \\cdot \\frac{$(rhs2)}{s} = $(rhs1)\$",
                    "Simplify: \$s^3 - $(3*rhs2) = $(rhs1)\$, so \$s^3 = $(rhs1 + 3*rhs2)\$",
                    "Solve for \$s\$, then find \$p\$, then solve \$t^2 - st + p = 0\$ for \$x, y\$",
                    sol("Answer", ans)
                ),
                time=300
            )
        end
    end
end