# differential_equations - separable_equations (easy)
# Generated: 2026-03-08T20:49:45.783112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Simple dy/dx = f(x), integrate directly
        # ELO 700-900
        a = nonzero(-8, 8)
        b = randint(-12, 12)
        n = choice([1, 2, 3])
        
        if n == 1
            # dy/dx = ax + b
            rhs = a*x + b
            integral = a*x^2//2 + b*x
            C_sym = "C"
        elseif n == 2
            # dy/dx = ax^2 + b
            rhs = a*x^2 + b
            integral = a*x^3//3 + b*x
            C_sym = "C"
        else
            # dy/dx = ax^3
            a_coeff = nonzero(-6, 6)
            rhs = a_coeff*x^3
            integral = a_coeff*x^4//4
            C_sym = "C"
        end
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} = $(tex(rhs))\$",
            answer="y = $(tex(integral)) + C",
            difficulty=(700, 900),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(tex(rhs))"),
                "Separate variables: \$dy = ($(tex(rhs)))\\,dx\$",
                "Integrate both sides: \$\\int dy = \\int ($(tex(rhs)))\\,dx\$",
                sol("General solution", "y = $(tex(integral)) + C")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # dy/dx = g(y), separate and integrate
        # ELO 800-1000
        a = nonzero(-6, 6)
        n = choice([1, 2])
        
        if n == 1
            # dy/dx = ay
            rhs_y = a*y
            ans_form = "y = Ce^{$(tex(a*x))}"
        else
            # dy/dx = ay^2
            rhs_y = a*y^2
            if a > 0
                ans_form = "y = -\\frac{1}{$(tex(a*x)) + C}"
            else
                ans_form = "y = -\\frac{1}{$(tex(a*x)) + C}"
            end
        end
        
        problem(
            question="Solve the separable differential equation: \$\\frac{dy}{dx} = $(tex(rhs_y))\$",
            answer=ans_form,
            difficulty=(800, 1000),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(tex(rhs_y))"),
                "Separate variables: \$\\frac{1}{$(tex(rhs_y))}\\,dy = dx\$",
                "Integrate both sides",
                sol("General solution", ans_form)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # dy/dx = f(x)g(y), standard separable
        # ELO 900-1100
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-4, 4)
        
        form = choice(1:3)
        
        if form == 1
            # dy/dx = (ax + b)y
            f_x = a*x + b
            g_y = y
            integral_x = a*x^2//2 + b*x
            ans_form = "y = Ce^{$(tex(integral_x))}"
            
        elseif form == 2
            # dy/dx = x/y
            f_x = x
            g_y = 1//y
            ans_form = "y^2 = x^2 + C"
            
        else
            # dy/dx = xy
            f_x = x
            g_y = y
            ans_form = "y = Ce^{x^2/2}"
        end
        
        problem(
            question="Solve the separable differential equation: \$\\frac{dy}{dx} = $(tex(f_x * g_y))\$",
            answer=ans_form,
            difficulty=(900, 1100),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(tex(f_x * g_y))"),
                "Separate variables: \$\\frac{1}{$(tex(g_y))}\\,dy = ($(tex(f_x)))\\,dx\$",
                "Integrate both sides: \$\\int \\frac{1}{$(tex(g_y))}\\,dy = \\int ($(tex(f_x)))\\,dx\$",
                "Solve for y",
                sol("General solution", ans_form)
            ),
            time=150
        )
        
    else
        # Initial value problem
        # ELO 1000-1200
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        x0 = choice([0, 1, -1])
        y0 = randint(-8, 8)
        
        # dy/dx = ax + b, y(x0) = y0
        rhs = a*x + b
        integral = a*x^2//2 + b*x
        C_val = y0 - substitute(integral, x => x0)
        
        particular = simplify(integral + C_val)
        
        problem(
            question="Solve the initial value problem: \$\\frac{dy}{dx} = $(tex(rhs))\$, \$y($(x0)) = $(y0)\$",
            answer="y = $(tex(particular))",
            difficulty=(1000, 1200),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(tex(rhs)), y($(x0)) = $(y0)"),
                "Separate and integrate: \$y = $(tex(integral)) + C\$",
                "Apply initial condition: \$$(y0) = $(tex(substitute(integral, x => x0))) + C\$",
                "Solve for C: \$C = $(tex(C_val))\$",
                sol("Particular solution", "y = $(tex(particular))")
            ),
            time=180
        )
    end
end