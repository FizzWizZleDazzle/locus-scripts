# multivariable_calculus - change_of_variables (hard)
# Generated: 2026-03-08T21:03:35.524024

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y u v begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Jacobian computation for polynomial transformation
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        u_expr = a*x + b*y
        v_expr = c*x + d*y
        
        J = a*d - b*c
        
        if J == 0
            J = nonzero(-8, 8)
            d = (J + b*c) // a
            v_expr = c*x + d*y
        end
        
        problem(
            question = "Compute the Jacobian determinant \\(\\frac{\\partial(u,v)}{\\partial(x,y)}\\) for the transformation \\(u = $(tex(u_expr))\\), \\(v = $(tex(v_expr))\\).",
            answer = J,
            difficulty = (1800, 2000),
            solution = steps(
                sol("Transformation: u", u_expr),
                sol("v", v_expr),
                "Compute partial derivatives: \\(\\frac{\\partial u}{\\partial x} = $(a)\\), \\(\\frac{\\partial u}{\\partial y} = $(b)\\), \\(\\frac{\\partial v}{\\partial x} = $(c)\\), \\(\\frac{\\partial v}{\\partial y} = $(d)\\)",
                "Jacobian determinant: \\(J = \\frac{\\partial u}{\\partial x} \\cdot \\frac{\\partial v}{\\partial y} - \\frac{\\partial u}{\\partial y} \\cdot \\frac{\\partial v}{\\partial x}\\)",
                sol("J", J)
            ),
            time = 120
        )
        
    elseif problem_type == 2
        # Polar coordinates Jacobian and area element
        r_coef = nonzero(1, 3)
        
        problem(
            question = "Find the area element \\(dA\\) in polar coordinates when \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\). Express your answer as a product involving \\(dr\\) and \\(d\\theta\\).",
            answer = "r dr dtheta",
            difficulty = (1850, 2050),
            answer_type = "expression",
            solution = steps(
                "Transformation: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\)",
                "Compute Jacobian: \\(\\frac{\\partial(x,y)}{\\partial(r,\\theta)} = \\begin{vmatrix} \\cos\\theta & -r\\sin\\theta \\\\ \\sin\\theta & r\\cos\\theta \\end{vmatrix}\\)",
                "\\(J = r\\cos^2\\theta + r\\sin^2\\theta = r(\\cos^2\\theta + \\sin^2\\theta) = r\\)",
                "Area element: \\(dA = |J| \\, dr \\, d\\theta = r \\, dr \\, d\\theta\\)"
            ),
            time = 150
        )
        
    elseif problem_type == 3
        # Double integral with change of variables
        a = nonzero(1, 4)
        b = nonzero(1, 4)
        
        R1 = randint(1, 3)
        R2 = R1 + randint(2, 4)
        
        # Integral of r over region in polar coords
        result = (a * (R2^3 - R1^3)) // 3
        
        problem(
            question = "Evaluate \\(\\iint_R $(a)\\sqrt{x^2 + y^2} \\, dA\\) where \\(R\\) is the annular region \\($(R1) \\leq \\sqrt{x^2+y^2} \\leq $(R2)\\) using polar coordinates.",
            answer = result,
            difficulty = (2000, 2200),
            solution = steps(
                "Convert to polar coordinates: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\), \\(dA = r \\, dr \\, d\\theta\\)",
                "The integrand becomes: \\($(a)r\\), and the region is \\($(R1) \\leq r \\leq $(R2)\\), \\(0 \\leq \\theta \\leq 2\\pi\\)",
                "\\(\\int_0^{2\\pi} \\int_{$(R1)}^{$(R2)} $(a)r \\cdot r \\, dr \\, d\\theta = \\int_0^{2\\pi} \\int_{$(R1)}^{$(R2)} $(a)r^2 \\, dr \\, d\\theta\\)",
                "\\(= \\int_0^{2\\pi} \\left[ \\frac{$(a)r^3}{3} \\right]_{$(R1)}^{$(R2)} d\\theta = \\int_0^{2\\pi} \\frac{$(a)}{3}($(R2)^3 - $(R1)^3) \\, d\\theta\\)",
                sol("Answer", result * 2 * 3.141592653589793)
            ),
            time = 240
        )
        
    elseif problem_type == 4
        # Inverse Jacobian
        a = nonzero(2, 5)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(2, 5)
        
        J_uv = a*d - b*c
        if J_uv == 0
            d = nonzero(2, 5)
            J_uv = a*d - b*c
        end
        
        J_xy = 1 // J_uv
        
        problem(
            question = "Given the transformation \\(u = $(a)x + $(b)y\\), \\(v = $(c)x + $(d)y\\) with Jacobian \\(\\frac{\\partial(u,v)}{\\partial(x,y)} = $(J_uv)\\), find \\(\\frac{\\partial(x,y)}{\\partial(u,v)}\\).",
            answer = J_xy,
            difficulty = (1900, 2100),
            solution = steps(
                sol("Given Jacobian", J_uv),
                "By the inverse function theorem: \\(\\frac{\\partial(x,y)}{\\partial(u,v)} = \\left( \\frac{\\partial(u,v)}{\\partial(x,y)} \\right)^{-1}\\)",
                sol("Answer", J_xy)
            ),
            time = 90
        )
        
    else
        # Change of variables in ellipse region
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        
        area = a_val * b_val * 3.141592653589793
        
        problem(
            question = "Find the area of the region bounded by the ellipse \\(\\frac{x^2}{$(a_val)^2} + \\frac{y^2}{$(b_val)^2} = 1\\) using the change of variables \\(u = \\frac{x}{$(a_val)}\\), \\(v = \\frac{y}{$(b_val)}\\).",
            answer = round(area, digits=2),
            difficulty = (2100, 2300),
            solution = steps(
                "Change of variables: \\(x = $(a_val)u\\), \\(y = $(b_val)v\\) transforms the ellipse to the unit circle \\(u^2 + v^2 = 1\\)",
                "Compute Jacobian: \\(\\frac{\\partial(x,y)}{\\partial(u,v)} = \\begin{vmatrix} $(a_val) & 0 \\\\ 0 & $(b_val) \\end{vmatrix} = $(a_val * b_val)\\)",
                "Area = \\(\\iint_{u^2+v^2 \\leq 1} $(a_val * b_val) \\, du \\, dv = $(a_val * b_val) \\cdot \\pi \\cdot 1^2\\)",
                sol("Answer", round(area, digits=2))
            ),
            time = 180
        )
    end
end