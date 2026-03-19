# precalculus - function_composition (very_easy)
# Generated: 2026-03-08T20:24:04.565086

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/function_composition")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 200-400: Evaluate f(g(a)) where f and g are simple linear, given explicit values
        a_val = randint(-5, 5)
        b_val = randint(-5, 5)
        c_val = randint(-5, 5)
        d_val = randint(-5, 5)
        x_val = randint(-3, 3)
        
        g_result = a_val * x_val + b_val
        f_result = c_val * g_result + d_val
        
        problem(
            question="Let \$f(x) = $(c_val)x + $(d_val)\$ and \$g(x) = $(a_val)x + $(b_val)\$. Find \$f(g($(x_val)))\$.",
            answer=f_result,
            difficulty=(200, 400),
            solution=steps(
                "First evaluate \$g($(x_val))\$",
                sol("g($(x_val))", a_val * x_val + b_val, g_result),
                "Now evaluate \$f($(g_result))\$",
                sol("f($(g_result))", c_val * g_result + d_val, f_result)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # ELO 300-500: Find (f∘g)(x) for simple linear functions
        a = nonzero(-8, 8)
        b = randint(-10, 10)
        c = nonzero(-8, 8)
        d = randint(-10, 10)
        
        composition = expand(a * (c*x + d) + b)
        
        problem(
            question="Let \$f(x) = $(a)x + $(b)\$ and \$g(x) = $(c)x + $(d)\$. Find \$(f \\circ g)(x)\$.",
            answer=composition,
            difficulty=(300, 500),
            solution=steps(
                sol("(f \\circ g)(x) = f(g(x))"),
                "Substitute \$g(x)\$ into \$f(x)\$",
                sol("f($(c)x + $(d))", a*(c*x + d) + b),
                "Simplify",
                sol("Answer", composition)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # ELO 400-600: Evaluate g(f(a)) with quadratic and linear
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-4, 4)
        x_val = randint(-3, 3)
        
        f_result = a * x_val + b
        g_result = c * f_result^2
        
        problem(
            question="Let \$f(x) = $(a)x + $(b)\$ and \$g(x) = $(c)x^2\$. Find \$g(f($(x_val)))\$.",
            answer=g_result,
            difficulty=(400, 600),
            solution=steps(
                "First evaluate \$f($(x_val))\$",
                sol("f($(x_val))", a * x_val + b, f_result),
                "Now evaluate \$g($(f_result))\$",
                sol("g($(f_result))", c * f_result^2, g_result)
            ),
            time=90
        )
        
    else
        # ELO 500-700: Find (g∘f)(x) where f is quadratic and g is linear
        q = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-8,8))
        m = nonzero(-6, 6)
        n = randint(-10, 10)
        
        composition = expand(m * q.expr + n)
        
        problem(
            question="Let \$f(x) = $(tex(q.expr))\$ and \$g(x) = $(m)x + $(n)\$. Find \$(g \\circ f)(x)\$.",
            answer=composition,
            difficulty=(500, 700),
            solution=steps(
                sol("(g \\circ f)(x) = g(f(x))"),
                "Substitute \$f(x)\$ into \$g(x)\$",
                sol("g($(tex(q.expr)))", m * q.expr + n),
                "Expand and simplify",
                sol("Answer", composition)
            ),
            time=120
        )
    end
end