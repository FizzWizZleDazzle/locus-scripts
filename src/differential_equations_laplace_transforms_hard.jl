# differential_equations - laplace_transforms (hard)
# Generated: 2026-03-08T20:56:34.823787

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script t s begin
    set_topic!("differential_equations/laplace_transforms")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Laplace transform of polynomial with exponential
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        n = randint(2, 4)
        
        f_expr = expand(t^n * exp(a*t))
        
        # L{t^n * e^(at)} = n! / (s-a)^(n+1)
        answer_expr = factorial(n) / (s - a)^(n+1)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(t^n)) e^{$(a)t}\$",
            answer=answer_expr,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", f_expr),
                "Use the formula: \$\\mathcal{L}\\{t^n e^{at}\\} = \\frac{n!}{(s-a)^{n+1}}\$",
                "Here \$n = $(n)\$ and \$a = $(a)\$",
                sol("Answer", answer_expr)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Inverse Laplace with partial fractions
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        while b == a
            b = nonzero(-8, 8)
        end
        
        # F(s) = k / [(s-a)(s-b)]
        k = randint(2, 20)
        
        # Partial fractions: k/[(s-a)(s-b)] = A/(s-a) + B/(s-b)
        # A = k/(b-a), B = -k/(b-a)
        A = k // (b - a)
        B = -k // (b - a)
        
        F_s = k / ((s - a) * (s - b))
        answer_expr = A * exp(a*t) + B * exp(b*t)
        
        problem(
            question="Find the inverse Laplace transform of \$F(s) = $(tex(F_s))\$",
            answer=answer_expr,
            difficulty=(1900, 2150),
            solution=steps(
                sol("Given", F_s),
                "Use partial fraction decomposition: \$\\frac{$(k)}{(s-$(a))(s-$(b))} = \\frac{A}{s-$(a)} + \\frac{B}{s-$(b)}\$",
                "Solve for constants: \$A = $(tex(A))\$, \$B = $(tex(B))\$",
                "Apply inverse Laplace: \$\\mathcal{L}^{-1}\\{\\frac{1}{s-a}\\} = e^{at}\$",
                sol("Answer", answer_expr)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Laplace transform with shifting theorem
        a = nonzero(-6, 6)
        ω = randint(2, 8)
        k = nonzero(-10, 10)
        
        # f(t) = k * e^(at) * sin(ωt)
        f_expr = k * exp(a*t) * sin(ω*t)
        
        # L{e^(at) sin(ωt)} = ω / [(s-a)^2 + ω^2]
        answer_expr = k * ω / ((s - a)^2 + ω^2)
        
        problem(
            question="Find the Laplace transform of \$f(t) = $(tex(f_expr))\$",
            answer=answer_expr,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", f_expr),
                "Use the frequency shifting theorem: \$\\mathcal{L}\\{e^{at} \\sin(\\omega t)\\} = \\frac{\\omega}{(s-a)^2 + \\omega^2}\$",
                "Here \$a = $(a)\$, \$\\omega = $(ω)\$, and coefficient \$k = $(k)\$",
                sol("Answer", answer_expr)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Solve IVP using Laplace transforms
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        y0 = randint(-10, 10)
        
        # y' + ay = b, y(0) = y0
        # L{y'} + aL{y} = L{b}
        # sY - y0 + aY = b/s
        # Y(s) = (y0 + b/s) / (s + a) = y0/(s+a) + b/[s(s+a)]
        
        # Solve: y(t) = y0*e^(-at) + (b/a)(1 - e^(-at))
        answer_expr = y0 * exp(-a*t) + (b//a) * (1 - exp(-a*t))
        
        problem(
            question="Solve the initial value problem using Laplace transforms: \$y' + $(a)y = $(b)\$, \$y(0) = $(y0)\$",
            answer=answer_expr,
            difficulty=(2000, 2300),
            solution=steps(
                "Take Laplace transform of both sides: \$sY(s) - y(0) + $(a)Y(s) = \\frac{$(b)}{s}\$",
                "Substitute initial condition: \$sY(s) - $(y0) + $(a)Y(s) = \\frac{$(b)}{s}\$",
                "Solve for \$Y(s)\$: \$Y(s) = \\frac{$(y0)}{s+$(a)} + \\frac{$(b)}{s(s+$(a))}\$",
                "Apply partial fractions and inverse Laplace transform",
                sol("Answer", answer_expr)
            ),
            time=240
        )
        
    else
        # Laplace transform with convolution
        ω1 = randint(2, 6)
        ω2 = randint(2, 6)
        while ω2 == ω1
            ω2 = randint(2, 6)
        end
        
        # F(s) = ω1/(s^2 + ω1^2), G(s) = ω2/(s^2 + ω2^2)
        # f(t) = sin(ω1*t), g(t) = sin(ω2*t)
        
        F_s = ω1 / (s^2 + ω1^2)
        G_s = ω2 / (s^2 + ω2^2)
        product = F_s * G_s
        
        # The convolution integral is complex, so we state the result
        if ω1^2 - ω2^2 != 0
            coeff = ω1 * ω2 / (ω1^2 - ω2^2)
            answer_expr = coeff * (sin(ω1*t)/ω1 - sin(ω2*t)/ω2)
        else
            answer_expr = (ω1/2) * (sin(ω1*t) - ω1*t*cos(ω1*t))
        end
        
        problem(
            question="Find \$\\mathcal{L}^{-1}\\left\\{$(tex(product))\\right\\}\$ using the convolution theorem",
            answer=answer_expr,
            difficulty=(2200, 2500),
            solution=steps(
                sol("Given", product),
                "Recognize \$F(s) = $(tex(F_s)) \\leftrightarrow \\sin($(ω1)t)\$ and \$G(s) = $(tex(G_s)) \\leftrightarrow \\sin($(ω2)t)\$",
                "Apply convolution theorem: \$\\mathcal{L}^{-1}\\{F(s)G(s)\\} = (f * g)(t) = \\int_0^t f(\\tau)g(t-\\tau)d\\tau\$",
                "Evaluate the convolution integral of the sine functions",
                sol("Answer", answer_expr)
            ),
            time=300
        )
    end
end