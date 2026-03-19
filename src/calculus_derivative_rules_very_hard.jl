# calculus - derivative_rules (very_hard)
# Generated: 2026-03-08T20:39:34.425982

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Implicit differentiation with challenging composition (2500-3000)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        x0 = nonzero(-8, 8)
        y0 = nonzero(-8, 8)
        
        # Verify point satisfies equation
        while abs(a*x0^3 + b*x0*y0^2 + c*y0^3 - (a*x0^3 + b*x0*y0^2 + c*y0^3)) > 0.01
            y0 = nonzero(-8, 8)
        end
        
        # dy/dx = -(3ax^2 + by^2) / (2bxy + 3cy^2)
        numer = -(3*a*x0^2 + b*y0^2)
        denom = 2*b*x0*y0 + 3*c*y0^2
        
        if denom != 0
            ans = numer // denom
        else
            ans = "undefined"
        end
        
        problem(
            question="Given the implicit curve \$$(a)x^3 + $(b)xy^2 + $(c)y^3 = $(a*x0^3 + b*x0*y0^2 + c*y0^3)\$, find \$\\frac{dy}{dx}\$ at the point \$($(x0), $(y0))\$.",
            answer=ans,
            difficulty=(2500, 3000),
            solution=steps(
                "Differentiate both sides with respect to \$x\$ using implicit differentiation",
                sol("", "$(3*a)x^2 + $(b)y^2 + $(2*b)xy\\frac{dy}{dx} + $(3*c)y^2\\frac{dy}{dx} = 0"),
                "Collect terms with \$\\frac{dy}{dx}\$",
                sol("", "\\frac{dy}{dx}($(2*b)xy + $(3*c)y^2) = -($(3*a)x^2 + $(b)y^2)"),
                "Substitute \$(x, y) = ($(x0), $(y0))\$ and solve",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Higher-order derivative of composite function (2600-3200)
        @variables t
        k = nonzero(-4, 4)
        m = nonzero(2, 5)
        n = nonzero(2, 5)
        
        # f(t) = sin^m(kt), find f''(π/(2k))
        t0_val = π / (2*abs(k))
        
        # At t = π/(2k), sin(kt) = ±1
        sin_val = k > 0 ? 1 : -1
        
        # f'(t) = m*sin^(m-1)(kt)*cos(kt)*k
        # f''(t) = m*k*[(m-1)*sin^(m-2)(kt)*cos^2(kt)*k - sin^m(kt)*k]
        # At sin(kt)=±1, cos(kt)=0
        # f''(π/(2k)) = -m*k^2*sin^m(kt) = -m*k^2*(±1)^m
        
        ans = -m * k^2 * (sin_val^m)
        
        problem(
            question="Let \$f(t) = \\sin^{$(m)}($(k)t)\$. Find \$f''\\left(\\frac{\\pi}{$(2*abs(k))}\\right)\$.",
            answer=ans,
            difficulty=(2600, 3200),
            solution=steps(
                sol("Given", "f(t) = \\sin^{$(m)}($(k)t)"),
                "First derivative (chain rule): \$f'(t) = $(m)\\sin^{$(m-1)}($(k)t)\\cos($(k)t)\\cdot $(k)\$",
                "Second derivative (product + chain rule): \$f''(t) = $(m*k^2)[$(m-1)\\sin^{$(m-2)}($(k)t)\\cos^2($(k)t) - \\sin^{$(m)}($(k)t)]\$",
                "At \$t = \\frac{\\pi}{$(2*abs(k))}\$: \$\\sin($(k)t) = $(sin_val)\$, \$\\cos($(k)t) = 0\$",
                "Substitute to get \$f''\\left(\\frac{\\pi}{$(2*abs(k))}\\right) = $(m*k^2) \\cdot (-($(sin_val))^{$(m)}) = $(ans)\$",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Logarithmic differentiation with product (2700-3300)
        a = nonzero(2, 6)
        b = nonzero(2, 6)
        c = nonzero(2, 6)
        
        # y = x^a * (x+1)^b * (x+2)^c, find dy/dx at x=0
        # ln(y) = a*ln(x) + b*ln(x+1) + c*ln(x+2)
        # y'/y = a/x + b/(x+1) + c/(x+2)
        # At x=0: y(0) = 0^a * 1^b * 2^c = 0 if a > 0
        # But limit as x→0+: y'/y → a/x + b + c/2
        
        # Actually compute at x=1 for cleaner answer
        x0 = 1
        y0 = x0^a * (x0+1)^b * (x0+2)^c
        deriv_val = y0 * (a/x0 + b/(x0+1) + c/(x0+2))
        
        # Simplify: deriv_val = 1^a * 2^b * 3^c * (a + b/2 + c/3)
        ans = 2^b * 3^c * (a*6 + b*3 + c*2) // 6
        
        problem(
            question="Use logarithmic differentiation to find \$\\frac{dy}{dx}\$ at \$x = 1\$ for \$y = x^{$(a)}(x+1)^{$(b)}(x+2)^{$(c)}\$.",
            answer=ans,
            difficulty=(2700, 3300),
            solution=steps(
                sol("Given", "y = x^{$(a)}(x+1)^{$(b)}(x+2)^{$(c)}"),
                "Take natural log: \$\\ln(y) = $(a)\\ln(x) + $(b)\\ln(x+1) + $(c)\\ln(x+2)\$",
                "Differentiate: \$\\frac{1}{y}\\frac{dy}{dx} = \\frac{$(a)}{x} + \\frac{$(b)}{x+1} + \\frac{$(c)}{x+2}\$",
                "At \$x=1\$: \$y(1) = 1^{$(a)} \\cdot 2^{$(b)} \\cdot 3^{$(c)} = $(y0)\$",
                "Evaluate: \$\\frac{dy}{dx}\\bigg|_{x=1} = $(y0)\\left(\\frac{$(a)}{1} + \\frac{$(b)}{2} + \\frac{$(c)}{3}\\right)\$",
                sol("Answer", ans)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Parametric curve second derivative (3000-3500)
        a = nonzero(2, 5)
        b = nonzero(2, 5)
        t0 = nonzero(1, 4)
        
        # x = t^a, y = t^b
        # dy/dx = (dy/dt)/(dx/dt) = (b*t^(b-1))/(a*t^(a-1)) = (b/a)*t^(b-a)
        # d²y/dx² = d/dt[dy/dx] / (dx/dt) = [(b/a)(b-a)*t^(b-a-1)] / [a*t^(a-1)]
        #         = (b(b-a)/a²) * t^(b-2a)
        
        ans_numer = b * (b - a) * (t0^(b - 2*a))
        ans_denom = a^2
        
        if ans_numer % ans_denom == 0
            ans = ans_numer // ans_denom
        else
            ans = ans_numer / ans_denom
        end
        
        problem(
            question="For the parametric curve \$x = t^{$(a)}\$, \$y = t^{$(b)}\$, find \$\\frac{d^2y}{dx^2}\$ at \$t = $(t0)\$.",
            answer=ans,
            difficulty=(3000, 3500),
            solution=steps(
                sol("Given", "x = t^{$(a)}, \\quad y = t^{$(b)}"),
                "First derivative: \$\\frac{dy}{dx} = \\frac{dy/dt}{dx/dt} = \\frac{$(b)t^{$(b-1)}}{$(a)t^{$(a-1)}} = \\frac{$(b)}{$(a)}t^{$(b-a)}\$",
                "Second derivative: \$\\frac{d^2y}{dx^2} = \\frac{d}{dt}\\left[\\frac{dy}{dx}\\right] \\cdot \\frac{1}{dx/dt}\$",
                sol("", "\\frac{d^2y}{dx^2} = \\frac{\\frac{$(b)}{$(a)}\\cdot $(b-a) t^{$(b-a-1)}}{$(a)t^{$(a-1)}} = \\frac{$(b*(b-a))}{$(a^2)}t^{$(b-2*a)}"),
                "Substitute \$t = $(t0)\$",
                sol("Answer", ans)
            ),
            time=300
        )
        
    else
        # Related rates with challenging geometry (2800-3400)
        r0 = randint(5, 15)
        dr_dt = randint(2, 8)
        
        # Sphere: V = (4/3)πr³, dV/dt = 4πr²(dr/dt)
        # At r = r0, find dV/dt
        
        ans_coeff = 4 * r0^2 * dr_dt
        
        problem(
            question="A spherical balloon is being inflated so that its radius increases at a rate of \$$(dr_dt)\$ cm/s. At the instant when the radius is \$$(r0)\$ cm, at what rate (in cm³/s) is the volume increasing? Express your answer as a multiple of \$\\pi\$.",
            answer="$(ans_coeff)π",
            difficulty=(2800, 3400),
            solution=steps(
                sol("Volume formula", "V = \\frac{4}{3}\\pi r^3"),
                "Differentiate with respect to time: \$\\frac{dV}{dt} = 4\\pi r^2 \\frac{dr}{dt}\$",
                "Given: \$\\frac{dr}{dt} = $(dr_dt)\$ cm/s and \$r = $(r0)\$ cm",
                "Substitute: \$\\frac{dV}{dt} = 4\\pi ($(r0))^2 \\cdot $(dr_dt) = $(ans_coeff)\\pi\$ cm³/s",
                sol("Answer", "$(ans_coeff)\\pi")
            ),
            time=240
        )
    end
end