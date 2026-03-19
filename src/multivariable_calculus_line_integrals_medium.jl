# multivariable_calculus - line_integrals (medium)
# Generated: 2026-03-08T21:04:36.693131

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("multivariable_calculus/line_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Scalar line integral over a straight line segment
        # ELO 1200-1400
        x0, y0 = randint(-8, 8), randint(-8, 8)
        x1, y1 = randint(-8, 8), randint(-8, 8)
        while x0 == x1 && y0 == y1
            x1, y1 = randint(-8, 8), randint(-8, 8)
        end
        
        # Simple scalar function f(x,y) = ax + by + c
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        f = a*x + b*y + c
        
        # Parametrize: r(t) = (x0, y0) + t((x1-x0), (y1-y0)), t in [0,1]
        dx = x1 - x0
        dy = y1 - y0
        arc_length = sqrt(dx^2 + dy^2)
        
        # Substitute parametrization
        x_param = x0 + t*dx
        y_param = y0 + t*dy
        f_param = substitute(f, [x => x_param, y => y_param])
        f_param = expand(f_param)
        
        # ds = sqrt((dx/dt)^2 + (dy/dt)^2) dt = sqrt(dx^2 + dy^2) dt
        integrand = f_param * arc_length
        integrand = expand(integrand)
        
        # Integrate from 0 to 1
        # Manual integration of polynomial in t
        result = substitute(integrand, t => 1) - substitute(integrand, t => 0)
        result = simplify(result)
        
        ans = Float64(result)
        
        problem(
            question="Evaluate the scalar line integral \\int_C $(tex(f)) \\, ds where C is the line segment from ($(x0), $(y0)) to ($(x1), $(y1)).",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given function", f),
                "Parametrize C: \\mathbf{r}(t) = ($(x0) + $(dx)t, $(y0) + $(dy)t), t \\in [0,1]",
                "Compute ds = \\sqrt{($(dx))^2 + ($(dy))^2} \\, dt = $(round(arc_length, digits=3)) \\, dt",
                sol("Substitute into f", f_param),
                sol("Integrand", integrand),
                "Integrate from 0 to 1",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Vector line integral F · dr over a curve
        # ELO 1300-1500
        # F = (P, Q) and curve is parametrized
        
        # Simple vector field F = (ay, bx)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        P = a*y
        Q = b*x
        
        # Circle parametrization or simple path
        path_type = rand(1:2)
        
        if path_type == 1
            # Circle x = r*cos(t), y = r*sin(t), t in [0, 2π]
            r = randint(1, 5)
            
            # x(t) = r*cos(t), y(t) = r*sin(t)
            # dx = -r*sin(t) dt, dy = r*cos(t) dt
            # P(x(t), y(t)) = a*r*sin(t)
            # Q(x(t), y(t)) = b*r*cos(t)
            # F · dr = a*r*sin(t)*(-r*sin(t)) + b*r*cos(t)*(r*cos(t))
            #        = -a*r²*sin²(t) + b*r²*cos²(t)
            
            # Integral from 0 to 2π
            # = -a*r²*π + b*r²*π = (b - a)*r²*π
            ans = (b - a) * r^2 * π
            
            problem(
                question="Evaluate \\int_C \\mathbf{F} \\cdot d\\mathbf{r} where \\mathbf{F} = ($(tex(P)), $(tex(Q))) and C is the circle x^2 + y^2 = $(r^2) traversed counterclockwise.",
                answer=Float64(ans),
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Vector field", "\\mathbf{F} = ($(tex(P)), $(tex(Q)))"),
                    "Parametrize C: \\mathbf{r}(t) = ($(r)\\cos(t), $(r)\\sin(t)), t \\in [0, 2\\pi]",
                    "Compute d\\mathbf{r} = (-$(r)\\sin(t), $(r)\\cos(t)) \\, dt",
                    "Substitute: \\mathbf{F}(\\mathbf{r}(t)) = ($(a*r)\\sin(t), $(b*r)\\cos(t))",
                    "Compute dot product: $(a*r)\\sin(t) \\cdot (-$(r)\\sin(t)) + $(b*r)\\cos(t) \\cdot $(r)\\cos(t)",
                    "Simplify: $(-(a*r^2))\\sin^2(t) + $(b*r^2)\\cos^2(t)",
                    "Integrate from 0 to 2\\pi using \\int_0^{2\\pi} \\sin^2(t) \\, dt = \\pi, \\int_0^{2\\pi} \\cos^2(t) \\, dt = \\pi",
                    sol("Answer", Float64(ans))
                ),
                time=240
            )
        else
            # Line segment from origin to (a_val, b_val)
            x1 = nonzero(-8, 8)
            y1 = nonzero(-8, 8)
            
            # Parametrize: x = x1*t, y = y1*t, t in [0,1]
            # dx = x1 dt, dy = y1 dt
            # P(x(t), y(t)) = a*y1*t
            # Q(x(t), y(t)) = b*x1*t
            # F · dr = a*y1*t*x1 + b*x1*t*y1 = (a*x1*y1 + b*x1*y1)*t
            
            ans = (a*x1*y1 + b*x1*y1) / 2  # integral of t from 0 to 1
            
            problem(
                question="Evaluate \\int_C \\mathbf{F} \\cdot d\\mathbf{r} where \\mathbf{F} = ($(tex(P)), $(tex(Q))) and C is the line segment from (0, 0) to ($(x1), $(y1)).",
                answer=Float64(ans),
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Vector field", "\\mathbf{F} = ($(tex(P)), $(tex(Q)))"),
                    "Parametrize C: \\mathbf{r}(t) = ($(x1)t, $(y1)t), t \\in [0, 1]",
                    "Compute d\\mathbf{r} = ($(x1), $(y1)) \\, dt",
                    "Substitute: \\mathbf{F}(\\mathbf{r}(t)) = ($(a*y1)t, $(b*x1)t)",
                    sol("Dot product", "$(a*y1)t \\cdot $(x1) + $(b*x1)t \\cdot $(y1) = $(a*x1*y1 + b*x1*y1)t"),
                    "Integrate from 0 to 1: \\int_0^1 $(a*x1*y1 + b*x1*y1)t \\, dt",
                    sol("Answer", Float64(ans))
                ),
                time=180
            )
        end
        
    elseif problem_type == 3
        # Work done by force field F along a path
        # ELO 1400-1600
        
        # Conservative field: F = ∇f for f = ax² + by²
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # F = (2ax, 2by)
        P = 2*a*x
        Q = 2*b*y
        
        # Path from (x0, y0) to (x1, y1)
        x0, y0 = randint(-6, 6), randint(-6, 6)
        x1, y1 = randint(-6, 6), randint(-6, 6)
        
        # Work = f(x1, y1) - f(x0, y0)
        f0 = a*x0^2 + b*y0^2
        f1 = a*x1^2 + b*y1^2
        ans = f1 - f0
        
        problem(
            question="Find the work done by the force field \\mathbf{F} = ($(tex(P)), $(tex(Q))) in moving a particle from ($(x0), $(y0)) to ($(x1), $(y1)).",
            answer=Float64(ans),
            difficulty=(1400, 1600),
            solution=steps(
                sol("Force field", "\\mathbf{F} = ($(tex(P)), $(tex(Q)))"),
                "Check if conservative: \\frac{\\partial Q}{\\partial x} = $(2*b), \\frac{\\partial P}{\\partial y} = 0",
                "Since \\frac{\\partial Q}{\\partial x} \\neq \\frac{\\partial P}{\\partial y}, we use potential function (if it exists) or direct computation",
                "Notice \\mathbf{F} = \\nabla($(a)x^2 + $(b)y^2)",
                "Work = f($(x1), $(y1)) - f($(x0), $(y0))",
                "f($(x1), $(y1)) = $(a)($(x1))^2 + $(b)($(y1))^2 = $(f1)",
                "f($(x0), $(y0)) = $(a)($(x0))^2 + $(b)($(y0))^2 = $(f0)",
                sol("Answer", Float64(ans))
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Line integral with parametric curve (polynomial path)
        # ELO 1300-1500
        
        # f(x, y) = x² + y²
        f_expr = x^2 + y^2
        
        # Curve: x = t, y = t², t in [0, a]
        upper = randint(1, 4)
        
        # x(t) = t, y(t) = t²
        # f(x(t), y(t)) = t² + t⁴
        # dx/dt = 1, dy/dt = 2t
        # ds = sqrt(1 + 4t²) dt
        
        # Integral is ∫₀ᵃ (t² + t⁴) sqrt(1 + 4t²) dt
        # This is complex, so use simpler version
        
        # Actually use f(x,y) = x + y instead
        f_expr = x + y
        
        # f(x(t), y(t)) = t + t² 
        # ds = sqrt(1 + 4t²) dt
        
        # For simplicity, approximate or use exact symbolic
        # Let's use exact: integral of (t + t²)sqrt(1 + 4t²) from 0 to upper
        
        # Use substitution or numerical
        # For answer generation, compute numerically
        
        integrand_val(t_val) = (t_val + t_val^2) * sqrt(1 + 4*t_val^2)
        
        # Simple numerical integration (midpoint rule)
        n_steps = 1000
        dt = upper / n_steps
        ans = sum(integrand_val((i-0.5)*dt) * dt for i in 1:n_steps)
        
        problem(
            question="Evaluate \\int_C (x + y) \\, ds where C is the curve parametrized by x = t, y = t^2 for t \\in [0, $(upper)].",
            answer=Float64(round(ans, digits=4)),
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given function", "f(x, y) = x + y"),
                "Parametrization: x(t) = t, y(t) = t^2, t \\in [0, $(upper)]",
                "Compute ds = \\sqrt{(dx/dt)^2 + (dy/dt)^2} \\, dt = \\sqrt{1 + 4t^2} \\, dt",
                "Substitute: f(x(t), y(t)) = t + t^2",
                "Integrand: (t + t^2)\\sqrt{1 + 4t^2}",
                "Evaluate \\int_0^{$(upper)} (t + t^2)\\sqrt{1 + 4t^2} \\, dt numerically",
                sol("Answer", Float64(round(ans, digits=4)))
            ),
            time=240
        )
        
    else  # problem_type == 5
        # Green's theorem application
        # ELO 1500-1700
        
        # F = (P, Q) where ∂Q/∂x - ∂P/∂y is simple
        # P = -y, Q = x gives curl = 2 (simple)
        
        # Region: rectangle [a, b] × [c, d]
        a = randint(-5, 0)
        b = randint(1, 6)
        c = randint(-5, 0)
        d = randint(1, 6)
        
        P = -y
        Q = x
        
        # curl = ∂Q/∂x - ∂P/∂y = 1 - (-1) = 2
        area = (b - a) * (d - c)
        ans = 2 * area
        
        problem(
            question="Use Green's theorem to evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} where \\mathbf{F} = (-y, x) and C is the boundary of the rectangle [$(a), $(b)] \\times [$(c), $(d)], traversed counterclockwise.",
            answer=Float64(ans),
            difficulty=(1500, 1700),
            solution=steps(
                sol("Vector field", "\\mathbf{F} = (-y, x)"),
                "Apply Green's theorem: line integral equals double integral of curl over region",
                "Compute curl and multiply by area of region",
                sol("Answer", Float64(ans))
            ),
            time=210
        )
    end
end
