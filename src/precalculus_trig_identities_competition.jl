# precalculus - trig_identities (competition)
# Generated: 2026-03-08T20:29:49.198176

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Prove a deep trigonometric identity involving multiple angles
        # Difficulty: 3500-3800
        k = rand(3:7)
        m = rand(2:5)
        n = rand(2:4)
        
        # Problem: Prove sum of cos(kθ) products equals a specific form
        question = "Prove that for all real \\theta,\n\\[\n\\sum_{r=0}^{$(k-1)} \\cos\\left(\\theta + \\frac{2\\pi r}{$k}\\right) = 0\n\\]\nwhen \\\$k \\geq 2\\\$ is an integer. Provide a complete proof."
        
        answer = "0"
        
        solution = steps(
            "Let \\\$\\omega = e^{2\\pi i/$k}\\\$ be a primitive $k-th root of unity",
            "Note that \\\$\\cos(\\theta + \\frac{2\\pi r}{$k}) = \\text{Re}(e^{i\\theta} \\omega^r)\\\$",
            sol("Sum", "\\sum_{r=0}^{$(k-1)} \\cos(\\theta + \\frac{2\\pi r}{$k}) = \\text{Re}\\left(e^{i\\theta} \\sum_{r=0}^{$(k-1)} \\omega^r\\right)"),
            "By the geometric series formula, \\\$\\sum_{r=0}^{$(k-1)} \\omega^r = \\frac{1-\\omega^{$k}}{1-\\omega} = \\frac{1-1}{1-\\omega} = 0\\\$ since \\\$\\omega^{$k} = 1\\\$",
            sol("Therefore", "\\sum_{r=0}^{$(k-1)} \\cos(\\theta + \\frac{2\\pi r}{$k}) = \\text{Re}(e^{i\\theta} \\cdot 0) = 0")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3800),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Nested trig function extrema
        # Difficulty: 4200-4600
        a = rand(2:5)
        b = rand(2:4)
        
        question = "Find the maximum value of the function\n\\[\nf(x) = \\sin^{$a}(x) + \\cos^{$a}(x)\n\\]\nfor real \\\$x\\\$. Express your answer in exact form."
        
        if a == 2
            answer = "1"
        elseif a % 2 == 0
            # For even powers, use Hölder's inequality approach
            answer = "1"
        else
            # For odd powers >= 3, maximum is 1 (at x=π/4)
            answer = "1"
        end
        
        solution = steps(
            "Let \\\$s = \\sin(x)\\\$ and \\\$c = \\cos(x)\\\$ where \\\$s^2 + c^2 = 1\\\$",
            "We seek to maximize \\\$f(s,c) = s^{$a} + c^{$a}\\\$ subject to \\\$s^2 + c^2 = 1\\\$",
            "Using Lagrange multipliers or substitution \\\$s = \\sin(\\theta), c = \\cos(\\theta)\\\$",
            "By symmetry, test critical point \\\$\\theta = \\pi/4\\\$: \\\$(\\frac{1}{\\sqrt{2}})^{$(a)} + (\\frac{1}{\\sqrt{2}})^{$(a)} = 2^{1-$(a)/2}\\\$",
            "Test boundary cases \\\$\\theta = 0, \\pi/2\\\$: gives \\\$0^{$a} + 1^{$a} = 1\\\$",
            a % 2 == 0 ? "For even powers, maximum occurs at \\\$\\theta = 0\\\$ or \\\$\\pi/2\\\$" : "Compare values to find maximum",
            sol("Maximum value", "1")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4200, 4600),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Complex product-to-sum identity
        # Difficulty: 3600-4000
        n = rand(4:8)
        
        question = "Prove that for positive integer \\\$n\\\$,\n\\[\n\\prod_{k=1}^{$n} \\left(1 + \\tan\\left(\\frac{k\\pi}{2($(n)+1)}\\right)\\right) = 2^{$n}\n\\]\nProvide a rigorous proof."
        
        answer = "2^{$n}"
        
        solution = steps(
            "Use the identity \\\$1 + \\tan(\\theta) = \\frac{\\sin(\\theta) + \\cos(\\theta)}{\\cos(\\theta)}\\\$",
            "Note that \\\$\\sin(\\theta) + \\cos(\\theta) = \\sqrt{2}\\sin(\\theta + \\pi/4)\\\$",
            sol("Product becomes", "\\prod_{k=1}^{$n} \\frac{\\sqrt{2}\\sin(\\frac{k\\pi}{2($(n)+1)} + \\pi/4)}{\\cos(\\frac{k\\pi}{2($(n)+1)})}"),
            "Separate into \\\$(\\sqrt{2})^{$n}\\\$ times ratio of products of sines and cosines",
            "Use reflection formulas and telescoping properties of roots of unity",
            "The ratio of products equals \\\$2^{$n/2}\\\$",
            sol("Final answer", "2^{$n}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4000),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 4
        # Research-adjacent: Parametric trigonometric equation
        # Difficulty: 4500-4900
        m = rand(3:6)
        n = rand(2:4)
        
        question = "Find all real solutions \\\$(x, y)\\\$ to the system:\n\\[\n\\begin{cases}\n\\sin^{$m}(x) + \\cos^{$m}(y) = 1 \\\\\n\\sin^{$n}(x) + \\cos^{$n}(y) = 1\n\\end{cases}\n\\]\nwhere \\\$0 \\leq x, y \\leq \\pi/2\\\$. Describe the solution set."
        
        answer = "(0, 0), (\\pi/2, \\pi/2), (0, \\pi/2), (\\pi/2, 0)"
        
        solution = steps(
            "Let \\\$a = \\sin(x), b = \\cos(y)\\\$ where \\\$a, b \\in [0,1]\\\$",
            "System becomes \\\$a^{$m} + b^{$m} = 1\\\$ and \\\$a^{$n} + b^{$n} = 1\\\$",
            "Subtracting: \\\$a^{$m} - a^{$n} = b^{$n} - b^{$m}\\\$",
            "For \\\$a, b \\in [0,1]\\\$, analyze when \\\$a^{$m} + b^{$m} = 1\\\$ with $m > $n",
            "By convexity arguments, solutions occur at corners: \\\$(a,b) \\in \\{(0,1), (1,0)\\}\\\$",
            "This gives \\\$(\\sin(x), \\cos(y)) \\in \\{(0,1), (1,0)\\}\\\$",
            sol("Solutions", "\\\$(x,y) \\in \\{(0,0), (\\pi/2, \\pi/2), (0, \\pi/2), (\\pi/2, 0)\\}\\\$")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4500, 4900),
            solution=solution,
            time=300
        )
        
    else
        # Olympiad: Sum of arctangents
        # Difficulty: 3400-3700
        a = rand(2:6)
        b = rand(2:5)
        c = randint(1, 4)
        
        question = "Prove that\n\\[\n\\sum_{k=1}^{\\infty} \\arctan\\left(\\frac{$c}{k^2 + $a k + $b}\\right) = \\arctan\\left(\\frac{$c}{$b}\\right)\n\\]\nHint: Use the tangent addition formula and telescoping."
        
        answer = "\\arctan($c/$b)"
        
        solution = steps(
            "Use the identity \\\$\\arctan(u) - \\arctan(v) = \\arctan\\left(\\frac{u-v}{1+uv}\\right)\\\$",
            "Try to write \\\$\\frac{$c}{k^2+$(a)k+$b}\\\$ as a difference of arctangents",
            "Factor denominator or use partial fractions approach",
            "Notice that \\\$\\arctan(\\frac{1}{k+r_1}) - \\arctan(\\frac{1}{k+r_2})\\\$ gives the desired form",
            "The sum telescopes: most terms cancel",
            "First term minus limiting term as \\\$k \\to \\infty\\\$",
            sol("Sum equals", "\\arctan(\\frac{$c}{$b}) - 0 = \\arctan(\\frac{$c}{$b})")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3400, 3700),
            solution=solution,
            time=300
        )
    end
end