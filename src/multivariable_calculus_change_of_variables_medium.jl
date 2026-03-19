# multivariable_calculus - change_of_variables (medium)
# Generated: 2026-03-08T21:03:31.796157

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y u v begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Jacobian computation for polynomial transformation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        u_expr = a*x + b*y
        v_expr = c*x + d*y
        
        du_dx = diff(u_expr, x)
        du_dy = diff(u_expr, y)
        dv_dx = diff(v_expr, x)
        dv_dy = diff(v_expr, y)
        
        jac = du_dx * dv_dy - du_dy * dv_dx
        ans = simplify(jac)
        
        problem(
            question="Compute the Jacobian \\(\\frac{\\partial(u,v)}{\\partial(x,y)}\\) for the transformation \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\).",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Given transformation: \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\)",
                "Compute partial derivatives:<br>\\(\\frac{\\partial u}{\\partial x} = $(tex(du_dx))\\), \\(\\frac{\\partial u}{\\partial y} = $(tex(du_dy))\\)<br>\\(\\frac{\\partial v}{\\partial x} = $(tex(dv_dx))\\), \\(\\frac{\\partial v}{\\partial y} = $(tex(dv_dy))\\)",
                "The Jacobian is \\(\\frac{\\partial u}{\\partial x} \\cdot \\frac{\\partial v}{\\partial y} - \\frac{\\partial u}{\\partial y} \\cdot \\frac{\\partial v}{\\partial x}\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Jacobian for polar-like transformation
        r_power = choice([1, 2])
        theta_coeff = choice([1, 2, 3])
        
        if r_power == 1
            u_expr = x
            v_expr = theta_coeff * y
        else
            u_expr = x^2 - y^2
            v_expr = 2*x*y
        end
        
        du_dx = diff(u_expr, x)
        du_dy = diff(u_expr, y)
        dv_dx = diff(v_expr, x)
        dv_dy = diff(v_expr, y)
        
        jac = simplify(du_dx * dv_dy - du_dy * dv_dx)
        
        problem(
            question="Find the Jacobian \\(\\frac{\\partial(u,v)}{\\partial(x,y)}\\) for \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\).",
            answer=jac,
            difficulty=(1300, 1500),
            solution=steps(
                "Given: \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\)",
                "Calculate partials:<br>\\(\\frac{\\partial u}{\\partial x} = $(tex(du_dx))\\), \\(\\frac{\\partial u}{\\partial y} = $(tex(du_dy))\\)<br>\\(\\frac{\\partial v}{\\partial x} = $(tex(dv_dx))\\), \\(\\frac{\\partial v}{\\partial y} = $(tex(dv_dy))\\)",
                "Jacobian determinant: \\(($(tex(du_dx)))($(tex(dv_dy))) - ($(tex(du_dy)))($(tex(dv_dx)))\\)",
                sol("Answer", jac)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Area scaling factor
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        jac = a * d - b * c
        
        while abs(jac) < 2
            a = nonzero(-6, 6)
            b = nonzero(-6, 6)
            c = nonzero(-6, 6)
            d = nonzero(-6, 6)
            jac = a * d - b * c
        end
        
        area_uv = randint(3, 15)
        area_xy = abs(jac) * area_uv
        
        u_expr = a*x + b*y
        v_expr = c*x + d*y
        
        problem(
            question="Given the transformation \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\), suppose a region \\(R\\) in the \\(uv\\)-plane has area $(area_uv). What is the area of the corresponding region in the \\(xy\\)-plane?",
            answer=area_xy,
            difficulty=(1400, 1600),
            solution=steps(
                "The area scaling factor is \\(\\left|\\frac{\\partial(x,y)}{\\partial(u,v)}\\right|\\)",
                "First find \\(\\frac{\\partial(u,v)}{\\partial(x,y)} = $(a)($(d)) - $(b)($(c)) = $(jac)\\)",
                "Therefore \\(\\left|\\frac{\\partial(x,y)}{\\partial(u,v)}\\right| = \\frac{1}{|$(jac)|} = \\frac{1}{$(abs(jac))}\\)",
                "Area in \\(xy\\)-plane = \\(\\frac{\\text{Area in }uv}{|J_{uv}|} = \\frac{$(area_uv)}{1/$(abs(jac))} = $(area_xy)\\)"
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Inverse Jacobian relationship
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        jac_uv_xy = a * d - b * c
        
        while abs(jac_uv_xy) < 2
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            c = nonzero(-4, 4)
            d = nonzero(-4, 4)
            jac_uv_xy = a * d - b * c
        end
        
        jac_xy_uv = 1 // jac_uv_xy
        
        u_expr = a*x + b*y
        v_expr = c*x + d*y
        
        problem(
            question="If \\(\\frac{\\partial(u,v)}{\\partial(x,y)} = $(jac_uv_xy)\\) for the transformation \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\), find \\(\\frac{\\partial(x,y)}{\\partial(u,v)}\\).",
            answer=jac_xy_uv,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: \\(\\frac{\\partial(u,v)}{\\partial(x,y)} = $(jac_uv_xy)\\)",
                "The Jacobians of a transformation and its inverse are reciprocals",
                "Therefore \\(\\frac{\\partial(x,y)}{\\partial(u,v)} = \\frac{1}{\\frac{\\partial(u,v)}{\\partial(x,y)}}\\)",
                sol("Answer", jac_xy_uv)
            ),
            time=90
        )
        
    else
        # Chain rule with change of variables
        k = nonzero(-5, 5)
        m = nonzero(-5, 5)
        
        u_expr = k*x
        v_expr = m*y
        
        du_dx = k
        dv_dy = m
        
        f_power = randint(2, 4)
        
        problem(
            question="Let \\(f(u,v) = u^{$(f_power)} + v^{$(f_power)}\\) where \\(u = $(tex(u_expr))\\) and \\(v = $(tex(v_expr))\\). Find \\(\\frac{\\partial f}{\\partial x}\\) in terms of \\(x\\) and \\(y\\).",
            answer=f_power * k^f_power * x^(f_power-1),
            difficulty=(1500, 1700),
            solution=steps(
                "Given: \\(f(u,v) = u^{$(f_power)} + v^{$(f_power)}\\), \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\)",
                "By chain rule: \\(\\frac{\\partial f}{\\partial x} = \\frac{\\partial f}{\\partial u}\\frac{\\partial u}{\\partial x} + \\frac{\\partial f}{\\partial v}\\frac{\\partial v}{\\partial x}\\)",
                "Compute: \\(\\frac{\\partial f}{\\partial u} = $(f_power)u^{$(f_power-1)}\\), \\(\\frac{\\partial u}{\\partial x} = $(k)\\), \\(\\frac{\\partial v}{\\partial x} = 0\\)",
                "Therefore \\(\\frac{\\partial f}{\\partial x} = $(f_power)u^{$(f_power-1)} \\cdot $(k) = $(f_power ⋅ k)($(tex(u_expr)))^{$(f_power-1)}\\)",
                sol("Answer", f_power * k^f_power * x^(f_power-1))
            ),
            time=180
        )
    end
end