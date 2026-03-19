# differential_equations - homogeneous_equations (medium)
# Generated: 2026-03-08T20:52:17.570624

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/homogeneous_equations")
    
    prob_type = choice(1:4)
    
    if prob_type == 1
        # First-order homogeneous: dy/dx = f(y/x)
        # Use substitution v = y/x
        k = nonzero(-8, 8)
        m = nonzero(-8, 8)
        
        # dy/dx = (y + kx) / (mx)
        # This is homogeneous of degree 0
        
        question_text = "Verify that the differential equation \$\\frac{dy}{dx} = \\frac{y + $(k)x}{$(m)x}\$ is homogeneous."
        
        if m == 1
            simplified = "\\frac{y}{x} + $(k)"
        else
            simplified = "\\frac{y}{$(m)x} + \\frac{$(k)}{$(m)}"
        end
        
        answer = "homogeneous"
        
        solution = steps(
            "A differential equation \\(\\frac{dy}{dx} = f(x, y)\\) is homogeneous if \\(f(tx, ty) = f(x, y)\\) for all \\(t\\).",
            "Rewrite: \\(\\frac{dy}{dx} = \\frac{y + $(k)x}{$(m)x}\\)",
            "Factor: \\(\\frac{dy}{dx} = \\frac{1}{$(m)} \\cdot \\frac{y}{x} + \\frac{$(k)}{$(m)}\\)",
            "This can be written as a function of \\(y/x\\) only, so the equation is homogeneous.",
            sol("Answer", "homogeneous")
        )
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(1200, 1400),
            solution=solution,
            time=90
        )
        
    elseif prob_type == 2
        # Solve a simple homogeneous equation: dy/dx = y/x
        k = nonzero(-6, 6)
        
        question_text = "Solve the homogeneous differential equation \$\\frac{dy}{dx} = \\frac{$(k)y}{x}\$."
        
        # Solution: y = Cx^k
        answer_text = "y = Cx^{$(k)}"
        
        solution = steps(
            sol("Given", "\\frac{dy}{dx} = \\frac{$(k)y}{x}"),
            "Separate variables: \\(\\frac{dy}{y} = \\frac{$(k)dx}{x}\\)",
            "Integrate both sides: \\(\\ln|y| = $(k)\\ln|x| + C_1\\)",
            "Exponentiate: \\(y = e^{$(k)\\ln|x| + C_1} = e^{C_1} \\cdot x^{$(k)}\\)",
            sol("Answer", "y = Cx^{$(k)}, \\text{ where } C = e^{C_1}")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1300, 1500),
            solution=solution,
            time=120
        )
        
    elseif prob_type == 3
        # More complex: dy/dx = (x + y) / (x - y)
        # This requires substitution v = y/x
        
        question_text = "Solve the homogeneous differential equation \$\\frac{dy}{dx} = \\frac{x + y}{x - y}\$."
        
        answer_text = "x^2 - 2xy - y^2 = C"
        
        solution = steps(
            sol("Given", "\\frac{dy}{dx} = \\frac{x + y}{x - y}"),
            "Divide numerator and denominator by \\(x\\): \\(\\frac{dy}{dx} = \\frac{1 + y/x}{1 - y/x}\\)",
            "Substitute \\(v = y/x\\), so \\(y = vx\\) and \\(\\frac{dy}{dx} = v + x\\frac{dv}{dx}\\)",
            "Then: \\(v + x\\frac{dv}{dx} = \\frac{1 + v}{1 - v}\\)",
            "Rearrange: \\(x\\frac{dv}{dx} = \\frac{1 + v}{1 - v} - v = \\frac{1 + v - v(1 - v)}{1 - v} = \\frac{1 + v^2}{1 - v}\\)",
            "Separate: \\(\\frac{1 - v}{1 + v^2}dv = \\frac{dx}{x}\\)",
            "Integrate and substitute back \\(v = y/x\\)",
            sol("Answer", "x^2 - 2xy - y^2 = C")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1600, 1800),
            solution=solution,
            time=180
        )
        
    else
        # Identify if equation is homogeneous: dy/dx = (ax + by) / (cx + dy)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        question_text = "Determine if the differential equation \$\\frac{dy}{dx} = \\frac{$(a)x + $(b)y}{$(c)x + $(d)y}\$ is homogeneous."
        
        answer = "yes"
        
        solution = steps(
            sol("Given", "\\frac{dy}{dx} = \\frac{$(a)x + $(b)y}{$(c)x + $(d)y}"),
            "Check homogeneity: Replace \\(x\\) with \\(tx\\) and \\(y\\) with \\(ty\\)",
            "\\(f(tx, ty) = \\frac{$(a)(tx) + $(b)(ty)}{$(c)(tx) + $(d)(ty)} = \\frac{t($(a)x + $(b)y)}{t($(c)x + $(d)y)} = \\frac{$(a)x + $(b)y}{$(c)x + $(d)y} = f(x, y)\\)",
            "Since \\(f(tx, ty) = f(x, y)\\), the equation is homogeneous of degree 0.",
            sol("Answer", "Yes, the equation is homogeneous")
        )
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(1200, 1400),
            solution=solution,
            time=90
        )
    end
end