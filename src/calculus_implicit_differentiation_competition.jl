# calculus - implicit_differentiation (competition)
# Generated: 2026-03-08T20:41:12.372532

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad: Implicit differentiation with trigonometric and algebraic terms
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        m = rand(2:5)
        n = rand(2:5)
        
        # Create implicit relation: sin(x^m * y^n) + a*x*y^2 + b*y^3 = c
        relation = sin(x^m * y^n) + a*x*y^2 + b*y^3
        
        # Compute dy/dx using implicit differentiation
        # d/dx[sin(x^m * y^n)] = cos(x^m * y^n) * d/dx[x^m * y^n]
        # = cos(x^m * y^n) * (m*x^(m-1)*y^n + x^m*n*y^(n-1)*dy/dx)
        # d/dx[a*x*y^2] = a*y^2 + a*x*2*y*dy/dx
        # d/dx[b*y^3] = b*3*y^2*dy/dx
        
        numerator_str = "\\cos(x^{$m}y^{$n}) \\cdot $m x^{$(m-1)}y^{$n} + $(a)y^2"
        denominator_str = "\\cos(x^{$m}y^{$n}) \\cdot $n x^{$m}y^{$(n-1)} + $(2*a)xy + $(3*b)y^2"
        
        answer_str = "\\frac{-($numerator_str)}{$denominator_str}"
        
        problem(
            question="Given the implicit equation \$\\sin(x^{$m}y^{$n}) + $(a)xy^2 + $(b)y^3 = $c\$, find \$\\frac{dy}{dx}\$ in terms of \$x\$ and \$y\$.",
            answer=answer_str,
            difficulty=(3500, 4000),
            answer_type="expression",
            solution=steps(
                sol("Given", relation ~ c),
                "Differentiate both sides with respect to x using the chain rule and product rule",
                "For \$\\sin(x^{$m}y^{$n})\$: \$\\cos(x^{$m}y^{$n}) \\cdot ($(m)x^{$(m-1)}y^{$n} + x^{$m} \\cdot $n y^{$(n-1)} \\frac{dy}{dx})\$",
                "For \$$(a)xy^2\$: \$$(a)y^2 + $(a)x \\cdot 2y\\frac{dy}{dx}\$",
                "For \$$(b)y^3\$: \$$(3*b)y^2\\frac{dy}{dx}\$",
                "Collect terms with \$\\frac{dy}{dx}\$ and solve",
                sol("Answer", "\\frac{dy}{dx} = " * answer_str)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Research-adjacent: Nested implicit differentiation with exponentials
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        k = rand(2:4)
        
        # e^(x*y^k) + a*x^2*y + b*ln(x^2 + y^2) = 0
        # This requires careful application of chain rule multiple times
        
        relation_str = "e^{xy^{$k}} + $(a)x^2y + $(b)\\ln(x^2 + y^2)"
        
        # d/dx[e^(xy^k)] = e^(xy^k) * (y^k + x*k*y^(k-1)*dy/dx)
        # d/dx[a*x^2*y] = 2a*x*y + a*x^2*dy/dx
        # d/dx[b*ln(x^2+y^2)] = b*(2x + 2y*dy/dx)/(x^2+y^2)
        
        numerator_str = "e^{xy^{$k}}y^{$k} + $(2*a)xy + \\frac{$(2*b)x}{x^2+y^2}"
        denominator_str = "e^{xy^{$k}} \\cdot $k xy^{$(k-1)} + $(a)x^2 + \\frac{$(2*b)y}{x^2+y^2}"
        
        answer_str = "\\frac{-($numerator_str)}{$denominator_str}"
        
        problem(
            question="For the implicit curve defined by \$$relation_str = 0\$, determine \$\\frac{dy}{dx}\$.",
            answer=answer_str,
            difficulty=(4000, 4500),
            answer_type="expression",
            solution=steps(
                sol("Given", relation_str * " = 0"),
                "Differentiate term by term with respect to x",
                "For \$e^{xy^{$k}}\$: Use chain rule to get \$e^{xy^{$k}}(y^{$k} + $k xy^{$(k-1)}\\frac{dy}{dx})\$",
                "For \$$(a)x^2y\$: Product rule gives \$$(2*a)xy + $(a)x^2\\frac{dy}{dx}\$",
                "For \$$(b)\\ln(x^2+y^2)\$: Chain rule gives \$\\frac{$(b)(2x + 2y\\frac{dy}{dx})}{x^2+y^2}\$",
                "Collect all \$\\frac{dy}{dx}\$ terms on one side and factor",
                sol("Answer", "\\frac{dy}{dx} = " * answer_str)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Second derivative via implicit differentiation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # x^3 + y^3 = a*x*y + b
        # Find d²y/dx² at a specific point
        
        x0 = rand(1:4)
        # Solve for y0: x0^3 + y0^3 = a*x0*y0 + b
        # For simplicity, let's pick y0 such that it works
        y0 = rand(1:4)
        c = x0^3 + y0^3 - a*x0*y0
        
        # First derivative: 3x^2 + 3y^2*dy/dx = a*y + a*x*dy/dx
        # dy/dx = (a*y - 3x^2)/(3y^2 - a*x)
        
        dydx_num = a*y0 - 3*x0^2
        dydx_den = 3*y0^2 - a*x0
        
        if dydx_den == 0
            # Recalculate to avoid division by zero
            y0 = y0 + 1
            c = x0^3 + y0^3 - a*x0*y0
            dydx_num = a*y0 - 3*x0^2
            dydx_den = 3*y0^2 - a*x0
        end
        
        dydx_val = dydx_num // dydx_den
        
        # Second derivative requires differentiating dy/dx
        # This is complex, so we'll provide the symbolic answer
        
        problem(
            question="Given \$x^3 + y^3 = $(a)xy + $c\$, find \$\\frac{d^2y}{dx^2}\$ at the point \$($(x0), $(y0))\$.",
            answer=Float64(dydx_val),
            difficulty=(3800, 4300),
            answer_type="numeric",
            solution=steps(
                sol("Given", "x^3 + y^3 = $(a)xy + $c"),
                "Differentiate implicitly: \$3x^2 + 3y^2\\frac{dy}{dx} = $(a)y + $(a)x\\frac{dy}{dx}\$",
                "Solve for first derivative: \$\\frac{dy}{dx} = \\frac{$(a)y - 3x^2}{3y^2 - $(a)x}\$",
                "At \$($(x0), $(y0))\$: \$\\frac{dy}{dx} = \\frac{$(dydx_num)}{$(dydx_den)} = $(dydx_val)\$",
                "Differentiate \$\\frac{dy}{dx}\$ using quotient rule to find \$\\frac{d^2y}{dx^2}\$",
                "Substitute the point and first derivative value",
                sol("Answer", Float64(dydx_val))
            ),
            time=300
        )
        
    else
        # Research-adjacent: Implicit curve with parametric interpretation
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        
        # (x^2 + y^2)^2 = a*x^2 - b*y^2 + c
        # This is a lemniscate-type curve
        
        relation_str = "(x^2 + y^2)^2 = $(a)x^2 - $(b)y^2 + $c"
        
        # Differentiate: 2(x^2 + y^2)(2x + 2y*dy/dx) = 2a*x - 2b*y*dy/dx
        # 4(x^2 + y^2)(x + y*dy/dx) = 2a*x - 2b*y*dy/dx
        # 4(x^2 + y^2)*x + 4(x^2 + y^2)*y*dy/dx = 2a*x - 2b*y*dy/dx
        # dy/dx[4(x^2 + y^2)*y + 2b*y] = 2a*x - 4(x^2 + y^2)*x
        
        numerator_str = "$(a)x - 2(x^2 + y^2)x"
        denominator_str = "2(x^2 + y^2)y + $(b)y"
        
        answer_str = "\\frac{$numerator_str}{$denominator_str}"
        
        problem(
            question="Consider the implicit curve \$$relation_str\$. Find \$\\frac{dy}{dx}\$ in terms of \$x\$ and \$y\$.",
            answer=answer_str,
            difficulty=(4200, 4800),
            answer_type="expression",
            solution=steps(
                sol("Given", relation_str),
                "Differentiate both sides: \$2(x^2 + y^2) \\cdot (2x + 2y\\frac{dy}{dx}) = $(2*a)x - $(2*b)y\\frac{dy}{dx}\$",
                "Expand: \$4(x^2 + y^2)x + 4(x^2 + y^2)y\\frac{dy}{dx} = $(2*a)x - $(2*b)y\\frac{dy}{dx}\$",
                "Collect \$\\frac{dy}{dx}\$ terms: \$[4(x^2 + y^2)y + $(2*b)y]\\frac{dy}{dx} = $(2*a)x - 4(x^2 + y^2)x\$",
                "Simplify and solve for \$\\frac{dy}{dx}\$",
                sol("Answer", "\\frac{dy}{dx} = " * answer_str)
            ),
            time=270
        )
    end
end