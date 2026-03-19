# precalculus - inverse_functions (medium)
# Generated: 2026-03-08T20:25:24.207788

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Find inverse of linear function
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        f_expr = a*x + b
        
        # Inverse: solve y = ax + b for x
        # x = (y - b) / a
        inv_expr = (y - b) // a
        
        problem(
            question="Find the inverse function \$f^{-1}(x)\$ if \$f(x) = $(tex(f_expr))\$",
            answer=substitute(inv_expr, y => x),
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", "f(x) = $(tex(f_expr))"),
                "Replace f(x) with y: \$y = $(tex(f_expr))\$",
                "Swap x and y: \$x = $(tex(substitute(f_expr, x => y)))\$",
                "Solve for y: \$y = $(tex(inv_expr))\$",
                sol("Answer", "f^{-1}(x) = $(tex(substitute(inv_expr, y => x)))")
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Verify if two functions are inverses
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        is_inverse = choice([true, false])
        
        if is_inverse
            f_expr = a*x + b
            g_expr = (x - b) // a
            ans = "Yes"
        else
            f_expr = a*x + b
            wrong_b = b + nonzero(-5, 5)
            g_expr = (x - wrong_b) // a
            ans = "No"
        end
        
        # Compute f(g(x))
        fg = substitute(f_expr, x => g_expr)
        fg_simplified = simplify(expand(fg))
        
        problem(
            question="Are \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g_expr))\$ inverse functions? Answer Yes or No.",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "Check if \$f(g(x)) = x\$",
                sol("f(g(x))", fg),
                sol("Simplified", fg_simplified),
                is_inverse ? "Since \$f(g(x)) = x\$, they are inverses" : "Since \$f(g(x)) \\neq x\$, they are not inverses",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Find inverse of rational function f(x) = (ax + b)/(cx + d)
        a = nonzero(-7, 7)
        b = randint(-10, 10)
        c = nonzero(-7, 7)
        d = randint(-10, 10)
        
        # Ensure ad ≠ bc (not linear)
        while a*d == b*c
            d = randint(-10, 10)
        end
        
        f_expr = (a*x + b) // (c*x + d)
        
        # Inverse: y = (ax+b)/(cx+d) → x(cy+d) = ay+b → x = (dy-b)/(a-cy) = (-dy+b)/(-a+cy)
        inv_expr = (d*y - b) // (a - c*y)
        
        problem(
            question="Find the inverse function \$f^{-1}(x)\$ if \$f(x) = $(tex(f_expr))\$",
            answer=substitute(inv_expr, y => x),
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", "f(x) = $(tex(f_expr))"),
                "Set \$y = $(tex(f_expr))\$",
                "Swap x and y: \$x = $(tex(substitute(f_expr, x => y)))\$",
                "Solve for y: multiply both sides by \$($(tex(c*y + d)))\$",
                "Rearrange: \$$(tex(a - c*x))y = $(tex(d*x - b))\$",
                sol("Answer", "f^{-1}(x) = $(tex(substitute(inv_expr, y => x)))")
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Evaluate f^(-1)(value) given f(x)
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = randint(-15, 15)
        
        # f(x) = ax + b, so f^(-1)(x) = (x-b)/a
        # We want f^(-1)(c), which means solving f(x) = c
        # ax + b = c → x = (c - b)/a
        
        ans = (c - b) // a
        f_expr = a*x + b
        
        problem(
            question="If \$f(x) = $(tex(f_expr))\$, find \$f^{-1}($(c))\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "To find \$f^{-1}($(c))\$, solve \$f(x) = $(c)\$",
                sol("Equation", tex(f_expr) * " = $(c)"),
                "Solve for x: \$$(tex(a*x)) = $(c - b)\$",
                sol("Answer", ans)
            ),
            time=90
        )
        
    else  # problem_type == 5
        # Find domain of inverse function (range of original)
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        d = randint(-10, 10)
        
        # Ensure ac ≠ 0 and ad ≠ bc
        while a*d == b*c
            d = randint(-10, 10)
        end
        
        f_expr = (a*x + b) // (c*x + d)
        
        # Range of f(x) = (ax+b)/(cx+d) is all reals except a/c (horizontal asymptote)
        excluded = a // c
        
        ans_left = fmt_interval(-Inf, excluded, true, false)
        ans_right = fmt_interval(excluded, Inf, false, true)
        ans = ans_left * " \\cup " * ans_right
        
        problem(
            question="What is the domain of \$f^{-1}(x)\$ if \$f(x) = $(tex(f_expr))\$? Express your answer in interval notation.",
            answer=ans,
            difficulty=(1600, 1800),
            answer_type="text",
            solution=steps(
                "The domain of \$f^{-1}\$ equals the range of \$f\$",
                "For \$f(x) = $(tex(f_expr))\$, the horizontal asymptote is \$y = $(tex(excluded))\$",
                "The range of \$f\$ is all reals except \$$(tex(excluded))\$",
                sol("Answer", ans)
            ),
            time=150
        )
    end
end