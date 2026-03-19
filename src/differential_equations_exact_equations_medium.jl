# differential_equations - exact_equations (medium)
# Generated: 2026-03-08T20:51:29.337724

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # Choose problem type
    problem_type = choice(1:3)
    
    if problem_type == 1
        # Type 1: Simple exact equation M(x,y)dx + N(x,y)dy = 0
        # Build from a potential function F(x,y)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # Potential function F(x,y) = ax²y + bxy² + cy²
        F = a*x^2*y + b*x*y^2 + c*y^2
        
        # M = ∂F/∂x, N = ∂F/∂y
        M = diff(F, x)
        N = diff(F, y)
        
        # Verify exactness: ∂M/∂y = ∂N/∂x
        My = diff(M, y)
        Nx = diff(N, x)
        
        # General solution is F(x,y) = C
        C_val = randint(-15, 15)
        
        difficulty_val = (1200, 1500)
        
        question_text = "Solve the exact differential equation: \$$(tex(M))\\,dx + ($(tex(N)))\\,dy = 0\$"
        
        answer_expr = F ~ C_val
        
        solution_text = steps(
            "Check exactness: \$M = $(tex(M))\$, \$N = $(tex(N))\$",
            sol("\\frac{\\partial M}{\\partial y}", My),
            sol("\\frac{\\partial N}{\\partial x}", Nx),
            "Since \$\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\$, the equation is exact.",
            "Find \$F(x,y)\$ such that \$\\frac{\\partial F}{\\partial x} = M\$ and \$\\frac{\\partial F}{\\partial y} = N\$",
            "Integrating \$M\$ with respect to \$x\$: \$F(x,y) = $(tex(F)) + g(y)\$",
            "Taking \$\\frac{\\partial F}{\\partial y}\$ and comparing with \$N\$, we find \$g(y) = 0\$",
            sol("General solution", F ~ "C"),
            "For the given initial condition or specific case:",
            sol("Answer", answer_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=difficulty_val,
            solution=solution_text,
            time=180,
            grading_mode="symbolic"
        )
        
    elseif problem_type == 2
        # Type 2: Exact equation with polynomial terms
        # F(x,y) = ax³ + bx²y + cxy² + dy³
        a = nonzero(-5, 5)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-5, 5)
        
        F = a*x^3 + b*x^2*y + c*x*y^2 + d*y^3
        
        M = diff(F, x)
        N = diff(F, y)
        
        My = diff(M, y)
        Nx = diff(N, x)
        
        C_val = randint(-20, 20)
        
        difficulty_val = (1300, 1600)
        
        question_text = "Verify that the differential equation is exact and solve: \$$(tex(M))\\,dx + ($(tex(N)))\\,dy = 0\$"
        
        answer_expr = F ~ C_val
        
        solution_text = steps(
            sol("Given M(x,y)", M),
            sol("Given N(x,y)", N),
            sol("Compute \\frac{\\partial M}{\\partial y}", My),
            sol("Compute \\frac{\\partial N}{\\partial x}", Nx),
            "The equation is exact since \$\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\$",
            "Integrate \$M\$ with respect to \$x\$: \$\\int $(tex(M))\\,dx = $(tex(F)) + g(y)\$",
            "Differentiate with respect to \$y\$: \$\\frac{\\partial}{\\partial y}[$(tex(F)) + g(y)] = $(tex(diff(F, y))) + g'(y)\$",
            "Set equal to \$N\$: \$$(tex(diff(F, y))) + g'(y) = $(tex(N))\$, so \$g'(y) = 0\$",
            "Therefore \$g(y) = 0\$ and \$F(x,y) = $(tex(F))\$",
            sol("General solution", F ~ "C"),
            sol("Particular solution", answer_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=difficulty_val,
            solution=solution_text,
            time=240,
            grading_mode="symbolic"
        )
        
    else
        # Type 3: Exact equation with exponential or trigonometric terms
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # F(x,y) = axy + bx²/2 + cy²/2
        c = nonzero(-4, 4)
        
        F = a*x*y + (b//2)*x^2 + (c//2)*y^2
        
        M = diff(F, x)
        N = diff(F, y)
        
        My = diff(M, y)
        Nx = diff(N, x)
        
        C_val = randint(-12, 12)
        
        difficulty_val = (1200, 1500)
        
        question_text = "Determine if the equation is exact. If so, solve: \$$(tex(M))\\,dx + ($(tex(N)))\\,dy = 0\$"
        
        answer_expr = F ~ C_val
        
        solution_text = steps(
            "Identify \$M(x,y) = $(tex(M))\$ and \$N(x,y) = $(tex(N))\$",
            sol("\\frac{\\partial M}{\\partial y}", My),
            sol("\\frac{\\partial N}{\\partial x}", Nx),
            "Since \$\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x} = $(tex(My))\$, the equation is exact",
            "Find potential function \$F\$ by integrating \$M\$ with respect to \$x\$:",
            "\$F(x,y) = \\int $(tex(M))\\,dx = $(tex(F)) + h(y)\$",
            "Differentiate with respect to \$y\$: \$\\frac{\\partial F}{\\partial y} = $(tex(diff(F, y))) + h'(y) = N = $(tex(N))\$",
            "Solving for \$h'(y)\$: \$h'(y) = 0\$, so \$h(y) = 0\$",
            sol("Solution", F ~ "C"),
            sol("Particular case", answer_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=difficulty_val,
            solution=solution_text,
            time=200,
            grading_mode="symbolic"
        )
    end
end