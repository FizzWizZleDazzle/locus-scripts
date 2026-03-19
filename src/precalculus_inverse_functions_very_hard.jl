# precalculus - inverse_functions (very_hard)
# Generated: 2026-03-08T20:25:44.979984

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Competition: Find inverse of composite rational function
        a = nonzero(-8, 8)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        d = nonzero(-12, 12)
        
        # Ensure c*x + d is not proportional to a*x + b
        while c * b == a * d
            c = nonzero(-8, 8)
        end
        
        f_expr = (a*x + b) // (c*x + d)
        
        # Solve y = (ax + b)/(cx + d) for x
        # y(cx + d) = ax + b
        # ycx + yd = ax + b
        # ycx - ax = b - yd
        # x(yc - a) = b - yd
        # x = (b - yd)/(yc - a) = (b - dy)/(cy - a)
        
        inv_expr = (b - d*y) // (c*y - a)
        inv_simplified = simplify(inv_expr)
        
        problem(
            question="Let \\(f(x) = $(tex(f_expr))\\). Find the inverse function \\(f^{-1}(x)\\).",
            answer=substitute(inv_simplified, y => x),
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given", y ~ f_expr),
                "Swap \\(x\\) and \\(y\\), then solve for \\(y\\):",
                sol(x ~ f_expr),
                "Cross multiply: \\($(tex(x*(c*y + d))) = $(tex(a*y + b))\\)",
                "Collect \\(y\\) terms: \\($(tex(c*x*y - a*y)) = $(tex(b - d*x))\\)",
                "Factor: \\(y($(tex(c*x - a))) = $(tex(b - d*x))\\)",
                sol("f^{-1}(x)", substitute(inv_simplified, y => x))
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Competition: Functional equation with inverse
        # If f(2x - 1) = 3x + 5, find f^{-1}(x)
        m = nonzero(-6, 6)
        n = nonzero(-15, 15)
        p = nonzero(-8, 8)
        q = nonzero(-20, 20)
        
        # f(mx + n) = px + q
        # Let u = mx + n, then x = (u - n)/m
        # f(u) = p(u - n)/m + q = (p/m)u + (q - pn/m)
        
        slope = p // m
        intercept = q - p*n//m
        f_expr = slope * x + intercept
        
        # Inverse: y = slope*x + intercept => x = (y - intercept)/slope
        inv_slope = 1 // slope
        inv_intercept = -intercept // slope
        inv_expr = inv_slope * x + inv_intercept
        
        problem(
            question="If \\(f($(tex(m*x + n))) = $(tex(p*x + q))\\), find \\(f^{-1}(x)\\).",
            answer=simplify(inv_expr),
            difficulty=(2600, 2900),
            solution=steps(
                "Let \\(u = $(tex(m*x + n))\\), so \\(x = $(tex((x - n)//m))\\) (solving for \\(x\\) in terms of \\(u\\))",
                "Substitute: \\(f(u) = $(tex(p*((x-n)//m) + q)) = $(tex(f_expr))\\)",
                sol("f(x)", f_expr),
                "To find inverse, solve \\(y = $(tex(f_expr))\\) for \\(x\\):",
                sol("x", (y - intercept) // slope),
                sol("f^{-1}(x)", simplify(inv_expr))
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Olympiad: Self-inverse function characterization
        # Find all a such that f(x) = (ax + b)/(x + a) is self-inverse
        # Self-inverse means f(f(x)) = x
        
        b = nonzero(-15, 15)
        
        # For f(f(x)) = x with f(x) = (ax + b)/(x + a), we need a^2 = b
        a_val = choice([randint(2, 7), -randint(2, 7)])
        b_computed = a_val^2
        
        f_expr = (a_val*x + b_computed) // (x + a_val)
        
        problem(
            question="Determine whether the function \\(f(x) = $(tex(f_expr))\\) is self-inverse (i.e., \\(f(f(x)) = x\\) for all \\(x\\) in the domain).",
            answer="yes",
            answer_type="text",
            difficulty=(3000, 3300),
            solution=steps(
                sol("Given", f_expr),
                "Compute \\(f(f(x))\\): substitute \\(f(x)\\) into itself",
                "\\(f(f(x)) = \\frac{$(a_val)\\cdot\\frac{$(a_val)x + $(b_computed)}{x + $(a_val)} + $(b_computed)}{\\frac{$(a_val)x + $(b_computed)}{x + $(a_val)} + $(a_val)}\\)",
                "Simplify numerator: \\($(a_val)($(a_val)x + $(b_computed)) + $(b_computed)(x + $(a_val)) = $(a_val^2)x + $(a_val*b_computed) + $(b_computed)x + $(a_val*b_computed) = $(a_val^2 + b_computed)x + $(2*a_val*b_computed)\\)",
                "Simplify denominator: \\($(a_val)x + $(b_computed) + $(a_val)(x + $(a_val)) = $(a_val)x + $(b_computed) + $(a_val)x + $(a_val^2) = $(2*a_val)x + $(b_computed + a_val^2)\\)",
                "Since \\($(a_val^2) = $(b_computed)\\), numerator \\(= $(2*b_computed)x + $(2*a_val*b_computed) = $(2*b_computed)(x + $(a_val))\\)",
                "Denominator \\(= $(2*a_val)x + $(2*b_computed) = $(2*a_val)(x + $(a_val))\\)",
                "Thus \\(f(f(x)) = \\frac{$(2*b_computed)(x + $(a_val))}{$(2*a_val)(x + $(a_val))} = \\frac{$(2*b_computed)}{$(2*a_val)} = \\frac{$(b_computed)}{$(a_val)} = $(a_val) = x\\) only if \\(a^2 = b\\)",
                "Answer: Yes, the function is self-inverse"
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Olympiad: Inverse of nested radical
        # f(x) = sqrt(ax + b) + c, find f^{-1}(x)
        a = randint(2, 9)
        b = randint(-20, 20)
        c = randint(-10, 10)
        
        f_expr_str = "\\sqrt{$(tex(a*x + b))} $(c >= 0 ? "+" : "") $(c)"
        
        # y = sqrt(ax + b) + c
        # y - c = sqrt(ax + b)
        # (y - c)^2 = ax + b
        # x = ((y - c)^2 - b)/a
        
        inv_expr = ((x - c)^2 - b) // a
        
        problem(
            question="Let \\(f(x) = $(f_expr_str)\\) for \\(x \\geq $(tex(-b//a))\\). Find \\(f^{-1}(x)\\).",
            answer=simplify(inv_expr),
            difficulty=(2700, 3000),
            solution=steps(
                "Given: \\(y = $(f_expr_str)\\)",
                "Isolate the radical: \\(y - $(c) = \\sqrt{$(tex(a*x + b))}\\)",
                "Square both sides: \\((y - $(c))^2 = $(tex(a*x + b))\\)",
                "Solve for \\(x\\): \\($(a)x = (y - $(c))^2 - $(b)\\)",
                sol("x", ((y - c)^2 - b) // a),
                sol("f^{-1}(x)", simplify(inv_expr))
            ),
            time=240
        )
        
    else
        # Olympiad: Iterative inverse composition
        # Given f(x) = (ax + b)/(cx + d), find f^{-1}(f^{-1}(x))
        a = nonzero(-6, 6)
        b = nonzero(-10, 10)
        c = nonzero(-6, 6)
        d = nonzero(-10, 10)
        
        while a*d == b*c  # Ensure not degenerate
            d = nonzero(-10, 10)
        end
        
        f_expr = (a*x + b) // (c*x + d)
        
        # f^{-1}(x) = (dx - b)/(-cx + a) = (b - dx)/(cx - a)
        finv_expr = (d*x - b) // (-c*x + a)
        
        # f^{-1}(f^{-1}(x)) = apply f^{-1} to finv_expr
        # Replace x with (dx - b)/(-cx + a) in f^{-1}
        finv_finv = (d*((d*x - b)//(-c*x + a)) - b) // (-c*((d*x - b)//(-c*x + a)) + a)
        finv_finv_simplified = simplify(finv_finv)
        
        problem(
            question="Let \\(f(x) = $(tex(f_expr))\\). Find \\((f^{-1} \\circ f^{-1})(x)\\).",
            answer=finv_finv_simplified,
            difficulty=(3200, 3500),
            solution=steps(
                sol("Given", f_expr),
                "Find \\(f^{-1}\\): Let \\(y = $(tex(f_expr))\\), solve for \\(x\\)",
                "\\(y($(tex(c*x + d))) = $(tex(a*x + b))\\)",
                "\\($(tex(c*y*x + d*y)) = $(tex(a*x + b))\\)",
                "\\(x($(tex(c*y - a))) = $(tex(b - d*y))\\)",
                sol("f^{-1}(x)", simplify(finv_expr)),
                "Compute \\((f^{-1} \\circ f^{-1})(x) = f^{-1}(f^{-1}(x))\\)",
                "Substitute \\(f^{-1}(x)\\) into \\(f^{-1}\\)",
                sol("Answer", finv_finv_simplified)
            ),
            time=300
        )
    end
end