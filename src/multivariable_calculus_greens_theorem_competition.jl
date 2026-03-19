# multivariable_calculus - greens_theorem (competition)
# Generated: 2026-03-08T21:05:51.424947

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Compute circulation around a complex region using Green's theorem
        # Pick vector field F = (P, Q) where ∂Q/∂x - ∂P/∂y is tractable
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # F = (P, Q) where P = ay^2 + bx, Q = cx^2 + dy
        P = a*y^2 + b*x
        Q = c*x^2 + d*y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl_comp = simplify(dQ_dx - dP_dy)
        
        # Region: disk of radius R
        R = randint(2, 8)
        
        # Double integral over disk: ∫∫(curl_comp) dA
        # For x^2 + y^2 ≤ R^2, area = πR^2
        # If curl_comp = 2cx - 2ay, integral by symmetry considerations
        
        # Evaluate the double integral
        # ∫∫(2cx - 2ay) dA over disk = 0 by symmetry (odd functions)
        # ∫∫ constant dA = constant * πR^2
        
        # Extract constant term
        curl_constant = substitute(substitute(curl_comp, x => 0), y => 0)
        
        # For linear terms, use polar: x = r*cos(θ), y = r*sin(θ)
        # ∫₀^(2π) ∫₀^R (2cr*cos(θ) - 2ar*sin(θ)) r dr dθ
        # = ∫₀^(2π) [2c*cos(θ) - 2a*sin(θ)] ∫₀^R r² dr dθ
        # = ∫₀^(2π) [2c*cos(θ) - 2a*sin(θ)] * R³/3 dθ = 0
        
        ans = Rational(2*c - 2*a) * R^2 * π
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle. Use Green's theorem to compute the circulation \\oint_C \\mathbf{F} \\cdot d\\mathbf{r}, where C is the circle x^2 + y^2 = $(R^2) oriented counterclockwise."
        
        solution_steps = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle"),
            sol("Green's theorem", "\\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right) dA"),
            sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
            sol("\\frac{\\partial P}{\\partial y}", dP_dy),
            sol("Curl component", curl_comp),
            "Integrate over disk D: x^2 + y^2 \\leq $(R^2) using polar coordinates",
            "By symmetry, linear terms vanish. Evaluate \\iint_D ($(tex(curl_comp))) dA",
            sol("Answer", "$(tex(ans))")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3500, 4200),
            solution=solution_steps,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Area calculation using Green's theorem with line integral
        # Area = (1/2) ∮ (x dy - y dx) or ∮ x dy or -∮ y dx
        
        # Parametric curve enclosing region
        a = randint(2, 6)
        b = randint(2, 6)
        
        # Ellipse: x = a*cos(t), y = b*sin(t), t ∈ [0, 2π]
        area = π * a * b
        
        question = "Use Green's theorem to find the area enclosed by the ellipse \\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} = 1. Express your answer in terms of \\pi."
        
        solution_steps = steps(
            "Green's theorem for area: A = \\frac{1}{2} \\oint_C (x\\,dy - y\\,dx)",
            "Parametrize the ellipse: x = $(a)\\cos(t), y = $(b)\\sin(t), t \\in [0, 2\\pi]",
            sol("dx", "$(tex(-a))*\\sin(t)\\,dt"),
            sol("dy", "$(tex(b))*\\cos(t)\\,dt"),
            "Substitute: x\\,dy - y\\,dx = $(a*b)\\cos^2(t)\\,dt + $(a*b)\\sin^2(t)\\,dt = $(a*b)\\,dt",
            sol("Area", "\\frac{1}{2}\\int_0^{2\\pi} $(a*b)\\,dt = $(tex(area))")
        )
        
        problem(
            question=question,
            answer=area,
            difficulty=(3800, 4500),
            solution=solution_steps,
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Prove a circulation is path-independent using Green's theorem
        # Show curl = 0 in simply connected domain
        
        α = nonzero(-6, 6)
        β = nonzero(-6, 6)
        
        # Conservative field: F = ∇f where f = αxy^2 + βx^2y
        # P = ∂f/∂x = αy^2 + 2βxy
        # Q = ∂f/∂y = 2αxy + βx^2
        
        P = α*y^2 + 2*β*x*y
        Q = 2*α*x*y + β*x^2
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl_comp = simplify(dQ_dx - dP_dy)
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle. Prove that \\mathbf{F} is conservative on \\mathbb{R}^2 by showing the circulation around any simple closed curve is zero. Then find a potential function f such that \\mathbf{F} = \\nabla f."
        
        potential = α*x*y^2 + β*x^2*y
        
        solution_steps = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle"),
            sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
            sol("\\frac{\\partial P}{\\partial y}", dP_dy),
            sol("Curl test", "\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y} = $(tex(curl_comp)) = 0"),
            "By Green's theorem, \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_D 0\\,dA = 0 for any closed curve C",
            "Therefore \\mathbf{F} is conservative. Find f: \\frac{\\partial f}{\\partial x} = $(tex(P))",
            "Integrate with respect to x: f = $(tex(potential)) + g(y)",
            "Check: \\frac{\\partial f}{\\partial y} = $(tex(Q)) \\checkmark",
            sol("Potential function", potential)
        )
        
        problem(
            question=question,
            answer=potential,
            difficulty=(4000, 4800),
            solution=solution_steps,
            time=360
        )
        
    else
        # Type 4: Complex region with holes - extended Green's theorem
        # Circulation around outer boundary minus inner boundaries
        
        R_outer = randint(5, 10)
        R_inner = randint(2, 4)
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # Field with constant curl: F = (-ay, bx)
        # curl = b - (-a) = b + a
        
        P = -a*y
        Q = b*x
        
        curl_val = b + a
        
        # Annulus area
        area = π * (R_outer^2 - R_inner^2)
        ans = curl_val * area
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle. Use the extended Green's theorem to compute \\oint_{C_1} \\mathbf{F} \\cdot d\\mathbf{r} - \\oint_{C_2} \\mathbf{F} \\cdot d\\mathbf{r}, where C_1 is the circle x^2 + y^2 = $(R_outer^2) (counterclockwise) and C_2 is the circle x^2 + y^2 = $(R_inner^2) (counterclockwise). Express in terms of \\pi."
        
        solution_steps = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle"),
            "Extended Green's theorem for annulus: \\oint_{C_1} - \\oint_{C_2} = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right) dA",
            sol("\\frac{\\partial Q}{\\partial x}", b),
            sol("\\frac{\\partial P}{\\partial y}", -a),
            sol("Curl", "$(tex(curl_val))"),
            "Area of annulus: \\pi($(R_outer)^2 - $(R_inner)^2) = $(tex(area))",
            sol("Answer", "$(tex(ans))")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(4200, 5000),
            solution=solution_steps,
            time=420
        )
    end
end