# differential_equations - first_order_linear (very_hard)
# Generated: 2026-03-08T20:51:04.397029

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Non-standard integrating factor with parametric family
        # dy/dx + P(x)y = Q(x) where P(x) requires clever manipulation
        n = randint(2, 4)
        k = nonzero(-5, 5)
        c = randint(-8, 8)
        
        # Construct dy/dx + (n/x)y = x^k
        # Integrating factor: μ(x) = x^n
        # General solution: y = x^(-n) * [x^(n+k+1)/(n+k+1) + C]
        
        P_expr = n // x
        Q_expr = x^k
        
        # Simplify the general solution
        if n + k + 1 != 0
            ans_expr = x^(k + 1) // (n + k + 1)
        else
            ans_expr = log(abs(x))
        end
        
        question_text = "Find the general solution to the differential equation: \$\\frac{dy}{dx} + \\frac{$(n)}{x}y = $(tex(Q_expr))\$"
        
        solution_steps = steps(
            sol("Given", "\\frac{dy}{dx} + \\frac{$(n)}{x}y = $(tex(Q_expr))"),
            "This is a first-order linear ODE. Identify P(x) = $(n)/x and Q(x) = $(tex(Q_expr))",
            "Integrating factor: \$\\mu(x) = e^{\\int $(n)/x \\, dx} = e^{$(n)\\ln|x|} = x^{$(n)}\$",
            "Multiply both sides by \$x^{$(n)}\$: \$x^{$(n)}\\frac{dy}{dx} + $(n)x^{$(n-1)}y = x^{$(n+k)}\$",
            "Left side is \$\\frac{d}{dx}[x^{$(n)}y]\$",
            "Integrate: \$x^{$(n)}y = \\int x^{$(n+k)} dx = $(tex(x^(n+k+1)//(n+k+1))) + C\$",
            sol("General solution", "y = $(tex(ans_expr)) + Cx^{-$(n)}")
        )
        
        problem(
            question=question_text,
            answer="y = $(tex(ans_expr)) + Cx^{-$(n)}",
            difficulty=(2500, 2900),
            solution=solution_steps,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Singular solution / envelope analysis
        # Riccati-type or Bernoulli requiring substitution
        
        n = choice([2, 3, -1, -2])
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        
        # Bernoulli equation: dy/dx + P(x)y = Q(x)y^n
        P_coeff = a
        Q_coeff = b
        
        # For y' + ay = by^n, substitute v = y^(1-n)
        # v' = (1-n)y^(-n)y' = (1-n)(by^n - ay) = (1-n)b - (1-n)av
        
        question_text = "Solve the Bernoulli equation: \$\\frac{dy}{dx} + $(P_coeff)y = $(Q_coeff)y^{$(n)}\$ (express in terms of y)"
        
        if n == 2
            # v = y^(-1), v' + av = -b
            # Integrating factor e^(ax)
            # v = -b/a + Ce^(-ax)
            # y = 1/v = a/(-b + Ce^(-ax))
            ans_text = "y = \\frac{1}{Ce^{-$(P_coeff)x} - $(Q_coeff//P_coeff)}"
        else
            ans_text = "y^{$(1-n)} = Ce^{-$(P_coeff*(1-n))x} + \\frac{$(Q_coeff*(1-n))}{$(P_coeff*(1-n))}"
        end
        
        solution_steps = steps(
            sol("Given Bernoulli equation", "\\frac{dy}{dx} + $(P_coeff)y = $(Q_coeff)y^{$(n)}"),
            "This is Bernoulli with n=$(n). Substitute \$v = y^{$(1-n)}\$",
            "Then \$\\frac{dv}{dx} = $(1-n)y^{$(−n)}\\frac{dy}{dx}\$",
            "Divide original equation by \$y^{$(n)}\$: \$y^{-$(n)}\\frac{dy}{dx} + $(P_coeff)y^{$(1-n)} = $(Q_coeff)\$",
            "Multiply by $(1-n): \$\\frac{dv}{dx} + $(P_coeff*(1-n))v = $(Q_coeff*(1-n))\$",
            "This is linear in v. Integrating factor: \$\\mu = e^{$(P_coeff*(1-n))x}\$",
            "Solve for v, then substitute back \$y = v^{1/$(1-n)}\$"
        )
        
        problem(
            question=question_text,
            answer=ans_text,
            difficulty=(2800, 3200),
            solution=solution_steps,
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Initial value problem with transcendental coefficients
        # dy/dx + y*tan(x) = sec(x), demanding trig manipulation
        
        mult = choice([-1, 1, 2, -2])
        shift = randint(-3, 3)
        x0_choices = [0, π//6, π//4, π//3]
        x0 = choice(x0_choices)
        y0 = randint(-5, 5)
        
        question_text = "Solve the initial value problem: \$\\frac{dy}{dx} + y\\tan(x) = $(mult)\\sec(x)\$, \$y($(tex(x0))) = $(y0)\$"
        
        # P(x) = tan(x), Q(x) = mult*sec(x)
        # μ = e^(∫tan(x)dx) = e^(-ln|cos(x)|) = sec(x)
        # sec(x)y' + sec(x)tan(x)y = mult*sec^2(x)
        # d/dx[sec(x)y] = mult*sec^2(x)
        # sec(x)y = mult*tan(x) + C
        # y = mult*sin(x) + C*cos(x)
        
        # Apply IC: y0 = mult*sin(x0) + C*cos(x0)
        # C = (y0 - mult*sin(x0))/cos(x0) (if x0 ≠ π/2)
        
        sin_x0 = sin(Float64(x0))
        cos_x0 = cos(Float64(x0))
        
        if abs(cos_x0) > 0.01
            C_val = (y0 - mult * sin_x0) / cos_x0
            ans_text = "y = $(mult)\\sin(x) + $(round(C_val, digits=3))\\cos(x)"
        else
            ans_text = "y = $(mult)\\sin(x)"
        end
        
        solution_steps = steps(
            sol("Given", "\\frac{dy}{dx} + y\\tan(x) = $(mult)\\sec(x), \\quad y($(tex(x0))) = $(y0)"),
            "Identify P(x) = \\tan(x), Q(x) = $(mult)\\sec(x)",
            "Integrating factor: \$\\mu = e^{\\int \\tan(x)dx} = e^{-\\ln|\\cos(x)|} = \\sec(x)\$",
            "Multiply: \$\\sec(x)\\frac{dy}{dx} + \\sec(x)\\tan(x)y = $(mult)\\sec^2(x)\$",
            "Recognize: \$\\frac{d}{dx}[\\sec(x)y] = $(mult)\\sec^2(x)\$",
            "Integrate: \$\\sec(x)y = $(mult)\\tan(x) + C\$",
            "General solution: \$y = $(mult)\\sin(x) + C\\cos(x)\$",
            "Apply initial condition y($(tex(x0))) = $(y0) to find C=$(round(C_val, digits=3))"
        )
        
        problem(
            question=question_text,
            answer=ans_text,
            difficulty=(2600, 3100),
            solution=solution_steps,
            time=270
        )
        
    else
        # Type 4: Exact equation requiring olympiad-level insight
        # M(x,y)dx + N(x,y)dy = 0 where exactness test + potential function
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        # Construct exact: ∂ψ/∂x = M, ∂ψ/∂y = N
        # Let ψ = ax²y + by³ + cx²
        # M = ∂ψ/∂x = 2axy + 2cx
        # N = ∂ψ/∂y = ax² + 3by²
        
        M_text = "$(2*a)xy + $(2*c)x"
        N_text = "$(a)x^2 + $(3*b)y^2"
        
        question_text = "Determine whether the equation \$($(M_text))dx + ($(N_text))dy = 0\$ is exact. If exact, find the implicit solution."
        
        # Check exactness: ∂M/∂y = 2a*x, ∂N/∂x = 2a*x ✓
        
        solution_steps = steps(
            sol("Given equation", "($(M_text))dx + ($(N_text))dy = 0"),
            "Check exactness: \$\\frac{\\partial M}{\\partial y} = $(2*a)x\$, \$\\frac{\\partial N}{\\partial x} = $(2*a)x\$",
            "Since \$\\frac{\\partial M}{\\partial y} = \\frac{\\partial N}{\\partial x}\$, the equation is exact",
            "Find potential \$\\psi\$: \$\\int M \\, dx = \\int ($(M_text)) dx = $(a)x^2y + $(c)x^2 + g(y)\$",
            "Differentiate w.r.t. y: \$\\frac{\\partial \\psi}{\\partial y} = $(a)x^2 + g'(y) = N = $(a)x^2 + $(3*b)y^2\$",
            "Thus \$g'(y) = $(3*b)y^2\$, so \$g(y) = $(b)y^3\$",
            sol("Implicit solution", "$(a)x^2y + $(b)y^3 + $(c)x^2 = C")
        )
        
        problem(
            question=question_text,
            answer="$(a)x^2y + $(b)y^3 + $(c)x^2 = C",
            difficulty=(2700, 3400),
            solution=solution_steps,
            time=300
        )
    end
end