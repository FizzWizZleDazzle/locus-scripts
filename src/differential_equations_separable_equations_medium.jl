# differential_equations - separable_equations (medium)
# Generated: 2026-03-08T20:49:51.747174

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # dy/dx = k*y type (exponential growth/decay)
        k = nonzero(-8, 8)
        y0 = nonzero(-15, 15)
        x0 = rand([0, 1])
        
        # Solution: y = y0 * e^(k*(x-x0))
        C = y0 / exp(k * x0)
        
        if x0 == 0
            question = "Solve the initial value problem: \\frac{dy}{dx} = $(k)y with y(0) = $(y0)"
            solution_steps = steps(
                sol("Given", "\\frac{dy}{dx} = $(k)y, \\quad y(0) = $(y0)"),
                "Separate variables: \\frac{dy}{y} = $(k)dx",
                "Integrate both sides: \\ln|y| = $(k)x + C",
                "Exponentiate: y = Ae^{$(k)x}",
                "Apply initial condition y(0) = $(y0): $(y0) = Ae^{0} \\implies A = $(y0)",
                sol("Answer", "y = $(y0)e^{$(k)x}")
            )
            answer = "$(y0)*exp($(k)*x)"
        else
            question = "Solve the initial value problem: \\frac{dy}{dx} = $(k)y with y(1) = $(y0)"
            solution_steps = steps(
                sol("Given", "\\frac{dy}{dx} = $(k)y, \\quad y(1) = $(y0)"),
                "Separate variables: \\frac{dy}{y} = $(k)dx",
                "Integrate both sides: \\ln|y| = $(k)x + C",
                "Exponentiate: y = Ae^{$(k)x}",
                "Apply initial condition y(1) = $(y0): $(y0) = Ae^{$(k)} \\implies A = $(y0)e^{-$(k)}",
                sol("Answer", "y = $(y0)e^{$(k)(x-1)}")
            )
            answer = "$(y0)*exp($(k)*(x-1))"
        end
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1200, 1400),
            solution=solution_steps,
            time=180
        )
        
    elseif problem_type == 2
        # dy/dx = f(x)*g(y) type
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        n = rand(1:3)
        y0 = nonzero(-10, 10)
        x0 = rand([0, 1])
        
        # dy/dx = a*x^n / y^b
        question = "Solve the initial value problem: \\frac{dy}{dx} = \\frac{$(a)x^{$(n)}}{y^{$(b)}} with y($(x0)) = $(y0)"
        
        if b == 1
            int_left = "\\frac{y^2}{2}"
        else
            int_left = "\\frac{y^{$(b+1)}}{$(b+1)}"
        end
        
        if n == 1
            int_right = "\\frac{$(a)x^2}{2}"
        else
            int_right = "\\frac{$(a)x^{$(n+1)}}{$(n+1)}"
        end
        
        solution_steps = steps(
            sol("Given", "\\frac{dy}{dx} = \\frac{$(a)x^{$(n)}}{y^{$(b)}}, \\quad y($(x0)) = $(y0)"),
            "Separate variables: y^{$(b)}dy = $(a)x^{$(n)}dx",
            "Integrate both sides: $(int_left) = $(int_right) + C",
            "Apply initial condition to find C",
            "Solve for y explicitly"
        )
        
        answer = "implicit"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1400, 1600),
            solution=solution_steps,
            time=240,
            grading_mode="expression"
        )
        
    elseif problem_type == 3
        # dy/dx = (ax + b)/(cy + d) type
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-5, 5)
        d = randint(-8, 8)
        y0 = nonzero(-10, 10)
        x0 = rand([0, 1])
        
        question = "Solve the initial value problem: \\frac{dy}{dx} = \\frac{$(a)x + $(b)}{$(c)y + $(d)} with y($(x0)) = $(y0)"
        
        solution_steps = steps(
            sol("Given", "\\frac{dy}{dx} = \\frac{$(a)x + $(b)}{$(c)y + $(d)}, \\quad y($(x0)) = $(y0)"),
            "Separate variables: ($(c)y + $(d))dy = ($(a)x + $(b))dx",
            "Integrate both sides: \\frac{$(c)y^2}{2} + $(d)y = \\frac{$(a)x^2}{2} + $(b)x + C",
            "Apply initial condition y($(x0)) = $(y0) to find C",
            "The solution is given implicitly by the integrated equation"
        )
        
        answer = "implicit"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1500, 1700),
            solution=solution_steps,
            time=240,
            grading_mode="expression"
        )
        
    else
        # dy/dx = k*x*y type
        k = nonzero(-5, 5)
        y0 = nonzero(-10, 10)
        
        question = "Solve the initial value problem: \\frac{dy}{dx} = $(k)xy with y(0) = $(y0)"
        
        solution_steps = steps(
            sol("Given", "\\frac{dy}{dx} = $(k)xy, \\quad y(0) = $(y0)"),
            "Separate variables: \\frac{dy}{y} = $(k)x\\,dx",
            "Integrate both sides: \\ln|y| = \\frac{$(k)x^2}{2} + C",
            "Exponentiate: y = Ae^{\\frac{$(k)x^2}{2}}",
            "Apply initial condition y(0) = $(y0): $(y0) = Ae^0 \\implies A = $(y0)",
            sol("Answer", "y = $(y0)e^{\\frac{$(k)x^2}{2}}")
        )
        
        answer = "$(y0)*exp($(k)*x^2/2)"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1300, 1500),
            solution=solution_steps,
            time=200
        )
    end
end