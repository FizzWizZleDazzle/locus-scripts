# algebra2 - rational_expressions (easy)
# Generated: 2026-03-08T20:15:40.626009

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify a rational expression with common factors
        # ELO: 700-900
        root = nonzero(-8, 8)
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        
        numerator = expand(a * (x - root))
        denominator = expand((x - root) * (x - b))
        
        simplified_num = a
        simplified_den = x - b
        
        problem(
            question="Simplify: \$\\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer="$(tex(simplified_num))/$(tex(simplified_den))",
            difficulty=(700, 900),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: \$$(tex(a*(x - root)))\$",
                "Factor denominator: \$$(tex((x - root)*(x - b)))\$",
                "Cancel common factor \$(x - $(root))\$",
                sol("Answer", simplified_num / simplified_den)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Add two rational expressions with same denominator
        # ELO: 750-950
        den_lin = rand_linear(x; a=(-6,6), b=(-10,10))
        num1 = rand_linear(x; a=(-5,5), b=(-8,8))
        num2 = rand_linear(x; a=(-5,5), b=(-8,8))
        
        sum_num = simplify(num1.expr + num2.expr)
        
        problem(
            question="Add: \$\\frac{$(tex(num1.expr))}{$(tex(den_lin.expr))} + \\frac{$(tex(num2.expr))}{$(tex(den_lin.expr))}\$",
            answer="$(tex(sum_num))/$(tex(den_lin.expr))",
            difficulty=(750, 950),
            solution=steps(
                "Since denominators are equal, add numerators",
                sol("Numerator sum", num1.expr + num2.expr),
                sol("Simplified", sum_num),
                sol("Answer", sum_num / den_lin.expr)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Multiply two rational expressions
        # ELO: 800-1000
        root1 = nonzero(-7, 7)
        root2 = nonzero(-7, 7)
        a1 = nonzero(-4, 4)
        a2 = nonzero(-4, 4)
        
        while root1 == root2
            root2 = nonzero(-7, 7)
        end
        
        num1 = expand(a1 * (x - root1))
        den1 = expand(x - root2)
        num2 = expand(a2 * (x - root2))
        den2 = expand(x - root1)
        
        ans_num = a1 * a2
        ans_den = 1
        
        problem(
            question="Multiply and simplify: \$\\frac{$(tex(num1))}{$(tex(den1))} \\cdot \\frac{$(tex(num2))}{$(tex(den2))}\$",
            answer=ans_num,
            difficulty=(800, 1000),
            solution=steps(
                "Multiply numerators and denominators",
                sol("Product", (num1 * num2) / (den1 * den2)),
                "Factor and cancel \$(x - $(root1))\$ and \$(x - $(root2))\$",
                sol("Simplified", ans_num * ans_den),
                sol("Answer", ans_num)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Divide two rational expressions
        # ELO: 850-1050
        common = nonzero(-6, 6)
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        num1 = expand(a * (x - common))
        den1 = expand(x - b)
        num2 = expand(x - common)
        den2 = expand(x - c)
        
        ans_num = a * (x - c)
        ans_den = x - b
        
        problem(
            question="Divide and simplify: \$\\frac{$(tex(num1))}{$(tex(den1))} \\div \\frac{$(tex(num2))}{$(tex(den2))}\$",
            answer="$(tex(expand(ans_num)))/$(tex(ans_den))",
            difficulty=(850, 1050),
            solution=steps(
                "Multiply by reciprocal: \$\\frac{$(tex(num1))}{$(tex(den1))} \\cdot \\frac{$(tex(den2))}{$(tex(num2))}\$",
                "Factor and cancel common term \$(x - $(common))\$",
                sol("Numerator", expand(a * (x - c))),
                sol("Denominator", x - b),
                sol("Answer", expand(ans_num) / ans_den)
            ),
            time=110
        )
        
    else
        # Subtract rational expressions with different denominators
        # ELO: 900-1100
        b1 = nonzero(-6, 6)
        b2 = nonzero(-6, 6)
        
        while b1 == b2
            b2 = nonzero(-6, 6)
        end
        
        a1 = nonzero(-5, 5)
        a2 = nonzero(-5, 5)
        
        den1 = x - b1
        den2 = x - b2
        
        num1 = a1
        num2 = a2
        
        lcd = expand((x - b1) * (x - b2))
        
        new_num1 = expand(a1 * (x - b2))
        new_num2 = expand(a2 * (x - b1))
        
        final_num = simplify(new_num1 - new_num2)
        
        problem(
            question="Subtract: \$\\frac{$(a1)}{$(tex(den1))} - \\frac{$(a2)}{$(tex(den2))}\$",
            answer="$(tex(final_num))/$(tex(lcd))",
            difficulty=(900, 1100),
            solution=steps(
                "Find LCD: \$$(tex(lcd))\$",
                "First fraction: \$\\frac{$(tex(new_num1))}{$(tex(lcd))}\$",
                "Second fraction: \$\\frac{$(tex(new_num2))}{$(tex(lcd))}\$",
                "Subtract numerators: \$$(tex(new_num1)) - ($(tex(new_num2)))\$",
                sol("Answer", final_num / lcd)
            ),
            time=120
        )
    end
end