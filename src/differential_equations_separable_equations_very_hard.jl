# differential_equations - separable_equations (very_hard)
# Generated: 2026-03-08T20:50:10.947208

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Separable DE with polynomial and exponential
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        k = nonzero(-6, 6)
        m = randint(2, 5)
        
        # dy/dx = a*x^m * e^(k*y)
        # Solution: e^(-k*y) = -a*x^(m+1)/(k*(m+1)) + C
        
        question_str = "Solve the differential equation \\frac{dy}{dx} = $(tex(a*x^m)) e^{$(k)y}"
        
        if k > 0
            solution_form = "e^{-$(k)y} = -\\frac{$(a)x^{$(m+1)}}{$(k*(m+1))} + C"
        else
            solution_form = "e^{$(abs(k))y} = \\frac{$(a)x^{$(m+1)}}{$(abs(k)*(m+1))} + C"
        end
        
        answer_str = solution_form
        
        sol_steps = steps(
            "Separate variables: \\frac{dy}{e^{$(k)y}} = $(tex(a*x^m)) dx",
            "Rewrite: e^{-$(k)y} dy = $(tex(a*x^m)) dx",
            "Integrate both sides",
            "Left side: \\int e^{-$(k)y} dy = -\\frac{1}{$(k)} e^{-$(k)y}",
            "Right side: \\int $(tex(a*x^m)) dx = \\frac{$(a)x^{$(m+1)}}{$(m+1)}",
            sol("General solution", solution_form)
        )
        
        diff_level = (2600, 3200)
        time_limit = 240
        
    elseif problem_type == 2
        # Homogeneous DE requiring substitution
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        
        # dy/dx = (ax + by)/(cx)
        # Requires v = y/x substitution
        
        question_str = "Solve the differential equation \\frac{dy}{dx} = \\frac{$(a)x + $(b)y}{$(c)x}"
        
        # After substitution v = y/x, dv/dx = (a - cv + bv)/(cx)
        # Separating: dv/(a + (b-c)v) = dx/x
        
        if b != c
            solution_form = "\\ln|$(a) + $(b-c)v| = $(c)\\ln|x| + C \\text{ where } v = \\frac{y}{x}"
        else
            solution_form = "v = \\frac{$(a)}{$(c)}\\ln|x| + C \\text{ where } v = \\frac{y}{x}"
        end
        
        answer_str = solution_form
        
        sol_steps = steps(
            "This is a homogeneous equation. Use substitution v = \\frac{y}{x}, so y = vx",
            "Then \\frac{dy}{dx} = v + x\\frac{dv}{dx}",
            "Substitute: v + x\\frac{dv}{dx} = \\frac{$(a)x + $(b)vx}{$(c)x} = \\frac{$(a) + $(b)v}{$(c)}",
            "Rearrange: x\\frac{dv}{dx} = \\frac{$(a) + $(b)v}{$(c)} - v = \\frac{$(a) + $(b-c)v}{$(c)}",
            "Separate: \\frac{$(c) dv}{$(a) + $(b-c)v} = \\frac{dx}{x}",
            "Integrate both sides to get general solution",
            sol("General solution", solution_form)
        )
        
        diff_level = (2800, 3400)
        time_limit = 300
        
    elseif problem_type == 3
        # Separable with trigonometric functions
        a = nonzero(-6, 6)
        k = randint(2, 4)
        
        # dy/dx = a*sin(kx)*cos(y)
        # Solution: sin(y) = -a*cos(kx)/k + C
        
        question_str = "Solve the differential equation \\frac{dy}{dx} = $(a)\\sin($(k)x)\\cos(y)"
        
        solution_form = "\\sin(y) = -\\frac{$(a)\\cos($(k)x)}{$(k)} + C"
        answer_str = solution_form
        
        sol_steps = steps(
            "Separate variables: \\frac{dy}{\\cos(y)} = $(a)\\sin($(k)x) dx",
            "Rewrite: \\sec(y) dy = $(a)\\sin($(k)x) dx",
            "Integrate both sides",
            "Left side: \\int \\sec(y) dy = \\ln|\\sec(y) + \\tan(y)|",
            "Or use \\int \\frac{dy}{\\cos(y)} via substitution u = \\sin(y): \\sin(y)",
            "Right side: \\int $(a)\\sin($(k)x) dx = -\\frac{$(a)\\cos($(k)x)}{$(k)}",
            sol("General solution", solution_form)
        )
        
        diff_level = (2700, 3300)
        time_limit = 270
        
    else
        # Bernoulli equation (nonlinear but reducible)
        p = nonzero(-4, 4)
        q = nonzero(-5, 5)
        n = choice([2, 3, -1, -2])
        
        # dy/dx + p*y = q*y^n
        # Bernoulli equation
        
        question_str = "Solve the Bernoulli equation \\frac{dy}{dx} + $(p)y = $(q)y^{$(n)}"
        
        if n != 1
            m = 1 - n
            solution_form = "\\text{Use substitution } v = y^{$(m)} \\text{ to linearize}"
        else
            solution_form = "\\text{Linear first-order DE}"
        end
        
        answer_str = solution_form
        
        sol_steps = steps(
            "This is a Bernoulli equation with n = $(n)",
            "Divide by y^{$(n)}: y^{-$(n)}\\frac{dy}{dx} + $(p)y^{$(1-n)} = $(q)",
            "Substitute v = y^{$(1-n)}, so \\frac{dv}{dx} = $(1-n)y^{-$(n)}\\frac{dy}{dx}",
            "The equation becomes: \\frac{1}{$(1-n)}\\frac{dv}{dx} + $(p)v = $(q)",
            "Simplify: \\frac{dv}{dx} + $(p*(1-n))v = $(q*(1-n))",
            "This is a linear first-order DE. Solve using integrating factor",
            sol("Solution approach", solution_form)
        )
        
        diff_level = (3000, 3600)
        time_limit = 300
    end
    
    problem(
        question=question_str,
        answer=answer_str,
        difficulty=diff_level,
        solution=sol_steps,
        time=time_limit,
        answer_type="expression"
    )
end