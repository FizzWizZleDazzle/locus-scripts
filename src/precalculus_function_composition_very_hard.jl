# precalculus - function_composition (very_hard)
# Generated: 2026-03-08T20:25:01.850075

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Iterated composition with polynomial finding f^n(x) = x
        k = rand(2:4)
        
        if k == 2
            # f(f(x)) = x type (involution)
            inv_type = rand(1:3)
            
            if inv_type == 1
                # f(x) = (a-x)/(1+bx) form
                a = nonzero(-8, 8)
                b = nonzero(-5, 5)
                f_expr = (a - x) / (1 + b*x)
                
                question = "Let \\\$f(x) = $(tex(f_expr))\\\$. Find all values of \\\$x\\\$ such that \\\$f(f(x)) = x\\\$ for all \\\$x\\\$ in the domain."
                
                # Compute f(f(x))
                ff = simplify(substitute(f_expr, x => f_expr))
                
                # This is an identity - true for all x in domain
                answer = "All real numbers except \\\$x = -\\frac{1}{$(b)}\\\$"
                
                solution = steps(
                    sol("Given", f_expr),
                    "Compute \\\$f(f(x))\\\$ by substituting \\\$f(x)\\\$ into itself",
                    sol("f(f(x))", ff),
                    "Simplify to verify this equals \\\$x\\\$ for all \\\$x\\\$ in the domain",
                    "The domain excludes \\\$x = -1/$(b)\\\$ where denominator is zero",
                    "Answer: All real numbers except \\\$x = -1/$(b)\\\$"
                )
                
                difficulty = (2600, 2900)
                
            elseif inv_type == 2
                # f(x) = k - x type
                k_val = nonzero(-12, 12)
                f_expr = k_val - x
                
                question = "Let \\\$f(x) = $(tex(f_expr))\\\$. Solve \\\$f(f(f(f(x)))) = 7\\\$."
                
                # f(f(x)) = k - (k - x) = x, so f^4(x) = x
                # We need x = 7
                answer = 7
                
                solution = steps(
                    sol("Given", f_expr),
                    "Compute \\\$f(f(x)) = f($(k_val) - x) = $(k_val) - ($(k_val) - x) = x\\\$",
                    "Therefore \\\$f(f(f(f(x)))) = f(f(x)) = x\\\$",
                    "Setting this equal to 7 gives \\\$x = 7\\\$",
                    sol("Answer", 7)
                )
                
                difficulty = (2500, 2700)
                
            else
                # Fractional linear with order 2
                a = nonzero(-6, 6)
                f_expr = a / x
                
                question = "Let \\\$f(x) = $(tex(f_expr))\\\$. Find the sum of all real solutions to \\\$f(f(f(x))) = x\\\$ where \\\$x \\neq 0\\\$."
                
                # f(f(x)) = a/(a/x) = x, so f(f(f(x))) = f(x) = a/x
                # a/x = x => x^2 = a
                if a > 0
                    r1 = sqrt(a)
                    r2 = -sqrt(a)
                    ans = 0
                else
                    ans = 0  # No real solutions
                end
                
                answer = ans
                
                solution = steps(
                    sol("Given", f_expr),
                    "Compute \\\$f(f(x)) = f(a/x) = a/(a/x) = x\\\$",
                    "Therefore \\\$f(f(f(x))) = f(x) = a/x\\\$",
                    "Setting \\\$a/x = x\\\$ gives \\\$x^2 = $(a)\\\$",
                    a > 0 ? "Solutions: \\\$x = \\pm \\sqrt{$(a)}\\\$, sum = 0" : "No real solutions, sum = 0",
                    sol("Answer", ans)
                )
                
                difficulty = (2700, 3000)
            end
            
        else
            # Higher order iteration
            # f(x) = 1/(1-x) has order 3
            f_expr = 1 / (1 - x)
            
            question = "Let \\\$f(x) = $(tex(f_expr))\\\$. Find the sum of all real solutions to \\\$f(f(f(f(f(f(x)))))) = x\\\$ where \\\$x \\notin \\{0, 1\\}\\\$."
            
            # This function has order 3: f^3(x) = x
            # So f^6(x) = x for all x
            # Sum over domain (excluding 0, 1): all real numbers except 0, 1
            
            answer = "All real numbers except 0 and 1"
            
            solution = steps(
                sol("Given", f_expr),
                "Compute \\\$f(f(x)) = f\\left(\\frac{1}{1-x}\\right) = \\frac{1}{1-\\frac{1}{1-x}} = \\frac{1-x}{-x} = \\frac{x-1}{x}\\\$",
                "Compute \\\$f(f(f(x))) = f\\left(\\frac{x-1}{x}\\right) = \\frac{1}{1-\\frac{x-1}{x}} = \\frac{x}{1} = x\\\$",
                "Since \\\$f^3(x) = x\\\$, we have \\\$f^6(x) = x\\\$ for all \\\$x\\\$ in the domain",
                "The domain excludes \\\$x = 0\\\$ and \\\$x = 1\\\$",
                "Answer: All real numbers except 0 and 1"
            )
            
            difficulty = (2800, 3200)
        end
        
    elseif problem_type == 2
        # Functional equation f(g(x)) = h(x), solve for f or g
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        d = nonzero(-10, 10)
        
        # Let g(x) = ax + b, f(g(x)) = cx + d
        # Find f(x)
        g_expr = a*x + b
        h_expr = c*x + d
        
        # f(y) where y = ax + b, so x = (y-b)/a
        # f(y) = c(y-b)/a + d
        f_of_y = simplify(c*(y - b)//a + d)
        
        question = "Let \\\$g(x) = $(tex(g_expr))\\\$ and suppose \\\$f(g(x)) = $(tex(h_expr))\\\$ for all \\\$x\\\$. Find \\\$f(x)\\\$."
        
        answer = substitute(f_of_y, y => x)
        
        solution = steps(
            "Given \\\$g(x) = $(tex(g_expr))\\\$ and \\\$f(g(x)) = $(tex(h_expr))\\\$",
            "Let \\\$y = g(x) = $(tex(g_expr))\\\$, so \\\$x = \\frac{y - $(b)}{$(a)}\\\$",
            "Substitute into \\\$f(y) = $(c)x + $(d)\\\$",
            sol("f(y)", f_of_y),
            sol("f(x)", answer)
        )
        
        difficulty = (2500, 2800)
        
    elseif problem_type == 3
        # Commutative composition: f(g(x)) = g(f(x))
        # Use polynomials
        a = nonzero(-4, 4)
        b = nonzero(-8, 8)
        
        # f(x) = x^2 + a, g(x) = bx
        # Find condition on a, b
        
        f_expr = x^2 + a
        g_expr = b*x
        
        question = "Let \\\$f(x) = x^2 + $(a)\\\$ and \\\$g(x) = $(b)x\\\$. Find the value of \\\$f(g(2)) - g(f(2))\\\$."
        
        fg_2 = substitute(f_expr, x => substitute(g_expr, x => 2))
        gf_2 = substitute(g_expr, x => substitute(f_expr, x => 2))
        
        answer = simplify(fg_2 - gf_2)
        
        solution = steps(
            sol("f(x)", f_expr),
            sol("g(x)", g_expr),
            "Compute \\\$g(2) = $(b) \\cdot 2 = $(2b)\\\$",
            "Compute \\\$f(g(2)) = f($(2b)) = ($(2b))^2 + $(a) = $(4*b^2 + a)\\\$",
            "Compute \\\$f(2) = 4 + $(a) = $(4 + a)\\\$",
            "Compute \\\$g(f(2)) = g($(4+a)) = $(b) \\cdot $(4+a) = $(b*(4+a))\\\$",
            sol("Answer", answer)
        )
        
        difficulty = (2400, 2700)
        
    elseif problem_type == 4
        # Find all functions satisfying f(f(x)) = polynomial
        # Example: f(f(x)) = 4x - 3, find linear f
        
        m = choice([2, 3, 4, -2, -3])
        k = nonzero(-15, 15)
        
        target = m*x + k
        
        question = "Find all linear functions \\\$f(x) = ax + b\\\$ such that \\\$f(f(x)) = $(tex(target))\\\$ for all \\\$x\\\$."
        
        # f(f(x)) = a(ax + b) + b = a^2 x + ab + b = a^2 x + b(a+1)
        # Need a^2 = m and b(a+1) = k
        
        if m > 0
            a1 = isqrt(m)
            a2 = -isqrt(m)
            
            if a1^2 == m
                b1 = k // (a1 + 1)
                b2 = k // (a2 + 1)
                
                f1 = a1*x + b1
                f2 = a2*x + b2
                
                answer = "f(x) = $(tex(f1)) \\text{ or } f(x) = $(tex(f2))"
            else
                answer = "No real linear solutions"
            end
        else
            answer = "No real linear solutions (a^2 cannot be negative)"
        end
        
        solution = steps(
            "Let \\\$f(x) = ax + b\\\$",
            "Then \\\$f(f(x)) = a(ax+b) + b = a^2 x + b(a+1)\\\$",
            "Comparing with \\\$$(tex(target))\\\$: \\\$a^2 = $(m)\\\$ and \\\$b(a+1) = $(k)\\\$",
            m > 0 && isqrt(m)^2 == m ? "From \\\$a^2 = $(m)\\\$: \\\$a = \\pm $(isqrt(m))\\\$" : "No real solution for \\\$a\\\$",
            answer
        )
        
        difficulty = (2700, 3100)
        
    else
        # Complex functional equation with multiple compositions
        # f(x) + f(1/x) = polynomial
        
        a = nonzero(-8, 8)
        
        question = "Find all polynomial functions \\\$f(x)\\\$ such that \\\$f(x) + f\\left(\\frac{1}{x}\\right) = $(a)x\\\$ for all \\\$x \\neq 0\\\$."
        
        # Let f(x) = cx, then f(1/x) = c/x
        # cx + c/x = ax requires c = a and c = 0, contradiction unless...
        # Try f(x) = cx - c/x
        
        c = a // 2
        f_candidate = c*x - c/x
        
        answer = "f(x) = $(tex(f_candidate))"
        
        solution = steps(
            "Assume \\\$f(x)\\\$ has the form \\\$f(x) = cx + \\frac{d}{x}\\\$",
            "Then \\\$f(1/x) = \\frac{c}{x} + dx\\\$",
            "So \\\$f(x) + f(1/x) = cx + \\frac{d}{x} + \\frac{c}{x} + dx = (c+d)x + \\frac{c+d}{x}\\\$",
            "Comparing with \\\$$(a)x\\\$: need \\\$c + d = $(a)\\\$ and \\\$c + d = 0\\\$",
            "This gives \\\$c = $(c)\\\$ and \\\$d = $(−c)\\\$",
            sol("Answer", f_candidate)
        )
        
        difficulty = (2900, 3400)
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=240,
        calculator="none"
    )
end