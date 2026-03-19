# calculus - continuity (hard)
# Generated: 2026-03-08T20:38:29.901998

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x a t begin
    set_topic!("calculus/continuity")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Piecewise function continuity - find parameter for continuity
        b = randint(-15, 15)
        c = randint(-20, 20)
        d = randint(-20, 20)
        x0 = randint(-8, 8)
        
        # Left limit: ax + b at x = x0 gives a*x0 + b
        # Right limit: x^2 + c at x = x0 gives x0^2 + c
        # For continuity: a*x0 + b = x0^2 + c
        # So a = (x0^2 + c - b) / x0
        
        if x0 == 0
            x0 = choice([-5, -3, -2, 2, 3, 5])
        end
        
        ans = (x0^2 + c - b) // x0
        
        piecewise_str = "f(x) = \\begin{cases} ax + $(b) & x < $(x0) \\\\ x^2 + $(c) & x \\geq $(x0) \\end{cases}"
        
        problem(
            question="For what value of \\(a\\) is the function \\($(piecewise_str)\\) continuous at \\(x = $(x0)\\)?",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "For continuity at \\(x = $(x0)\\), we need \\(\\lim_{x \\to $(x0)^-} f(x) = f($(x0))\\)",
                "Left limit: \\(\\lim_{x \\to $(x0)^-} (ax + $(b)) = $(x0)a + $(b)\\)",
                "Function value: \\(f($(x0)) = $(x0)^2 + $(c) = $(x0^2 + c)\\)",
                "Set equal: \\($(x0)a + $(b) = $(x0^2 + c)\\)",
                sol("Solving for \\(a\\)", ans)
            ),
            time=180
        )
        
    elseif prob_type == 2
        # Removable discontinuity - find limit
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        while r2 == r1
            r2 = nonzero(-10, 10)
        end
        
        m = nonzero(-5, 5)
        b_val = randint(-15, 15)
        
        # f(x) = (x - r1)(x - r2) / (x - r1) has removable discontinuity at r1
        # limit as x -> r1 is (r1 - r2)
        ans = r1 - r2
        
        numerator = expand((x - r1) * (x - r2))
        denominator = x - r1
        
        problem(
            question="Find \\(\\lim_{x \\to $(r1)} \\frac{$(tex(numerator))}{$(tex(denominator))}\\)",
            answer=ans,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: \\(\\frac{(x - $(r1))(x - $(r2))}{x - $(r1)}\\)",
                "Cancel common factor \\((x - $(r1))\\) for \\(x \\neq $(r1)\\)",
                "Simplified: \\(x - $(r2)\\)",
                sol("Evaluate limit", ans)
            ),
            time=150
        )
        
    elseif prob_type == 3
        # Continuity on interval - piecewise with two parameters
        x0 = nonzero(-6, 6)
        b1 = randint(-12, 12)
        c1 = randint(-12, 12)
        
        # Left: ax^2 + b at x = x0 gives a*x0^2 + b
        # Middle: tx + c at x = x0 gives t*x0 + c
        # For continuity at x0: a*x0^2 + b = t*x0 + c
        
        # Choose specific values for a and solve for t
        a_val = nonzero(-4, 4)
        left_val = a_val * x0^2 + b1
        t_val = (left_val - c1) // x0
        
        ans = t_val
        
        piecewise_str = "f(x) = \\begin{cases} $(a_val)x^2 + $(b1) & x \\leq $(x0) \\\\ tx + $(c1) & x > $(x0) \\end{cases}"
        
        problem(
            question="Find the value of \\(t\\) that makes \\($(piecewise_str)\\) continuous everywhere.",
            answer=ans,
            difficulty=(1900, 2200),
            solution=steps(
                "For continuity at \\(x = $(x0)\\), we need \\(\\lim_{x \\to $(x0)^-} f(x) = \\lim_{x \\to $(x0)^+} f(x)\\)",
                "Left limit: \\($(a_val) \\cdot $(x0)^2 + $(b1) = $(left_val)\\)",
                "Right limit: \\(t \\cdot $(x0) + $(c1)\\)",
                "Set equal: \\($(x0)t + $(c1) = $(left_val)\\)",
                sol("Solve for \\(t\\)", ans)
            ),
            time=200
        )
        
    elseif prob_type == 4
        # IVT application - prove existence of root
        a_coef = nonzero(-5, 5)
        b_coef = randint(-20, 20)
        c_coef = randint(-20, 20)
        d_coef = randint(-30, 30)
        
        # Create polynomial that changes sign
        expr = a_coef*x^3 + b_coef*x^2 + c_coef*x + d_coef
        
        x1 = randint(-5, 0)
        x2 = randint(1, 5)
        
        val1 = substitute(expr, x => x1)
        val2 = substitute(expr, x => x2)
        
        # Ensure sign change
        if val1 * val2 > 0
            x2 = x2 + choice([3, 4, 5])
            val2 = substitute(expr, x => x2)
        end
        
        problem(
            question="Using the Intermediate Value Theorem, explain why the equation \\($(tex(expr)) = 0\\) has at least one real solution in the interval \\([$(x1), $(x2)]\\). Compute \\(f($(x1))\\) and \\(f($(x2))\\).",
            answer="IVT guarantees a root",
            answer_type="text",
            difficulty=(1850, 2100),
            solution=steps(
                sol("Let \\(f(x)\\)", expr),
                "Evaluate: \\(f($(x1)) = $(val1)\\) and \\(f($(x2)) = $(val2)\\)",
                "Since \\(f\\) is continuous (polynomial) and \\(f($(x1))\\) and \\(f($(x2))\\) have opposite signs, by IVT there exists \\(c \\in ($(x1), $(x2))\\) where \\(f(c) = 0\\)",
                "Therefore the equation has at least one real solution in \\([$(x1), $(x2)]\\)"
            ),
            time=240
        )
        
    else
        # Jump discontinuity - find size of jump
        x0 = nonzero(-8, 8)
        a1 = nonzero(-6, 6)
        b1 = randint(-15, 15)
        a2 = nonzero(-6, 6)
        b2 = randint(-15, 15)
        
        left_limit = a1 * x0 + b1
        right_limit = a2 * x0 + b2
        
        jump_size = abs(right_limit - left_limit)
        
        piecewise_str = "f(x) = \\begin{cases} $(a1)x + $(b1) & x < $(x0) \\\\ $(a2)x + $(b2) & x \\geq $(x0) \\end{cases}"
        
        problem(
            question="The function \\($(piecewise_str)\\) has a jump discontinuity at \\(x = $(x0)\\). Find the magnitude of the jump (the absolute difference between the left and right limits).",
            answer=jump_size,
            difficulty=(1900, 2200),
            solution=steps(
                "Find left limit: \\(\\lim_{x \\to $(x0)^-} ($(a1)x + $(b1)) = $(left_limit)\\)",
                "Find right limit: \\(\\lim_{x \\to $(x0)^+} ($(a2)x + $(b2)) = $(right_limit)\\)",
                "Jump magnitude: \\(|$(right_limit) - ($(left_limit))| = |$(right_limit - left_limit)|\\)",
                sol("Answer", jump_size)
            ),
            time=180
        )
    end
end