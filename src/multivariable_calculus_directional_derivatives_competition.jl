# multivariable_calculus - directional_derivatives (competition)
# Generated: 2026-03-08T21:00:09.303018

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Directional derivative optimization on a sophisticated surface
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-3, 3)
        e = nonzero(-3, 3)
        
        f = a*x^3 + b*y^3 + c*x*y^2 + d*x + e*y
        
        x0 = nonzero(-4, 4)
        y0 = nonzero(-4, 4)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        grad_mag = simplify(sqrt(fx_val^2 + fy_val^2))
        
        problem(
            question="Let \\(f(x,y) = $(tex(f))\\). Find the maximum rate of change of \\(f\\) at the point \\(($(x0), $(y0))\\). Express your answer in simplified radical form if necessary.",
            answer=grad_mag,
            difficulty=(3500, 3800),
            solution=steps(
                sol("Given function", f),
                "The maximum rate of change equals \\(\\|\\nabla f\\|\\) at the point",
                sol("\\nabla f = ", [fx, fy]),
                sol("At ($(x0), $(y0)): \\nabla f = ", [fx_val, fy_val]),
                sol("Maximum rate", grad_mag)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Research-adjacent: Find all directions where directional derivative vanishes
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        
        f = a*x^2*y + b*x*y^2 + c*(x^2 + y^2)
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Unit vectors where D_u f = 0 means u ⊥ ∇f
        # If ∇f = (A, B), perpendicular directions are (B, -A) and (-B, A)
        # Normalized: (B, -A)/√(A²+B²) and (-B, A)/√(A²+B²)
        
        if fx_val == 0 && fy_val == 0
            ans = "All directions (gradient is zero)"
        else
            norm_sq = fx_val^2 + fy_val^2
            u1_x = fy_val / sqrt(norm_sq)
            u1_y = -fx_val / sqrt(norm_sq)
            ans = simplify(sqrt(norm_sq))
        end
        
        problem(
            question="For \\(f(x,y) = $(tex(f))\\), find the magnitude of the gradient vector at the point \\(($(x0), $(y0))\\). This determines the family of directions where the directional derivative is zero (perpendicular to the gradient).",
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                sol("Given", f),
                sol("\\nabla f = ", [fx, fy]),
                sol("At ($(x0), $(y0))", [fx_val, fy_val]),
                "Directions with \\(D_{\\mathbf{u}} f = 0\\) are perpendicular to \\(\\nabla f\\)",
                sol("\\|\\nabla f\\| = ", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Directional derivative equals a specific value
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        f = a*x^2 + b*y^2 + c*x*y
        
        x0 = nonzero(-5, 5)
        y0 = nonzero(-5, 5)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        target_rate = nonzero(-20, 20)
        
        # D_u f = ∇f · u = target_rate where |u| = 1
        # fx_val * cos(θ) + fy_val * sin(θ) = target_rate
        # This is possible iff |target_rate| ≤ |∇f|
        
        grad_norm = sqrt(fx_val^2 + fy_val^2)
        
        problem(
            question="Let \\(f(x,y) = $(tex(f))\\). At the point \\(($(x0), $(y0))\\), determine whether there exists a unit direction vector \\(\\mathbf{u}\\) such that \\(D_{\\mathbf{u}} f = $(target_rate)\\). If so, find the angle \\(\\theta\\) (in degrees, \\(0 \\leq \\theta < 360\\)) that such a direction makes with the positive \\(x\\)-axis, choosing the smaller angle. If not possible, answer 'impossible'. Round to nearest degree if necessary.",
            answer=simplify(grad_norm),
            difficulty=(4000, 4500),
            solution=steps(
                sol("\\nabla f = ", [fx, fy]),
                sol("At ($(x0), $(y0))", [fx_val, fy_val]),
                sol("\\|\\nabla f\\| = ", grad_norm),
                "Directional derivative \\(D_{\\mathbf{u}} f\\) ranges from \\(-\\|\\nabla f\\|\\) to \\(\\|\\nabla f\\|\\)",
                "Check if \\(|$(target_rate)| \\leq \\|\\nabla f\\|\\)"
            ),
            time=280
        )
        
    elseif problem_type == 4
        # Research-adjacent: Composition with directional derivative
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-2, 2)
        
        g = a*x^2 + b*y^2
        
        x0 = nonzero(-4, 4)
        y0 = nonzero(-4, 4)
        
        u1 = nonzero(-3, 3)
        u2 = nonzero(-3, 3)
        u_norm = sqrt(u1^2 + u2^2)
        
        gx = diff(g, x)
        gy = diff(g, y)
        
        gx_val = substitute(gx, Dict(x => x0, y => y0))
        gy_val = substitute(gy, Dict(x => x0, y => y0))
        
        dir_deriv = simplify((gx_val * u1 + gy_val * u2) / u_norm)
        
        # Now consider h(t) = g(x0 + t*u1/||u||, y0 + t*u2/||u||)
        # h'(0) = D_u g
        
        ans = dir_deriv
        
        problem(
            question="Let \\(g(x,y) = $(tex(g))\\) and let \\(\\mathbf{v} = \\langle $(u1), $(u2) \\rangle\\). Define \\(h(t) = g($(x0) + t \\cdot \\frac{$(u1)}{\\|\\mathbf{v}\\|}, $(y0) + t \\cdot \\frac{$(u2)}{\\|\\mathbf{v}\\|})\\). Find \\(h'(0)\\).",
            answer=ans,
            difficulty=(3600, 4000),
            solution=steps(
                "\\(h'(0)\\) is the directional derivative of \\(g\\) at \\(($(x0), $(y0))\\) in direction \\(\\mathbf{v}/\\|\\mathbf{v}\\|\\)",
                sol("\\nabla g = ", [gx, gy]),
                sol("At point", [gx_val, gy_val]),
                sol("\\|\\mathbf{v}\\| = ", u_norm),
                sol("h'(0) = \\nabla g \\cdot (\\mathbf{v}/\\|\\mathbf{v}\\|) = ", ans)
            ),
            time=260
        )
        
    else
        # Research-adjacent: Level curve and directional derivative relationship
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        d = nonzero(-2, 2)
        
        f = a*x^3 + b*y^3 + c*x*y + d*(x + y)
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Tangent direction to level curve: perpendicular to gradient
        # Tangent vector proportional to (-fy_val, fx_val)
        tangent_norm = sqrt(fy_val^2 + fx_val^2)
        
        # Directional derivative in tangent direction should be 0
        ans = tangent_norm
        
        problem(
            question="Consider \\(f(x,y) = $(tex(f))\\). At the point \\(P = ($(x0), $(y0))\\), a level curve of \\(f\\) passes through \\(P\\). The directional derivative of \\(f\\) in the direction tangent to this level curve is zero. Find \\(\\|\\nabla f(P)\\|\\), which characterizes the maximum rate of change perpendicular to the level curve.",
            answer=simplify(ans),
            difficulty=(4200, 4800),
            solution=steps(
                sol("f(x,y) = ", f),
                sol("\\nabla f = ", [fx, fy]),
                sol("\\nabla f(P) = ", [fx_val, fy_val]),
                "The gradient is perpendicular to level curves",
                sol("\\|\\nabla f(P)\\| = ", ans)
            ),
            time=300
        )
    end
end