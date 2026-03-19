# algebra2 - radical_equations (competition)
# Generated: 2026-03-08T20:18:41.307038

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nested radicals with multiple solutions requiring algebraic number theory
        # ELO: 3500-4000
        a = randint(2, 5)
        b = randint(2, 4)
        c = randint(3, 8)
        
        # Construct: sqrt(x + sqrt(x + sqrt(x + ... ))) = a
        # Solution involves solving y = sqrt(x + y) where y = a
        # So a^2 = x + a, thus x = a^2 - a
        ans = a^2 - a
        
        question_text = "Let \\( y = \\sqrt{x + \\sqrt{x + \\sqrt{x + \\cdots}}} \\) (infinitely nested). If \\( y = $(a) \\), find the value of \\( x \\)."
        
        solution_text = steps(
            "Let \\( y = \\sqrt{x + \\sqrt{x + \\sqrt{x + \\cdots}}} \\)",
            "Since the expression is infinitely nested and self-similar, we have \\( y = \\sqrt{x + y} \\)",
            "Square both sides: \\( y^2 = x + y \\)",
            "Rearrange: \\( x = y^2 - y \\)",
            "Substitute \\( y = $(a) \\): \\( x = $(a)^2 - $(a) = $(a^2) - $(a) = $(ans) \\)",
            "Verify: \\( \\sqrt{$(ans) + $(a)} = \\sqrt{$(ans + a)} = $(a) \\) ✓",
            sol("Answer", ans)
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(3500, 4000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 2
        # System of radical equations with parametric solutions
        # ELO: 3800-4500
        k = randint(2, 6)
        m = randint(3, 7)
        
        # Construct: sqrt(x) + sqrt(y) = k, sqrt(x) - sqrt(y) = m
        # Solution: sqrt(x) = (k+m)/2, sqrt(y) = (k-m)/2
        # x = ((k+m)/2)^2, y = ((k-m)/2)^2
        
        sqrt_x = (k + m) // 2
        sqrt_y = (k - m) // 2
        
        if sqrt_y < 0
            # Adjust to ensure real solution
            k = randint(5, 10)
            m = randint(2, k-1)
            sqrt_x = (k + m) // 2
            sqrt_y = (k - m) // 2
        end
        
        ans_x = sqrt_x^2
        ans_y = sqrt_y^2
        
        question_text = "Solve the system of equations:\n\\[\n\\begin{cases}\n\\sqrt{x} + \\sqrt{y} = $(k) \\\\\n\\sqrt{x} - \\sqrt{y} = $(m)\n\\end{cases}\n\\]\nFind the sum \\( x + y \\)."
        
        ans = ans_x + ans_y
        
        solution_text = steps(
            "Let \\( u = \\sqrt{x} \\) and \\( v = \\sqrt{y} \\) where \\( u, v \\geq 0 \\)",
            "The system becomes: \\( u + v = $(k) \\) and \\( u - v = $(m) \\)",
            "Add equations: \\( 2u = $(k + m) \\), so \\( u = $(sqrt_x) \\)",
            "Subtract equations: \\( 2v = $(k - m) \\), so \\( v = $(sqrt_y) \\)",
            "Therefore \\( x = u^2 = $(ans_x) \\) and \\( y = v^2 = $(ans_y) \\)",
            "Sum: \\( x + y = $(ans_x) + $(ans_y) = $(ans) \\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=360
        )
        
    elseif problem_type == 3
        # Radical equation requiring substitution and quartic solving
        # ELO: 4000-4600
        p = randint(2, 5)
        q = randint(3, 8)
        
        # sqrt(x + sqrt(x)) = p requires solving a quartic
        # Let y = sqrt(x), then sqrt(y^2 + y) = p
        # So y^2 + y = p^2
        # y^2 + y - p^2 = 0
        # y = (-1 + sqrt(1 + 4p^2))/2
        
        discriminant = 1 + 4*p^2
        y_val = (-1 + sqrt(discriminant)) / 2
        ans = rationalize(y_val^2)
        
        # For cleaner problems, construct backwards
        a = randint(3, 12)
        target = a^2 - a  # This is x where sqrt(x) = a-1 and we want sqrt(x + sqrt(x))
        
        # Actually, let's use a different construction
        # If x = b(b+1) for integer b, then sqrt(x) + sqrt(x + sqrt(x)) has nice form
        b = randint(4, 15)
        ans = b * (b + 1)
        
        question_text = "Solve: \\( \\sqrt{x + 2\\sqrt{x}} + \\sqrt{x - 2\\sqrt{x}} = $(b) \\)"
        
        solution_text = steps(
            "Factor inside radicals: \\( \\sqrt{x + 2\\sqrt{x}} = \\sqrt{(\\sqrt{x} + 1)^2 - 1 + 1} \\)",
            "Note that \\( x + 2\\sqrt{x} = (\\sqrt{x})^2 + 2\\sqrt{x} \\cdot 1 + 1 - 1 = (\\sqrt{x} + 1)^2 - 1 + 1 \\)",
            "Similarly, recognize \\( x \\pm 2\\sqrt{x} = (\\sqrt{x} \\pm 1)^2 \\pm 1 \\mp 1 \\)",
            "Simplify to \\( \\sqrt{(\\sqrt{x}+1)^2} + \\sqrt{(\\sqrt{x}-1)^2} = |\\sqrt{x}+1| + |\\sqrt{x}-1| \\)",
            "For \\( x > 1 \\): \\( (\\sqrt{x}+1) + (\\sqrt{x}-1) = 2\\sqrt{x} = $(b) \\)",
            "Therefore \\( \\sqrt{x} = $(b//2) \\), so \\( x = $(ans) \\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(4000, 4600),
            solution=solution_text,
            time=420
        )
        
    elseif problem_type == 4
        # Functional equation with radicals (Olympiad style)
        # ELO: 4200-4800
        n = randint(3, 8)
        k = randint(2, 5)
        
        ans = n^2 * k
        
        question_text = "Find all positive real \\( x \\) such that:\n\\[\n\\sqrt{x} + \\sqrt{x + $(n)\\sqrt{x}} = $(n + k)\n\\]\nGive the value of \\( x \\)."
        
        solution_text = steps(
            "Let \\( u = \\sqrt{x} \\) where \\( u > 0 \\)",
            "Factor: \\( \\sqrt{x + $(n)\\sqrt{x}} = \\sqrt{u^2 + $(n)u} = \\sqrt{u(u + $(n))} \\)",
            "Equation becomes: \\( u + \\sqrt{u(u + $(n))} = $(n + k) \\)",
            "Rearrange: \\( \\sqrt{u(u + $(n))} = $(n + k) - u \\)",
            "Square: \\( u(u + $(n)) = ($(n + k))^2 - 2($(n + k))u + u^2 \\)",
            "Simplify: \\( u^2 + $(n)u = $(Int((n+k)^2)) - $(2*(n+k))u + u^2 \\)",
            "Solve: \\( $(n + 2*(n+k))u = $(Int((n+k)^2)) \\), so \\( u = $(k) \\)",
            "Therefore \\( x = u^2 = $(ans) \\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(4200, 4800),
            solution=solution_text,
            time=480
        )
        
    else
        # Radical Diophantine equation (research-adjacent)
        # ELO: 4500-5000
        a = randint(2, 4)
        b = randint(3, 6)
        c = randint(5, 12)
        
        # Find integer solutions to sqrt(x) + sqrt(y) = sqrt(c)
        # Requires x = m^2, y = n^2 where m + n = sqrt(c)
        # For integer solutions, c must be a perfect square
        c_sqrt = randint(4, 8)
        c = c_sqrt^2
        
        # Choose m, n such that m + n = c_sqrt
        m = randint(1, c_sqrt - 1)
        n = c_sqrt - m
        
        ans = m^2 + n^2
        
        question_text = "Find the sum of all positive integer pairs \\( (x, y) \\) satisfying:\n\\[\n\\sqrt{x} + \\sqrt{y} = $(c_sqrt), \\quad \\sqrt{xy} = $(m*n)\n\\]\nCalculate \\( x + y \\)."
        
        solution_text = steps(
            "From \\( \\sqrt{x} + \\sqrt{y} = $(c_sqrt) \\), let \\( \\sqrt{x} = a \\) and \\( \\sqrt{y} = b \\)",
            "System: \\( a + b = $(c_sqrt) \\) and \\( ab = $(m*n) \\)",
            "These are roots of \\( t^2 - $(c_sqrt)t + $(m*n) = 0 \\)",
            "By Vieta's formulas or quadratic formula: \\( t = \\frac{$(c_sqrt) \\pm \\sqrt{$(c_sqrt^2) - $(4*m*n)}}{2} \\)",
            "Calculate: \\( t = \\frac{$(c_sqrt) \\pm $(abs(c_sqrt^2 - 4*m*n))}{2} \\)",
            "Solutions: \\( a = $(m), b = $(n) \\) (or vice versa)",
            "Therefore \\( x = $(m^2), y = $(n^2) \\) and \\( x + y = $(ans) \\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(4500, 5000),
            solution=solution_text,
            time=540
        )
    end
end