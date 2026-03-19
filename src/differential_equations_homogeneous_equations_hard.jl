# differential_equations - homogeneous_equations (hard)
# Generated: 2026-03-08T20:52:44.100892

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/homogeneous_equations")
    
    problem_type = choice([1, 2, 3, 4, 5])
    
    if problem_type == 1
        # Homogeneous ODE: dy/dx = f(y/x), solve by substitution v = y/x
        # Target: 1800-2100 ELO
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # Create a homogeneous rational equation
        numerator = expand(a*x + b*y)
        denominator = expand(c*x)
        
        question_text = "Solve the homogeneous differential equation: \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$"
        
        solution_text = steps(
            "This is a homogeneous differential equation of the form \$\\frac{dy}{dx} = f\\left(\\frac{y}{x}\\right)\$",
            "Substitute \$v = \\frac{y}{x}\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Rewrite: \$v + x\\frac{dv}{dx} = \\frac{$(a) + $(b)v}{$(c)}\$",
            "Separate variables: \$x\\frac{dv}{dx} = \\frac{$(a) + $(b)v}{$(c)} - v = \\frac{$(a) + $(b-c)v}{$(c)}\$",
            "Integrate both sides: \$\\int \\frac{$(c)\\,dv}{$(a) + $(b-c)v} = \\int \\frac{dx}{x}\$",
            "Solution involves \$\\ln|$(a) + $(b-c)v| = \\ln|x| + C\$",
            "Substitute back \$v = \\frac{y}{x}\$ to get implicit solution in terms of \$x\$ and \$y\$"
        )
        
        answer_text = "y = vx (implicit solution)"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1800, 2100),
            solution=solution_text,
            time=240,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Homogeneous ODE: x dy/dx = y + f(x,y) where f is homogeneous
        # Target: 1900-2200 ELO
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        
        # Create: x dy/dx = y + sqrt(x^2 + a*y^2)
        question_text = "Solve the differential equation: \$x\\frac{dy}{dx} = y + \\sqrt{x^2 + $(a)y^2}\$"
        
        solution_text = steps(
            "This is homogeneous since both sides have degree 1",
            "Substitute \$v = \\frac{y}{x}\$, giving \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Substitute: \$x(v + x\\frac{dv}{dx}) = vx + x\\sqrt{1 + $(a)v^2}\$",
            "Simplify: \$x^2\\frac{dv}{dx} = x\\sqrt{1 + $(a)v^2}\$",
            "Separate: \$\\frac{dv}{\\sqrt{1 + $(a)v^2}} = \\frac{dx}{x}\$",
            "Integrate both sides using substitution or inverse hyperbolic functions",
            "Back-substitute \$v = \\frac{y}{x}\$ to obtain the general solution"
        )
        
        answer_text = "implicit solution"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1900, 2200),
            solution=solution_text,
            time=300,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # Transform non-homogeneous to homogeneous via translation
        # Target: 2000-2300 ELO
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # dy/dx = (ax + by + c)/(dx + ey + f)
        e = nonzero(-5, 5)
        f = nonzero(-5, 5)
        
        question_text = "Solve: \$\\frac{dy}{dx} = \\frac{$(a)x + $(b)y + $(c)}{$(d)x + $(e)y + $(f)}\$"
        
        solution_text = steps(
            "This equation is not homogeneous due to constant terms $(c) and $(f)",
            "Find the critical point \$(h, k)\$ where \$$(a)h + $(b)k + $(c) = 0\$ and \$$(d)h + $(e)k + $(f) = 0\$",
            "Substitute \$X = x - h\$, \$Y = y - k\$ to transform to homogeneous form",
            "The transformed equation becomes \$\\frac{dY}{dX} = \\frac{$(a)X + $(b)Y}{$(d)X + $(e)Y}\$",
            "Apply substitution \$V = \\frac{Y}{X}\$ to separate variables",
            "Integrate and back-substitute to find solution in original variables"
        )
        
        answer_text = "implicit solution"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2000, 2300),
            solution=solution_text,
            time=360,
            answer_type="expression"
        )
        
    elseif problem_type == 4
        # Homogeneous with initial condition
        # Target: 1850-2150 ELO
        a = nonzero(-7, 7)
        y0 = nonzero(-10, 10)
        x0 = choice([1, 2])
        
        question_text = "Solve the initial value problem: \$\\frac{dy}{dx} = \\frac{x + y}{x}\$, \$y($(x0)) = $(y0)\$"
        
        solution_text = steps(
            "Rewrite as \$\\frac{dy}{dx} = 1 + \\frac{y}{x}\$, which is homogeneous",
            "Substitute \$v = \\frac{y}{x}\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Equation becomes: \$v + x\\frac{dv}{dx} = 1 + v\$",
            "Simplify: \$x\\frac{dv}{dx} = 1\$, giving \$dv = \\frac{dx}{x}\$",
            "Integrate: \$v = \\ln|x| + C\$",
            "Substitute back: \$\\frac{y}{x} = \\ln|x| + C\$, so \$y = x\\ln|x| + Cx\$",
            "Apply initial condition \$y($(x0)) = $(y0)\$: \$$(y0) = $(x0)\\ln($(x0)) + C($(x0))\$",
            sol("Solve for C and write final solution")
        )
        
        C_val = (y0 - x0 * log(abs(x0))) / x0
        answer_text = "y = x*ln(|x|) + C*x"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1850, 2150),
            solution=solution_text,
            time=270,
            answer_type="expression"
        )
        
    else
        # Complex homogeneous with trig/exponential
        # Target: 2100-2500 ELO
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        question_text = "Solve: \$x\\frac{dy}{dx} = y + x\\tan\\left(\\frac{y}{x}\\right)\$"
        
        solution_text = steps(
            "Recognize this as homogeneous: right side is of degree 1 in \$x\$ and \$y\$",
            "Let \$v = \\frac{y}{x}\$, then \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Substitute: \$x(v + x\\frac{dv}{dx}) = vx + x\\tan(v)\$",
            "Simplify: \$x^2\\frac{dv}{dx} = x\\tan(v)\$, so \$\\frac{dv}{\\tan(v)} = \\frac{dx}{x}\$",
            "Rewrite: \$\\cot(v)\\,dv = \\frac{dx}{x}\$",
            "Integrate both sides: \$\\int \\cot(v)\\,dv = \\int \\frac{dx}{x}\$",
            "Result: \$\\ln|\\sin(v)| = \\ln|x| + C\$",
            "Simplify: \$\\sin(v) = Kx\$ where \$K = \\pm e^C\$",
            "Back-substitute: \$\\sin\\left(\\frac{y}{x}\\right) = Kx\$ or \$\\frac{y}{x} = \\arcsin(Kx)\$",
            sol("Final solution", "y = x\\arcsin(Kx)")
        )
        
        answer_text = "y = x*arcsin(Kx)"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2100, 2500),
            solution=solution_text,
            time=360,
            answer_type="expression"
        )
    end
end