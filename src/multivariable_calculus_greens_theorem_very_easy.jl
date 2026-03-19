# multivariable_calculus - greens_theorem (very_easy)
# Generated: 2026-03-08T21:04:55.854892

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify when Green's theorem applies (ELO 200-400)
        scenario = choice([
            ("a simple closed curve in the xy-plane", true),
            ("an open curve in the xy-plane", false),
            ("a curve that crosses itself", false),
            ("a closed curve in 3D space", false),
        ])
        
        problem(
            question="Can Green's theorem be applied to a line integral over $(scenario[1])?",
            answer=scenario[2] ? "Yes" : "No",
            difficulty=(200, 400),
            answer_type="multiple_choice",
            solution=steps(
                "Green's theorem applies to line integrals over simple closed curves in the plane",
                "Check if the curve is: (1) closed, (2) simple (non-self-intersecting), (3) in a plane",
                scenario[2] ? "This curve satisfies all conditions" : "This curve does not satisfy the requirements",
                sol("Answer", scenario[2] ? "Yes" : "No")
            ),
            time=45,
        )
        
    elseif problem_type == 2
        # Type 2: Compute ∂Q/∂x - ∂P/∂y for simple polynomials (ELO 400-700)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        P = a*x + b*y
        Q = c*x + d*y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        result = simplify(dQ_dx - dP_dy)
        
        problem(
            question="Given the vector field \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle, compute \\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}",
            answer=result,
            difficulty=(400, 700),
            solution=steps(
                sol("P(x,y)", P),
                sol("Q(x,y)", Q),
                sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
                sol("\\frac{\\partial P}{\\partial y}", dP_dy),
                sol("\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}", result)
            ),
            time=90,
        )
        
    elseif problem_type == 3
        # Type 3: Identify P and Q from vector field notation (ELO 300-500)
        a = randint(-9, 9)
        b = randint(-9, 9)
        c = randint(1, 5)
        
        P = a*x^c + b
        Q = b*y^c + a
        
        which = choice(["P", "Q"])
        ans = which == "P" ? P : Q
        
        problem(
            question="Given the vector field \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle, what is $(which)(x,y)?",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Vector fields are written as \\mathbf{F} = \\langle P(x,y), Q(x,y) \\rangle",
                "The first component is P(x,y) and the second component is Q(x,y)",
                sol("\\mathbf{F}", "\\langle $(tex(P)), $(tex(Q)) \\rangle"),
                sol("$(which)(x,y)", ans)
            ),
            time=30,
        )
        
    else
        # Type 4: Simple curl computation (∂Q/∂x - ∂P/∂y) with quadratic terms (ELO 500-700)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        
        P = a*x^2 + b*y
        Q = c*y^2 + d*x
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl = simplify(dQ_dx - dP_dy)
        
        problem(
            question="Compute the scalar curl \\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y} for \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)) \\rangle",
            answer=curl,
            difficulty=(500, 700),
            solution=steps(
                sol("P(x,y)", P),
                sol("Q(x,y)", Q),
                "Take partial derivatives:",
                sol("\\frac{\\partial Q}{\\partial x}", dQ_dx),
                sol("\\frac{\\partial P}{\\partial y}", dP_dy),
                sol("\\text{Curl}", curl)
            ),
            time=120,
        )
    end
end