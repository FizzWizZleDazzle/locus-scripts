# multivariable_calculus - change_of_variables (easy)
# Generated: 2026-03-08T21:03:10.405705

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y u v begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Polar coordinates - compute Jacobian
        # x = r*cos(θ), y = r*sin(θ)
        # Jacobian determinant is r
        
        problem(
            question="Compute the Jacobian determinant \\(\\frac{\\partial(x,y)}{\\partial(r,\\theta)}\\) for the polar coordinate transformation \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\).",
            answer="r",
            difficulty=(700, 900),
            solution=steps(
                "Given: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\)",
                "Compute partial derivatives:<br>\\(\\frac{\\partial x}{\\partial r} = \\cos\\theta\\), \\(\\frac{\\partial x}{\\partial \\theta} = -r\\sin\\theta\\)<br>\\(\\frac{\\partial y}{\\partial r} = \\sin\\theta\\), \\(\\frac{\\partial y}{\\partial \\theta} = r\\cos\\theta\\)",
                "Jacobian determinant: \\(J = \\begin{vmatrix} \\cos\\theta & -r\\sin\\theta \\\\ \\sin\\theta & r\\cos\\theta \\end{vmatrix}\\)",
                "\\(J = \\cos\\theta \\cdot r\\cos\\theta - (-r\\sin\\theta) \\cdot \\sin\\theta = r\\cos^2\\theta + r\\sin^2\\theta\\)",
                sol("Answer", "r")
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Simple linear transformation Jacobian
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        det_val = a * d - b * c
        
        problem(
            question="Compute the Jacobian determinant \\(\\frac{\\partial(x,y)}{\\partial(u,v)}\\) for the transformation \\(x = $(a)u + $(b)v\\), \\(y = $(c)u + $(d)v\\).",
            answer=det_val,
            difficulty=(700, 900),
            solution=steps(
                "Given: \\(x = $(a)u + $(b)v\\), \\(y = $(c)u + $(d)v\\)",
                "Compute partial derivatives:<br>\\(\\frac{\\partial x}{\\partial u} = $(a)\\), \\(\\frac{\\partial x}{\\partial v} = $(b)\\)<br>\\(\\frac{\\partial y}{\\partial u} = $(c)\\), \\(\\frac{\\partial y}{\\partial v} = $(d)\\)",
                "Jacobian determinant: \\(J = \\begin{vmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{vmatrix}\\)",
                "\\(J = ($(a))($(d)) - ($(b))($(c)) = $(a*d) - $(b*c)\\)",
                sol("Answer", det_val)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Compute area element in polar coordinates
        r_min = randint(1, 5)
        r_max = r_min + randint(2, 6)
        
        problem(
            question="When converting the double integral \\(\\iint_R dx\\,dy\\) to polar coordinates, what is the area element \\(dA\\) in terms of \\(r\\) and \\(\\theta\\)?",
            answer="r dr dθ",
            difficulty=(700, 900),
            solution=steps(
                "In polar coordinates: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\)",
                "The Jacobian determinant is \\(J = r\\)",
                "The area element transforms as: \\(dx\\,dy = |J|\\,dr\\,d\\theta = r\\,dr\\,d\\theta\\)",
                sol("Answer", "r\\,dr\\,d\\theta")
            ),
            time=60
        )
        
    else
        # Evaluate Jacobian for a specific transformation with quadratic
        a = nonzero(-3, 3)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        
        # x = au + bv, y = u^2 + cv
        # ∂x/∂u = a, ∂x/∂v = b
        # ∂y/∂u = 2u, ∂y/∂v = c
        # J = a*c - b*2u = ac - 2bu
        
        u_val = randint(-3, 3)
        v_val = randint(-3, 3)
        
        det_val = a * c - 2 * b * u_val
        
        problem(
            question="For the transformation \\(x = $(a)u + $(b)v\\), \\(y = u^2 + $(c)v\\), evaluate the Jacobian determinant \\(\\frac{\\partial(x,y)}{\\partial(u,v)}\\) at the point \\((u,v) = ($(u_val), $(v_val))\\).",
            answer=det_val,
            difficulty=(900, 1200),
            solution=steps(
                "Given: \\(x = $(a)u + $(b)v\\), \\(y = u^2 + $(c)v\\)",
                "Compute partial derivatives:<br>\\(\\frac{\\partial x}{\\partial u} = $(a)\\), \\(\\frac{\\partial x}{\\partial v} = $(b)\\)<br>\\(\\frac{\\partial y}{\\partial u} = 2u\\), \\(\\frac{\\partial y}{\\partial v} = $(c)\\)",
                "Jacobian determinant: \\(J = \\begin{vmatrix} $(a) & $(b) \\\\ 2u & $(c) \\end{vmatrix} = $(a) \\cdot $(c) - $(b) \\cdot 2u = $(a*c) - $(2*b)u\\)",
                "At \\((u,v) = ($(u_val), $(v_val))\\): \\(J = $(a*c) - $(2*b)($(u_val)) = $(a*c) - $(2*b*u_val)\\)",
                sol("Answer", det_val)
            ),
            time=150
        )
    end
end