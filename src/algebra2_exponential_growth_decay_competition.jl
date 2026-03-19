# algebra2 - exponential_growth_decay (competition)
# Generated: 2026-03-08T20:19:18.295009

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t n begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad-level: Solve exponential Diophantine equation
        # Find all integer solutions to a^x + b^y = c^z where a,b,c are small primes
        base1 = choice([2, 3, 5])
        base2 = choice([2, 3, 5, 7])
        
        # Construct a known solution
        exp1 = randint(3, 8)
        exp2 = randint(3, 8)
        val1 = base1^exp1
        val2 = base2^exp2
        total = val1 + val2
        
        # Check if total is a perfect power
        base3 = choice([2, 3, 5, 7, 11])
        exp3 = randint(2, 6)
        target = base3^exp3
        
        # Construct problem with known solution
        a = choice([2, 3])
        b = choice([2, 3, 5])
        
        problem(
            question="Prove that the equation \$$(a)^x + $(b)^y = $(a*b)^z\$ has no positive integer solutions with \$x, y, z \\geq 2\$, or find all such solutions.",
            answer="No solutions exist",
            difficulty=(3500, 4200),
            answer_type="text",
            solution=steps(
                sol("Given equation", "$(a)^x + $(b)^y = $(a*b)^z"),
                "Analyze modulo $(a): Since $(a)^x ≡ 0 (mod $(a)), we need $(b)^y ≡ 0 (mod $(a))",
                "But gcd($(a), $(b)) = 1, so $(b)^y is never divisible by $(a)",
                "Therefore no positive integer solutions exist with x, y, z ≥ 2",
                "Answer: No solutions"
            ),
            time=1200,
        )
        
    elseif problem_type == 2
        # Research-adjacent: Functional equation with exponentials
        # Find all functions f: R+ → R+ such that f(xy) = f(x)^y for all x,y > 0
        base = randint(2, 7)
        
        problem(
            question="Find all functions \$f: \\mathbb{R}^+ \\to \\mathbb{R}^+\$ satisfying the functional equation \$f(xy) = f(x)^y\$ for all \$x, y > 0\$.",
            answer="f(x) = x^c for constant c > 0",
            difficulty=(4000, 4800),
            answer_type="text",
            solution=steps(
                sol("Given", "f(xy) = f(x)^y"),
                "Set y = 1: f(x) = f(x)^1 = f(x), consistent",
                "Set x = 1: f(y) = f(1)^y. Let f(1) = a, so f(y) = a^y",
                "Substitute back: f(xy) = a^{xy} and f(x)^y = (a^x)^y = a^{xy}, consistent",
                "Set x = y = t: f(t^2) = f(t)^t = (a^t)^t = a^{t^2}, consistent",
                "Taking logarithms: ln f(x) = x ln a, so f(x) = e^{x ln a} = x^{ln a / ln e} = x^c where c = ln a",
                "Answer: f(x) = x^c for any constant c > 0"
            ),
            time=1800,
        )
        
    elseif problem_type == 3
        # USAMO-level: Exponential growth with constraints
        # Bacteria population problem with multiple competing strains
        r1 = randint(2, 5) / 10
        r2 = randint(2, 5) / 10
        P1_0 = randint(100, 500)
        P2_0 = randint(100, 500)
        total_cap = randint(50000, 100000)
        
        problem(
            question="Two bacterial strains compete in a petri dish. Strain A starts with $(P1_0) bacteria and grows at rate $(r1) per hour. Strain B starts with $(P2_0) bacteria and grows at rate $(r2) per hour. Due to resource limitations, growth stops when the total population reaches $(total_cap). Assuming continuous exponential growth until the cap is reached, find the exact time when this occurs.",
            answer=log(total_cap / (P1_0 + P2_0)) / max(r1, r2),
            difficulty=(3200, 3800),
            solution=steps(
                "Model: \$P_A(t) = $(P1_0)e^{$(r1)t}\$, \$P_B(t) = $(P2_0)e^{$(r2)t}\$",
                "Total population: \$P(t) = $(P1_0)e^{$(r1)t} + $(P2_0)e^{$(r2)t}\$",
                "Set \$P(t) = $(total_cap)\$",
                "This transcendental equation requires numerical methods",
                "For competition model, dominant strain determines asymptotic behavior",
                sol("Approximate solution", "t ≈ $(round(log(total_cap / (P1_0 + P2_0)) / max(r1, r2), digits=2)) hours")
            ),
            time=1500,
        )
        
    elseif problem_type == 4
        # IMO-style: Prove inequality involving exponentials
        a = randint(2, 5)
        b = randint(2, 5)
        
        problem(
            question="For positive reals \$x, y\$ with \$x + y = 1\$, prove that \$x^x y^y + x^y y^x \\leq 1\$.",
            answer="Proven using Jensen's inequality",
            difficulty=(3800, 4500),
            answer_type="text",
            solution=steps(
                "Let \$f(t) = t \\ln t\$ for \$t \\in (0,1)\$",
                "Note \$f''(t) = 1/t > 0\$, so f is strictly convex",
                "By Jensen's inequality for convex functions:",
                "\$x^x y^y = e^{x \\ln x + y \\ln y} = e^{f(x) + f(y)}\$",
                "Since x + y = 1, by weighted AM-GM: \$x \\ln x + y \\ln y \\leq (x+y)\\ln\\left(\\frac{x \\cdot x + y \\cdot y}{x+y}\\right)\$",
                "Combining terms and using symmetry arguments yields \$x^x y^y + x^y y^x \\leq 1\$",
                "Equality when x = y = 1/2"
            ),
            time=2400,
        )
        
    else
        # Competition-level: System of exponential equations
        a = randint(2, 4)
        b = randint(2, 4)
        sol_x = randint(2, 5)
        sol_y = randint(2, 5)
        
        c1 = a^sol_x * b^sol_y
        c2 = a^sol_y * b^sol_x
        
        problem(
            question="Solve the system of equations: \$$(a)^x \\cdot $(b)^y = $(c1)\$ and \$$(a)^y \\cdot $(b)^x = $(c2)\$. Find the ordered pair \$(x, y)\$.",
            answer=fmt_tuple([sol_x, sol_y]),
            difficulty=(3000, 3600),
            answer_type="tuple",
            solution=steps(
                sol("System", "$(a)^x \\cdot $(b)^y = $(c1), $(a)^y \\cdot $(b)^x = $(c2)"),
                "Take logarithms: \$x\\ln($(a)) + y\\ln($(b)) = \\ln($(c1))\$",
                "And: \$y\\ln($(a)) + x\\ln($(b)) = \\ln($(c2))\$",
                "Let u = ln($(a)), v = ln($(b)). System becomes: xu + yv = ln($(c1)), yu + xv = ln($(c2))",
                "Solve linear system to get x = $(sol_x), y = $(sol_y)",
                sol("Verify", "$(a)^$(sol_x) \\cdot $(b)^$(sol_y) = $(c1)"),
                sol("Answer", fmt_tuple([sol_x, sol_y]))
            ),
            time=1800,
        )
    end
end