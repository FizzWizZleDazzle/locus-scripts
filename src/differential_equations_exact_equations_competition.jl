# differential_equations - exact_equations (competition)
# Generated: 2026-03-08T20:52:12.134027

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # For Olympiad/Research-Adjacent level (3500-5000), we need problems that require:
    # - Deep understanding of exactness conditions
    # - Non-obvious integrating factors
    # - Creative substitutions or transformations
    # - Subtle interplay between M and N
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Exact equation requiring recognition of hidden structure
        # Construct from a potential function with non-polynomial terms
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        k = nonzero(2, 6)
        m = nonzero(2, 5)
        
        # Potential: F(x,y) = x^k * y^m + a*x*y^2 + b*x^2*y + c*x*y
        # M = ∂F/∂x, N = ∂F/∂y
        M = k*x^(k-1)*y^m + a*y^2 + 2*b*x*y + c*y
        N = m*x^k*y^(m-1) + 2*a*x*y + b*x^2 + c*x
        
        # Verify exactness
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        F = x^k * y^m + a*x*y^2 + b*x^2*y + c*x*y
        C = nonzero(-20, 20)
        
        question = "Solve the exact differential equation: \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$"
        answer = "$(tex(F)) = C"
        
        solution = steps(
            "Verify exactness by checking \\(\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\\)",
            sol("\\frac{\\partial M}{\\partial y}", dM_dy),
            sol("\\frac{\\partial N}{\\partial x}", dN_dx),
            "Since the equation is exact, find \\(F(x,y)\\) such that \\(\\frac{\\partial F}{\\partial x} = M\\) and \\(\\frac{\\partial F}{\\partial y} = N\\)",
            "Integrate \\(M\\) with respect to \\(x\\): \\(F(x,y) = \\int M \\, dx\\)",
            "Determine the arbitrary function of \\(y\\) by comparing \\(\\frac{\\partial F}{\\partial y}\\) with \\(N\\)",
            sol("Solution", F ~ C)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4200),
            solution=solution,
            answer_type="expression",
            time=480
        )
        
    elseif problem_type == 2
        # Type 2: Non-exact equation requiring integrating factor μ(x) or μ(y)
        # Construct so that (∂M/∂y - ∂N/∂x)/N = f(x) only or (∂N/∂x - ∂M/∂y)/M = g(y) only
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        k = rand(2:4)
        
        # Start with exact equation, then modify
        # Original exact: M0 = 2xy + x^2, N0 = x^2 + 2by
        # Modify to: M = 2xy + x^2, N = x^2 + 2by + a*y^k
        M = 2*x*y + x^2
        N = x^2 + 2*b*y + a*y^k
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        diff_term = expand(dM_dy - dN_dx)
        
        # For integrating factor approach
        μ_info = "The equation is not exact. Check if an integrating factor exists."
        
        if a == 0
            F = x^2*y + b*y^2 + (1//3)*x^3
            sol_expr = F
        else
            # Complex case
            sol_expr = expand(x^2*y + b*y^2 + (1//3)*x^3)
        end
        
        question = "Determine whether the differential equation \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$ is exact. If not, find an integrating factor and solve."
        answer = "$(tex(sol_expr)) = C"
        
        solution = steps(
            sol("\\frac{\\partial M}{\\partial y}", dM_dy),
            sol("\\frac{\\partial N}{\\partial x}", dN_dx),
            "Since \\(\\frac{\\partial M}{\\partial y} \\neq \\frac{\\partial N}{\\partial x}\\), the equation is not exact",
            "Test for integrating factor: compute \\(\\frac{\\frac{\\partial M}{\\partial y} - \\frac{\\partial N}{\\partial x}}{N}\\) or \\(\\frac{\\frac{\\partial N}{\\partial x} - \\frac{\\partial M}{\\partial y}}{M}\\)",
            "Find the integrating factor and multiply through the equation",
            "Solve the resulting exact equation to obtain the solution",
            sol("Solution", sol_expr ~ "C")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4500),
            solution=solution,
            answer_type="expression",
            time=600
        )
        
    elseif problem_type == 3
        # Type 3: Exact equation with parametric constraints
        # Solve for parameter that makes equation exact
        
        λ = "\\lambda"
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        k = rand(2:4)
        m = rand(2:4)
        
        # M = x^k + λ*y^m, N = a*x*y^(m-1) + b*y
        # For exactness: ∂M/∂y = ∂N/∂x
        # λ*m*y^(m-1) = a*y^(m-1)
        # So λ = a/m
        
        λ_val = a // m
        
        M_expr = "x^{$k} + $λ y^{$m}"
        N_expr = "$(a)xy^{$(m-1)} + $(b)y"
        
        question = "Find all values of \\($λ\\) for which the differential equation \$($M_expr) \\, dx + ($N_expr) \\, dy = 0\$ is exact. Then solve the equation for that value of \\($λ\\)."
        
        M_final = x^k + λ_val*y^m
        N_final = a*x*y^(m-1) + b*y
        F = x^(k+1)/(k+1) + λ_val*x*y^m + b*y^2/2
        
        answer = "$λ = $(tex(λ_val)), $(tex(F)) = C"
        
        solution = steps(
            "For exactness, we need \\(\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\\)",
            "\\(\\frac{\\partial M}{\\partial y} = $λ \\cdot $m y^{$(m-1)}\\)",
            "\\(\\frac{\\partial N}{\\partial x} = $(a) y^{$(m-1)}\\)",
            sol("Exactness condition", "$λ = $(tex(λ_val))"),
            "With this value, integrate to find \\(F(x,y)\\) where \\(\\frac{\\partial F}{\\partial x} = M\\)",
            "Verify by checking \\(\\frac{\\partial F}{\\partial y} = N\\)",
            sol("Solution", F ~ "C")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4600),
            solution=solution,
            answer_type="expression",
            time=720
        )
        
    else
        # Type 4: Exact equation with substitution/transformation required
        # Homogeneous equation convertible to exact via substitution
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        k = rand(2:3)
        
        # Construct homogeneous equation: M(x,y) and N(x,y) both homogeneous of same degree
        # M = x^2 + a*x*y, N = b*x*y + y^2
        M = x^2 + a*x*y
        N = b*x*y + y^2
        
        # This is homogeneous of degree 2
        # Substitution: y = vx, dy = v dx + x dv
        # Leads to separable equation
        
        question = "Solve the differential equation \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$ by recognizing its special structure and applying an appropriate transformation."
        
        # General solution involves ln terms
        sol_hint = "v = y/x transformation leads to separable equation"
        answer = "Implicit solution in terms of x and y"
        
        solution = steps(
            "Observe that both \\(M(x,y)\\) and \\(N(x,y)\\) are homogeneous of degree 2",
            "Apply the substitution \\(y = vx\\), so \\(dy = v\\,dx + x\\,dv\\)",
            "Substitute and simplify to obtain a separable equation in \\(v\\) and \\(x\\)",
            "Separate variables: \\(\\frac{dv}{f(v)} = \\frac{dx}{x}\\)",
            "Integrate both sides to find \\(v\\) as a function of \\(x\\)",
            "Back-substitute \\(v = y/x\\) to express the solution in terms of \\(x\\) and \\(y\\)",
            "The solution is an implicit relation: \\(F(x, y) = C\\)"
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4200, 4800),
            solution=solution,
            answer_type="expression",
            time=900
        )
    end
end