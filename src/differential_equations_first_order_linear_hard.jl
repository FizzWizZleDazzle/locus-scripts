# differential_equations - first_order_linear (hard)
# Generated: 2026-03-08T20:50:46.585029

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Standard form dy/dx + P(x)y = Q(x) with polynomial coefficients
        p_coeff = nonzero(-5, 5)
        q_a = randint(-8, 8)
        q_b = randint(-12, 12)
        
        P_expr = p_coeff * x
        Q_expr = q_a * x + q_b
        
        # Integrating factor: μ(x) = e^(∫P dx) = e^(p_coeff*x^2/2)
        if p_coeff == 2
            mu_str = "e^{x^2}"
            int_p = "x^2"
        elseif p_coeff == -2
            mu_str = "e^{-x^2}"
            int_p = "-x^2"
        else
            mu_str = "e^{\\frac{$(p_coeff)x^2}{2}}"
            int_p = "\\frac{$(p_coeff)x^2}{2}"
        end
        
        question_text = "Solve the first-order linear differential equation: \$\\frac{dy}{dx} + $(tex(P_expr))y = $(tex(Q_expr))\$. Express your answer in the form \$y = f(x, C)\$ where \$C\$ is an arbitrary constant."
        
        answer_text = "y = e^{-$(int_p)}\\left(\\int $(tex(Q_expr))$(mu_str)\\,dx + C\\right)"
        
        solution_text = steps(
            sol("Standard form", "\\frac{dy}{dx} + $(tex(P_expr))y = $(tex(Q_expr))"),
            "Identify \$P(x) = $(tex(P_expr))\$ and \$Q(x) = $(tex(Q_expr))\$",
            "Compute integrating factor: \$\\mu(x) = e^{\\int P(x)\\,dx} = e^{$(int_p)} = $(mu_str)\$",
            "Multiply both sides by \$\\mu(x)\$: \$\\frac{d}{dx}[y\\cdot $(mu_str)] = $(tex(Q_expr))\\cdot $(mu_str)\$",
            "Integrate both sides: \$y\\cdot $(mu_str) = \\int $(tex(Q_expr))$(mu_str)\\,dx + C\$",
            sol("General solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1800, 2100),
            solution=solution_text,
            time=240,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Separable equation disguised as first-order linear
        k = nonzero(-6, 6)
        n = randint(1, 3)
        
        if n == 1
            rhs = k * x
            integral_rhs = "\\frac{$(k)x^2}{2}"
            int_val = k // 2
        elseif n == 2
            rhs = k * x^2
            integral_rhs = "\\frac{$(k)x^3}{3}"
            int_val = k // 3
        else
            rhs = k * x^3
            integral_rhs = "\\frac{$(k)x^4}{4}"
            int_val = k // 4
        end
        
        question_text = "Solve the differential equation: \$\\frac{dy}{dx} = $(tex(rhs))y\$. Express your answer in the form \$y = f(x, C)\$ where \$C\$ is an arbitrary constant."
        
        answer_text = "y = Ce^{$(integral_rhs)}"
        
        solution_text = steps(
            sol("Given equation", "\\frac{dy}{dx} = $(tex(rhs))y"),
            "Separate variables: \$\\frac{dy}{y} = $(tex(rhs))\\,dx\$",
            "Integrate both sides: \$\\ln|y| = $(integral_rhs) + C_1\$",
            "Exponentiate: \$y = e^{$(integral_rhs) + C_1} = e^{C_1}\\cdot e^{$(integral_rhs)}\$",
            sol("General solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1850, 2150),
            solution=solution_text,
            time=180,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # Initial value problem with exponential coefficient
        a = nonzero(-4, 4)
        b = nonzero(-8, 8)
        x0 = choice([-1, 0, 1])
        y0 = randint(-10, 10)
        
        if a > 0
            P_str = "-$(a)"
            mu_exp = "-$(a)x"
        else
            P_str = "$(abs(a))"
            mu_exp = "$(abs(a))x"
        end
        
        question_text = "Solve the initial value problem: \$\\frac{dy}{dx} $(P_str)y = $(b)e^{$(a)x}\$, with \$y($(x0)) = $(y0)\$."
        
        # Solution: y = e^(ax)[∫b·e^(ax)·e^(-ax)dx + C] = e^(ax)[bx + C]
        # At x=x0: y0 = e^(a*x0)[b*x0 + C] => C = y0*e^(-a*x0) - b*x0
        
        if x0 == 0
            c_val_str = "$(y0)"
            answer_text = "y = e^{$(a)x}($(b)x + $(y0))"
        else
            answer_text = "y = e^{$(a)x}\\left($(b)x + $(y0)e^{-$(a*x0)} - $(b*x0)\\right)"
            c_val_str = "$(y0)e^{-$(a*x0)} - $(b*x0)"
        end
        
        solution_text = steps(
            sol("Standard form", "\\frac{dy}{dx} $(P_str)y = $(b)e^{$(a)x}"),
            "Integrating factor: \$\\mu(x) = e^{$(mu_exp)}\$",
            "Multiply and integrate: \$y\\cdot e^{$(mu_exp)} = \\int $(b)\\,dx + C = $(b)x + C\$",
            "General solution: \$y = e^{$(a)x}($(b)x + C)\$",
            "Apply initial condition \$y($(x0)) = $(y0)\$: \$C = $(c_val_str)\$",
            sol("Particular solution", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(1900, 2300),
            solution=solution_text,
            time=270,
            answer_type="expression"
        )
        
    else
        # Bernoulli equation: dy/dx + P(x)y = Q(x)y^n
        p = nonzero(-3, 3)
        q = nonzero(-6, 6)
        n = choice([2, 3])
        
        question_text = "Solve the Bernoulli equation: \$\\frac{dy}{dx} + $(p)y = $(q)y^{$(n)}\$. Express your answer in the form \$y = f(x, C)\$ where \$C\$ is an arbitrary constant."
        
        # Substitution: v = y^(1-n), dv/dx = (1-n)y^(-n)dy/dx
        # Divided by y^n: y^(-n)dy/dx + p*y^(1-n) = q
        # Let v = y^(1-n): dv/dx/(1-n) + pv = q
        # dv/dx + p(1-n)v = q(1-n)
        
        one_minus_n = 1 - n
        p_new = p * one_minus_n
        q_new = q * one_minus_n
        
        if n == 2
            v_power = "-1"
            v_expr = "y^{-1}"
        else
            v_power = "$(one_minus_n)"
            v_expr = "y^{$(v_power)}"
        end
        
        answer_text = "y = \\left[Ce^{-$(p_new)x} + \\frac{$(q_new)}{$(p_new)}\\right]^{\\frac{1}{$(one_minus_n)}}"
        
        solution_text = steps(
            sol("Bernoulli equation", "\\frac{dy}{dx} + $(p)y = $(q)y^{$(n)}"),
            "Divide by \$y^{$(n)}\$: \$y^{-$(n)}\\frac{dy}{dx} + $(p)y^{$(one_minus_n)} = $(q)\$",
            "Substitute \$v = $(v_expr)\$, so \$\\frac{dv}{dx} = $(one_minus_n)y^{-$(n)}\\frac{dy}{dx}\$",
            "Linear equation in \$v\$: \$\\frac{dv}{dx} + $(p_new)v = $(q_new)\$",
            "Solve for \$v\$: \$v = Ce^{-$(p_new)x} + \\frac{$(q_new)}{$(p_new)}\$",
            sol("Solution for y", answer_text)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2100, 2500),
            solution=solution_text,
            time=300,
            answer_type="expression"
        )
    end
end