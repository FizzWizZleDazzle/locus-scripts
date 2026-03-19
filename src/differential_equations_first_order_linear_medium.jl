# differential_equations - first_order_linear (medium)
# Generated: 2026-03-08T20:50:48.029446

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t y begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Standard form: dy/dx + P(x)y = Q(x), integrating factor method
        # Pick simple P(x) and Q(x)
        p_coeff = nonzero(-5, 5)
        q_const = nonzero(-12, 12)
        
        # dy/dx + p_coeff*y = q_const
        # Integrating factor: μ = e^(p_coeff*x)
        # Solution: y = (q_const/p_coeff) + C*e^(-p_coeff*x)
        
        mu_expr = "e^{$(p_coeff)x}"
        particular = q_const // p_coeff
        
        diff_eq = "\\frac{dy}{dx} + $(p_coeff)y = $(q_const)"
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$",
            "This is a first-order linear ODE in standard form",
            "Integrating factor: \$\\mu(x) = e^{\\int $(p_coeff) dx} = $(mu_expr)\$",
            "Multiply both sides by \$$(mu_expr)\$",
            "Left side becomes: \$\\frac{d}{dx}[y \\cdot $(mu_expr)]\$",
            "Integrate: \$y \\cdot $(mu_expr) = \\int $(q_const) $(mu_expr) dx = \\frac{$(q_const)}{$(p_coeff)} $(mu_expr) + C\$",
            sol("General solution", "y = $(particular) + Ce^{-$(p_coeff)x}")
        )
        
        problem(
            question="Solve the first-order linear differential equation: \$$(diff_eq)\$",
            answer="y = $(particular) + Ce^{-$(p_coeff)x}",
            difficulty=(1200, 1400),
            solution=solution_steps,
            time=180
        )
        
    elseif problem_type == 2
        # Initial value problem with simple coefficients
        p_coeff = nonzero(-4, 4)
        q_const = nonzero(-10, 10)
        x0 = rand([0, 1])
        y0 = randint(-8, 8)
        
        # dy/dx + p_coeff*y = q_const, y(x0) = y0
        particular = q_const // p_coeff
        # y = particular + C*e^(-p_coeff*x)
        # y(x0) = particular + C*e^(-p_coeff*x0) = y0
        # C = (y0 - particular)*e^(p_coeff*x0)
        
        if x0 == 0
            C_val = y0 - particular
            if C_val == 0
                answer_str = "y = $(particular)"
            else
                answer_str = "y = $(particular) + $(C_val)e^{-$(p_coeff)x}"
            end
            C_calc = "C = $(y0) - $(particular) = $(C_val)"
        else
            C_val = (y0 - particular) * exp(p_coeff * x0)
            answer_str = "y = $(particular) + $(C_val)e^{-$(p_coeff)x}"
            C_calc = "C = ($(y0) - $(particular))e^{$(p_coeff)} = $(C_val)e^{$(p_coeff)}"
        end
        
        diff_eq = "\\frac{dy}{dx} + $(p_coeff)y = $(q_const)"
        
        solution_steps = steps(
            "Given: \$$(diff_eq)\$, \$y($(x0)) = $(y0)\$",
            "General solution: \$y = $(particular) + Ce^{-$(p_coeff)x}\$",
            "Apply initial condition: $(C_calc)",
            sol("Particular solution", answer_str)
        )
        
        problem(
            question="Solve the initial value problem: \$$(diff_eq)\$, \$y($(x0)) = $(y0)\$",
            answer=answer_str,
            difficulty=(1400, 1600),
            solution=solution_steps,
            time=240
        )
        
    elseif problem_type == 3
        # dy/dx + P(x)y = 0 (homogeneous)
        # Solution: y = C*e^(-∫P(x)dx)
        
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        
        # dy/dx + (a/x)*y = 0 or dy/dx + a*y = 0
        use_rational = rand([true, false])
        
        if use_rational && abs(a) <= 3
            # dy/dx + (a/x)*y = 0
            # Solution: y = C*x^(-a) = C/x^a
            diff_eq = "\\frac{dy}{dx} + \\frac{$(a)}{x}y = 0"
            if a == 1
                answer_str = "y = \\frac{C}{x}"
            elseif a == -1
                answer_str = "y = Cx"
            elseif a > 0
                answer_str = "y = \\frac{C}{x^{$(a)}}"
            else
                answer_str = "y = Cx^{$(-a)}"
            end
            
            solution_steps = steps(
                "Given: \$$(diff_eq)\$",
                "This is a separable homogeneous linear ODE",
                "Integrating factor: \$\\mu(x) = e^{\\int \\frac{$(a)}{x} dx} = e^{$(a)\\ln|x|} = x^{$(a)}\$",
                "General solution by separation: \$\\frac{dy}{y} = -\\frac{$(a)}{x}dx\$",
                sol("Answer", answer_str)
            )
        else
            # dy/dx + a*y = 0
            # Solution: y = C*e^(-a*x)
            diff_eq = "\\frac{dy}{dx} + $(a)y = 0"
            answer_str = "y = Ce^{$(-a)x}"
            
            solution_steps = steps(
                "Given: \$$(diff_eq)\$",
                "This is a homogeneous first-order linear ODE",
                "Separate variables: \$\\frac{dy}{y} = -$(a)dx\$",
                "Integrate: \$\\ln|y| = $(-a)x + K\$",
                sol("General solution", answer_str)
            )
        end
        
        problem(
            question="Find the general solution: \$$(diff_eq)\$",
            answer=answer_str,
            difficulty=(1200, 1400),
            solution=solution_steps,
            time=150
        )
        
    else
        # Word problem: Newton's law of cooling or exponential growth/decay
        use_cooling = rand([true, false])
        
        if use_cooling
            T_env = choice([20, 25, 30, 72, 75])
            T_init = T_env + randint(40, 80)
            k = choice([0.1, 0.15, 0.2, 0.25])
            t_val = choice([5, 10, 15, 20])
            
            # dT/dt = -k(T - T_env)
            # T(t) = T_env + (T_init - T_env)*e^(-kt)
            T_t = T_env + (T_init - T_env) * exp(-k * t_val)
            T_t_rounded = round(T_t, digits=1)
            
            diff_eq = "\\frac{dT}{dt} = -$(k)(T - $(T_env))"
            
            solution_steps = steps(
                "Newton's Law of Cooling: \$$(diff_eq)\$",
                "This is linear: \$\\frac{dT}{dt} + $(k)T = $(k * T_env)\$",
                "General solution: \$T(t) = $(T_env) + Ce^{-$(k)t}\$",
                "Initial condition: \$T(0) = $(T_init)\$ gives \$C = $(T_init - T_env)\$",
                "Evaluate at \$t = $(t_val)\$: \$T($(t_val)) = $(T_env) + $(T_init - T_env)e^{-$(k)($(t_val))}\$",
                sol("Answer", "T($(t_val)) \\approx $(T_t_rounded)°")
            )
            
            problem(
                question="An object initially at \$$(T_init)°\$ is placed in an environment at \$$(T_env)°\$. The temperature \$T(t)\$ satisfies \$$(diff_eq)\$ where \$t\$ is time in minutes. Find the temperature after \$$(t_val)\$ minutes.",
                answer=T_t_rounded,
                difficulty=(1600, 1800),
                solution=solution_steps,
                time=300,
                calculator="scientific"
            )
        else
            # Population growth: dP/dt = kP
            P0 = randint(100, 500)
            k = choice([0.05, 0.08, 0.1, 0.12, 0.15])
            t_val = choice([5, 8, 10, 12])
            
            P_t = P0 * exp(k * t_val)
            P_t_rounded = round(Int, P_t)
            
            diff_eq = "\\frac{dP}{dt} = $(k)P"
            
            solution_steps = steps(
                "Exponential growth model: \$$(diff_eq)\$",
                "This is homogeneous linear: \$\\frac{dP}{dt} - $(k)P = 0\$",
                "General solution: \$P(t) = Ce^{$(k)t}\$",
                "Initial condition: \$P(0) = $(P0)\$ gives \$C = $(P0)\$",
                "Evaluate at \$t = $(t_val)\$: \$P($(t_val)) = $(P0)e^{$(k)($(t_val))}\$",
                sol("Answer", "P($(t_val)) \\approx $(P_t_rounded)")
            )
            
            problem(
                question="A population grows according to \$$(diff_eq)\$ where \$P\$ is population and \$t\$ is time in years. If the initial population is \$$(P0)\$, find the population after \$$(t_val)\$ years.",
                answer=P_t_rounded,
                difficulty=(1600, 1800),
                solution=solution_steps,
                time=300,
                calculator="scientific"
            )
        end
    end
end