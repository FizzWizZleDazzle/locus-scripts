# differential_equations - homogeneous_equations (very_easy)
# Generated: 2026-03-08T20:51:53.053050

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/homogeneous_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify if equation is homogeneous (recognition)
        # ELO 200-400
        is_homogeneous = rand(Bool)
        
        if is_homogeneous
            # Create a homogeneous equation: M(x,y)dx + N(x,y)dy = 0
            # where M and N are homogeneous of same degree
            degree = rand(1:2)
            if degree == 1
                a, b = nonzero(-5, 5), nonzero(-5, 5)
                M_str = "$(a)x + $(b)y"
                c, d = nonzero(-5, 5), nonzero(-5, 5)
                N_str = "$(c)x + $(d)y"
            else
                a, b, c = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
                M_str = "$(a)x^2 + $(b)xy + $(c)y^2"
                d, e, f = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
                N_str = "$(d)x^2 + $(e)xy + $(f)y^2"
            end
            ans = "Yes"
            explanation = "Both M and N are homogeneous functions of degree $(degree)."
        else
            # Create non-homogeneous equation
            a, b, c = nonzero(-5, 5), nonzero(-5, 5), nonzero(-8, 8)
            M_str = "$(a)x + $(b)y + $(c)"
            d, e = nonzero(-5, 5), nonzero(-5, 5)
            N_str = "$(d)x + $(e)y"
            ans = "No"
            explanation = "M contains a constant term, so it is not homogeneous."
        end
        
        problem(
            question="Is the differential equation \$($(M_str))dx + ($(N_str))dy = 0\$ homogeneous? Answer Yes or No.",
            answer=ans,
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "A differential equation M dx + N dy = 0 is homogeneous if M and N are both homogeneous functions of the same degree.",
                "Check if M = $(M_str) and N = $(N_str) are homogeneous of the same degree.",
                explanation,
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Type 2: Determine the degree of homogeneity
        # ELO 300-500
        degree = rand(1:3)
        
        if degree == 1
            a, b = nonzero(-6, 6), nonzero(-6, 6)
            func_str = "$(a)x + $(b)y"
        elseif degree == 2
            a, b, c = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
            func_str = "$(a)x^2 + $(b)xy + $(c)y^2"
        else
            a, b = nonzero(-3, 3), nonzero(-3, 3)
            func_str = "$(a)x^3 + $(b)y^3"
        end
        
        problem(
            question="What is the degree of homogeneity of the function \$f(x, y) = $(func_str)\$?",
            answer=degree,
            difficulty=(300, 500),
            solution=steps(
                sol("Given function", func_str),
                "A function f(x,y) is homogeneous of degree n if f(tx, ty) = t^n f(x, y).",
                "Each term has total degree $(degree) (sum of exponents).",
                sol("Degree of homogeneity", degree)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Type 3: Verify homogeneity using substitution
        # ELO 400-600
        a, b = nonzero(-5, 5), nonzero(-5, 5)
        M_str = "$(a)x + $(b)y"
        c, d = nonzero(-5, 5), nonzero(-5, 5)
        N_str = "$(c)x + $(d)y"
        
        problem(
            question="Verify that M(x,y) = $(M_str) and N(x,y) = $(N_str) are homogeneous of degree 1 by computing M(tx, ty) and N(tx, ty).",
            answer="Yes",
            difficulty=(400, 600),
            answer_type="text",
            solution=steps(
                "Substitute tx for x and ty for y in M:",
                sol("M(tx, ty)", "$(a)(tx) + $(b)(ty) = t($(a)x + $(b)y) = t \\cdot M(x,y)"),
                "Substitute tx for x and ty for y in N:",
                sol("N(tx, ty)", "$(c)(tx) + $(d)(ty) = t($(c)x + $(d)y) = t \\cdot N(x,y)"),
                "Both M and N satisfy f(tx, ty) = t^1 f(x, y), so they are homogeneous of degree 1."
            ),
            time=90
        )
        
    else
        # Type 4: Identify the substitution for solving
        # ELO 500-700
        a, b = nonzero(-5, 5), nonzero(-5, 5)
        M_str = "$(a)x + $(b)y"
        c, d = nonzero(-5, 5), nonzero(-5, 5)
        N_str = "$(c)x + $(d)y"
        
        ans = "y = vx"
        
        problem(
            question="To solve the homogeneous differential equation \$($(M_str))dx + ($(N_str))dy = 0\$, what substitution should be used? Answer in the form 'y = vx' or 'x = vy'.",
            answer=ans,
            difficulty=(500, 700),
            answer_type="text",
            solution=steps(
                "For homogeneous differential equations M(x,y)dx + N(x,y)dy = 0, we use a substitution to reduce the equation to separable form.",
                "The standard substitution is y = vx, where v is a new variable.",
                "This gives dy = v dx + x dv.",
                sol("Substitution", ans)
            ),
            time=60
        )
    end
end