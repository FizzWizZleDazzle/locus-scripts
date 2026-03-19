# calculus - definite_integrals (competition)
# Generated: 2026-03-08T20:47:50.696502

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Symmetry-based integral with complex integrand (3500-4000)
        n = rand(2:5)
        m = rand(1:4)
        a = randint(2, 8)
        
        # Construct integrand: x^(2n+1) * sin^m(x) / (1 + e^(ax))
        # Key insight: use substitution u = -x to show symmetry
        integrand = x^(2*n + 1) * sin(x)^m / (1 + exp(a*x))
        
        # Answer is 0 due to odd function symmetry around origin
        ans = 0
        
        problem(
            question="Evaluate \\displaystyle\\int_{-\\pi}^{\\pi} \\frac{$(tex(x^(2*n+1) * sin(x)^m))}{1 + e^{$(a)x}} \\, dx",
            answer=ans,
            difficulty=(3500, 4000),
            solution=steps(
                "Let \$I = \\displaystyle\\int_{-\\pi}^{\\pi} \\frac{$(tex(x^(2*n+1) * sin(x)^m))}{1 + e^{$(a)x}} \\, dx\$",
                "Substitute \$u = -x\$, so \$du = -dx\$. When \$x = -\\pi\$, \$u = \\pi\$; when \$x = \\pi\$, \$u = -\\pi\$",
                "Then \$I = \\displaystyle\\int_{\\pi}^{-\\pi} \\frac{(-u)^{$(2*n+1)} \\sin^{$(m)}(-u)}{1 + e^{-$(a)u}} \\, (-du) = -\\displaystyle\\int_{-\\pi}^{\\pi} \\frac{(-1)^{$(2*n+1)} u^{$(2*n+1)} \\cdot (-1)^{$(m)} \\sin^{$(m)}(u)}{1 + e^{-$(a)u}} \\, du\$",
                "Note that \$\\frac{1}{1 + e^{-$(a)u}} = \\frac{e^{$(a)u}}{1 + e^{$(a)u}}\$",
                "So \$I = -(-1)^{$(2*n+1+m)} \\displaystyle\\int_{-\\pi}^{\\pi} \\frac{u^{$(2*n+1)} \\sin^{$(m)}(u) \\cdot e^{$(a)u}}{1 + e^{$(a)u}} \\, du\$",
                "Observe that \$\\frac{1}{1 + e^{$(a)x}} + \\frac{e^{$(a)x}}{1 + e^{$(a)x}} = 1\$",
                "Adding the original integral and its transformed version: \$2I = \\displaystyle\\int_{-\\pi}^{\\pi} $(tex(x^(2*n+1) * sin(x)^m)) \\left(\\frac{1}{1 + e^{$(a)x}} + \\frac{e^{$(a)x}}{1 + e^{$(a)x}}\\right) dx = \\displaystyle\\int_{-\\pi}^{\\pi} $(tex(x^(2*n+1) * sin(x)^m)) \\, dx\$",
                "Since \$$(tex(x^(2*n+1) * sin(x)^m))\$ is an odd function (odd power of \$x\$ times even/odd power of \$\\sin x\$ which is odd), this integral over a symmetric interval is 0",
                sol("Answer", 0)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Feynman's trick (differentiation under the integral sign) (3800-4500)
        a = randint(2, 6)
        b = randint(2, 5)
        
        # We want to compute ∫₀^∞ (sin(ax)/x) * e^(-bx) dx
        # Using Feynman: let I(t) = ∫₀^∞ (sin(ax)/x) * e^(-tx) dx
        # Then dI/dt = -∫₀^∞ sin(ax) * e^(-tx) dx = -a/(t²+a²)
        # I(∞) = 0, so I(b) = ∫ᵦ^∞ a/(t²+a²) dt = arctan(∞) - arctan(b/a) = π/2 - arctan(b/a)
        
        ans_expr = π/2 - atan(b//a)
        
        problem(
            question="Evaluate \\displaystyle\\int_{0}^{\\infty} \\frac{\\sin($(a)x)}{x} e^{-$(b)x} \\, dx",
            answer=ans_expr,
            difficulty=(3800, 4500),
            solution=steps(
                "Use Feynman's trick: Let \$I(t) = \\displaystyle\\int_{0}^{\\infty} \\frac{\\sin($(a)x)}{x} e^{-tx} \\, dx\$ for \$t > 0\$",
                "Differentiate under the integral: \$\\frac{dI}{dt} = -\\displaystyle\\int_{0}^{\\infty} \\sin($(a)x) e^{-tx} \\, dx\$",
                "Compute the integral using integration by parts twice or Laplace transform: \$\\displaystyle\\int_{0}^{\\infty} \\sin($(a)x) e^{-tx} \\, dx = \\frac{$(a)}{t^2 + $(a^2)}\$",
                "Thus \$\\frac{dI}{dt} = -\\frac{$(a)}{t^2 + $(a^2)}\$",
                "Integrate: \$I(t) = -\\arctan\\left(\\frac{t}{$(a)}\\right) + C\$",
                "As \$t \\to \\infty\$, \$I(t) \\to 0\$, so \$0 = -\\frac{\\pi}{2} + C\$, giving \$C = \\frac{\\pi}{2}\$",
                "Therefore \$I(t) = \\frac{\\pi}{2} - \\arctan\\left(\\frac{t}{$(a)}\\right)\$",
                sol("Answer", ans_expr)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Contour integration insight / residue-like approach (4000-4800)
        n = rand(3:6)
        
        # ∫₀^(π/2) sin^n(x) dx using reduction formula or Beta function
        # For sin^n(x) from 0 to π/2: if n even = (n-1)!!/n!! * π/2, if n odd = (n-1)!!/n!!
        
        if n % 2 == 0
            # Even: (n-1)(n-3)...1 / (n)(n-2)...2 * π/2
            num = prod(1:2:(n-1))
            den = prod(2:2:n)
            ans = π * num // (2 * den)
        else
            # Odd: (n-1)(n-3)...2 / (n)(n-2)...1
            num = prod(2:2:(n-1))
            den = prod(1:2:n)
            ans = num // den
        end
        
        problem(
            question="Evaluate \\displaystyle\\int_{0}^{\\pi/2} \\sin^{$(n)}(x) \\, dx using the Wallis-like reduction formula",
            answer=ans,
            difficulty=(4000, 4800),
            solution=steps(
                "Let \$I_n = \\displaystyle\\int_{0}^{\\pi/2} \\sin^n(x) \\, dx\$",
                "Use integration by parts: \$u = \\sin^{$(n-1)}(x)\$, \$dv = \\sin(x) dx\$",
                "Then \$I_n = [-\\sin^{$(n-1)}(x)\\cos(x)]_0^{\\pi/2} + $(n-1)\\displaystyle\\int_0^{\\pi/2} \\sin^{$(n-2)}(x)\\cos^2(x) dx\$",
                "The boundary term vanishes. Use \$\\cos^2(x) = 1 - \\sin^2(x)\$:",
                "\$I_n = $(n-1)I_{$(n-2)} - $(n-1)I_n\$",
                "Solve for \$I_n\$: \$I_n = \\frac{$(n-1)}{$(n)} I_{$(n-2)}\$",
                n % 2 == 0 ? 
                    "Apply recursively down to \$I_0 = \\pi/2\$: \$I_{$(n)} = \\frac{$(n-1)}{$(n)} \\cdot \\frac{$(n-3)}{$(n-2)} \\cdots \\frac{1}{2} \\cdot \\frac{\\pi}{2}\$" :
                    "Apply recursively down to \$I_1 = 1\$: \$I_{$(n)} = \\frac{$(n-1)}{$(n)} \\cdot \\frac{$(n-3)}{$(n-2)} \\cdots \\frac{2}{3} \\cdot 1\$",
                sol("Answer", ans)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Leibniz integral rule with parameter (3600-4200)
        a = randint(2, 5)
        k = randint(1, 3)
        
        # Evaluate d/da ∫₀^a x^k e^(-x²) dx at specific a
        # By Leibniz: d/da = a^k e^(-a²)
        
        eval_a = randint(1, 4)
        ans = eval_a^k * exp(-eval_a^2)
        
        problem(
            question="Let \$F(a) = \\displaystyle\\int_{0}^{a} x^{$(k)} e^{-x^2} \\, dx\$. Find \$F'($(eval_a))\$",
            answer=ans,
            difficulty=(3600, 4200),
            solution=steps(
                "Apply the Leibniz integral rule for differentiation under the integral sign with variable limits:",
                "\$F'(a) = \\frac{d}{da}\\left[\\displaystyle\\int_{0}^{a} x^{$(k)} e^{-x^2} \\, dx\\right]\$",
                "By the fundamental theorem of calculus (since upper limit depends on \$a\$):",
                "\$F'(a) = a^{$(k)} e^{-a^2} \\cdot \\frac{da}{da} - 0^{$(k)} e^{0} \\cdot \\frac{d(0)}{da} = a^{$(k)} e^{-a^2}\$",
                "Evaluate at \$a = $(eval_a)\$:",
                sol("F'($(eval_a))", ans)
            ),
            time=180
        )
        
    else
        # King property / functional equation approach (4200-5000)
        # ∫₀^(π/2) f(sin x) dx = ∫₀^(π/2) f(cos x) dx (King property)
        # Use this to evaluate ∫₀^(π/2) sin^p(x) / (sin^p(x) + cos^p(x)) dx = π/4
        
        p = rand(2:6)
        ans = π // 4
        
        problem(
            question="Evaluate \\displaystyle\\int_{0}^{\\pi/2} \\frac{\\sin^{$(p)}(x)}{\\sin^{$(p)}(x) + \\cos^{$(p)}(x)} \\, dx",
            answer=ans,
            difficulty=(4200, 5000),
            solution=steps(
                "Let \$I = \\displaystyle\\int_{0}^{\\pi/2} \\frac{\\sin^{$(p)}(x)}{\\sin^{$(p)}(x) + \\cos^{$(p)}(x)} \\, dx\$",
                "Apply the substitution \$u = \\frac{\\pi}{2} - x\$, so \$du = -dx\$. When \$x=0\$, \$u=\\frac{\\pi}{2}\$; when \$x=\\frac{\\pi}{2}\$, \$u=0\$",
                "\$I = \\displaystyle\\int_{\\pi/2}^{0} \\frac{\\sin^{$(p)}(\\pi/2 - u)}{\\sin^{$(p)}(\\pi/2 - u) + \\cos^{$(p)}(\\pi/2 - u)} \\, (-du)\$",
                "Using \$\\sin(\\pi/2 - u) = \\cos(u)\$ and \$\\cos(\\pi/2 - u) = \\sin(u)\$:",
                "\$I = \\displaystyle\\int_{0}^{\\pi/2} \\frac{\\cos^{$(p)}(u)}{\\cos^{$(p)}(u) + \\sin^{$(p)}(u)} \\, du\$",
                "Add the two expressions for \$I\$:",
                "\$2I = \\displaystyle\\int_{0}^{\\pi/2} \\frac{\\sin^{$(p)}(x) + \\cos^{$(p)}(x)}{\\sin^{$(p)}(x) + \\cos^{$(p)}(x)} \\, dx = \\displaystyle\\int_{0}^{\\pi/2} 1 \\, dx = \\frac{\\pi}{2}\$",
                sol("Answer", ans)
            ),
            time=210
        )
    end
end