# precalculus - function_composition (easy)
# Generated: 2026-03-08T20:24:10.014695

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Basic composition with linear functions
        # ELO: 700-900
        a1 = nonzero(-8, 8)
        b1 = randint(-15, 15)
        a2 = nonzero(-8, 8)
        b2 = randint(-15, 15)
        
        f_expr = a1*x + b1
        g_expr = a2*x + b2
        
        # (f ∘ g)(x) = f(g(x))
        composition = substitute(f_expr, x => g_expr)
        ans = expand(composition)
        
        problem(
            question="Let \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g_expr))\$. Find \$(f \\circ g)(x)\$.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("f(x)", f_expr),
                sol("g(x)", g_expr),
                sol("(f \\circ g)(x) = f(g(x))", substitute(f_expr, x => g_expr)),
                "Simplify",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Composition at a point
        # ELO: 750-950
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = nonzero(-6, 6)
        d = randint(-12, 12)
        
        f_expr = a*x + b
        g_expr = c*x^2 + d
        
        eval_point = randint(-5, 5)
        
        # Calculate (f ∘ g)(eval_point)
        g_val = c * eval_point^2 + d
        f_of_g = a * g_val + b
        ans = f_of_g
        
        problem(
            question="Let \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g_expr))\$. Find \$(f \\circ g)($(eval_point))\$.",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                sol("g($(eval_point))", g_val),
                sol("(f \\circ g)($(eval_point)) = f(g($(eval_point))) = f($(g_val))", substitute(f_expr, x => g_val)),
                "Evaluate",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Type 3: Quadratic with linear composition
        # ELO: 850-1050
        q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-10,10))
        l = rand_linear(x; a=(-5,5), b=(-10,10))
        
        # (f ∘ g)(x) where f is quadratic, g is linear
        composition = substitute(q.expr, x => l.expr)
        ans = expand(composition)
        
        problem(
            question="Let \$f(x) = $(tex(q.expr))\$ and \$g(x) = $(tex(l.expr))\$. Find \$(f \\circ g)(x)\$.",
            answer=ans,
            difficulty=(850, 1050),
            solution=steps(
                sol("f(x)", q.expr),
                sol("g(x)", l.expr),
                sol("(f \\circ g)(x) = f(g(x))", substitute(q.expr, x => l.expr)),
                "Expand and simplify",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Type 4: Find f(x) given composition and g(x)
        # ELO: 900-1100
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        c = nonzero(-7, 7)
        d = randint(-15, 15)
        
        g_expr = a*x + b
        f_expr = c*x + d
        
        # Given (f ∘ g)(x), find f(x)
        composition = expand(substitute(f_expr, x => g_expr))
        
        problem(
            question="Let \$g(x) = $(tex(g_expr))\$ and \$(f \\circ g)(x) = $(tex(composition))\$. Find \$f(x)\$.",
            answer=f_expr,
            difficulty=(900, 1100),
            solution=steps(
                sol("(f \\circ g)(x) = f(g(x))", composition),
                sol("g(x)", g_expr),
                "Since \$f(g(x)) = $(tex(composition))\$, replace \$$(tex(g_expr))\$ with \$x\$ in the composition",
                "Solve for the pattern",
                sol("f(x)", f_expr)
            ),
            time=150
        )
        
    else
        # Type 5: Double composition or evaluation
        # ELO: 950-1200
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        d = randint(-10, 10)
        
        f_expr = a*x^2 + b
        g_expr = c*x + d
        
        eval_point = randint(-4, 4)
        
        # Calculate (g ∘ f)(eval_point)
        f_val = a * eval_point^2 + b
        g_of_f = c * f_val + d
        ans = g_of_f
        
        problem(
            question="Let \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g_expr))\$. Find \$(g \\circ f)($(eval_point))\$.",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                sol("f($(eval_point))", f_val),
                sol("(g \\circ f)($(eval_point)) = g(f($(eval_point))) = g($(f_val))", substitute(g_expr, x => f_val)),
                "Evaluate",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end