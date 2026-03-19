# multivariable_calculus - directional_derivatives (hard)
# Generated: 2026-03-08T20:59:57.600324

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compute directional derivative at a point
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        f = a*x^2 + b*y^2 + c*x*y + d
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        # Direction vector
        v1 = nonzero(-4, 4)
        v2 = nonzero(-4, 4)
        
        # Normalize
        mag = sqrt(v1^2 + v2^2)
        u1 = v1 / mag
        u2 = v2 / mag
        
        # Gradient
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        ans = fx_val * u1 + fy_val * u2
        
        problem(
            question="Let \\( f(x,y) = $(tex(f)) \\). Find the directional derivative of \\( f \\) at the point \\( ($x0, $y0) \\) in the direction of the vector \\( \\mathbf{v} = \\langle $v1, $v2 \\rangle \\).",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", f),
                "Compute gradient: \\( \\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle \\)",
                "At \\( ($x0, $y0) \\): \\( \\nabla f($x0, $y0) = \\langle $fx_val, $fy_val \\rangle \\)",
                "Normalize direction: \\( \\mathbf{u} = \\frac{1}{$(tex(mag))} \\langle $v1, $v2 \\rangle = \\langle $(tex(u1)), $(tex(u2)) \\rangle \\)",
                sol("Directional derivative", "D_{\\mathbf{u}} f = \\nabla f \\cdot \\mathbf{u} = $(tex(ans))"),
            ),
            time=180,
        )
        
    elseif problem_type == 2
        # Maximum rate of increase
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        f = a*x^2 + b*y^2 + c*x*y
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        ans = sqrt(fx_val^2 + fy_val^2)
        
        problem(
            question="For the function \\( f(x,y) = $(tex(f)) \\), find the maximum rate of change of \\( f \\) at the point \\( ($x0, $y0) \\).",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", f),
                "The maximum rate of change is \\( \\|\\nabla f\\| \\)",
                "Compute gradient: \\( \\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle \\)",
                "At \\( ($x0, $y0) \\): \\( \\nabla f = \\langle $fx_val, $fy_val \\rangle \\)",
                sol("Maximum rate", "\\|\\nabla f\\| = \\sqrt{$(fx_val)^2 + $(fy_val)^2} = $(tex(ans))"),
            ),
            time=150,
        )
        
    elseif problem_type == 3
        # Direction of maximum increase
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        f = a*x*y + b*x^2 + c*y^2 + d*x
        
        x0 = nonzero(-4, 4)
        y0 = nonzero(-4, 4)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        ans = fmt_tuple((fx_val, fy_val))
        
        problem(
            question="For \\( f(x,y) = $(tex(f)) \\), find the direction (as a vector) in which \\( f \\) increases most rapidly at the point \\( ($x0, $y0) \\).",
            answer=ans,
            difficulty=(1900, 2100),
            answer_type="tuple",
            solution=steps(
                sol("Given", f),
                "The direction of maximum increase is \\( \\nabla f \\)",
                "Compute: \\( \\frac{\\partial f}{\\partial x} = $(tex(fx)) \\), \\( \\frac{\\partial f}{\\partial y} = $(tex(fy)) \\)",
                "At \\( ($x0, $y0) \\): \\( \\nabla f = \\langle $fx_val, $fy_val \\rangle \\)",
                sol("Direction", "\\langle $fx_val, $fy_val \\rangle"),
            ),
            time=150,
        )
        
    elseif problem_type == 4
        # Directional derivative equals given value - find angle
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        f = a*x^2 + b*y^2
        
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        fx = diff(f, x)
        fy = diff(f, y)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0))
        fy_val = substitute(fy, Dict(x => x0, y => y0))
        
        # Magnitude of gradient
        grad_mag = sqrt(fx_val^2 + fy_val^2)
        
        # Pick a target value between -grad_mag and grad_mag
        gm = Float64(Symbolics.value(grad_mag))
        target = randint(Int(floor(-gm)), Int(ceil(gm)))
        
        # cos(theta) = target / grad_mag
        if Float64(abs(target)) <= Float64(grad_mag)
            cos_theta = target / grad_mag
            # Clamp to avoid numerical issues
            cos_theta = max(-1.0, min(1.0, Float64(cos_theta)))
            theta_rad = acos(cos_theta)
            theta_deg = round(theta_rad * 180 / π, digits=1)
            ans = theta_deg
        else
            ans = 0  # Fallback
        end
        
        problem(
            question="Let \\( f(x,y) = $(tex(f)) \\). At the point \\( ($x0, $y0) \\), find the angle (in degrees, 0 to 180) between the gradient \\( \\nabla f \\) and a unit vector \\( \\mathbf{u} \\) such that the directional derivative \\( D_{\\mathbf{u}} f = $target \\). Round to one decimal place.",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", f),
                "Compute \\( \\nabla f = \\langle $(tex(fx)), $(tex(fy)) \\rangle \\)",
                "At \\( ($x0, $y0) \\): \\( \\nabla f = \\langle $fx_val, $fy_val \\rangle \\), \\( \\|\\nabla f\\| = $(tex(grad_mag)) \\)",
                "Use \\( D_{\\mathbf{u}} f = \\nabla f \\cdot \\mathbf{u} = \\|\\nabla f\\| \\cos\\theta = $target \\)",
                "Solve: \\( \\cos\\theta = \\frac{$target}{$(tex(grad_mag))} = $(tex(cos_theta)) \\)",
                sol("Angle", "\\theta = \\arccos($(tex(cos_theta))) \\approx $ans^\\circ"),
            ),
            calculator="scientific",
            time=240,
        )
        
    else
        # Three-variable directional derivative
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        f = a*x^2 + b*y^2 + c*z^2
        
        x0 = randint(-2, 2)
        y0 = randint(-2, 2)
        z0 = randint(-2, 2)
        
        v1 = nonzero(-3, 3)
        v2 = nonzero(-3, 3)
        v3 = nonzero(-3, 3)
        
        mag = sqrt(v1^2 + v2^2 + v3^2)
        u1 = v1 / mag
        u2 = v2 / mag
        u3 = v3 / mag
        
        fx = diff(f, x)
        fy = diff(f, y)
        fz = diff(f, z)
        
        fx_val = substitute(fx, Dict(x => x0, y => y0, z => z0))
        fy_val = substitute(fy, Dict(x => x0, y => y0, z => z0))
        fz_val = substitute(fz, Dict(x => x0, y => y0, z => z0))
        
        ans = fx_val * u1 + fy_val * u2 + fz_val * u3
        
        problem(
            question="Let \\( f(x,y,z) = $(tex(f)) \\). Find the directional derivative of \\( f \\) at \\( ($x0, $y0, $z0) \\) in the direction of \\( \\mathbf{v} = \\langle $v1, $v2, $v3 \\rangle \\).",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", f),
                "Gradient: \\( \\nabla f = \\langle $(tex(fx)), $(tex(fy)), $(tex(fz)) \\rangle \\)",
                "At \\( ($x0, $y0, $z0) \\): \\( \\nabla f = \\langle $fx_val, $fy_val, $fz_val \\rangle \\)",
                "Normalize: \\( \\mathbf{u} = \\frac{1}{$(tex(mag))} \\langle $v1, $v2, $v3 \\rangle \\)",
                sol("Answer", "D_{\\mathbf{u}} f = \\nabla f \\cdot \\mathbf{u} = $(tex(ans))"),
            ),
            time=210,
        )
    end
end