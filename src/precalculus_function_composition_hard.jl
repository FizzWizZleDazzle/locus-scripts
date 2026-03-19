# precalculus - function_composition (hard)
# Generated: 2026-03-08T20:24:33.625926

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Compose two polynomials and find (f∘g)(a)
        f = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-12,12))
        g = rand_linear(y; a=(-5,5), b=(-8,8))
        
        a_val = randint(-6, 6)
        g_at_a = substitute(g.expr, y => a_val)
        fog_at_a = substitute(f.expr, x => g_at_a)
        
        problem(
            question="Let \$f(x) = $(tex(f.expr))\$ and \$g(y) = $(tex(g.expr))\$. Find \$(f \\circ g)($(a_val))\$.",
            answer=fog_at_a,
            difficulty=(1800, 2000),
            solution=steps(
                sol("First find", "g($(a_val)) = $(tex(g.expr)) = $(g_at_a)", y => a_val),
                sol("Then compute", "f($(g_at_a)) = $(tex(f.expr))", x => g_at_a),
                sol("Simplify to get", fog_at_a)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type 2: Find f∘g as a function, then evaluate
        f_coeffs = [nonzero(-3,3), randint(-10,10)]
        g = rand_quadratic(x; a=(-3,3), b=(-7,7), c=(-10,10))
        
        f_expr = f_coeffs[1]*x + f_coeffs[2]
        fog_expr = substitute(f_expr, x => g.expr)
        fog_expanded = expand(fog_expr)
        
        eval_at = randint(-4, 4)
        answer = substitute(fog_expanded, x => eval_at)
        
        problem(
            question="Given \$f(x) = $(tex(f_expr))\$ and \$g(x) = $(tex(g.expr))\$, find \$(f \\circ g)(x)\$ and evaluate it at \$x = $(eval_at)\$.",
            answer=answer,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Compute composition", "(f \\circ g)(x) = f(g(x)) = $(tex(fog_expr))"),
                sol("Expand", fog_expanded),
                sol("Evaluate at x = $(eval_at)", answer)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Type 3: Solve f(g(x)) = k for x
        g = rand_linear(x; a=(-4,4), b=(-9,9))
        f = rand_linear(y; a=(-5,5), b=(-10,10))
        
        target_x = randint(-8, 8)
        g_val = substitute(g.expr, x => target_x)
        k = substitute(f.expr, y => g_val)
        
        fog_expr = substitute(f.expr, y => g.expr)
        
        problem(
            question="Let \$f(y) = $(tex(f.expr))\$ and \$g(x) = $(tex(g.expr))\$. Solve \$(f \\circ g)(x) = $(k)\$ for \$x\$.",
            answer=target_x,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Set up equation", "(f \\circ g)(x) = $(tex(fog_expr)) = $(k)"),
                sol("Solve linear equation", "$(tex(g.a*f.a))*x + $(f.a*g.b + f.b) = $(k)"),
                sol("Solution", target_x)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Type 4: Find g such that f(g(x)) = h(x)
        f = rand_linear(y; a=(-6,6), b=(-12,12))
        target_g = rand_linear(x; a=(-5,5), b=(-10,10))
        h_expr = substitute(f.expr, y => target_g.expr)
        h_expanded = expand(h_expr)
        
        problem(
            question="Let \$f(y) = $(tex(f.expr))\$ and \$h(x) = $(tex(h_expanded))\$. Find the linear function \$g(x) = ax + b\$ such that \$(f \\circ g)(x) = h(x)\$. Enter your answer as the coefficient \$a\$.",
            answer=target_g.a,
            difficulty=(2000, 2200),
            solution=steps(
                sol("We need", "f(g(x)) = $(tex(f.a))(ax + b) + $(tex(f.b)) = $(tex(h_expanded))"),
                sol("Expand", "$(tex(f.a))*a*x + $(tex(f.a))*b + $(tex(f.b)) = $(tex(h_expanded))"),
                sol("Match coefficients", "$(tex(f.a))*a = $(tex(h_expanded.coeff(x))), so a = $(target_g.a)")
            ),
            time=240
        )
        
    else
        # Type 5: Triple composition f(g(h(x)))
        f = rand_linear(x; a=(-4,4), b=(-8,8))
        g = rand_linear(y; a=(-4,4), b=(-8,8))
        h = rand_linear(x; a=(-4,4), b=(-8,8))
        
        eval_at = randint(-5, 5)
        
        h_val = substitute(h.expr, x => eval_at)
        g_val = substitute(g.expr, y => h_val)
        f_val = substitute(f.expr, x => g_val)
        
        problem(
            question="Let \$f(x) = $(tex(f.expr))\$, \$g(y) = $(tex(g.expr))\$, and \$h(x) = $(tex(h.expr))\$. Find \$(f \\circ g \\circ h)($(eval_at))\$.",
            answer=f_val,
            difficulty=(2100, 2300),
            solution=steps(
                sol("First", "h($(eval_at)) = $(tex(h.expr)) = $(h_val)", x => eval_at),
                sol("Then", "g($(h_val)) = $(tex(g.expr)) = $(g_val)", y => h_val),
                sol("Finally", "f($(g_val)) = $(tex(f.expr)) = $(f_val)", x => g_val)
            ),
            time=180
        )
    end
end