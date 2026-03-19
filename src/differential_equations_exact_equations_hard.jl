# differential_equations - exact_equations (hard)
# Generated: 2026-03-08T20:51:28.205984

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # Pick problem type: 1=basic exact, 2=exact with integrating factor check, 3=harder exact
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Basic exact equation: construct from potential function ψ(x,y)
        # ψ = ax²y + bxy² + cy² + dx + ey
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = randint(-15, 15)
        e = randint(-15, 15)
        
        psi = a*x^2*y + b*x*y^2 + c*y^2 + d*x + e*y
        
        # M = ∂ψ/∂x, N = ∂ψ/∂y
        M = diff(psi, x)
        N = diff(psi, y)
        
        # Verify exactness
        M_y = diff(M, y)
        N_x = diff(N, x)
        
        C = randint(-20, 20)
        
        question_text = "Solve the exact differential equation: \$$(tex(M)) \\, dx + ($(tex(N))) \\, dy = 0\$"
        
        solution_text = steps(
            sol("Given", M ~ 0),
            "Check exactness: \$M_y = $(tex(M_y))\$, \$N_x = $(tex(N_x))\$",
            "Since \$M_y = N_x\$, the equation is exact",
            "Find \$\\psi(x,y)\$ where \$\\psi_x = M\$ and \$\\psi_y = N\$",
            "Integrate \$M\$ with respect to \$x\$: \$\\psi = $(tex(psi)) + h(y)\$",
            "Differentiate with respect to \$y\$ and compare to \$N\$ to find \$h(y)\$",
            sol("General solution", psi ~ C)
        )
        
        problem(
            question=question_text,
            answer=psi,
            difficulty=(1800, 2100),
            solution=solution_text,
            time=240,
            grading_mode="symbolic"
        )
        
    elseif problem_type == 2
        # Exact equation with product structure: (ax + by)(cx + dy)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        # Ensure exactness by construction
        # ψ = (ax² + bxy)(cy² + dxy)/4 or similar
        # Simpler: use ψ = f(x)g(y) structure
        
        # ψ = (ax² + bx)(cy² + dy)
        f_x = a*x^2 + b*x
        g_y = c*y^2 + d*y
        
        psi = f_x * g_y
        
        M = diff(psi, x)
        N = diff(psi, y)
        
        M_y = diff(M, y)
        N_x = diff(N, x)
        
        C = randint(-25, 25)
        
        question_text = "Determine if the following differential equation is exact, and if so, solve it: \$$(tex(M)) \\, dx + ($(tex(N))) \\, dy = 0\$"
        
        solution_text = steps(
            "Check exactness condition: \$\\frac{\\partial M}{\\partial y} = $(tex(M_y))\$",
            "\$\\frac{\\partial N}{\\partial x} = $(tex(N_x))\$",
            "Since \$M_y = N_x\$, equation is exact",
            "Integrate \$M\$ with respect to \$x\$: \$\\psi(x,y) = \\int $(tex(M)) \\, dx\$",
            "Differentiate result with respect to \$y\$ and match to \$N\$ to find \$h(y)\$",
            sol("Implicit solution", psi ~ C)
        )
        
        problem(
            question=question_text,
            answer=psi,
            difficulty=(1900, 2200),
            solution=solution_text,
            time=270,
            grading_mode="symbolic"
        )
        
    else
        # More challenging: exact equation with trig or exponential terms (symbolic)
        # Use polynomial structure that's challenging but exact
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        k = nonzero(-4, 4)
        m = nonzero(-4, 4)
        
        # ψ = ax³y² + bx²y³ + cx*y + ky² + mx³
        psi = a*x^3*y^2 + b*x^2*y^3 + c*x*y + k*y^2 + m*x^3
        
        M = diff(psi, x)
        N = diff(psi, y)
        
        M_y = diff(M, y)
        N_x = diff(N, x)
        
        C = randint(-30, 30)
        
        question_text = "Verify that the differential equation is exact and find its general solution: \$$(tex(M)) \\, dx + ($(tex(N))) \\, dy = 0\$"
        
        solution_text = steps(
            "Compute \$\\frac{\\partial M}{\\partial y} = $(tex(M_y))\$",
            "Compute \$\\frac{\\partial N}{\\partial x} = $(tex(N_x))\$",
            "Exactness verified: \$M_y = N_x\$",
            "Find potential function \$\\psi(x,y)\$: Integrate \$M\$ with respect to \$x\$",
            "\$\\psi(x,y) = \\int $(tex(M)) \\, dx = $(tex(psi)) + h(y)\$",
            "Differentiate with respect to \$y\$: \$\\psi_y = $(tex(diff(psi, y)))\$, compare with \$N\$ to find \$h'(y)\$",
            sol("General solution", psi ~ C)
        )
        
        problem(
            question=question_text,
            answer=psi,
            difficulty=(2000, 2400),
            solution=solution_text,
            time=300,
            grading_mode="symbolic"
        )
    end
end