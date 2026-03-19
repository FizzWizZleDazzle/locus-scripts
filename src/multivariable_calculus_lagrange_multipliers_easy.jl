# multivariable_calculus - lagrange_multipliers (easy)
# Generated: 2026-03-08T21:00:23.684133

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/lagrange_multipliers")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Basic: Find critical points of f(x,y) subject to g(x,y) = c
        # ELO: 700-900 (just setup equations, possibly solve simple case)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        k = randint(1, 20)
        
        # f(x,y) = ax + by (linear objective)
        # Constraint: x^2 + y^2 = k
        
        f_expr = a*x + b*y
        g_expr = x^2 + y^2
        
        # Lagrange: ∇f = λ∇g
        # (a, b) = λ(2x, 2y)
        # So a = 2λx, b = 2λy
        # From constraint: x^2 + y^2 = k
        
        # Solution: x = ak/(2√(a²+b²)), y = bk/(2√(a²+b²))
        denom_sq = a^2 + b^2
        
        question_text = "Set up the Lagrange multiplier equations for maximizing \$f(x,y) = $(tex(f_expr))\$ subject to \$$(tex(g_expr)) = $(k)\$. What equation relates the gradient of \$f\$ to the gradient of the constraint?"
        
        answer_text = "\\nabla f = \\lambda \\nabla g"
        
        solution_text = steps(
            sol("Objective function", f_expr),
            sol("Constraint", g_expr ~ k),
            "Compute \\nabla f = ($(a), $(b))",
            "Compute \\nabla g = (2x, 2y)",
            sol("Lagrange condition", "\\nabla f = \\lambda \\nabla g")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(700, 850),
            answer_type="text",
            solution=solution_text,
            time=90
        )
        
    elseif problem_type == 2
        # Find λ given simple constraint
        # ELO: 800-1000
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        k = randint(5, 30)
        
        # f(x,y) = ax + by
        # g(x,y) = cx + dy = k
        
        # ∇f = (a,b), ∇g = (c,d)
        # a = λc, b = λd
        # λ = a/c = b/d (must be consistent)
        
        # Choose so λ is nice
        lambda_val = nonzero(-4, 4)
        a = lambda_val * nonzero(-3, 3)
        b = lambda_val * nonzero(-3, 3)
        c = a // lambda_val
        d = b // lambda_val
        
        f_expr = a*x + b*y
        g_expr = c*x + d*y
        
        question_text = "For \$f(x,y) = $(tex(f_expr))\$ subject to \$$(tex(g_expr)) = $(k)\$, find the Lagrange multiplier \$\\lambda\$ such that \$\\nabla f = \\lambda \\nabla g\$."
        
        solution_text = steps(
            "Compute \\nabla f = ($(a), $(b))",
            "Compute \\nabla g = ($(c), $(d))",
            "From \\nabla f = \\lambda \\nabla g: $(a) = \\lambda \\cdot $(c) and $(b) = \\lambda \\cdot $(d)",
            sol("\\lambda", lambda_val)
        )
        
        problem(
            question=question_text,
            answer=lambda_val,
            difficulty=(800, 1000),
            solution=solution_text,
            time=120
        )
        
    elseif problem_type == 3
        # Solve simple Lagrange system
        # ELO: 900-1150
        # Optimize x + y subject to x^2 + y^2 = r^2
        
        r_sq = randint(4, 25)
        
        # f(x,y) = x + y, g(x,y) = x^2 + y^2 = r_sq
        # ∇f = (1,1), ∇g = (2x, 2y)
        # 1 = 2λx, 1 = 2λy => x = y
        # x^2 + x^2 = r_sq => 2x^2 = r_sq => x = √(r_sq/2)
        
        f_expr = x + y
        g_expr = x^2 + y^2
        
        # Maximum at x = y = √(r_sq/2)
        max_val_sq = r_sq // 2
        
        question_text = "Find the maximum value of \$f(x,y) = $(tex(f_expr))\$ subject to \$$(tex(g_expr)) = $(r_sq)\$."
        
        # Maximum value is 2√(r_sq/2) = √(2r_sq)
        # Simplify based on r_sq
        if r_sq == 2
            ans = 2
        elseif r_sq % 2 == 0
            ans_simplified = "\\sqrt{$(2*r_sq)}"
        else
            ans_simplified = "\\sqrt{$(2*r_sq)}"
        end
        
        # For grading, use numerical answer
        max_value = sqrt(2 * r_sq)
        
        solution_text = steps(
            sol("Set up Lagrange", "\\nabla f = \\lambda \\nabla g"),
            "(1, 1) = \\lambda(2x, 2y)",
            "From symmetry: x = y",
            "Substitute into constraint: 2x^2 = $(r_sq)",
            "Maximum value: 2\\sqrt{$(max_val_sq)}"
        )
        
        problem(
            question=question_text,
            answer=round(max_value, digits=4),
            difficulty=(900, 1150),
            solution=solution_text,
            time=180
        )
        
    else
        # Find critical point coordinates
        # ELO: 950-1200
        # Minimize x^2 + y^2 subject to ax + by = c
        
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-12, 12)
        
        # f(x,y) = x^2 + y^2, g(x,y) = ax + by = c
        # ∇f = (2x, 2y), ∇g = (a, b)
        # 2x = λa, 2y = λb
        # x = λa/2, y = λb/2
        # a(λa/2) + b(λb/2) = c
        # λ(a^2 + b^2)/2 = c
        # λ = 2c/(a^2 + b^2)
        
        denom = a^2 + b^2
        x_ans = a * c // denom
        y_ans = b * c // denom
        
        f_expr = x^2 + y^2
        constraint = a*x + b*y
        
        question_text = "Find the point (x, y) that minimizes \$f(x,y) = $(tex(f_expr))\$ subject to \$$(tex(constraint)) = $(c)\$. Enter your answer as an ordered pair."
        
        answer_tuple = fmt_tuple([x_ans, y_ans])
        
        solution_text = steps(
            sol("Lagrange equations", "\\nabla f = \\lambda \\nabla g"),
            "(2x, 2y) = \\lambda($(a), $(b))",
            "From first equation: x = \\lambda \\cdot $(a)/2",
            "From second equation: y = \\lambda \\cdot $(b)/2",
            "Substitute into constraint and solve for \\lambda",
            sol("Critical point", answer_tuple)
        )
        
        problem(
            question=question_text,
            answer=answer_tuple,
            difficulty=(950, 1200),
            answer_type="tuple",
            solution=solution_text,
            time=180
        )
    end
end