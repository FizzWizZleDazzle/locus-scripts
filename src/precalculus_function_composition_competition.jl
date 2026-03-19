# precalculus - function_composition (competition)
# Generated: 2026-03-08T20:25:01.352100

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Find all functions satisfying f(f(x)) = g(x) with specific properties
        # ELO 3500-4000
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # Target: f(f(x)) = ax^2 + bx + c where f is linear
        # If f(x) = px + q, then f(f(x)) = p(px+q)+q = p²x + pq + q
        # So p² = a, pq + q = b, which means q(p+1) = b
        
        valid = false
        while !valid
            a = rand([1, 4, 9])  # perfect squares
            p = isqrt(a)
            b = nonzero(-15, 15)
            if p != -1
                q = b // (p + 1)
                if denominator(q) == 1
                    q = numerator(q)
                    c = 0  # Not used in this formulation
                    valid = true
                    break
                end
            end
            a = rand([1, 4, 9])
        end
        
        p = isqrt(a)
        q = b // (p + 1)
        q = numerator(q)
        
        target_expr = expand(a*x^2 + b*x + c)
        f_expr = p*x + q
        
        problem(
            question="Find all linear functions \\(f(x) = px + q\\) such that \\(f(f(x)) = $(tex(target_expr))\\). Express your answer as an ordered pair \\((p, q)\\).",
            answer=fmt_tuple([p, q]),
            difficulty=(3500, 3800),
            answer_type="tuple",
            solution=steps(
                "Let \\(f(x) = px + q\\) for constants \\(p\\) and \\(q\\)",
                sol("Then", expand(p*(p*x + q) + q) ~ target_expr),
                "Expanding: \\(p^2 x + pq + q = $(tex(target_expr))\\)",
                "Comparing coefficients: \\(p^2 = $(a)\\) and \\(pq + q = $(b)\\)",
                "From \\(p^2 = $(a)\\), we get \\(p = \\pm $(isqrt(a))\\)",
                "From \\(q(p+1) = $(b)\\): if \\(p = $(p)\\), then \\(q = $(q)\\)",
                sol("Answer", fmt_tuple([p, q]))
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Functional equation with composition
        # Find f such that f(x) + f(1-x) = g(x) and determine f∘f
        # ELO 4000-4500
        
        # Use symmetric construction: f(x) = ax^2 + bx, g(x) symmetric
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        
        f_expr = a*x^2 + b*x
        g_check = substitute(f_expr, x => 1-x)
        g_expr = expand(f_expr + g_check)
        
        fof = substitute(f_expr, x => f_expr)
        fof = expand(fof)
        
        problem(
            question="Suppose \\(f(x)\\) is a polynomial satisfying \\(f(x) + f(1-x) = $(tex(g_expr))\\) for all \\(x\\). If \\(f(0) = 0\\), find \\((f \\circ f)(x)\\).",
            answer=fof,
            difficulty=(4000, 4500),
            solution=steps(
                "Given: \\(f(x) + f(1-x) = $(tex(g_expr))\\) and \\(f(0) = 0\\)",
                "Substituting \\(x = 0\\): \\(f(0) + f(1) = $(substitute(g_expr, x=>0))\\), so \\(f(1) = $(substitute(g_expr, x=>0))\\)",
                "Assume \\(f(x) = ax^2 + bx\\). Then \\(f(1-x) = a(1-x)^2 + b(1-x) = a(1-2x+x^2) + b - bx = ax^2 + (b-2a-b)x + (a+b) = ax^2 - 2ax + a + b\\)",
                "Therefore \\(f(x) + f(1-x) = 2ax^2 + (b-2a)x + (a+b)\\)",
                "Matching coefficients with \\($(tex(g_expr))\\) gives \\(a = $(a), b = $(b)\\)",
                sol("So", f_expr),
                sol("Finally", fof)
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Nested composition with constraint
        # ELO 3800-4200
        
        n = rand(3:5)
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        
        # f^n(x) = x implies finding fixed points of n-fold composition
        # Use f(x) = ax + b, solve f^n(x) = x
        
        f_expr = a*x + b
        
        # For linear f(x) = ax+b, f^n(x) = a^n x + b(a^(n-1) + a^(n-2) + ... + 1)
        # = a^n x + b(a^n - 1)/(a-1) if a ≠ 1
        
        if a != 1
            geom_sum = (a^n - 1) // (a - 1)
            fn_expr = expand(a^n * x + b * geom_sum)
            fixed_pt = -b * geom_sum // (a^n - 1)
            
            if denominator(fixed_pt) == 1
                fixed_pt = numerator(fixed_pt)
            end
        else
            fn_expr = x + n*b
            fixed_pt = "no finite solution"
        end
        
        problem(
            question="Let \\(f(x) = $(tex(f_expr))\\). Define \\(f^{$(n)}(x) = \\underbrace{f(f(\\cdots f}_{$(n) \\text{ times}}(x)\\cdots))\\). Find all real numbers \\(c\\) such that \\(f^{$(n)}(c) = c\\).",
            answer=(a == 1 ? "\\text{No solution}" : fixed_pt),
            difficulty=(3800, 4200),
            solution=steps(
                sol("Given", f_expr),
                "Compute \\(f^{$(n)}(x)\\) by repeated composition",
                (a != 1 ? "For linear \\(f(x) = ax+b\\), \\(f^n(x) = a^n x + b\\frac{a^n-1}{a-1}\\)" : "For \\(f(x) = x + $(b)\\), \\(f^n(x) = x + $(n*b)\\)"),
                sol("So", fn_expr ~ x),
                (a != 1 ? "Solving: \\(($(a^n) - 1)x = $(- b * geom_sum)\\)" : "This gives \\($(n*b) = 0\\), which is false"),
                sol("Answer", (a == 1 ? "No solution" : fixed_pt))
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Research-adjacent: Find inverse under composition
        # ELO 4200-4800
        
        a = nonzero(2, 5)
        b = nonzero(-10, 10)
        c = nonzero(-10, 10)
        
        # Use f(x) = (ax+b)/(x+c) - rational function
        # Find g such that f(g(x)) = x
        
        f_expr = (a*x + b) / (x + c)
        
        # If f(x) = (ax+b)/(x+c), solve y = (ax+b)/(x+c) for x
        # y(x+c) = ax+b → yx + yc = ax + b → yx - ax = b - yc → x(y-a) = b-yc → x = (b-yc)/(y-a)
        # So g(x) = (b - cx)/(x - a)
        
        g_expr = (b - c*x) / (x - a)
        
        # Verify f(g(x)) = x
        verification = substitute(f_expr, x => g_expr)
        verification = simplify(verification)
        
        problem(
            question="Let \\(f(x) = \\frac{$(a)x + $(b)}{x + $(c)}\\). Find the function \\(g(x)\\) such that \\((f \\circ g)(x) = x\\) for all \\(x\\) in the domain.",
            answer=g_expr,
            difficulty=(4200, 4800),
            solution=steps(
                sol("Given", f_expr),
                "We need \\(f(g(x)) = x\\), which means \\(g = f^{-1}\\)",
                "Set \\(y = \\frac{$(a)x + $(b)}{x + $(c)}\\) and solve for \\(x\\)",
                "\\(y(x + $(c)) = $(a)x + $(b)\\)",
                "\\(yx + $(c)y = $(a)x + $(b)\\)",
                "\\(x(y - $(a)) = $(b) - $(c)y\\)",
                sol("Therefore", g_expr)
            ),
            time=240
        )
        
    else
        # Olympiad: Commuting functions
        # Find all pairs (f,g) where f∘g = g∘f with constraints
        # ELO 3600-4000
        
        m = nonzero(-5, 5)
        n = nonzero(-8, 8)
        
        # Use f(x) = x + m, g(x) = nx
        # f(g(x)) = nx + m, g(f(x)) = n(x+m) = nx + nm
        # These commute when m = nm, i.e., m(1-n) = 0
        
        f_expr = x + m
        g_expr = n * x
        
        fog = substitute(f_expr, x => g_expr)
        gof = substitute(g_expr, x => f_expr)
        
        commute = simplify(fog - gof) == 0
        
        problem(
            question="Let \\(f(x) = x + $(m)\\) and \\(g(x) = $(n)x\\). Determine whether \\(f \\circ g = g \\circ f\\). If they commute, find the value of \\((f \\circ g \\circ f)(0)\\). If not, find \\(|(f \\circ g)(1) - (g \\circ f)(1)|\\).",
            answer=(commute ? substitute(substitute(fog, x=>0), x=>0) : abs(substitute(fog, x=>1) - substitute(gof, x=>1))),
            difficulty=(3600, 4000),
            solution=steps(
                sol("Compute", fog),
                sol("Compute", gof),
                (commute ? "Since \\($(tex(fog)) = $(tex(gof))\\), they commute" : "Since \\($(tex(fog)) \\neq $(tex(gof))\\), they do not commute"),
                (commute ? "\\((f \\circ g \\circ f)(0) = f(g(f(0))) = f(g($(m))) = f($(n*m)) = $(n*m + m)\\)" : "\\(|(f \\circ g)(1) - (g \\circ f)(1)| = |$(substitute(fog, x=>1)) - $(substitute(gof, x=>1))| = $(abs(substitute(fog, x=>1) - substitute(gof, x=>1)))|\\)"),
                sol("Answer", (commute ? n*m + m : abs(substitute(fog, x=>1) - substitute(gof, x=>1))))
            ),
            time=280
        )
    end
end