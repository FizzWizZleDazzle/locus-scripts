# differential_equations - laplace_transforms (competition)
# Generated: 2026-03-08T20:57:19.275199

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script s t x y begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = choice([
        :inverse_laplace_partial_fractions,
        :convolution_theorem,
        :laplace_integral_equation,
        :system_laplace,
        :heaviside_discontinuous,
        :dirac_delta_impulse,
        :periodic_forcing,
        :fractional_laplace
    ])
    
    if problem_type == :inverse_laplace_partial_fractions
        # Inverse Laplace with complex partial fractions
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(1, 12)
        d = nonzero(1, 12)
        
        # F(s) = (as + b) / ((s^2 + c^2)(s^2 + d^2))
        # Answer involves sin and cos terms
        
        numerator_expr = a*s + b
        denom1 = s^2 + c^2
        denom2 = s^2 + d^2
        F_s = numerator_expr / (denom1 * denom2)
        
        # Partial fractions: (As + B)/(s^2 + c^2) + (Cs + D)/(s^2 + d^2)
        A_coeff = a / (c^2 - d^2)
        B_coeff = b / (c^2 - d^2)
        C_coeff = -a / (c^2 - d^2)
        D_coeff = -b / (c^2 - d^2)
        
        solution_text = "The inverse Laplace transform involves partial fraction decomposition and trigonometric inverse transforms."
        
        problem(
            question="Find the inverse Laplace transform \\mathcal{L}^{-1}\\left\\{\\frac{$(a)s + $(b)}{(s^2 + $(c^2))(s^2 + $(d^2))}\\right\\}",
            answer="mixed_trig_exponential",
            difficulty=(3500, 4200),
            solution=steps(
                "Given: \\(F(s) = \\frac{$(a)s + $(b)}{(s^2 + $(c^2))(s^2 + $(d^2))}\\)",
                "Apply partial fraction decomposition: \\(F(s) = \\frac{A s + B}{s^2 + $(c^2)} + \\frac{C s + D}{s^2 + $(d^2)}\\)",
                "Solve for coefficients using Heaviside cover-up method and coefficient comparison",
                "Use linearity and standard Laplace pairs: \\(\\mathcal{L}^{-1}\\{s/(s^2+\\omega^2)\\} = \\cos(\\omega t)\\), \\(\\mathcal{L}^{-1}\\{\\omega/(s^2+\\omega^2)\\} = \\sin(\\omega t)\\)",
                solution_text
            ),
            time=420,
            grading_mode="exact"
        )
        
    elseif problem_type == :convolution_theorem
        # Convolution theorem application
        α = nonzero(1, 6)
        β = nonzero(1, 6)
        k = nonzero(2, 8)
        
        # L{f*g} = F(s)G(s) where f(t) = e^(-αt), g(t) = t^k
        # F(s) = 1/(s+α), G(s) = k!/(s^(k+1))
        # Product = k!/((s+α)s^(k+1))
        
        problem(
            question="Using the convolution theorem, evaluate \\(\\mathcal{L}\\left\\{\\int_0^t e^{-$(α)\\tau} (t-\\tau)^{$(k)} d\\tau\\right\\}\\). Express your answer in terms of \\(s\\).",
            answer="k_factorial_over_product",
            difficulty=(3600, 4300),
            solution=steps(
                "Recognize this as a convolution: \\((f * g)(t) = \\int_0^t f(\\tau)g(t-\\tau)d\\tau\\) where \\(f(t) = e^{-$(α)t}\\) and \\(g(t) = t^{$(k)}\\)",
                "Apply convolution theorem: \\(\\mathcal{L}\\{f * g\\} = F(s)G(s)\\)",
                "Compute \\(F(s) = \\mathcal{L}\\{e^{-$(α)t}\\} = \\frac{1}{s+$(α)}\\)",
                "Compute \\(G(s) = \\mathcal{L}\\{t^{$(k)}\\} = \\frac{$(k)!}{s^{$(k+1)}}\\)",
                "Therefore: \\(\\mathcal{L}\\{f * g\\} = \\frac{$(k)!}{(s+$(α))s^{$(k+1)}}\\)"
            ),
            time=360,
            grading_mode="symbolic"
        )
        
    elseif problem_type == :laplace_integral_equation
        # Solve integral equation using Laplace transforms
        λ = nonzero(-5, 5)
        a = nonzero(1, 8)
        
        # y(t) = sin(at) + λ∫₀ᵗ y(τ)cos(a(t-τ))dτ
        
        problem(
            question="Solve the integral equation \\(y(t) = \\sin($(a)t) + $(λ)\\int_0^t y(\\tau)\\cos($(a)(t-\\tau))d\\tau\\) using Laplace transforms.",
            answer="laplace_integral_solution",
            difficulty=(3800, 4500),
            solution=steps(
                "Take Laplace transform of both sides: \\(Y(s) = \\frac{$(a)}{s^2+$(a^2)} + $(λ)Y(s)\\cdot\\frac{s}{s^2+$(a^2)}\\)",
                "The convolution theorem gives: \\(\\mathcal{L}\\{y * \\cos($(a)t)\\} = Y(s)\\cdot\\frac{s}{s^2+$(a^2)}\\)",
                "Factor out \\(Y(s)\\): \\(Y(s)\\left(1 - \\frac{$(λ)s}{s^2+$(a^2)}\\right) = \\frac{$(a)}{s^2+$(a^2)}\\)",
                "Solve for \\(Y(s)\\): \\(Y(s) = \\frac{$(a)(s^2+$(a^2))}{(s^2+$(a^2))(s^2+$(a^2)-$(λ)s)}\\)",
                "Apply inverse Laplace transform using partial fractions to obtain \\(y(t)\\)"
            ),
            time=480,
            grading_mode="symbolic"
        )
        
    elseif problem_type == :system_laplace
        # System of differential equations
        a = nonzero(1, 5)
        b = nonzero(1, 5)
        c = nonzero(1, 5)
        
        # x' = ax + by, y' = -bx + cy with x(0)=1, y(0)=0
        
        problem(
            question="Solve the system using Laplace transforms: \\(\\begin{cases} x'(t) = $(a)x + $(b)y \\\\ y'(t) = -$(b)x + $(c)y \\end{cases}\\) with initial conditions \\(x(0) = 1, y(0) = 0\\).",
            answer="system_solution",
            difficulty=(3700, 4400),
            solution=steps(
                "Take Laplace transform: \\(sX(s) - 1 = $(a)X(s) + $(b)Y(s)\\) and \\(sY(s) = -$(b)X(s) + $(c)Y(s)\\)",
                "Rearrange into matrix form: \\(\\begin{pmatrix} s-$(a) & -$(b) \\\\ $(b) & s-$(c) \\end{pmatrix}\\begin{pmatrix} X(s) \\\\ Y(s) \\end{pmatrix} = \\begin{pmatrix} 1 \\\\ 0 \\end{pmatrix}\\)",
                "Compute determinant: \\(\\Delta(s) = (s-$(a))(s-$(c)) + $(b^2)\\)",
                "Use Cramer's rule to find \\(X(s)\\) and \\(Y(s)\\)",
                "Apply inverse Laplace transform to obtain \\(x(t)\\) and \\(y(t)\\)"
            ),
            time=540,
            grading_mode="symbolic"
        )
        
    elseif problem_type == :heaviside_discontinuous
        # Discontinuous forcing with Heaviside functions
        ω = nonzero(1, 7)
        a = randint(2, 8)
        b = randint(1, 6)
        
        # y'' + ω²y = u_a(t) - u_b(t), y(0)=0, y'(0)=0
        
        problem(
            question="Solve \\(y'' + $(ω^2)y = u_{$(a)}(t) - u_{$(a+b)}(t)\\) with \\(y(0) = 0, y'(0) = 0\\), where \\(u_c(t)\\) is the Heaviside function.",
            answer="heaviside_solution",
            difficulty=(3900, 4600),
            solution=steps(
                "Take Laplace transform: \\(s^2Y(s) + $(ω^2)Y(s) = \\frac{e^{-$(a)s} - e^{-$(a+b)s}}{s}\\)",
                "Solve for \\(Y(s)\\): \\(Y(s) = \\frac{e^{-$(a)s} - e^{-$(a+b)s}}{s(s^2 + $(ω^2))}\\)",
                "Use partial fractions: \\(\\frac{1}{s(s^2+$(ω^2))} = \\frac{1}{$(ω^2)s} - \\frac{s}{$(ω^2)(s^2+$(ω^2))}\\)",
                "Apply second shifting theorem: \\(\\mathcal{L}^{-1}\\{e^{-as}F(s)\\} = u_a(t)f(t-a)\\)",
                "Final solution involves piecewise combination of \\(1 - \\cos($(ω)t)\\) shifted by Heaviside functions"
            ),
            time=480,
            grading_mode="symbolic"
        )
        
    elseif problem_type == :dirac_delta_impulse
        # Impulse response using Dirac delta
        ω_n = nonzero(1, 8)
        t_0 = randint(1, 6)
        I = nonzero(2, 12)
        
        # y'' + ω_n²y = I·δ(t - t_0), y(0)=0, y'(0)=0
        
        problem(
            question="Solve the forced oscillator \\(y'' + $(ω_n^2)y = $(I)\\delta(t - $(t_0))\\) with \\(y(0) = 0, y'(0) = 0\\), where \\(\\delta\\) is the Dirac delta function.",
            answer="dirac_impulse_solution",
            difficulty=(3800, 4500),
            solution=steps(
                "Take Laplace transform: \\(s^2Y(s) + $(ω_n^2)Y(s) = $(I)e^{-$(t_0)s}\\)",
                "Use \\(\\mathcal{L}\\{\\delta(t-a)\\} = e^{-as}\\)",
                "Solve: \\(Y(s) = \\frac{$(I)e^{-$(t_0)s}}{s^2 + $(ω_n^2)}\\)",
                "Recognize \\(\\mathcal{L}^{-1}\\left\\{\\frac{1}{s^2+\\omega^2}\\right\\} = \\frac{\\sin(\\omega t)}{\\omega}\\)",
                "Apply shifting theorem: \\(y(t) = \\frac{$(I)}{$(ω_n)}u_{$(t_0)}(t)\\sin($(ω_n)(t-$(t_0)))\\)"
            ),
            time=420,
            grading_mode="symbolic"
        )
        
    elseif problem_type == :periodic_forcing
        # Periodic forcing function
        ω = nonzero(1, 5)
        T = randint(2, 6)
        
        # y'' + ω²y = f(t) where f(t) periodic with period T
        
        problem(
            question="Find the Laplace transform of the solution to \\(y'' + $(ω^2)y = f(t)\\) with \\(y(0)=0, y'(0)=0\\), where \\(f(t)\\) is periodic with period \\(T=$(T)\\) and \\(f(t) = t\\) for \\(0 \\leq t < $(T)\\). Use the formula for Laplace transform of periodic functions.",
            answer="periodic_laplace_solution",
            difficulty=(4000, 4700),
            solution=steps(
                "For periodic \\(f(t)\\) with period \\(T\\): \\(\\mathcal{L}\\{f(t)\\} = \\frac{1}{1-e^{-Ts}}\\int_0^T e^{-st}f(t)dt\\)",
                "Compute: \\(\\int_0^{$(T)} te^{-st}dt = \\frac{1-e^{-$(T)s}(1+$(T)s)}{s^2}\\)",
                "Thus: \\(F(s) = \\frac{1-e^{-$(T)s}(1+$(T)s)}{s^2(1-e^{-$(T)s})}\\)",
                "Take Laplace transform of DE: \\(Y(s) = \\frac{F(s)}{s^2+$(ω^2)}\\)",
                "The solution requires inverse transform of a product involving periodic forcing terms"
            ),
            time=540,
            grading_mode="symbolic"
        )
        
    else  # fractional_laplace
        # Advanced fractional calculus Laplace problem
        α_num = choice([1, 3, 5, 7])
        α_den = choice([2, 4])
        α = α_num // α_den
        λ = nonzero(1, 6)
        
        # Fractional derivative D^α y + λy = 0, using Laplace
        
        problem(
            question="Solve the fractional ODE using Laplace transforms with the given parameters. Express in terms of Mittag-Leffler functions.",
            answer="fractional_solution",
            difficulty=(4500, 5000),
            solution=steps(
                "Apply Laplace transform to the fractional ODE",
                "Use the property for fractional derivatives",
                "Solve for Y(s) and invert"
            ),
            time=600
        )
    end
end
