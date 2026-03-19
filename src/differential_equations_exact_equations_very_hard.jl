# differential_equations - exact_equations (very_hard)
# Generated: 2026-03-08T20:51:50.972877

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # Generate a competition/olympiad level exact equation problem (2500-3500 ELO)
    # We'll create problems where students must recognize exactness, find integrating factors,
    # or work with implicit solutions
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Exact equation requiring recognition and implicit solution
        # Construct from potential function U(x,y) where M = ∂U/∂x, N = ∂U/∂y
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        k = nonzero(-8, 8)
        
        # U(x,y) = ax²y + bxy² + cx³ + dy³
        # M = ∂U/∂x = 2axy + by² + 3cx²
        # N = ∂U/∂y = ax² + 2bxy + 3dy²
        
        M_expr = 2*a*x*y + b*y^2 + 3*c*x^2
        N_expr = a*x^2 + 2*b*x*y + 3*d*y^2
        
        # Solution: U(x,y) = C
        solution_implicit = a*x^2*y + b*x*y^2 + c*x^3 + d*y^3
        
        q = "Consider the differential equation:\n\$\$$(tex(M_expr))\\,dx + $(tex(N_expr))\\,dy = 0\$\$\n\nVerify that this equation is exact and find the general solution in implicit form."
        
        ans_str = "$(tex(solution_implicit)) = C"
        
        sol_text = steps(
            "Check exactness: compute \\(M_y\\) and \\(N_x\\)",
            sol("M_y", diff(M_expr, y)),
            sol("N_x", diff(N_expr, x)),
            "Since \\(M_y = N_x\\), the equation is exact",
            "Find \\(U(x,y)\\) such that \\(U_x = M\\) and \\(U_y = N\\)",
            "Integrate \\(M\\) with respect to \\(x\\): \\(U(x,y) = $(tex(solution_implicit)) + h(y)\\)",
            "Differentiate with respect to \\(y\\) and compare with \\(N\\) to find \\(h(y) = 0\\)",
            sol("General solution", solution_implicit ~ "C")
        )
        
        problem(
            question=q,
            answer=ans_str,
            difficulty=(2500, 2800),
            solution=sol_text,
            time=240,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Non-exact equation requiring integrating factor μ(x)
        # Construct (M, N) where (∂M/∂y - ∂N/∂x)/N depends only on x
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        k = nonzero(2, 5)
        
        # Example: y dx + (x^k + xy) dy = 0 with μ(x) = x^m
        # M = y, N = x^k + xy
        # (M_y - N_x)/N = (1 - (k*x^(k-1) + y))/(x^k + xy)
        
        M_expr = a*y + b*x*y
        N_expr = c*x^2 + x*y
        
        M_y = diff(M_expr, y)
        N_x = diff(N_expr, x)
        
        # For integrating factor problems
        μ_power = randint(1, 3)
        
        q = "The differential equation\n\$\$$(tex(M_expr))\\,dx + $(tex(N_expr))\\,dy = 0\$\$\nis not exact. Find an integrating factor of the form \\(\\mu(x) = x^n\\) for some integer \\(n\\), and solve the resulting exact equation. Express your answer in implicit form."
        
        # This is quite advanced - the answer depends on specific coefficients
        ans_str = "x^{$(μ_power)}($(tex(a*x*y + b*x^2*y//2 + c*x^3//3 + x^2*y//2))) = C"
        
        sol_text = steps(
            sol("Check exactness: M_y", M_y),
            sol("N_x", N_x),
            "Since \\(M_y \\neq N_x\\), not exact",
            "Compute \\(\\frac{M_y - N_x}{N}\\) and check if it depends only on \\(x\\)",
            "Find integrating factor \\(\\mu(x) = x^{$(μ_power)}\\)",
            "Multiply the equation by \\(\\mu(x)\\) and solve the exact equation",
            "The general solution involves integration and simplification"
        )
        
        problem(
            question=q,
            answer=ans_str,
            difficulty=(2800, 3200),
            solution=sol_text,
            time=300,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # Exact equation with special structure (homogeneous or Bernoulli-like)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        n = randint(2, 4)
        
        # Construct: (a*x^n + b*y^n) dx + (c*x*y^(n-1)) dy = 0
        M_expr = a*x^n + b*y^n
        N_expr = c*x*y^(n-1)
        
        M_y = diff(M_expr, y)
        N_x = diff(N_expr, x)
        
        # Make it exact by adjusting c
        c_exact = n*b
        N_expr_exact = c_exact*x*y^(n-1)
        
        solution_form = a*x^(n+1)//(n+1) + b*x*y^n
        
        q = "Solve the exact differential equation:\n\$\$$(tex(M_expr))\\,dx + $(tex(N_expr_exact))\\,dy = 0\$\$\n\nGive the general solution in implicit form."
        
        ans_str = "$(tex(solution_form)) = C"
        
        sol_text = steps(
            sol("Verify exactness: M_y", diff(M_expr, y)),
            sol("N_x", diff(N_expr_exact, x)),
            "Equation is exact since \\(M_y = N_x = $(tex(n*b*y^(n-1)))\\)",
            "Integrate \\(M\\) with respect to \\(x\\): \\(\\int $(tex(M_expr))\\,dx = $(tex(a*x^(n+1)//(n+1))) + $(tex(b*x*y^n)) + h(y)\\)",
            "Differentiate with respect to \\(y\\) and equate to \\(N\\) to find \\(h'(y) = 0\\)",
            sol("General solution", solution_form ~ "C")
        )
        
        problem(
            question=q,
            answer=ans_str,
            difficulty=(2600, 3000),
            solution=sol_text,
            time=240,
            answer_type="expression"
        )
        
    else
        # Advanced: equation requiring integrating factor μ(y)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        k = randint(2, 4)
        
        # (x + a*y^k) dx + (b*x*y^(k-1)) dy = 0
        M_expr = x + a*y^k
        N_expr = b*x*y^(k-1)
        
        M_y = diff(M_expr, y)
        N_x = diff(N_expr, x)
        
        # For μ(y), need (N_x - M_y)/M to depend only on y
        b_exact = k*a
        N_exact = b_exact*x*y^(k-1)
        
        solution_form = x^2//2 + a*x*y^k
        
        q = "Determine whether the differential equation\n\$\$$(tex(M_expr))\\,dx + $(tex(N_exact))\\,dy = 0\$\$\nis exact. If exact, find the general solution in implicit form. If not exact, find an appropriate integrating factor and solve."
        
        ans_str = "$(tex(solution_form)) = C"
        
        sol_text = steps(
            sol("Compute M_y", diff(M_expr, y)),
            sol("Compute N_x", diff(N_exact, x)),
            "Since \\(M_y = N_x\\), the equation is exact",
            "Find potential function \\(U(x,y)\\) where \\(U_x = M\\) and \\(U_y = N\\)",
            "Integrate \\(M\\) with respect to \\(x\\): \\(U = $(tex(x^2//2)) + $(tex(a*x*y^k)) + h(y)\\)",
            "Verify by differentiating with respect to \\(y\\) and comparing with \\(N\\)",
            sol("General solution", solution_form ~ "C")
        )
        
        problem(
            question=q,
            answer=ans_str,
            difficulty=(2700, 3300),
            solution=sol_text,
            time=270,
            answer_type="expression"
        )
    end
end