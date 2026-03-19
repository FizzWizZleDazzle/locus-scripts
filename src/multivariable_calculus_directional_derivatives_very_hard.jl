# multivariable_calculus - directional_derivatives (very_hard)
# Generated: 2026-03-08T20:59:52.956165

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition level: Find directional derivative in direction of maximum increase
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        f = a*x^2 + b*y^2 + c*x*y + d*x
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        max_rate = sqrt(fx_val^2 + fy_val^2)
        ans = simplify(max_rate)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the maximum rate of change of \$f\$ at the point \$($(x0), $(y0))\$.",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given function", f),
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At point \$($(x0), $(y0))\$: \$\\nabla f = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "Maximum rate of change equals \$\\|\\nabla f\\| = \\sqrt{$(fx_val)^2 + $(fy_val)^2}\$",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Competition level: Directional derivative with constraint
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        f = a*x^2 + b*x*y + c*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        # Direction vector
        v1 = nonzero(-5, 5)
        v2 = nonzero(-5, 5)
        
        # Normalize
        norm_v = sqrt(v1^2 + v2^2)
        u1 = v1 // norm_v
        u2 = v2 // norm_v
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        D_u = fx_val * u1 + fy_val * u2
        ans = simplify(D_u)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the directional derivative of \$f\$ at \$($(x0), $(y0))\$ in the direction of the vector \$\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\$.",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                sol("Given", f),
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At \$($(x0), $(y0))\$: \$\\nabla f = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "Normalize direction: \$\\mathbf{u} = \\frac{1}{$(tex(norm_v))}\\langle $(v1), $(v2) \\rangle\$",
                "Directional derivative: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u} = $(tex(ans))\$",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Olympiad level: Three variables with critical analysis
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        f = a*x^2 + b*y^2 + c*z^2 + x*y + y*z
        
        x0 = randint(-2, 2)
        y0 = randint(-2, 2)
        z0 = randint(-2, 2)
        
        # Unit direction
        d1 = nonzero(-3, 3)
        d2 = nonzero(-3, 3)
        d3 = nonzero(-3, 3)
        
        norm_d = sqrt(d1^2 + d2^2 + d3^2)
        
        fx = diff(f, x)
        fy = diff(f, y)
        fz = diff(f, z)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0, z => z0))
        fy_val = substitute(fy, Dict(x => x0, y => y0, z => z0))
        fz_val = substitute(fz, Dict(x => x0, y => y0, z => z0))
        
        D_u = (fx_val * d1 + fy_val * d2 + fz_val * d3) // norm_d
        ans = simplify(D_u)
        
        problem(
            question="Let \$f(x,y,z) = $(tex(f))\$. Compute the directional derivative of \$f\$ at the point \$($(x0), $(y0), $(z0))\$ in the direction of \$\\mathbf{v} = \\langle $(d1), $(d2), $(d3) \\rangle\$.",
            answer=ans,
            difficulty=(3000, 3300),
            solution=steps(
                sol("Function", f),
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)), $(tex(fz)) \\rangle\$",
                "Evaluate at point: \$\\nabla f($(x0), $(y0), $(z0)) = \\langle $(fx_val), $(fy_val), $(fz_val) \\rangle\$",
                "Unit vector: \$\\mathbf{u} = \\frac{1}{\\sqrt{$(d1^2 + d2^2 + d3^2)}}\\langle $(d1), $(d2), $(d3) \\rangle\$",
                "Directional derivative: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u}\$",
                sol("Answer", ans)
            ),
            time=300
        )
        
    else
        # Olympiad level: Find direction for zero directional derivative
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        f = a*x*y + b*x^2 + c*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Perpendicular direction to gradient
        v1 = -fy_val
        v2 = fx_val
        
        gcd_val = gcd(abs(v1), abs(v2))
        if gcd_val > 1
            v1 = v1 // gcd_val
            v2 = v2 // gcd_val
        end
        
        ans = "\\langle $(v1), $(v2) \\rangle"
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find a nonzero direction vector \$\\mathbf{v}\$ such that the directional derivative of \$f\$ at \$($(x0), $(y0))\$ in the direction of \$\\mathbf{v}\$ equals zero. Express your answer as an ordered pair (up to scalar multiples).",
            answer=ans,
            difficulty=(3200, 3500),
            answer_type="vector",
            solution=steps(
                sol("Function", f),
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At \$($(x0), $(y0))\$: \$\\nabla f = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "For zero directional derivative, need \$\\mathbf{v} \\perp \\nabla f\$",
                "Perpendicular vector: \$\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\$ (or any scalar multiple)",
                sol("Answer", ans)
            ),
            time=270
        )
    end
end