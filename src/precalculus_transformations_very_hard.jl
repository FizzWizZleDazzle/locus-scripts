# precalculus - transformations (very_hard)
# Generated: 2026-03-08T20:26:52.120069

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/transformations")
    
    problem_type = choice([
        :composition_with_inverse,
        :functional_equation_transform,
        :graph_transformation_system,
        :iteration_periodicity,
        :transformation_conjugacy
    ])
    
    if problem_type == :composition_with_inverse
        # High-level problem: Find g such that f(g(x)) produces a specific transformation
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # We want f(g(x)) = cx + d where f(x) = ax + b
        # So a*g(x) + b = cx + d
        # Thus g(x) = (cx + d - b)/a = (c/a)x + (d-b)/a
        
        g_slope = c // a
        g_intercept = (d - b) // a
        g_expr = g_slope * x + g_intercept
        
        f_expr = a*x + b
        target_expr = c*x + d
        
        question_text = "Let \\\$f(x) = $(tex(f_expr))\\\$. Find the linear function \\\$g(x)\\\$ such that \\\$f(g(x)) = $(tex(target_expr))\\\$ for all \\\$x\\\$."
        
        answer_expr = g_expr
        
        solution_text = steps(
            sol("Given", "f(x) = $(tex(f_expr))"),
            "We need \\\$f(g(x)) = $(tex(target_expr))\\\$",
            "Substitute: \\\$$(tex(a))(g(x)) + $(tex(b)) = $(tex(target_expr))\\\$",
            "Solve for \\\$g(x)\\\$: \\\$g(x) = \\frac{$(tex(target_expr)) - $(tex(b))}{$(tex(a))}\\\$",
            sol("Simplify", "g(x) = $(tex(g_expr))"),
            sol("Answer", g_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=(2500, 2800),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == :functional_equation_transform
        # Find all functions satisfying f(x) + f(1-x) = x^2 + (1-x)^2
        k = randint(2, 5)
        
        # The general solution is f(x) = x^k + (1-x)^k + h(x) - h(1-x)
        # For uniqueness, we add a constraint like f(0) = c
        
        c = randint(-10, 10)
        
        # Simplest case: f(x) = x^2 + c works when k=2
        if k == 2
            # f(x) + f(1-x) = 2x^2 - 2x + 2c + 1
            # Want symmetric, so f(x) = x^2 - x + c works
            target_sum = expand(2*x^2 - 2*x + 1)
            f_solution = x^2 - x + c
            
            question_text = "Find a function \\\$f(x)\\\$ such that \\\$f(x) + f(1-x) = $(tex(target_sum))\\\$ for all \\\$x\\\$, and \\\$f(0) = $(c)\\\$."
            
            solution_text = steps(
                sol("Given", "f(x) + f(1-x) = $(tex(target_sum))"),
                "Try \\\$f(x) = ax^2 + bx + c\\\$ where \\\$f(0) = $(c)\\\$ gives \\\$c = $(c)\\\$",
                "Substitute: \\\$ax^2 + bx + $(c) + a(1-x)^2 + b(1-x) + $(c) = $(tex(target_sum))\\\$",
                "Expand and equate coefficients: \\\$2a = 2\\\$, \\\$-2a = -2\\\$, \\\$a + b + 2c = 1\\\$",
                "Solve: \\\$a = 1\\\$, \\\$b = -1\\\$",
                sol("Answer", f_solution)
            )
            
            problem(
                question=question_text,
                answer=f_solution,
                difficulty=(2800, 3200),
                solution=solution_text,
                time=300
            )
        else
            # More general case
            p = randint(1, 4)
            q = randint(1, 4)
            target_sum = expand(x^p + (1-x)^p + x^q + (1-x)^q)
            
            # One solution: f(x) = x^p + x^q
            f_solution = x^p + x^q
            
            question_text = "Find one function \\\$f(x)\\\$ (expressed as a polynomial) such that \\\$f(x) + f(1-x) = $(tex(target_sum))\\\$ for all \\\$x\\\$."
            
            solution_text = steps(
                sol("Given", "f(x) + f(1-x) = $(tex(target_sum))"),
                "Notice the right side has symmetry under \\\$x \\leftrightarrow 1-x\\\$",
                "Try \\\$f(x) = x^{$(p)} + x^{$(q)}\\\$",
                "Verify: \\\$f(1-x) = (1-x)^{$(p)} + (1-x)^{$(q)}\\\$",
                "Sum equals the target expression",
                sol("Answer", f_solution)
            )
            
            problem(
                question=question_text,
                answer=f_solution,
                difficulty=(3000, 3400),
                solution=solution_text,
                time=300
            )
        end
        
    elseif problem_type == :graph_transformation_system
        # Given transformations T1, T2, find the single transformation equivalent to T2∘T1
        h1 = nonzero(-6, 6)
        k1 = nonzero(-6, 6)
        h2 = nonzero(-6, 6)
        k2 = nonzero(-6, 6)
        scale_a = choice([2, 3, 4, Rational(1,2), Rational(1,3)])
        scale_b = choice([2, 3, Rational(1,2)])
        
        # T1: shift by (h1, k1), then vertical stretch by scale_a
        # T2: horizontal stretch by 1/scale_b, then shift by (h2, k2)
        
        # Result: h_total, k_total, combined scales
        h_total = h1 + scale_b * h2
        k_total = scale_a * k1 + k2
        
        question_text = "Let \\\$T_1\\\$ be the transformation that shifts a graph right by \\\$$(h1)\\\$ and up by \\\$$(k1)\\\$, then vertically stretches by a factor of \\\$$(tex(scale_a))\\\$. Let \\\$T_2\\\$ be the transformation that horizontally stretches by a factor of \\\$$(tex(scale_b))\\\$ then shifts right by \\\$$(h2)\\\$ and up by \\\$$(k2)\\\$. If \\\$f(x) = x^2\\\$, find the equation of \\\$y = T_2(T_1(f(x)))\\\$ in the form \\\$y = a(x-h)^2 + k\\\$."
        
        # T1(f(x)): scale_a * ((x - h1)^2) + k1 = scale_a*(x-h1)^2 + scale_a*k1
        # Actually k_total should be scale_a * k1 + k2
        k_total_correct = scale_a * k1 + k2
        
        # T2: replace x with x/scale_b, then shift
        # scale_a * ((x/scale_b - h1)^2) + scale_a*k1, then shift by (h2, k2)
        # = scale_a * ((x - scale_b*h1)/scale_b)^2 + scale_a*k1 + k2
        # = (scale_a/scale_b^2) * (x - scale_b*h1 - scale_b*h2)^2 + scale_a*k1 + k2
        
        a_final = scale_a // (scale_b^2)
        h_final = scale_b * (h1 + h2)
        k_final = scale_a * k1 + k2
        
        answer_expr = expand(a_final * (x - h_final)^2 + k_final)
        
        solution_text = steps(
            "Apply \\\$T_1\\\$ to \\\$f(x) = x^2\\\$: shift right by \\\$$(h1)\\\$, up by \\\$$(k1)\\\$, stretch vertically by \\\$$(tex(scale_a))\\\$",
            sol("After T_1", "y = $(tex(scale_a))\\cdot(x - $(h1))^2 + $(tex(scale_a))\\cdot$(k1)"),
            "Apply \\\$T_2\\\$: horizontal stretch by \\\$$(tex(scale_b))\\\$ means replace \\\$x\\\$ with \\\$x/$(tex(scale_b))\\\$, then shift",
            "After horizontal stretch: \\\$y = $(tex(scale_a))\\cdot\\left(\\frac{x}{$(tex(scale_b))} - $(h1)\\right)^2 + $(tex(scale_a * k1))\\\$",
            "Shift by \$($(h2), $(k2))\\\$: replace \\\$x\\\$ with \\\$x - $(h2)\\\$, add \\\$$(k2)\\\$ to \\\$y\\\$",
            sol("Final form", answer_expr),
            sol("Answer", answer_expr)
        )
        
        problem(
            question=question_text,
            answer=answer_expr,
            difficulty=(2600, 3000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == :iteration_periodicity
        # Find period of iterated transformation
        a = choice([-1, 2, -2, 3])
        b = nonzero(-5, 5)
        
        if a == -1
            period = 2
            question_text = "Define \\\$f(x) = $(tex(-x + b))\\\$. Find the smallest positive integer \\\$n\\\$ such that \\\$f^{(n)}(x) = x\\\$ for all \\\$x\\\$, where \\\$f^{(n)}\\\$ denotes \\\$f\\\$ applied \\\$n\\\$ times."
            
            solution_text = steps(
                sol("Given", "f(x) = $(tex(-x + b))"),
                sol("f(f(x))", "f($(tex(-x + b))) = -($(tex(-x + b))) + $(b) = x"),
                "Thus \\\$f^{(2)}(x) = x\\\$ for all \\\$x\\\$",
                sol("Answer", 2)
            )
        elseif abs(a) == 2
            # f(x) = ax + b, period is infinity unless a = -1
            period = randint(3, 5)
            # Create a different problem: rotation-like transformation
            question_text = "Define the transformation \\\$T\\\$ on the plane by \\\$T(x, y) = (-y, x)\\\$ (rotation by 90° counterclockwise). Find the smallest positive integer \\\$n\\\$ such that \\\$T^n\\\$ is the identity transformation."
            
            solution_text = steps(
                sol("T(x,y)", "(-y, x)"),
                sol("T^2(x,y)", "T(-y, x) = (-x, -y)"),
                sol("T^3(x,y)", "T(-x, -y) = (y, -x)"),
                sol("T^4(x,y)", "T(y, -x) = (x, y)"),
                "Thus the period is 4",
                sol("Answer", 4)
            )
            period = 4
        else
            # Use f(x) = 1/x type transformation
            question_text = "Define \\\$f(x) = \\frac{1}{1-x}\\\$ for \\\$x \\neq 0, 1\\\$. Find the smallest positive integer \\\$n\\\$ such that \\\$f^{(n)}(x) = x\\\$ for all \\\$x\\\$ in the domain."
            
            solution_text = steps(
                sol("f(x)", "\\frac{1}{1-x}"),
                sol("f^{(2)}(x)", "f\\left(\\frac{1}{1-x}\\right) = \\frac{1}{1 - \\frac{1}{1-x}} = \\frac{1-x}{-x} = \\frac{x-1}{x}"),
                sol("f^{(3)}(x)", "f\\left(\\frac{x-1}{x}\\right) = \\frac{1}{1 - \\frac{x-1}{x}} = \\frac{x}{1} = x"),
                "The transformation has period 3",
                sol("Answer", 3)
            )
            period = 3
        end
        
        problem(
            question=question_text,
            answer=period,
            difficulty=(2700, 3200),
            solution=solution_text,
            time=240
        )
        
    else  # :transformation_conjugacy
        # Find h such that h^{-1} ∘ f ∘ h = g for given f and g
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        s1 = nonzero(-8, 8)
        s2 = nonzero(-8, 8)
        
        # f(x) = (x - r1)(x - r2) with roots r1, r2
        # g(x) = (x - s1)(x - s2) with roots s1, s2
        # h should map s1 -> r1, s2 -> r2
        # h(x) = mx + b where h(s1) = r1, h(s2) = r2
        
        if s1 != s2
            m = (r2 - r1) // (s2 - s1)
            b = r1 - m * s1
            h_expr = m * x + b
            
            f_expr = expand((x - r1) * (x - r2))
            g_expr = expand((x - s1) * (x - s2))
            
            question_text = "Let \\\$f(x) = $(tex(f_expr))\\\$ and \\\$g(x) = $(tex(g_expr))\\\$. Find a linear function \\\$h(x) = mx + b\\\$ such that \\\$h^{-1}(f(h(x))) = g(x)\\\$ for all \\\$x\\\$."
            
            solution_text = steps(
                "The condition \\\$h^{-1} \\circ f \\circ h = g\\\$ means \\\$h\\\$ conjugates \\\$f\\\$ to \\\$g\\\$",
                "Roots of \\\$f\\\$: \\\$$(r1), $(r2)\\\$; roots of \\\$g\\\$: \\\$$(s1), $(s2)\\\$",
                "We need \\\$h($(s1)) = $(r1)\\\$ and \\\$h($(s2)) = $(r2)\\\$",
                "Solve the linear system for the coefficients",
                sol("Answer", tex(h_expr))
            )

            problem(
                question=question_text,
                answer=tex(h_expr),
                difficulty=(2900, 3400),
                solution=solution_text,
                time=270,
                answer_type="expression"
            )
        end
    end
end
