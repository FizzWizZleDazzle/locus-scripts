# multivariable_calculus - greens_theorem (medium)
# Generated: 2026-03-08T21:05:15.953001

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Compute line integral using Green's theorem (basic)
        # ELO 1200-1400
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        P = a*x + b*y
        Q = c*x + d*y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        integrand = dQ_dx - dP_dy
        
        # Region: rectangle [0, L] × [0, W]
        L = randint(2, 5)
        W = randint(2, 5)
        
        area = L * W
        ans = integrand * area
        
        problem(
            question="Use Green's theorem to evaluate \\(\\oint_C $(tex(P))\\,dx + $(tex(Q))\\,dy\\) where \\(C\\) is the rectangle with vertices \\((0,0)\\), \\(($(L),0)\\), \\(($(L),$(W))\\), \\((0,$(W))\\) traversed counterclockwise.",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Green's theorem", "\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA"),
                sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
                sol("\\frac{\\partial P}{\\partial y}", dP_dy),
                sol("Integrand", integrand),
                "Region \\(D\\) has area \\($(L) \\times $(W) = $(area)\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type 2: Green's theorem with polynomial terms (medium)
        # ELO 1300-1500
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        P = a*x^2 + b*y
        Q = c*x*y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        integrand = expand(dQ_dx - dP_dy)
        
        # Region: disk of radius R
        R = randint(2, 4)
        
        # Integrate c*y over disk: polar coords, result is 0 (odd function in y)
        # Integrate -b over disk: -b * π*R^2
        ans = -b * R^2
        ans_with_pi = ans
        
        problem(
            question="Use Green's theorem to evaluate \\(\\oint_C $(tex(P))\\,dx + $(tex(Q))\\,dy\\) where \\(C\\) is the circle \\(x^2 + y^2 = $(R^2)\\) oriented counterclockwise.",
            answer="$(ans_with_pi)π",
            difficulty=(1300, 1500),
            solution=steps(
                sol("Green's theorem", "\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA"),
                sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
                sol("\\frac{\\partial P}{\\partial y}", dP_dy),
                sol("Integrand", integrand),
                "Over the disk \\(x^2 + y^2 \\leq $(R^2)\\), the term \\($(c)y\\) integrates to 0 by symmetry",
                "The constant term \\($(−b)\\) gives \\($(−b) \\cdot \\pi \\cdot $(R)^2 = $(ans_with_pi)\\pi\\)",
                sol("Answer", "$(ans_with_pi)\\pi")
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Type 3: Area using Green's theorem
        # ELO 1400-1600
        # Ellipse x²/a² + y²/b² = 1 has area πab
        a_val = randint(2, 6)
        b_val = randint(2, 6)
        
        area = a_val * b_val
        
        problem(
            question="Use Green's theorem with \\(P = 0\\) and \\(Q = x\\) to find the area enclosed by the ellipse \\(\\frac{x^2}{$(a_val^2)} + \\frac{y^2}{$(b_val^2)} = 1\\).",
            answer="$(area)π",
            difficulty=(1400, 1600),
            solution=steps(
                sol("Area formula", "A = \\oint_C x\\,dy"),
                sol("By Green's theorem", "A = \\iint_D \\left(\\frac{\\partial(x)}{\\partial x} - \\frac{\\partial(0)}{\\partial y}\\right)\\,dA = \\iint_D 1\\,dA"),
                "For ellipse \\(\\frac{x^2}{a^2} + \\frac{y^2}{b^2} = 1\\) with \\(a = $(a_val)\\), \\(b = $(b_val)\\)",
                "The area is \\(\\pi ab = \\pi \\cdot $(a_val) \\cdot $(b_val)\\)",
                sol("Answer", "$(area)\\pi")
            ),
            time=150
        )
        
    else
        # Type 4: Verify Green's theorem computation (competent level)
        # ELO 1500-1700
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        P = -a*y
        Q = b*x
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        integrand = expand(dQ_dx - dP_dy)
        
        # Triangle with vertices (0,0), (L,0), (0,H)
        L = randint(3, 6)
        H = randint(3, 6)
        
        triangle_area = (L * H) // 2
        ans = integrand * triangle_area
        
        problem(
            question="Use Green's theorem to evaluate \\(\\oint_C $(tex(P))\\,dx + $(tex(Q))\\,dy\\) where \\(C\\) is the boundary of the triangle with vertices \\((0,0)\\), \\(($(L),0)\\), \\((0,$(H))\\) traversed counterclockwise.",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Green's theorem", "\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA"),
                sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
                sol("\\frac{\\partial P}{\\partial y}", dP_dy),
                sol("Integrand", integrand),
                "The triangle has area \\(\\frac{1}{2} \\cdot $(L) \\cdot $(H) = $(triangle_area)\\)",
                sol("Double integral", "$(tex(integrand)) \\cdot $(triangle_area) = $(ans)"),
                sol("Answer", ans)
            ),
            time=180
        )
    end
end