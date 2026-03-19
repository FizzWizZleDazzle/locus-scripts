# multivariable_calculus - greens_theorem (easy)
# Generated: 2026-03-08T21:05:11.051779

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Verify Green's theorem for a simple line integral around a rectangle
        # ELO: 700-900
        width = randint(1, 4)
        height = randint(1, 4)
        a = randint(-3, 3)
        b = randint(-3, 3)
        
        # Vector field F = (P, Q) = (ax, by)
        P = a*x
        Q = b*y
        
        # ∂Q/∂x - ∂P/∂y
        dQdx = diff(Q, x)
        dPdy = diff(P, y)
        integrand = dQdx - dPdy
        
        # Double integral over rectangle [0,width] × [0,height]
        area = width * height
        ans = simplify(integrand) * area
        
        problem(
            question="Let \\mathbf{F} = ($(tex(P)), $(tex(Q))). Use Green's theorem to evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} where C is the boundary of the rectangle [0, $(width)] \\times [0, $(height)], oriented counterclockwise.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Green's theorem: \\oint_C P\\,dx + Q\\,dy = \\iint_R \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA",
                sol("\\frac{\\partial Q}{\\partial x}", dQdx),
                sol("\\frac{\\partial P}{\\partial y}", dPdy),
                sol("Integrand", integrand),
                "\\iint_R $(tex(integrand))\\,dA = $(tex(integrand)) \\cdot $(area) = $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type 2: Compute circulation using Green's theorem for triangular region
        # ELO: 800-1000
        c1 = randint(1, 5)
        c2 = randint(1, 5)
        
        # Vector field F = (c1*y, c2*x)
        P = c1*y
        Q = c2*x
        
        dQdx = diff(Q, x)
        dPdy = diff(P, y)
        curl_F = dQdx - dPdy
        
        # Triangle with vertices (0,0), (h,0), (0,k)
        h = randint(2, 6)
        k = randint(2, 6)
        area = h * k // 2
        
        ans = curl_F * area
        
        problem(
            question="Use Green's theorem to find the circulation \\oint_C ($(tex(P)))\\,dx + ($(tex(Q)))\\,dy where C is the boundary of the triangle with vertices (0,0), ($(h),0), (0,$(k)), oriented counterclockwise.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Green's theorem: \\oint_C P\\,dx + Q\\,dy = \\iint_R \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA",
                sol("\\frac{\\partial Q}{\\partial x}", dQdx),
                sol("\\frac{\\partial P}{\\partial y}", dPdy),
                sol("Curl", curl_F),
                "Area of triangle = \\frac{1}{2} \\cdot $(h) \\cdot $(k) = $(area)",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Type 3: Calculate area using Green's theorem
        # ELO: 900-1100
        r = randint(2, 8)
        
        problem(
            question="Use Green's theorem with the vector field \\mathbf{F} = (-y, x) to find the area enclosed by the circle x^2 + y^2 = $(r)^2.",
            answer=r^2 * π,
            difficulty=(900, 1100),
            solution=steps(
                "For \\mathbf{F} = (-y, x), we have P = -y and Q = x",
                sol("\\frac{\\partial Q}{\\partial x}", 1),
                sol("\\frac{\\partial P}{\\partial y}", -1),
                "\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y} = 1 - (-1) = 2",
                "Green's theorem: \\oint_C (-y)\\,dx + x\\,dy = \\iint_R 2\\,dA = 2 \\cdot \\text{Area}",
                "Therefore, Area = \\frac{1}{2}\\oint_C (-y)\\,dx + x\\,dy",
                "For circle of radius $(r): Area = \\pi r^2 = $(r^2)\\pi"
            ),
            time=180
        )
        
    else
        # Type 4: Evaluate line integral using Green's theorem with polynomial field
        # ELO: 950-1200
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # Vector field F = (ax^2, by^2)
        P = a*x^2
        Q = b*y^2
        
        dQdx = diff(Q, x)
        dPdy = diff(P, y)
        integrand = dQdx - dPdy
        
        # Square [0,L] × [0,L]
        L = randint(2, 5)
        area = L^2
        
        ans = integrand * area
        
        problem(
            question="Evaluate \\oint_C ($(tex(P)))\\,dx + ($(tex(Q)))\\,dy using Green's theorem, where C is the boundary of the square [0, $(L)] \\times [0, $(L)], oriented counterclockwise.",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                "Apply Green's theorem: \\oint_C P\\,dx + Q\\,dy = \\iint_R \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA",
                sol("P", P),
                sol("Q", Q),
                sol("\\frac{\\partial Q}{\\partial x}", dQdx),
                sol("\\frac{\\partial P}{\\partial y}", dPdy),
                sol("Integrand", integrand),
                "\\iint_R $(tex(integrand))\\,dA = $(tex(integrand)) \\cdot $(L)^2 = $(ans)"
            ),
            time=180
        )
    end
end