# differential_equations - exact_equations (easy)
# Generated: 2026-03-08T20:51:13.428660

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # Generate exact differential equation at PRE-COMPETENT to BEGINNER level (700-1200)
    # Strategy: Create M(x,y)dx + N(x,y)dy = 0 where ∂M/∂y = ∂N/∂x
    
    problem_type = choice([:type1, :type2, :type3])
    
    if problem_type == :type1
        # Simple exact: (2x + y)dx + (x + 2y)dy = 0
        # ∂M/∂y = 1, ∂N/∂x = 1 ✓
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        M = a*x + y
        N = x + b*y
        
        # Verify exactness
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # Solution: F(x,y) = C where ∂F/∂x = M
        # F = (a/2)x² + xy, then ∂F/∂y must equal N
        # ∂F/∂y = x, so we need N = x + (b/2)y² after integrating
        F = (a//2)*x^2 + x*y + (b//2)*y^2
        C = randint(-10, 10)
        
        question = "Verify that the differential equation \$$(tex(M))\\,dx + $(tex(N))\\,dy = 0\$ is exact, then solve it."
        answer = "$(tex(F)) = C"
        
        solution = steps(
            sol("M(x,y)", M),
            sol("N(x,y)", N),
            sol("\\frac{\\partial M}{\\partial y}", dM_dy),
            sol("\\frac{\\partial N}{\\partial x}", dN_dx),
            "Since \\(\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\\), the equation is exact.",
            "Integrate M with respect to x: \\(F(x,y) = \\int $(tex(M))\\,dx = $(tex((a//2)*x^2 + x*y)) + g(y)\\)",
            "Differentiate with respect to y and set equal to N: \\(\\frac{\\partial F}{\\partial y} = $(tex(x)) + g'(y) = $(tex(N))\\)",
            "So \\(g'(y) = $(tex(b*y))\\), giving \\(g(y) = $(tex((b//2)*y^2))\\)",
            sol("Solution", F ~ "C")
        )
        
        difficulty = (700, 950)
        time = 180
        
    elseif problem_type == :type2
        # Polynomial exact: (ay² + bx)dx + (2axy + cy)dy = 0
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        M = a*y^2 + b*x
        N = 2*a*x*y + c*y
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # Solution: F = ax²y² + (b/2)x² + (c/2)y² = C
        F = a*x*y^2 + (b//2)*x^2 + (c//2)*y^2
        
        question = "Determine if the differential equation \$$(tex(M))\\,dx + $(tex(N))\\,dy = 0\$ is exact. If so, find the general solution."
        answer = "$(tex(F)) = C"
        
        solution = steps(
            sol("M(x,y)", M),
            sol("N(x,y)", N),
            sol("\\frac{\\partial M}{\\partial y}", dM_dy),
            sol("\\frac{\\partial N}{\\partial x}", dN_dx),
            "The equation is exact since the partial derivatives are equal.",
            "Integrate M: \\(F = \\int $(tex(M))\\,dx = $(tex(a*x*y^2 + (b//2)*x^2)) + g(y)\\)",
            "Differentiate and match to N: \\(\\frac{\\partial F}{\\partial y} = $(tex(2*a*x*y)) + g'(y) = $(tex(N))\\)",
            "Therefore \\(g'(y) = $(tex(c*y))\\), so \\(g(y) = $(tex((c//2)*y^2))\\)",
            sol("General solution", F ~ "C")
        )
        
        difficulty = (850, 1100)
        time = 210
        
    else  # type3
        # Simple with constants: (k₁y)dx + (k₁x + k₂)dy = 0
        k1 = nonzero(-6, 6)
        k2 = nonzero(-8, 8)
        
        M = k1*y
        N = k1*x + k2
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # F = k₁xy + k₂y = C
        F = k1*x*y + k2*y
        
        question = "Show that \$$(tex(M))\\,dx + $(tex(N))\\,dy = 0\$ is exact and find its solution."
        answer = "$(tex(F)) = C"
        
        solution = steps(
            sol("Given: M(x,y)", M),
            sol("Given: N(x,y)", N),
            sol("\\frac{\\partial M}{\\partial y}", dM_dy),
            sol("\\frac{\\partial N}{\\partial x}", dN_dx),
            "Exact since \\(\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\\)",
            "Integrate M: \\(F = \\int $(tex(M))\\,dx = $(tex(k1*x*y)) + g(y)\\)",
            "Match \\(\\frac{\\partial F}{\\partial y}\\) to N: \\($(tex(k1*x)) + g'(y) = $(tex(N))\\)",
            "So \\(g'(y) = $(k2)\\), giving \\(g(y) = $(tex(k2*y))\\)",
            sol("Solution", F ~ "C")
        )
        
        difficulty = (700, 900)
        time = 150
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=time,
        answer_type="expression",
        grading_mode="symbolic"
    )
end