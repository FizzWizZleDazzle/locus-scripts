# multivariable_calculus - change_of_variables (very_hard)
# Generated: 2026-03-08T21:03:43.946980

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y u v begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Jacobian computation for challenging transformation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        e = nonzero(-3, 3)
        f = nonzero(-3, 3)
        
        # Transformation: x = au + bv^2, y = cu^2 + dv + euv
        x_expr = a*u + b*v^2
        y_expr = c*u^2 + d*v + e*u*v
        
        dx_du = diff(x_expr, u)
        dx_dv = diff(x_expr, v)
        dy_du = diff(y_expr, u)
        dy_dv = diff(y_expr, v)
        
        jacobian = expand(dx_du * dy_dv - dx_dv * dy_du)
        
        question_text = "Consider the transformation \$x = $(tex(x_expr))\$, \$y = $(tex(y_expr))\$. Compute the Jacobian determinant \$\\frac{\\partial(x,y)}{\\partial(u,v)}\$ and express your answer in terms of \$u\$ and \$v\$."
        
        solution_text = steps(
            sol("Transformation", "x = $(tex(x_expr)), y = $(tex(y_expr))"),
            sol("\\frac{\\partial x}{\\partial u}", dx_du),
            sol("\\frac{\\partial x}{\\partial v}", dx_dv),
            sol("\\frac{\\partial y}{\\partial u}", dy_du),
            sol("\\frac{\\partial y}{\\partial v}", dy_dv),
            "Compute Jacobian: \$J = \\frac{\\partial x}{\\partial u} \\frac{\\partial y}{\\partial v} - \\frac{\\partial x}{\\partial v} \\frac{\\partial y}{\\partial u}\$",
            sol("Jacobian", jacobian)
        )
        
        problem(
            question=question_text,
            answer=jacobian,
            difficulty=(2500, 2800),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Double integral with polar-like transformation
        a = choice([2, 3, 4, 5])
        b = choice([2, 3, 4, 5])
        r_max = randint(2, 6)
        
        # Region in uv: 0 <= u <= r_max, 0 <= v <= 2π
        # Transformation: x = au*cos(v), y = bu*sin(v) (elliptical coordinates)
        
        jacobian_val = a * b * u
        
        # Integrating f(x,y) = 1 over the ellipse
        integral_result = a * b * r_max^2 * π
        
        question_text = "Let \$R\$ be the region in the \$uv\$-plane defined by \$0 \\le u \\le $(r_max)\$ and \$0 \\le v \\le 2\\pi\$. Consider the transformation \$x = $(a)u\\cos(v)\$, \$y = $(b)u\\sin(v)\$. If \$\\iint_S 1 \\, dA\$ where \$S\$ is the image of \$R\$ under this transformation, find the value of the integral."
        
        solution_text = steps(
            "The Jacobian for \$x = $(a)u\\cos(v), y = $(b)u\\sin(v)\$ is \$J = $(a * b)u\$",
            "The integral becomes \$\\int_0^{2\\pi} \\int_0^{$(r_max)} $(a * b)u \\, du \\, dv\$",
            sol("\\int_0^{$(r_max)} $(a * b)u \\, du", (a * b * r_max^2) // 2),
            sol("\\int_0^{2\\pi} $(tex((a * b * r_max^2) // 2)) \\, dv", integral_result),
            sol("Answer", integral_result)
        )
        
        problem(
            question=question_text,
            answer=integral_result,
            difficulty=(2600, 3000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Inverse transformation and region mapping
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        # Ensure invertible: ad - bc ≠ 0
        while a*d - b*c == 0
            d = nonzero(-4, 4)
        end
        
        det_val = a*d - b*c
        
        # Transformation: x = au + bv, y = cu + dv
        # Lines in xy: x = k map to au + bv = k in uv
        k1 = randint(1, 8)
        k2 = k1 + randint(3, 8)
        
        # u-coefficient when x = k1, k2
        # From x = au + bv, we get u = (x - bv)/a or more generally...
        
        question_text = "Consider the linear transformation \$x = $(a)u + $(b)v\$, \$y = $(c)u + $(d)v\$. The region \$R\$ in the \$xy\$-plane is bounded by the lines \$x = $(k1)\$, \$x = $(k2)\$, \$y = $(k1)\$, and \$y = $(k2)\$. Find the area of \$R\$ using the change of variables formula and the Jacobian determinant."
        
        area_xy = (k2 - k1)^2
        
        solution_text = steps(
            sol("Jacobian", "\\frac{\\partial(x,y)}{\\partial(u,v)} = $(det_val)"),
            "The region \$R\$ in \$xy\$-plane is a square with side length \$$(k2 - k1)\$",
            sol("Area in xy", area_xy),
            "By change of variables: Area\$_{xy}\$ = \$|J|\$ × Area\$_{uv}\$, so Area\$_{uv} = \\frac{$(area_xy)}{|$(det_val)|}\$",
            "But we're asked for area of \$R\$ (in \$xy\$-plane)",
            sol("Answer", area_xy)
        )
        
        problem(
            question=question_text,
            answer=area_xy,
            difficulty=(2700, 3200),
            solution=solution_text,
            time=270
        )
        
    else
        # Triple integral Jacobian (spherical-like)
        a = choice([1, 2, 3])
        b = choice([1, 2, 3])
        c = choice([1, 2, 3])
        
        # Generalized spherical: x = aρsin(φ)cos(θ), y = bρsin(φ)sin(θ), z = cρcos(φ)
        # Jacobian = abc ρ² sin(φ)
        
        R = randint(2, 5)
        
        # Volume of ellipsoid with semi-axes aR, bR, cR
        volume = (4 * a * b * c * R^3 * π) // 3
        
        question_text = "Consider the transformation from spherical-like coordinates \$(\\rho, \\phi, \\theta)\$ to Cartesian coordinates: \$x = $(a)\\rho\\sin(\\phi)\\cos(\\theta)\$, \$y = $(b)\\rho\\sin(\\phi)\\sin(\\theta)\$, \$z = $(c)\\rho\\cos(\\phi)\$. Given that the Jacobian determinant is \$J = $(a*b*c)\\rho^2\\sin(\\phi)\$, compute the volume of the region where \$0 \\le \\rho \\le $(R)\$, \$0 \\le \\phi \\le \\pi\$, \$0 \\le \\theta \\le 2\\pi\$."
        
        solution_text = steps(
            sol("Jacobian given", "J = $(a*b*c)\\rho^2\\sin(\\phi)"),
            "Volume = \$\\int_0^{2\\pi} \\int_0^{\\pi} \\int_0^{$(R)} $(a*b*c)\\rho^2\\sin(\\phi) \\, d\\rho \\, d\\phi \\, d\\theta\$",
            sol("\\int_0^{$(R)} \\rho^2 \\, d\\rho", "\\frac{$(R)^3}{3}"),
            sol("\\int_0^{\\pi} \\sin(\\phi) \\, d\\phi", 2),
            sol("\\int_0^{2\\pi} d\\theta", "2\\pi"),
            sol("Volume", "$(a*b*c) \\cdot \\frac{$(R)^3}{3} \\cdot 2 \\cdot 2\\pi = $(volume)")
        )
        
        problem(
            question=question_text,
            answer=volume,
            difficulty=(2800, 3400),
            solution=solution_text,
            time=300
        )
    end
end