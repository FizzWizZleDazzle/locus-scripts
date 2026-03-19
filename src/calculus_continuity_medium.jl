# calculus - continuity (medium)
# Generated: 2026-03-08T20:38:20.140010

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/continuity")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Type 1: Find value to make piecewise function continuous (1200-1400)
        a = randint(1, 5)
        b = randint(-8, 8)
        c = randint(-10, 10)
        
        # At x = c, need a*c + b = k for continuity
        k = a * c + b
        
        q_text = "Let \$f(x) = \\begin{cases} $(a)x + $(b) & \\text{if } x \\leq $(c) \\\\ k & \\text{if } x > $(c) \\end{cases}\$. Find the value of \$k\$ that makes \$f(x)\$ continuous at \$x = $(c)\$."
        
        problem(
            question=q_text,
            answer=k,
            difficulty=(1200, 1400),
            solution=steps(
                "For continuity at \$x = $(c)\$, we need \$\\lim_{x \\to $(c)^-} f(x) = \\lim_{x \\to $(c)^+} f(x) = f($(c))\$",
                sol("Left limit", substitute(a*x + b, x => c)),
                "Right limit equals \$k\$",
                sol("For continuity, k", k)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: Determine where rational function is discontinuous (1300-1500)
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        num_q = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-10,10))
        denom = expand((x - r1) * (x - r2))
        
        discontinuities = Set([r1, r2])
        
        q_text = "At what values of \$x\$ is \$f(x) = \\frac{$(tex(num_q.expr))}{$(tex(denom))}\$ discontinuous?"
        
        problem(
            question=q_text,
            answer=fmt_set(discontinuities),
            difficulty=(1300, 1500),
            answer_type="set",
            solution=steps(
                "A rational function is discontinuous where the denominator equals zero",
                sol("Set denominator to zero", denom ~ 0),
                "Factor: \$$(tex((x - r1)*(x - r2))) = 0\$",
                sol("Discontinuous at", fmt_set(discontinuities))
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Type 3: Find limit to determine if removable discontinuity (1400-1600)
        r = nonzero(-7, 7)
        a = nonzero(-6, 6)
        
        # Create (x - r)(x + a) / (x - r) which has removable discontinuity at x = r
        numerator = expand((x - r) * (x + a))
        denominator = x - r
        
        limit_value = r + a
        
        q_text = "Consider \$f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\$. Find \$\\lim_{x \\to $(r)} f(x)\$ if it exists."
        
        problem(
            question=q_text,
            answer=limit_value,
            difficulty=(1400, 1600),
            solution=steps(
                "Factor the numerator: \$$(tex((x - r)*(x + a)))\$",
                "Cancel common factor \$(x - $(r))\$ for \$x \\neq $(r)\$",
                sol("Simplified form", x + a),
                sol("Limit as x approaches $(r)", substitute(x + a, x => r))
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Type 4: Piecewise function - check continuity and find parameter (1500-1700)
        a = nonzero(2, 6)
        b = randint(-5, 5)
        c = randint(-8, 8)
        d = nonzero(1, 4)
        
        # At x = 0: need a*0^2 + b = c*0 + k, so k = b
        k = b
        
        q_text = "Let \$g(x) = \\begin{cases} $(a)x^2 + $(b) & \\text{if } x < 0 \\\\ $(c)x + k & \\text{if } x \\geq 0 \\end{cases}\$. For what value of \$k\$ is \$g(x)\$ continuous at \$x = 0\$?"
        
        problem(
            question=q_text,
            answer=k,
            difficulty=(1500, 1700),
            solution=steps(
                "For continuity at \$x = 0\$, we need \$\\lim_{x \\to 0^-} g(x) = g(0)\$",
                sol("Left-hand limit", substitute(a*x^2 + b, x => 0)),
                sol("Value at x = 0", c*0 + k),
                "Setting these equal: \$$(b) = k\$",
                sol("Answer", k)
            ),
            time=120
        )
        
    else
        # Type 5: Determine intervals of continuity (1600-1800)
        r = nonzero(-6, 6)
        
        # Function like sqrt(x - r) is continuous on [r, ∞)
        q_text = "On what interval is \$h(x) = \\sqrt{x - $(r)}\$ continuous?"
        
        ans = fmt_interval(r, Inf, false, true)
        
        problem(
            question=q_text,
            answer=ans,
            difficulty=(1600, 1800),
            answer_type="interval",
            solution=steps(
                "Square root function requires non-negative argument",
                sol("Require", x - r ≥ 0),
                sol("Solve inequality", x ≥ r),
                sol("Interval of continuity", ans)
            ),
            time=90
        )
    end
end