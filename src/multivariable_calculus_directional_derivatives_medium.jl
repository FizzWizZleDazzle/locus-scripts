# multivariable_calculus - directional_derivatives (medium)
# Generated: 2026-03-08T20:59:38.301181

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Compute directional derivative at a point given f and direction vector
        # ELO: 1200-1400
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        f = a*x^2 + b*y^2 + c*x*y
        
        x0 = randint(-4, 4)
        y0 = randint(-4, 4)
        
        # Direction vector
        v1 = nonzero(-5, 5)
        v2 = nonzero(-5, 5)
        mag = sqrt(v1^2 + v2^2)
        
        # Gradient at point
        fx = diff(f, x)
        fy = diff(f, y)
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Directional derivative
        ans = (fx_val * v1 + fy_val * v2) / mag
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the directional derivative of \$f\$ at the point \$($(x0), $(y0))\$ in the direction of the vector \$\\mathbf{v} = \\langle $(v1), $(v2) \\rangle\$.",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given function", f),
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At point \$($(x0), $(y0))\$: \$\\nabla f($(x0), $(y0)) = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "Unit vector: \$\\mathbf{u} = \\frac{1}{$(tex(mag))} \\langle $(v1), $(v2) \\rangle\$",
                "Directional derivative: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u} = \\frac{$(fx_val)($(v1)) + $(fy_val)($(v2))}{$(tex(mag))}\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Find direction of maximum rate of increase
        # ELO: 1300-1500
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(-3, 3)
        f = a*x^2 + b*x*y + c*y
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        ans_str = "\\langle $(fx_val), $(fy_val) \\rangle"
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the direction (as a vector) in which \$f\$ increases most rapidly at the point \$($(x0), $(y0))\$.",
            answer=ans_str,
            difficulty=(1300, 1500),
            answer_type="vector",
            solution=steps(
                sol("Given function", f),
                "The direction of maximum increase is the gradient vector",
                "Compute: \$\\frac{\\partial f}{\\partial x} = $(tex(fx))\$, \$\\frac{\\partial f}{\\partial y} = $(tex(fy))\$",
                "At point \$($(x0), $(y0))\$: \$\\nabla f($(x0), $(y0)) = \\langle $(fx_val), $(fy_val) \\rangle\$",
                sol("Answer", ans_str)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Compute maximum rate of change (magnitude of gradient)
        # ELO: 1400-1600
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        f = a*x*y + b*x + c*y
        
        x0 = randint(-4, 4)
        y0 = randint(-4, 4)
        
        fx = diff(f, x)
        fy = diff(f, y)
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        ans = sqrt(fx_val^2 + fy_val^2)
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the maximum rate of change of \$f\$ at the point \$($(x0), $(y0))\$.",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given function", f),
                "Maximum rate of change equals \$\\|\\nabla f\\|\$",
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At point \$($(x0), $(y0))\$: \$\\nabla f = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "Magnitude: \$\\|\\nabla f\\| = \\sqrt{($(fx_val))^2 + ($(fy_val))^2}\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Directional derivative equals given value - find relationship
        # ELO: 1500-1800
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        f = a*x^2 + b*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Ask for directional derivative in direction making angle θ with positive x-axis
        target_val = randint(-20, 20)
        
        # D_u f = fx_val * cos(θ) + fy_val * sin(θ) = target_val
        # This is for a specific angle, but we'll ask them to compute it
        
        theta_deg = choice([0, 30, 45, 60, 90, 120, 135, 150, 180])
        theta_rad = theta_deg * π / 180
        
        u1 = cos(theta_rad)
        u2 = sin(theta_rad)
        
        ans = fx_val * u1 + fy_val * u2
        
        problem(
            question="Let \$f(x,y) = $(tex(f))\$. Find the directional derivative of \$f\$ at the point \$($(x0), $(y0))\$ in the direction making an angle of \$$(theta_deg)^\\circ\$ with the positive \$x\$-axis.",
            answer=ans,
            difficulty=(1500, 1800),
            solution=steps(
                sol("Given function", f),
                "Direction vector: \$\\mathbf{u} = \\langle \\cos($(theta_deg)^\\circ), \\sin($(theta_deg)^\\circ) \\rangle = \\langle $(tex(u1)), $(tex(u2)) \\rangle\$",
                "Compute gradient: \$\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle\$",
                "At \$($(x0), $(y0))\$: \$\\nabla f = \\langle $(fx_val), $(fy_val) \\rangle\$",
                "Directional derivative: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u} = $(fx_val) \\cdot $(tex(u1)) + $(fy_val) \\cdot $(tex(u2))\$",
                sol("Answer", ans)
            ),
            time=150
        )
    end
end