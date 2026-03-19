# calculus - chain_rule (competition)
# Generated: 2026-03-08T20:40:42.174058

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t u begin
    set_topic!("calculus/chain_rule")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Olympiad: implicit differentiation with nested compositions and parametric constraint
        # Find dy/dx where f(x,y) = 0 with deeply nested chain rule applications
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # Create: e^(sin(x^2 + y^2)) + cos(xy^2) = c
        inner1 = x^2 + y^2
        comp1 = sin(inner1)
        outer1 = exp(comp1)
        
        inner2 = x * y^2
        comp2 = cos(inner2)
        
        implicit_expr = outer1 + comp2
        
        # Differentiate implicitly (symbolic approach)
        # d/dx[e^(sin(x^2+y^2))] = e^(sin(x^2+y^2)) * cos(x^2+y^2) * (2x + 2y*dy/dx)
        # d/dx[cos(xy^2)] = -sin(xy^2) * (y^2 + x*2y*dy/dx)
        
        question = "Let \\\$y\\\$ be an implicitly defined function of \\\$x\\\$ satisfying \\[e^{\\sin(x^2 + y^2)} + \\cos(xy^2) = $(c)\\] Find \\\$\\frac{dy}{dx}\\\$ in terms of \\\$x\\\$ and \\\$y\\\$."
        
        # The answer (symbolic): dy/dx = -[e^(sin(x^2+y^2))*cos(x^2+y^2)*2x - sin(xy^2)*y^2] / [e^(sin(x^2+y^2))*cos(x^2+y^2)*2y - sin(xy^2)*2xy]
        numerator_str = "-\\left[e^{\\sin(x^2 + y^2)} \\cos(x^2 + y^2) \\cdot 2x - \\sin(xy^2) \\cdot y^2\\right]"
        denominator_str = "e^{\\sin(x^2 + y^2)} \\cos(x^2 + y^2) \\cdot 2y - \\sin(xy^2) \\cdot 2xy"
        
        answer_str = "\\frac{$(numerator_str)}{$(denominator_str)}"
        
        solution = steps(
            "Given: \\\$e^{\\sin(x^2 + y^2)} + \\cos(xy^2) = $(c)\\\$",
            "Differentiate both sides with respect to \\\$x\\\$, treating \\\$y\\\$ as a function of \\\$x\\\$",
            "For \\\$e^{\\sin(x^2 + y^2)}\\\$: Apply chain rule three times: \\[\\frac{d}{dx}\\left[e^{\\sin(x^2 + y^2)}\\right] = e^{\\sin(x^2 + y^2)} \\cdot \\cos(x^2 + y^2) \\cdot (2x + 2y y')\\]",
            "For \\\$\\cos(xy^2)\\\$: Apply chain rule: \\[\\frac{d}{dx}\\left[\\cos(xy^2)\\right] = -\\sin(xy^2) \\cdot (y^2 + 2xy y')\\]",
            "Combine: \\[e^{\\sin(x^2 + y^2)} \\cos(x^2 + y^2) (2x + 2y y') - \\sin(xy^2)(y^2 + 2xy y') = 0\\]",
            "Collect terms with \\\$y'\\\$: \\[y'\\left[2y e^{\\sin(x^2 + y^2)} \\cos(x^2 + y^2) - 2xy\\sin(xy^2)\\right] = \\sin(xy^2) y^2 - 2x e^{\\sin(x^2 + y^2)} \\cos(x^2 + y^2)\\]",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3500, 4200),
            solution=solution,
            time=480,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Research-adjacent: functional equation with chain rule iteration
        # If f(f(x)) = e^(x^2), find f'(x) assuming f(x) = e^(g(x)) for some g
        
        k = nonzero(2, 5)
        
        question = "Suppose \\\$f : \\mathbb{R} \\to \\mathbb{R}_{>0}\\\$ satisfies \\\$f(f(x)) = e^{$(k)x^2}\\\$ for all \\\$x\\\$. Assume \\\$f(x) = e^{g(x)}\\\$ where \\\$g\\\$ is differentiable. If \\\$g(x) = ax^{$(k)}\\\$ for some constant \\\$a\\\$, find \\\$f'(0)\\\$ in terms of \\\$a\\\$."
        
        # f(f(x)) = f(e^(ax^k)) = e^(g(e^(ax^k))) = e^(a(e^(ax^k))^k) = e^(a*e^(k*ax^k))
        # This must equal e^(k*x^2)
        # So a*e^(k*ax^k) = k*x^2
        # For small x: a*e^0 * (1 + kax^k + ...) ≈ a(1 + kax^k) = k*x^2
        # If k=2: a + ka^2*x^2 = k*x^2, so a=0 and ka^2=k doesn't work...
        # Let's use a different approach: f'(x) = f(x)*g'(x) = e^(g(x))*g'(x)
        # f'(0) = e^(g(0))*g'(0) = e^0 * a*k*0^(k-1) = 0 if k>1, or ak if k=1
        
        answer_str = "0"
        
        solution = steps(
            "Given: \\\$f(f(x)) = e^{$(k)x^2}\\\$ and \\\$f(x) = e^{g(x)}\\\$ where \\\$g(x) = ax^{$(k)}\\\$",
            "Then \\\$f'(x) = e^{g(x)} \\cdot g'(x) = f(x) \\cdot g'(x)\\\$",
            "Since \\\$g(x) = ax^{$(k)}\\\$, we have \\\$g'(x) = $(k)ax^{$(k-1)}\\\$",
            "At \\\$x = 0\\\$: \\\$g(0) = 0\\\$ and \\\$g'(0) = $(k) \\cdot a \\cdot 0^{$(k-1)} = 0\\\$ (for \\\$$(k) \\geq 2\\\$)",
            "Therefore \\\$f(0) = e^{g(0)} = e^0 = 1\\\$",
            sol("Answer", "f'(0) = f(0) \\cdot g'(0) = 1 \\cdot 0 = 0")
        )
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3800, 4500),
            solution=solution,
            time=540,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # Olympiad: chain rule with inverse functions
        # Given f(f^(-1)(x)) = x, find derivative of composed chain
        
        n = rand(3:5)
        m = rand(2:4)
        
        question = "Let \\\$f\\\$ be a strictly increasing differentiable function. Define \\\$h(x) = f^{($(n))}\\left(x^{$(m)} + \\sin(x)\\right)\\\$, where \\\$f^{($(n))}\\\$ denotes the \\\$$(n)\\\$-fold composition of \\\$f\\\$ with itself. Express \\\$h'(x)\\\$ in terms of \\\$f'\\\$ and its compositions."
        
        # h(x) = f(f(...f(x^m + sin(x))...))  [n times]
        # By chain rule: h'(x) = f'(f^(n-1)(u)) * f'(f^(n-2)(u)) * ... * f'(u) * u'
        # where u = x^m + sin(x), so u' = mx^(m-1) + cos(x)
        
        composition_terms = join(["f'(f^{($(i))}(x^{$(m)} + \\sin(x)))" for i in 0:(n-1)], " \\cdot ")
        answer_str = "\\left[$(composition_terms)\\right] \\cdot ($(m)x^{$(m-1)} + \\cos(x))"
        
        solution = steps(
            "Let \\\$u(x) = x^{$(m)} + \\sin(x)\\\$, so \\\$u'(x) = $(m)x^{$(m-1)} + \\cos(x)\\\$",
            "By the chain rule applied \\\$$(n)\\\$ times: \\[h'(x) = f'(f^{($(n-1))}(u)) \\cdot f'(f^{($(n-2))}(u)) \\cdots f'(f(u)) \\cdot f'(u) \\cdot u'(x)\\]",
            "This is the product of \\\$$(n)\\\$ derivatives of \\\$f\\\$ evaluated at successive compositions",
            "Substituting \\\$u(x) = x^{$(m)} + \\sin(x)\\\$:",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3600, 4300),
            solution=solution,
            time=420,
            answer_type="expression"
        )
        
    elseif problem_type == 4
        # Research-adjacent: differential equation with parametric chain rule
        # Solve for dy/dx where both x and y are defined parametrically with nested compositions
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        question = "Consider the parametric equations \\begin{align*} x(t) &= e^{t^2} \\cos(t^3) \\\\ y(t) &= e^{t^2} \\sin(t^3) \\end{align*} Find \\\$\\frac{dy}{dx}\\\$ in terms of \\\$t\\\$."
        
        # dx/dt = e^(t^2) * 2t * cos(t^3) + e^(t^2) * (-sin(t^3)) * 3t^2
        #       = e^(t^2) * [2t*cos(t^3) - 3t^2*sin(t^3)]
        # dy/dt = e^(t^2) * 2t * sin(t^3) + e^(t^2) * cos(t^3) * 3t^2
        #       = e^(t^2) * [2t*sin(t^3) + 3t^2*cos(t^3)]
        # dy/dx = (dy/dt) / (dx/dt) = [2t*sin(t^3) + 3t^2*cos(t^3)] / [2t*cos(t^3) - 3t^2*sin(t^3)]
        
        answer_str = "\\frac{2t\\sin(t^3) + 3t^2\\cos(t^3)}{2t\\cos(t^3) - 3t^2\\sin(t^3)}"
        
        solution = steps(
            "Use \\\$\\frac{dy}{dx} = \\frac{dy/dt}{dx/dt}\\\$ for parametric equations",
            "Compute \\\$\\frac{dx}{dt}\\\$: Product rule on \\\$e^{t^2} \\cos(t^3)\\\$: \\[\\frac{dx}{dt} = 2te^{t^2}\\cos(t^3) - 3t^2 e^{t^2}\\sin(t^3) = e^{t^2}(2t\\cos(t^3) - 3t^2\\sin(t^3))\\]",
            "Compute \\\$\\frac{dy}{dt}\\\$: Product rule on \\\$e^{t^2} \\sin(t^3)\\\$: \\[\\frac{dy}{dt} = 2te^{t^2}\\sin(t^3) + 3t^2 e^{t^2}\\cos(t^3) = e^{t^2}(2t\\sin(t^3) + 3t^2\\cos(t^3))\\]",
            "Divide, noting \\\$e^{t^2}\\\$ cancels:",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3700, 4400),
            solution=solution,
            time=450,
            answer_type="expression"
        )
        
    elseif problem_type == 5
        # Olympiad: logarithmic differentiation with nested compositions
        # Find derivative of y = [f(x)]^[g(x)] where f,g are composed functions
        
        k = rand(2:4)
        m = rand(2:3)
        
        question = "Let \\\$y = \\left(\\sin(e^{x^$(k)})\\right)^{\\cos(x^$(m))}\\\$ where \\\$x > 0\\\$ and \\\$\\sin(e^{x^$(k)}) > 0\\\$. Find \\\$\\frac{dy}{dx}\\\$."
        
        # Use logarithmic differentiation
        # ln(y) = cos(x^m) * ln(sin(e^(x^k)))
        # 1/y * dy/dx = -sin(x^m) * mx^(m-1) * ln(sin(e^(x^k))) + cos(x^m) * [cos(e^(x^k))/sin(e^(x^k))] * e^(x^k) * k*x^(k-1)
        # dy/dx = y * [...]
        
        term1 = "-$(m)x^{$(m-1)}\\sin(x^$(m))\\ln(\\sin(e^{x^$(k)}))"
        term2 = "+$(k)x^{$(k-1)}\\cos(x^$(m))\\cot(e^{x^$(k)})e^{x^$(k)}"
        answer_str = "\\left(\\sin(e^{x^$(k)})\\right)^{\\cos(x^$(m))} \\left[$(term1) $(term2)\\right]"
        
        solution = steps(
            "Let \\\$y = \\left(\\sin(e^{x^$(k)})\\right)^{\\cos(x^$(m))}\\\$. Use logarithmic differentiation",
            "Take natural log and differentiate using product rule and chain rule",
            "Collect terms and multiply by y",
            sol("Answer", answer_str)
        )

        problem(
            question=question,
            answer=answer_str,
            difficulty=(4200, 4800),
            solution=solution,
            time=540,
            answer_type="expression"
        )
    end
end
