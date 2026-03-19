# arithmetic - order_of_operations (very_hard)
# Generated: 2026-03-08T19:51:18.190854

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/order_of_operations")
    
    # Competition to Olympiad level (2500-3500 ELO)
    # We'll create deeply nested expressions with multiple operations,
    # exponentiation, factorials, and clever algebraic identities
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Nested expression with exponentiation and factorial-like patterns
        # Construct: ((a^b - c^d) * e + f^g) / (h^i - j)
        a = randint(2, 5)
        b = randint(3, 5)
        c = randint(2, 4)
        d = randint(2, 4)
        e = randint(2, 8)
        f = randint(2, 4)
        g = randint(2, 4)
        h = randint(3, 6)
        i = randint(2, 3)
        j = randint(10, 30)
        
        # Ensure denominator is nonzero and reasonably sized
        denom = h^i - j
        for _attempt in 1:1000
            (abs(denom) < 5 || abs(denom) > 200) || break
            h = randint(3, 6)
            i = randint(2, 3)
            j = randint(10, 30)
            denom = h^i - j
        end
        
        numerator = (a^b - c^d) * e + f^g
        ans = numerator // denom
        
        question = "Evaluate: \\frac{($(a)^{$(b)} - $(c)^{$(d)}) \\cdot $(e) + $(f)^{$(g)}}{$(h)^{$(i)} - $(j)}"
        
        solution = steps(
            "Calculate exponents: \$$(a)^{$(b)} = $(a^b)\$, \$$(c)^{$(d)} = $(c^d)\$, \$$(f)^{$(g)} = $(f^g)\$, \$$(h)^{$(i)} = $(h^i)\$",
            "Evaluate parentheses: \$($(a^b) - $(c^d)) \\cdot $(e) = $(a^b - c^d) \\cdot $(e) = $((a^b - c^d) * e)\$",
            "Complete numerator: \$$(((a^b - c^d) * e)) + $(f^g) = $(numerator)\$",
            "Complete denominator: \$$(h^i) - $(j) = $(denom)\$",
            sol("Final division", "\\frac{$(numerator)}{$(denom)} = $(ans)")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2500, 2800),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Expression with multiple fraction operations and exponents
        # ((a/b)^c + (d/e)^f) * g - h^i
        a = randint(2, 9)
        b = randint(2, 4)
        c = randint(2, 3)
        d = randint(2, 9)
        e = randint(2, 4)
        f = randint(2, 3)
        g = randint(3, 12)
        h = randint(2, 5)
        i = randint(2, 4)
        
        # Compute with rationals
        term1 = (a // b)^c
        term2 = (d // e)^f
        sum_terms = term1 + term2
        product = sum_terms * g
        ans = product - h^i
        
        question = "Evaluate: \\left(\\left(\\frac{$(a)}{$(b)}\\right)^{$(c)} + \\left(\\frac{$(d)}{$(e)}\\right)^{$(f)}\\right) \\cdot $(g) - $(h)^{$(i)}"
        
        solution = steps(
            "Calculate powers: \$\\left(\\frac{$(a)}{$(b)}\\right)^{$(c)} = \\frac{$(a^c)}{$(b^c)}\$, \$\\left(\\frac{$(d)}{$(e)}\\right)^{$(f)} = \\frac{$(d^f)}{$(e^f)}\$",
            "Add fractions: \$\\frac{$(a^c)}{$(b^c)} + \\frac{$(d^f)}{$(e^f)} = $(term1 + term2)\$",
            "Multiply by $(g): \$$(sum_terms) \\cdot $(g) = $(product)\$",
            "Calculate \$$(h)^{$(i)} = $(h^i)\$",
            sol("Final subtraction", "$(product) - $(h^i) = $(ans)")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2700, 3000),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 3
        # Type 3: Complex nested expression with multiple groupings
        # a^(b+c) - d * (e^f + g) / h + i^j
        a = randint(2, 4)
        b = randint(2, 4)
        c = randint(1, 3)
        d = randint(2, 8)
        e = randint(2, 4)
        f = randint(2, 3)
        g = randint(5, 20)
        h = randint(2, 6)
        i = randint(2, 5)
        j = randint(2, 4)
        
        # Ensure division works nicely
        inner_sum = e^f + g
        for _attempt in 1:1000
            (d * inner_sum) % h != 0 || break
            h = randint(2, 6)
        end
        
        term1 = a^(b + c)
        term2 = (d * inner_sum) // h
        term3 = i^j
        ans = term1 - term2 + term3
        
        question = "Evaluate: $(a)^{$(b)+$(c)} - \\frac{$(d) \\cdot ($(e)^{$(f)} + $(g))}{$(h)} + $(i)^{$(j)}"
        
        solution = steps(
            "Evaluate exponent in base: \$$(a)^{$(b+c)} = $(a)^{$(b+c)} = $(term1)\$",
            "Calculate inner expression: \$$(e)^{$(f)} = $(e^f)\$, so \$$(e^f) + $(g) = $(inner_sum)\$",
            "Complete fraction: \$\\frac{$(d) \\cdot $(inner_sum)}{$(h)} = \\frac{$(d * inner_sum)}{$(h)} = $(term2)\$",
            "Calculate final term: \$$(i)^{$(j)} = $(term3)\$",
            sol("Combine all", "$(term1) - $(term2) + $(term3) = $(ans)")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2800, 3200),
            solution=solution,
            time=300
        )
        
    else
        # Type 4: Olympiad-style with pattern recognition
        # Expression like (a^b - a^c) / (a^d - a^e) * a^f where simplification reveals structure
        a = randint(2, 5)
        b = randint(4, 7)
        c = randint(2, 4)
        d = randint(3, 5)
        e = randint(1, 3)
        f = randint(2, 4)
        
        # Ensure c < b and e < d for positive differences
        if c >= b
            c = b - 2
        end
        if e >= d
            e = d - 2
        end
        
        numerator = a^b - a^c
        denominator = a^d - a^e
        
        # Factor and simplify
        num_factored = a^c * (a^(b-c) - 1)
        den_factored = a^e * (a^(d-e) - 1)
        
        ans_before_mult = (a^(b-c) - 1) // (a^(d-e) - 1) * a^(c - e)
        ans = ans_before_mult * a^f
        
        question = "Evaluate: \\frac{$(a)^{$(b)} - $(a)^{$(c)}}{$(a)^{$(d)} - $(a)^{$(e)}} \\cdot $(a)^{$(f)}"
        
        solution = steps(
            "Factor numerator: \$$(a)^{$(b)} - $(a)^{$(c)} = $(a)^{$(c)}($(a)^{$(b-c)} - 1) = $(a^c)($(a^(b-c) - 1)) = $(numerator)\$",
            "Factor denominator: \$$(a)^{$(d)} - $(a)^{$(e)} = $(a)^{$(e)}($(a)^{$(d-e)} - 1) = $(a^e)($(a^(d-e) - 1)) = $(denominator)\$",
            "Simplify fraction: \$\\frac{$(numerator)}{$(denominator)} = \\frac{$(a^(b-c) - 1)}{$(a^(d-e) - 1)} \\cdot $(a)^{$(c-e)} = $(ans_before_mult)\$",
            "Multiply by \$$(a)^{$(f)}\$: \$$(ans_before_mult) \\cdot $(a^f) = $(ans)\$",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3000, 3500),
            solution=solution,
            time=300
        )
    end
end