# precalculus - function_composition (medium)
# Generated: 2026-03-08T20:24:30.148017

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Simple composition (f ∘ g)(x) with linear and quadratic
        f = rand_linear(x; a=(-8, 8), b=(-12, 12))
        g = rand_quadratic(x; a=(-4, 4), b=(-8, 8), c=(-12, 12))
        
        fog = substitute(f.expr, x => g.expr)
        fog_expanded = expand(fog)
        
        problem(
            question="Let \$f(x) = $(tex(f.expr))\$ and \$g(x) = $(tex(g.expr))\$. Find \$(f \\circ g)(x)\$ in expanded form.",
            answer=fog_expanded,
            difficulty=(1200, 1400),
            solution=steps(
                sol("f(x)", f.expr),
                sol("g(x)", g.expr),
                sol("(f \\circ g)(x) = f(g(x))", fog),
                "Expand:",
                sol("Answer", fog_expanded)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type 2: Evaluate composition at a point
        a1 = nonzero(-6, 6)
        b1 = randint(-15, 15)
        a2 = nonzero(-5, 5)
        b2 = randint(-10, 10)
        c2 = randint(-15, 15)
        
        f_expr = a1*x + b1
        g_expr = a2*x^2 + b2*x + c2
        
        eval_point = randint(-8, 8)
        g_val = a2*eval_point^2 + b2*eval_point + c2
        fog_val = a1*g_val + b1
        
        problem(
            question="Let \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g_expr))\$. Evaluate \$(f \\circ g)($(eval_point))\$.",
            answer=fog_val,
            difficulty=(1200, 1500),
            solution=steps(
                sol("g($(eval_point))", substitute(g_expr, x => eval_point)),
                sol("", g_val),
                sol("f(g($(eval_point))) = f($(g_val))", substitute(f_expr, x => g_val)),
                sol("Answer", fog_val)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Type 3: Find (g ∘ f)(x) with rational function
        f = rand_linear(x; a=(-8, 8), b=(-15, 15))
        a_g = nonzero(-6, 6)
        b_g = randint(-12, 12)
        
        g_expr = a_g*x + b_g
        
        gof = substitute(g_expr, x => f.expr)
        gof_expanded = expand(gof)
        
        problem(
            question="Let \$f(x) = $(tex(f.expr))\$ and \$g(x) = $(tex(g_expr))\$. Find \$(g \\circ f)(x)\$ in simplified form.",
            answer=gof_expanded,
            difficulty=(1200, 1400),
            solution=steps(
                sol("f(x)", f.expr),
                sol("g(x)", g_expr),
                sol("(g \\circ f)(x) = g(f(x))", gof),
                "Simplify:",
                sol("Answer", gof_expanded)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Type 4: Composition with square root or absolute value
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        inner = rand_linear(x; a=(-6, 6), b=(-15, 15))
        
        if rand(Bool)
            f_expr = sqrt(x)
            fog = sqrt(inner.expr)
            
            problem(
                question="Let \$f(x) = \\sqrt{x}\$ and \$g(x) = $(tex(inner.expr))\$. Find \$(f \\circ g)(x)\$.",
                answer=fog,
                difficulty=(1100, 1300),
                solution=steps(
                    sol("f(x)", f_expr),
                    sol("g(x)", inner.expr),
                    sol("(f \\circ g)(x) = f(g(x))", fog),
                    "Answer: \$\\sqrt{$(tex(inner.expr))}\$"
                ),
                time=80
            )
        else
            f_expr = abs(x)
            fog = abs(inner.expr)
            
            problem(
                question="Let \$f(x) = |x|\$ and \$g(x) = $(tex(inner.expr))\$. Find \$(f \\circ g)(x)\$.",
                answer=fog,
                difficulty=(1100, 1300),
                solution=steps(
                    sol("f(x)", f_expr),
                    sol("g(x)", inner.expr),
                    sol("(f \\circ g)(x) = f(g(x))", fog),
                    "Answer: \$|$(tex(inner.expr))|\$"
                ),
                time=80
            )
        end
        
    else
        # Type 5: Triple composition or solving f(g(x)) = value
        if rand(Bool)
            # Triple composition
            f = rand_linear(x; a=(-5, 5), b=(-10, 10))
            g = rand_linear(x; a=(-5, 5), b=(-10, 10))
            h = rand_linear(x; a=(-5, 5), b=(-10, 10))
            
            temp = substitute(g.expr, x => h.expr)
            fog_oh = substitute(f.expr, x => temp)
            result = expand(fog_oh)
            
            problem(
                question="Let \$f(x) = $(tex(f.expr))\$, \$g(x) = $(tex(g.expr))\$, and \$h(x) = $(tex(h.expr))\$. Find \$(f \\circ g \\circ h)(x)\$ in simplified form.",
                answer=result,
                difficulty=(1400, 1700),
                solution=steps(
                    sol("h(x)", h.expr),
                    sol("g(h(x))", expand(temp)),
                    sol("f(g(h(x)))", fog_oh),
                    "Expand:",
                    sol("Answer", result)
                ),
                time=150
            )
        else
            # Solve f(g(x)) = value
            f = rand_linear(x; a=(-6, 6), b=(-12, 12))
            g = rand_linear(x; a=(-5, 5), b=(-10, 10))
            
            target_x = randint(-15, 15)
            g_val = substitute(g.expr, x => target_x)
            target_val = substitute(f.expr, x => g_val)
            target_val = simplify(target_val)
            
            problem(
                question="Let \$f(x) = $(tex(f.expr))\$ and \$g(x) = $(tex(g.expr))\$. Solve for \$x\$: \$(f \\circ g)(x) = $(tex(target_val))\$.",
                answer=target_x,
                difficulty=(1400, 1800),
                solution=steps(
                    sol("(f \\circ g)(x)", expand(substitute(f.expr, x => g.expr))),
                    "Set equal to $(tex(target_val)) and solve:",
                    sol("$(tex(expand(substitute(f.expr, x => g.expr))))", target_val),
                    "Solve for x:",
                    sol("Answer: x", target_x)
                ),
                time=180
            )
        end
    end
end