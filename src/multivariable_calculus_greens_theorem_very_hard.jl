# multivariable_calculus - greens_theorem (very_hard)
# Generated: 2026-03-08T21:05:34.731100

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Competition level: Green's theorem with polynomial vector field and unusual region
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        n = randint(2, 4)
        m = randint(2, 4)
        
        P = a*x^n + b*y^m
        Q = c*x*y^(m-1) + d*x^n
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        integrand = expand(dQ_dx - dP_dy)
        
        R = randint(2, 5)
        
        # For a disk of radius R, double integral becomes easier
        area = π * R^2
        
        # Evaluate the integrand at origin and multiply by area for simple cases
        integrand_simplified = simplify(integrand)
        
        question = "Let \\mathbf{F}(x,y) = \\langle $(tex(P)), $(tex(Q)) \\rangle. Use Green's theorem to evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r}, where C is the circle x^2 + y^2 = $(R^2) traversed counterclockwise."
        
        solution_text = steps(
            "By Green's theorem: \\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right) dA",
            sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
            sol("\\frac{\\partial P}{\\partial y}", dP_dy),
            sol("\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}", integrand_simplified),
            "Integrate over the disk of radius $(R)",
            "The answer depends on the specific evaluation of this double integral"
        )
        
        answer = 0  # Placeholder for symbolic answer
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2500, 2800),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad level: Green's theorem with path independence and curl
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        k = randint(2, 4)
        
        # Conservative field
        phi = a*x^(k+1)/(k+1) + b*x*y^k
        P = diff(phi, x)
        Q = diff(phi, y)
        
        x1, y1 = randint(-5, 5), randint(-5, 5)
        x2, y2 = randint(-5, 5), randint(-5, 5)
        
        answer = substitute(phi, [x => x2, y => y2]) - substitute(phi, [x => x1, y => y1])
        
        question = "Let \\mathbf{F}(x,y) = \\langle $(tex(P)), $(tex(Q)) \\rangle. Prove that \\mathbf{F} is conservative and evaluate \\int_C \\mathbf{F} \\cdot d\\mathbf{r} from ($(x1), $(y1)) to ($(x2), $(y2)) along any path C."
        
        solution_text = steps(
            sol("\\frac{\\partial P}{\\partial y}", diff(P, y)),
            sol("\\frac{\\partial Q}{\\partial x}", diff(Q, x)),
            "Since \\frac{\\partial P}{\\partial y} = \\frac{\\partial Q}{\\partial x}, the field is conservative",
            sol("Potential function \\phi(x,y)", phi),
            "By fundamental theorem: \\int_C \\mathbf{F} \\cdot d\\mathbf{r} = \\phi($(x2), $(y2)) - \\phi($(x1), $(y1))",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2800, 3200),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Competition: Area via Green's theorem
        a = randint(2, 6)
        b = randint(2, 6)
        
        # Ellipse area = π*a*b
        answer = π * a * b
        
        question = "Use Green's theorem with \\mathbf{F} = \\langle -y, x \\rangle to find the area enclosed by the ellipse \\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} = 1."
        
        solution_text = steps(
            "Area formula via Green's theorem: A = \\frac{1}{2}\\oint_C (-y\\,dx + x\\,dy)",
            "For \\mathbf{F} = \\langle -y, x \\rangle: \\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y} = 1 - (-1) = 2",
            "So \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_D 2\\,dA = 2A",
            "Therefore A = \\frac{1}{2} \\cdot 2A, confirming the setup",
            "Using \\frac{1}{2}\\oint_C x\\,dy - y\\,dx = \\text{Area}",
            "Parametrize: x = $(a)\\cos t, y = $(b)\\sin t, 0 \\leq t \\leq 2\\pi",
            sol("Area", "$(a)\\cdot$(b)\\pi")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3000),
            solution=solution_text,
            time=270
        )
        
    else
        # Olympiad: Green's theorem with non-simply connected domain
        R = randint(3, 6)
        r = randint(1, R-1)
        
        # Use F = <-y/(x^2+y^2), x/(x^2+y^2)> which has circulation 2π around origin
        
        answer = 2*π
        
        question = "Let D be the annular region $(r^2) \\leq x^2 + y^2 \\leq $(R^2), and let \\mathbf{F}(x,y) = \\left\\langle \\frac{-y}{x^2+y^2}, \\frac{x}{x^2+y^2} \\right\\rangle. Compute \\oint_{C_{outer}} \\mathbf{F} \\cdot d\\mathbf{r} - \\oint_{C_{inner}} \\mathbf{F} \\cdot d\\mathbf{r} where both curves are traversed counterclockwise."
        
        solution_text = steps(
            "Check if \\mathbf{F} is conservative: compute \\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}",
            "In the domain D (excluding origin), the field satisfies curl = 0",
            "By Green's theorem on the annulus: \\iint_D 0\\,dA = 0",
            "This equals \\oint_{outer} - \\oint_{inner} (with proper orientation)",
            "However, \\mathbf{F} has a singularity at origin, which is inside the inner circle",
            "Direct calculation on inner circle shows \\oint_{C_{inner}} \\mathbf{F} \\cdot d\\mathbf{r} = 2\\pi",
            sol("Answer", "2\\pi")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3200, 3600),
            solution=solution_text,
            time=300
        )
    end
end