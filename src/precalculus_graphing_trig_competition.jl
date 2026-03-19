# precalculus - graphing_trig (competition)
# Generated: 2026-03-08T20:29:53.981573

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Find all x in [0, 2π] where f(x) = g(x) for complex trig compositions
        a1 = nonzero(-4, 4)
        b1 = nonzero(-3, 3)
        c1 = randint(-5, 5)
        
        a2 = nonzero(-4, 4)
        b2 = nonzero(-3, 3)
        c2 = randint(-5, 5)
        
        # Create equation like: a1*sin(b1*x) + c1 = a2*cos(b2*x) + c2
        # This is olympiad-level because it requires:
        # 1. Understanding periodicity and composition
        # 2. Algebraic manipulation of trig identities
        # 3. Checking multiple periods and intersections
        # 4. Numerical/graphical insight for non-standard cases
        
        lhs_str = a1 == 1 ? "\\sin($(b1)x)" : "$(a1)\\sin($(b1)x)"
        if c1 != 0
            lhs_str = c1 > 0 ? lhs_str * " + $(c1)" : lhs_str * " - $(-c1)"
        end
        
        rhs_str = a2 == 1 ? "\\cos($(b2)x)" : "$(a2)\\cos($(b2)x)"
        if c2 != 0
            rhs_str = c2 > 0 ? rhs_str * " + $(c2)" : rhs_str * " - $(-c2)"
        end
        
        question_text = "Find all solutions to \$$(lhs_str) = $(rhs_str)\$ in the interval \$[0, 2\\pi]\$. Express your answer as a set of exact values in terms of \$\\pi\$ where possible."
        
        answer_text = "\\{x \\in [0, 2\\pi] : $(lhs_str) = $(rhs_str)\\}"
        
        solution_text = steps(
            "Given equation: \$$(lhs_str) = $(rhs_str)\$",
            "Rearrange: \$$(a1)\\sin($(b1)x) - $(a2)\\cos($(b2)x) = $(c2 - c1)\$",
            "Use graphical/numerical methods or identity transformations to find intersection points in \$[0, 2\\pi]\$",
            "Check periodicity: period of LHS is \$\\frac{2\\pi}{|$(b1)|}\$, period of RHS is \$\\frac{2\\pi}{|$(b2)|}\$",
            "Verify all solutions by substitution and check boundary behavior",
            "The solution set contains all \$x\$ values where the graphs intersect in the given domain"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(3500, 4200),
            answer_type="expression",
            solution=solution_text,
            time=300,
            calculator="graphing"
        )
        
    elseif problem_type == 2
        # Type 2: Determine number of solutions to trig equation with parameters
        k = nonzero(-8, 8)
        m = randint(2, 5)
        n = randint(2, 5)
        
        # Equation: sin(mx) = k*cos(nx) on [0, 2π]
        # Research-adjacent: requires understanding of:
        # - Multiple period interactions
        # - Parameter dependence
        # - Asymptotic behavior for large k
        
        question_text = "Determine the number of distinct solutions to the equation \$\\sin($(m)x) = $(k)\\cos($(n)x)\$ in the interval \$[0, 2\\pi]\$. Justify your answer by analyzing the behavior of both functions."
        
        # This is intentionally hard - answer depends on k, m, n
        answer_text = "Depends on graphical analysis"
        
        solution_text = steps(
            "Given: \$\\sin($(m)x) = $(k)\\cos($(n)x)\$ on \$[0, 2\\pi]\$",
            "Period of \$\\sin($(m)x)\$: \$\\frac{2\\pi}{$(m)}\$, completes $(m) full cycles in \$[0, 2\\pi]\$",
            "Period of \$\\cos($(n)x)\$: \$\\frac{2\\pi}{$(n)}\$, completes $(n) full cycles in \$[0, 2\\pi]\$",
            "The LHS oscillates between -1 and 1, while RHS oscillates between $(k)*(-1) = $(-k) and $(k)",
            "When |$(k)| > 1, the ranges don't fully overlap, limiting intersection points",
            "Graph both functions and count intersections, considering that each period contributes potential solutions",
            "The total number of solutions depends on the phase relationship and amplitude scaling"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(3800, 4500),
            answer_type="expression",
            solution=solution_text,
            time=360,
            calculator="graphing"
        )
        
    elseif problem_type == 3
        # Type 3: Inverse trig composition with domain restrictions
        a = nonzero(-6, 6)
        b = nonzero(-5, 5)
        c = randint(-8, 8)
        
        # Find domain where arcsin(a*sin(bx) + c) is defined
        # Olympiad-level: requires understanding:
        # - Range of sin function
        # - Domain restrictions of arcsin
        # - Set theory for valid x values
        
        inner_expr = a == 1 ? "\\sin($(b)x)" : "$(a)\\sin($(b)x)"
        if c != 0
            full_expr = c > 0 ? inner_expr * " + $(c)" : inner_expr * " - $(-c)"
        else
            full_expr = inner_expr
        end
        
        question_text = "Find all values of \$x \\in [0, 2\\pi]\$ for which \$\\arcsin($(full_expr))\$ is defined. Express your answer as a union of intervals."
        
        # Need -1 <= a*sin(bx) + c <= 1
        # -1 - c <= a*sin(bx) <= 1 - c
        
        lower_bound = (-1 - c) / a
        upper_bound = (1 - c) / a
        
        if a < 0
            lower_bound, upper_bound = upper_bound, lower_bound
        end
        
        answer_text = "Union of intervals where \$-1 \\leq $(full_expr) \\leq 1\$"
        
        solution_text = steps(
            "For \$\\arcsin($(full_expr))\$ to be defined, we need \$-1 \\leq $(full_expr) \\leq 1\$",
            "This gives: \$-1 \\leq $(a)\\sin($(b)x) + $(c) \\leq 1\$",
            "Subtract $(c): \$$(−1 - c) \\leq $(a)\\sin($(b)x) \\leq $(1 - c)\$",
            "Divide by $(a) (reversing inequality if negative): \$$(lower_bound) \\leq \\sin($(b)x) \\leq $(upper_bound)\$",
            "Find all \$x \\in [0, 2\\pi]\$ satisfying this constraint",
            "Since \$\\sin\$ ranges in \$[-1, 1]\$, intersect with this range and solve for valid \$x\$ intervals",
            "Express as union of intervals based on when the inequality holds"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(3600, 4300),
            answer_type="expression",
            solution=solution_text,
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Type 4: Optimization involving trig functions
        a = randint(2, 6)
        b = randint(2, 5)
        c = randint(1, 4)
        
        # Maximize/minimize a*sin(x) + b*cos(cx) on [0, 2π]
        # Research-adjacent: requires calculus of trig functions, critical point analysis
        
        expr_str = "$(a)\\sin(x) + $(b)\\cos($(c)x)"
        
        question_text = "Find the maximum value of \$f(x) = $(expr_str)\$ on the interval \$[0, 2\\pi]\$. Justify your answer using calculus or rigorous analysis."
        
        answer_text = "Maximum value (requires calculus analysis)"
        
        solution_text = steps(
            "Given: \$f(x) = $(expr_str)\$ on \$[0, 2\\pi]\$",
            "Find critical points: \$f'(x) = $(a)\\cos(x) - $(b*c)\\sin($(c)x) = 0\$",
            "Solve: \$$(a)\\cos(x) = $(b*c)\\sin($(c)x)\$",
            "Check endpoints \$x = 0\$ and \$x = 2\\pi\$, plus all critical points in the interval",
            "Evaluate \$f(x)\$ at each critical point and endpoint",
            "The maximum occurs at the point with the largest function value",
            "This problem requires numerical methods or graphical insight due to the mixed frequencies"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(4000, 4700),
            answer_type="expression",
            solution=solution_text,
            time=360,
            calculator="graphing"
        )
        
    else
        # Type 5: Functional equation with trig
        k = nonzero(-5, 5)
        n = randint(2, 4)
        
        # Find all functions g such that g(sin(x)) = k*sin(nx) for all x
        # Research-adjacent: functional equations are very hard
        
        question_text = "Find all continuous functions \$g: [-1, 1] \\to \\mathbb{R}\$ such that \$g(\\sin(x)) = $(k)\\sin($(n)x)\$ for all \$x \\in \\mathbb{R}\$. Prove that your answer is unique or characterize all solutions."
        
        answer_text = "Requires functional equation analysis and Chebyshev polynomial theory"
        
        solution_text = steps(
            "Given functional equation: \$g(\\sin(x)) = $(k)\\sin($(n)x)\$ for all \$x\$",
            "Let \$u = \\sin(x)\$, so \$x = \\arcsin(u)\$ for \$u \\in [-1, 1]\$ (principal branch)",
            "Then \$g(u) = $(k)\\sin($(n)\\arcsin(u))\$",
            "Use the identity: \$\\sin(n\\theta)\$ can be expressed as a polynomial in \$\\sin(\\theta)\$ (Chebyshev relation)",
            "For example, \$\\sin(2\\theta) = 2\\sin(\\theta)\\cos(\\theta) = 2\\sin(\\theta)\\sqrt{1-\\sin^2(\\theta)}\$",
            "Express \$\\sin($(n)\\arcsin(u))\$ as a polynomial/algebraic function of \$u\$",
            "Verify continuity and that this is the unique solution satisfying the functional equation"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(4200, 5000),
            answer_type="expression",
            solution=solution_text,
            time=420,
            calculator="none"
        )
    end
end