# precalculus - unit_circle (very_hard)
# Generated: 2026-03-08T20:27:33.969156

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("precalculus/unit_circle")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Advanced sum-to-product identity on unit circle
        k = randint(3, 12)
        m = randint(2, 8)
        n = randint(1, 6)
        
        question = "Let \\(\\theta_1, \\theta_2, \\ldots, \\theta_{$(k)}\\) be equally spaced points on the unit circle starting at \\(\\theta_1 = 0\\). Prove that \\[\\sum_{j=1}^{$(k)} \\cos($(m)\\theta_j) = 0\\] where \\(\\theta_j = \\frac{2\\pi(j-1)}{$(k)}\\)."
        
        answer = 0
        
        solution_text = steps(
            "The equally spaced points are \\(\\theta_j = \\frac{2\\pi(j-1)}{$(k)}\\) for \\(j = 1, 2, \\ldots, $(k)\\)",
            "Using Euler's formula: \\(\\sum_{j=1}^{$(k)} \\cos($(m)\\theta_j) = \\text{Re}\\left(\\sum_{j=1}^{$(k)} e^{i$(m)\\theta_j}\\right)\\)",
            "This is a geometric series with first term 1 and ratio \\(r = e^{i$(m) \\cdot 2\\pi/$(k)}\\)",
            "The sum equals \\(\\frac{1 - r^{$(k)}}{1 - r} = \\frac{1 - e^{i$(m) \\cdot 2\\pi}}{1 - e^{i$(m) \\cdot 2\\pi/$(k)}} = \\frac{1 - 1}{1 - e^{i$(m) \\cdot 2\\pi/$(k)}} = 0\\)",
            sol("Answer", 0)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2800, 3200),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Nested trigonometric equation with multiple angles
        n = randint(3, 7)
        k = choice([3, 4, 5, 6, 8, 12])
        
        question = "Find the number of distinct solutions to \\[\\sin($(n)x) = \\cos(x)\\] in the interval \\([0, 2\\pi)\\)."
        
        # sin(nx) = cos(x) = sin(π/2 - x)
        # nx = π/2 - x + 2πk  OR  nx = π - (π/2 - x) + 2πk
        # nx + x = π/2 + 2πk  OR  nx - x = π/2 + 2πk
        # (n+1)x = π/2 + 2πk  OR  (n-1)x = π/2 + 2πk
        
        sols = Set()
        for k_val in -20:20
            x1 = (π/2 + 2π*k_val)/(n+1)
            x2 = (π/2 + 2π*k_val)/(n-1)
            if 0 <= x1 < 2π
                push!(sols, round(x1, digits=10))
            end
            if n != 1 && 0 <= x2 < 2π
                push!(sols, round(x2, digits=10))
            end
        end
        
        answer = length(sols)
        
        solution_text = steps(
            "Rewrite \\(\\cos(x) = \\sin(\\frac{\\pi}{2} - x)\\)",
            "Equation becomes \\(\\sin($(n)x) = \\sin(\\frac{\\pi}{2} - x)\\)",
            "General solution: \\($(n)x = \\frac{\\pi}{2} - x + 2\\pi k\\) or \\($(n)x = \\pi - (\\frac{\\pi}{2} - x) + 2\\pi k\\)",
            "Simplify: \\(x = \\frac{\\pi/2 + 2\\pi k}{$(n+1)}\\) or \\(x = \\frac{\\pi/2 + 2\\pi k}{$(n-1)}\\)",
            "Count solutions in \\([0, 2\\pi)\\) by testing integer values of \\(k\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Product of cosines using complex exponentials
        n = randint(4, 9)
        
        question = "Evaluate \\[\\prod_{k=1}^{$(n)} \\cos\\left(\\frac{k\\pi}{$(2*n+1)}\\right)\\]"
        
        # Product of cos(kπ/(2n+1)) for k=1 to n equals 1/2^n
        answer_num = 1
        answer_den = 2^n
        answer = answer_num // answer_den
        
        solution_text = steps(
            "Use the identity for Chebyshev polynomials: \\(\\prod_{k=1}^{n} \\cos\\left(\\frac{k\\pi}{2n+1}\\right) = \\frac{1}{2^n}\\)",
            "This follows from the roots of \\(U_n(x) = 0\\) where \\(U_n\\) is the Chebyshev polynomial of the second kind",
            "The cosines are related to roots of \\(\\sin((n+1)\\theta) = 0\\)",
            "After careful product evaluation using symmetry and complex exponentials",
            sol("Answer", "\\frac{1}{$(2^n)}")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3000, 3400),
            solution=solution_text,
            time=270
        )
        
    elseif problem_type == 4
        # System involving unit circle parametrization
        a = randint(2, 6)
        b = randint(2, 6)
        c = randint(1, 5)
        
        question = "Find all \\(\\theta \\in [0, 2\\pi)\\) such that the point \\((\\cos($(a)\\theta), \\sin($(b)\\theta))\\) lies on the line \\(y = x\\). How many such solutions exist?"
        
        # sin(bθ) = cos(aθ) = sin(π/2 - aθ)
        # bθ = π/2 - aθ + 2πk  OR  bθ = π - (π/2 - aθ) + 2πk
        sols = Set()
        for k_val in -30:30
            x1 = (π/2 + 2π*k_val)/(a+b)
            x2 = (π/2 + 2π*k_val)/(b-a)
            if 0 <= x1 < 2π
                push!(sols, round(x1, digits=10))
            end
            if b != a && 0 <= x2 < 2π
                push!(sols, round(x2, digits=10))
            end
        end
        
        answer = length(sols)
        
        solution_text = steps(
            "Condition \\(y = x\\) gives \\(\\sin($(b)\\theta) = \\cos($(a)\\theta)\\)",
            "Rewrite as \\(\\sin($(b)\\theta) = \\sin(\\frac{\\pi}{2} - $(a)\\theta)\\)",
            "General solution: \\($(b)\\theta = \\frac{\\pi}{2} - $(a)\\theta + 2\\pi k\\) or \\($(b)\\theta = \\pi - (\\frac{\\pi}{2} - $(a)\\theta) + 2\\pi k\\)",
            "Solve for \\(\\theta\\) and count solutions in \\([0, 2\\pi)\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2700, 3100),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 5
        # Maximum/minimum of trigonometric combination
        a = randint(3, 9)
        b = randint(2, 8)
        c = randint(1, 7)
        
        question = "Find the maximum value of \\[f(\\theta) = $(a)\\sin(\\theta) + $(b)\\cos(\\theta) + $(c)\\]"
        
        # Max of a*sin + b*cos is sqrt(a^2 + b^2)
        max_trig = sqrt(a^2 + b^2)
        answer = max_trig + c
        
        solution_text = steps(
            "Express \\($(a)\\sin(\\theta) + $(b)\\cos(\\theta)\\) as \\(R\\sin(\\theta + \\phi)\\)",
            "Where \\(R = \\sqrt{$(a)^2 + $(b)^2} = \\sqrt{$(a^2 + b^2)}\\)",
            "Maximum of \\(R\\sin(\\theta + \\phi)\\) is \\(R = \\sqrt{$(a^2 + b^2)}\\)",
            "Adding constant \\($(c)\\): maximum is \\(\\sqrt{$(a^2 + b^2)} + $(c)\\)",
            sol("Answer", "\\sqrt{$(a^2 + b^2)} + $(c)")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2500, 2900),
            solution=solution_text,
            time=180
        )
        
    else
        # Complex number on unit circle with power
        n = randint(5, 15)
        k = randint(2, n-1)
        
        question = "Let \\(z = e^{2\\pi i/$(n)}\\) be a primitive \\($(n)\\)-th root of unity. Compute \\[\\sum_{j=0}^{$(n-1)} z^{$(k)j}\\]"
        
        # Geometric series sum with ratio z^k
        # If k and n are coprime, sum is 0
        # Otherwise sum is n/gcd(k,n)
        g = gcd(k, n)
        if g == 1
            answer = 0
        else
            answer = n ÷ g
        end
        
        solution_text = steps(
            "This is a geometric series with first term 1 and ratio \\(r = z^{$(k)} = e^{2\\pi i \\cdot $(k)/$(n)}\\)",
            "Sum \\(= \\frac{1 - (z^{$(k)})^{$(n)}}{1 - z^{$(k)}} = \\frac{1 - z^{$(k*n)}}{1 - z^{$(k)}}\\)",
            "Since \\(z^{$(n)} = 1\\), we have \\(z^{$(k*n)} = (z^{$(n)})^{$(k)} = 1^{$(k)} = 1\\)",
            "If \\(\\gcd($(k), $(n)) = $(g)\\), then \\(z^{$(k)}\\) is a primitive \\($(n÷g)\\)-th root of unity",
            g == 1 ? "Since \\(\\gcd($(k), $(n)) = 1\\), sum equals 0" : "Sum equals \\($(n÷g)\\) by counting multiplicities",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2900, 3300),
            solution=solution_text,
            time=240
        )
    end
end