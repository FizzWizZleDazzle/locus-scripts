# differential_equations - laplace_transforms (medium)
# Generated: 2026-03-08T20:56:23.975113

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x s t begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic Laplace transform of polynomial
        degree = rand(1:3)
        coeffs = [nonzero(-8, 8) for _ in 1:degree+1]
        
        f_expr = sum(coeffs[i] * t^(i-1) for i in 1:length(coeffs))
        
        # L{t^n} = n!/s^(n+1)
        laplace_terms = []
        for i in 1:length(coeffs)
            n = i - 1
            term = coeffs[i] * factorial(n) // s^(n+1)
            push!(laplace_terms, term)
        end
        laplace_result = sum(laplace_terms)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_result,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", f_expr),
                "Apply linearity: \$\\mathcal{L}\\{t^n\\} = \\frac{n!}{s^{n+1}}\$",
                sol("F(s)", laplace_result)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Laplace transform with exponential
        a = nonzero(-6, 6)
        b = nonzero(-5, 5)
        
        f_expr = b * exp(a * t)
        # L{e^(at)} = 1/(s-a)
        laplace_result = b // (s - a)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_result,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", f_expr),
                "Apply \$\\mathcal{L}\\{e^{at}\\} = \\frac{1}{s-a}\$",
                sol("F(s)", laplace_result)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Inverse Laplace transform - partial fractions setup
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        while b == a
            b = nonzero(-8, 8)
        end
        
        # F(s) = 1/((s-a)(s-b))
        F_s = 1 // ((s - a) * (s - b))
        
        # Inverse: (e^(at) - e^(bt))/(a-b)
        c = 1 // (a - b)
        f_t = c * (exp(a * t) - exp(b * t))
        
        problem(
            question="Find the inverse Laplace transform of \$F(s) = $(tex(F_s))\$",
            answer=f_t,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", F_s),
                "Use partial fractions: \$\\frac{1}{(s-$a)(s-$b)} = \\frac{A}{s-$a} + \\frac{B}{s-$b}\$",
                "Solve: \$A = \\frac{1}{$(a-b)}\$, \$B = \\frac{-1}{$(a-b)}\$",
                "Apply inverse transform: \$\\mathcal{L}^{-1}\\{\\frac{1}{s-a}\\} = e^{at}\$",
                sol("f(t)", f_t)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Solve first-order ODE using Laplace
        a = nonzero(-5, 5)
        y0 = randint(-10, 10)
        
        # y' + ay = 0, y(0) = y0
        # Taking Laplace: sY - y0 + aY = 0
        # Y(s) = y0/(s+a)
        # y(t) = y0*e^(-at)
        
        Y_s = y0 // (s + a)
        y_t = y0 * exp(-a * t)
        
        problem(
            question="Use Laplace transforms to solve the IVP: \$y' + $(a)y = 0\$, \$y(0) = $(y0)\$",
            answer=y_t,
            difficulty=(1400, 1700),
            solution=steps(
                "Take Laplace transform of both sides",
                "\$\\mathcal{L}\\{y'\\} + $(a)\\mathcal{L}\\{y\\} = 0\$",
                "\$sY(s) - $(y0) + $(a)Y(s) = 0\$",
                sol("Y(s)", Y_s),
                "Take inverse Laplace transform",
                sol("y(t)", y_t)
            ),
            time=240
        )
        
    else
        # Laplace of sin or cos
        omega = nonzero(1, 6)
        A = nonzero(-8, 8)
        use_sin = rand(Bool)
        
        if use_sin
            f_expr = A * sin(omega * t)
            # L{sin(ωt)} = ω/(s^2 + ω^2)
            laplace_result = A * omega // (s^2 + omega^2)
        else
            f_expr = A * cos(omega * t)
            # L{cos(ωt)} = s/(s^2 + ω^2)
            laplace_result = A * s // (s^2 + omega^2)
        end
        
        trig_name = use_sin ? "\\sin" : "\\cos"
        formula = use_sin ? "\\frac{\\omega}{s^2 + \\omega^2}" : "\\frac{s}{s^2 + \\omega^2}"
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=laplace_result,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", f_expr),
                "Apply \$\\mathcal{L}\\{$(trig_name)(\\omega t)\\} = $(formula)\$ with \$\\omega = $(omega)\$",
                sol("F(s)", laplace_result)
            ),
            time=90
        )
    end
end