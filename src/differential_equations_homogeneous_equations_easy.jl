# differential_equations - homogeneous_equations (easy)
# Generated: 2026-03-08T20:52:19.176828

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/homogeneous_equations")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Verify if a DE is homogeneous (ELO 700-900)
        m = nonzero(-5, 5)
        n = nonzero(-5, 5)
        
        is_homog = choice([true, false])
        
        if is_homog
            # Create homogeneous equation: dy/dx = f(y/x)
            # Example: dy/dx = (x + y) / x = 1 + y/x
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            numerator = expand(a*x + b*y)
            denominator = x
            
            question_text = "Is the differential equation \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$ homogeneous?"
            ans = "Yes"
            
            solution_text = steps(
                "A differential equation \$\\frac{dy}{dx} = f(x, y)\$ is homogeneous if \$f(tx, ty) = f(x, y)\$ for all \$t\$",
                "Rewrite: \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))} = $(a) + $(b)\\frac{y}{x}\$",
                "This can be written as a function of \$\\frac{y}{x}\$ only, so it is homogeneous",
                sol("Answer", "Yes")
            )
        else
            # Non-homogeneous: add a constant
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            c = nonzero(-6, 6)
            numerator = expand(a*x + b*y + c)
            denominator = x
            
            question_text = "Is the differential equation \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$ homogeneous?"
            ans = "No"
            
            solution_text = steps(
                "A differential equation \$\\frac{dy}{dx} = f(x, y)\$ is homogeneous if \$f(tx, ty) = f(x, y)\$ for all \$t\$",
                "The equation has the form \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$",
                "This includes the constant term \$$(c)\$, which cannot be written as a function of \$\\frac{y}{x}\$ only",
                sol("Answer", "No")
            )
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(700, 900),
            answer_type="text",
            solution=solution_text,
            time=90
        )
        
    elseif problem_type == 2
        # Make substitution v = y/x (ELO 800-1000)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        question_text = "For the homogeneous differential equation \$\\frac{dy}{dx} = $(a) + $(b)\\frac{y}{x}\$, use the substitution \$v = \\frac{y}{x}\$ to rewrite it in the form \$\\frac{dv}{dx} = g(v, x)\$. What is \$g(v, x)\$?"
        
        # y = vx, so dy/dx = v + x(dv/dx)
        # v + x(dv/dx) = a + b*v
        # x(dv/dx) = a + b*v - v = a + (b-1)v
        # dv/dx = (a + (b-1)v)/x
        
        ans_expr = (a + (b-1)*y) / x  # using y as v for symbolic
        
        solution_text = steps(
            sol("Given", "\\frac{dy}{dx} = $(a) + $(b)\\frac{y}{x}"),
            "Substitute \$v = \\frac{y}{x}\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Therefore: \$v + x\\frac{dv}{dx} = $(a) + $(b)v\$",
            "Solve for \$\\frac{dv}{dx}\$: \$x\\frac{dv}{dx} = $(a) + $(b-1)v\$",
            sol("Answer", "\\frac{dv}{dx} = \\frac{$(a) + $(b-1)v}{x}")
        )
        
        problem(
            question=question_text,
            answer=ans_expr,
            difficulty=(800, 1000),
            solution=solution_text,
            time=120
        )
        
    elseif problem_type == 3
        # Identify the correct substitution (ELO 700-900)
        question_text = "For a homogeneous differential equation of the form \$\\frac{dy}{dx} = f\\left(\\frac{y}{x}\\right)\$, what substitution should be used?"
        
        ans = "v = y/x"
        
        solution_text = steps(
            "For homogeneous differential equations, the standard substitution is \$v = \\frac{y}{x}\$",
            "This transforms the equation into a separable differential equation in \$v\$ and \$x\$",
            "Using \$y = vx\$, we get \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            sol("Answer", "v = \\frac{y}{x}")
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(700, 850),
            answer_type="text",
            solution=solution_text,
            time=60
        )
        
    else
        # Recognize homogeneous form (ELO 750-950)
        form_choice = choice(1:3)
        
        if form_choice == 1
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            expr = (a*x + b*y) / x
            is_homog = true
        elseif form_choice == 2
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            expr = (a*y) / (b*x)
            is_homog = true
        else
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            c = nonzero(-5, 5)
            expr = (a*x + b*y + c) / (x + y)
            is_homog = false
        end
        
        question_text = "Can the function \$f(x, y) = $(tex(expr))\$ be written as a function of \$\\frac{y}{x}\$ only?"
        ans = is_homog ? "Yes" : "No"
        
        if is_homog
            solution_text = steps(
                sol("Given", expr),
                "Divide numerator and denominator by \$x\$ (or factor out \$x\$)",
                "This can be rewritten as a function of the ratio \$\\frac{y}{x}\$",
                sol("Answer", "Yes")
            )
        else
            solution_text = steps(
                sol("Given", expr),
                "Attempt to write as a function of \$\\frac{y}{x}\$",
                "The presence of non-proportional terms prevents this simplification",
                sol("Answer", "No")
            )
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(750, 950),
            answer_type="text",
            solution=solution_text,
            time=90
        )
    end
end