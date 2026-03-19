# differential_equations - exact_equations (very_easy)
# Generated: 2026-03-08T20:51:03.542106

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/exact_equations")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we need very simple exact equations
    # At this level, students should recognize exactness and integrate directly
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Type 1: Very simple exact equation M dx + N dy = 0
        # where M and N are linear or constant
        # Example: (2x + y) dx + x dy = 0
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        M = a*x + b*y
        N = b*x
        
        # Check exactness: ∂M/∂y should equal ∂N/∂x
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        question = "Determine if the differential equation \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$ is exact. Answer 'yes' or 'no'."
        
        answer = "yes"
        
        solution = steps(
            sol("Given equation", M * 1 ~ 0),
            "Compute \\(\\frac{\\partial M}{\\partial y} = $(tex(dM_dy))\$",
            "Compute \\(\\frac{\\partial N}{\\partial x} = $(tex(dN_dx))\$",
            "Since \\(\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\$, the equation is exact"
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(400, 600),
            answer_type="text",
            solution=solution,
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Identify M and N from an exact equation
        
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        M = a*x + b
        N = c*y
        
        question = "In the differential equation \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$, what is M(x,y)?"
        
        answer = M
        
        solution = steps(
            "The equation is written in the form \\(M \\, dx + N \\, dy = 0\$",
            "M(x,y) is the coefficient of dx",
            sol("Answer: M(x,y) =", M)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(200, 400),
            solution=solution,
            time=60
        )
        
    else
        # Type 3: Test exactness with simple polynomial terms
        
        # Make it NOT exact for variety
        exact = rand(Bool)
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        if exact
            M = a*x + b*y
            N = b*x + c
        else
            M = a*x + b*y
            N = b*x + c + nonzero(-3, 3)  # Add term to make it non-exact
        end
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        is_exact = simplify(dM_dy - dN_dx) == 0
        
        question = "Is the equation \$$(tex(M)) \\, dx + $(tex(N)) \\, dy = 0\$ exact? Answer 'yes' or 'no'."
        
        answer = is_exact ? "yes" : "no"
        
        solution = steps(
            sol("M(x,y) =", M),
            sol("N(x,y) =", N),
            "Compute \\(\\frac{\\partial M}{\\partial y} = $(tex(dM_dy))\$ and \\(\\frac{\\partial N}{\\partial x} = $(tex(dN_dx))\$",
            is_exact ? "Since they are equal, the equation is exact" : "Since they are not equal, the equation is not exact"
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(500, 700),
            answer_type="text",
            solution=solution,
            time=120
        )
    end
end