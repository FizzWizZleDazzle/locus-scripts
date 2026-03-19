# multivariable_calculus - directional_derivatives (easy)
# Generated: 2026-03-08T20:59:23.926782

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Compute directional derivative at a point given gradient and direction vector
        # ELO: 700-900 (basic definition, plug and chug)
        
        gx = randint(-8, 8)
        gy = randint(-8, 8)
        vx = nonzero(-5, 5)
        vy = nonzero(-5, 5)
        
        # Normalize direction vector
        vmag = sqrt(vx^2 + vy^2)
        
        # Directional derivative = gradient · unit vector
        dir_deriv = (gx * vx + gy * vy) / vmag
        
        problem(
            question = "Given \\nabla f(a,b) = \\langle $(gx), $(gy) \\rangle and direction vector \\mathbf{v} = \\langle $(vx), $(vy) \\rangle, compute the directional derivative D_{\\mathbf{v}}f(a,b).",
            answer = dir_deriv,
            difficulty = (700, 900),
            solution = steps(
                "The directional derivative is given by \\(D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u}\\) where \\(\\mathbf{u}\\) is the unit vector in direction \\(\\mathbf{v}\\)",
                sol("Magnitude of \\mathbf{v}", "||\\mathbf{v}|| = \\sqrt{$(vx)^2 + $(vy)^2} = $(tex(vmag))"),
                sol("Unit vector", "\\mathbf{u} = \\frac{1}{$(tex(vmag))} \\langle $(vx), $(vy) \\rangle"),
                sol("Directional derivative", "D_{\\mathbf{v}}f = \\langle $(gx), $(gy) \\rangle \\cdot \\frac{1}{$(tex(vmag))} \\langle $(vx), $(vy) \\rangle = \\frac{$(gx*vx + gy*vy)}{$(tex(vmag))} = $(tex(dir_deriv))")
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # Type 2: Find gradient and then directional derivative
        # ELO: 900-1100 (compute partial derivatives, then apply definition)
        
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(-10, 10)
        
        @variables x y
        f = a*x^2 + b*y^2 + c*x*y
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        vx = nonzero(-4, 4)
        vy = nonzero(-4, 4)
        vmag = sqrt(vx^2 + vy^2)
        
        dir_deriv = (fx_val * vx + fy_val * vy) / vmag
        
        problem(
            question = "Let \\(f(x,y) = $(tex(f))\\). Find the directional derivative of \\(f\\) at the point \\(($(x0), $(y0))\\) in the direction of \\(\\mathbf{v} = \\langle $(vx), $(vy) \\rangle\\).",
            answer = dir_deriv,
            difficulty = (900, 1100),
            solution = steps(
                sol("Compute partial derivatives", "f_x = $(tex(fx)), \\quad f_y = $(tex(fy))"),
                sol("Evaluate at ($(x0), $(y0))", "\\nabla f($(x0), $(y0)) = \\langle $(fx_val), $(fy_val) \\rangle"),
                sol("Unit vector", "\\mathbf{u} = \\frac{1}{$(tex(vmag))} \\langle $(vx), $(vy) \\rangle"),
                sol("Directional derivative", "D_{\\mathbf{v}}f = \\langle $(fx_val), $(fy_val) \\rangle \\cdot \\frac{1}{$(tex(vmag))} \\langle $(vx), $(vy) \\rangle = $(tex(dir_deriv))")
            ),
            time = 120
        )
        
    elseif problem_type == 3
        # Type 3: Maximum rate of change (direction of gradient)
        # ELO: 1000-1200 (conceptual understanding that max is ||gradient||)
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        @variables x y
        f = a*x*y + b*x + c*y
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        max_rate = sqrt(fx_val^2 + fy_val^2)
        
        problem(
            question = "Let \\(f(x,y) = $(tex(f))\\). Find the maximum rate of change of \\(f\\) at the point \\(($(x0), $(y0))\\).",
            answer = max_rate,
            difficulty = (1000, 1200),
            solution = steps(
                "The maximum rate of change occurs in the direction of the gradient and equals \\(||\\nabla f||\\)",
                sol("Compute gradient", "\\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle"),
                sol("Evaluate at ($(x0), $(y0))", "\\nabla f($(x0), $(y0)) = \\langle $(fx_val), $(fy_val) \\rangle"),
                sol("Maximum rate", "||\\nabla f|| = \\sqrt{($(fx_val))^2 + ($(fy_val))^2} = $(tex(max_rate))")
            ),
            time = 100
        )
        
    else
        # Type 4: Directional derivative equals zero (perpendicular to gradient)
        # ELO: 800-1000 (understanding dot product and perpendicularity)
        
        gx = nonzero(-8, 8)
        gy = nonzero(-8, 8)
        
        # Direction perpendicular to gradient: swap and negate one component
        vx = -gy
        vy = gx
        
        problem(
            question = "Given \\(\\nabla f(2,3) = \\langle $(gx), $(gy) \\rangle\\), find a direction vector \\(\\mathbf{v}\\) such that the directional derivative \\(D_{\\mathbf{v}}f(2,3) = 0\\).",
            answer = fmt_tuple([vx, vy]),
            difficulty = (800, 1000),
            answer_type = "tuple",
            solution = steps(
                "The directional derivative equals zero when the direction is perpendicular to the gradient",
                "For \\(\\mathbf{v} \\perp \\nabla f\\), we need \\(\\mathbf{v} \\cdot \\nabla f = 0\\)",
                sol("Perpendicular vector", "\\mathbf{v} = \\langle $(vx), $(vy) \\rangle"),
                "Verify: \\(\\langle $(vx), $(vy) \\rangle \\cdot \\langle $(gx), $(gy) \\rangle = $(vx*gx + vy*gy) = 0\\)"
            ),
            time = 90
        )
    end
end