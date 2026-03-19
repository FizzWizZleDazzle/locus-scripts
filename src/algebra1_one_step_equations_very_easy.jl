# algebra1 - one_step_equations (very_easy)
# Generated: 2026-03-08T19:52:00.821678

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # x + a = b (addition, ELO 400-600)
        ans = randint(-25, 25)
        a = randint(-30, 30)
        b = ans + a
        
        problem(
            question = "Solve for \\(x\\): \$x + $(a) = $(b)\$",
            answer = ans,
            difficulty = (400, 600),
            solution = steps(
                sol("Given", x + a ~ b),
                "Subtract $(a) from both sides",
                sol("Answer", x ~ ans)
            ),
            time = 45
        )
        
    elseif problem_type == 2
        # x - a = b (subtraction, ELO 400-600)
        ans = randint(-25, 25)
        a = randint(-30, 30)
        b = ans - a
        
        problem(
            question = "Solve for \\(x\\): \$x - $(a) = $(b)\$",
            answer = ans,
            difficulty = (400, 600),
            solution = steps(
                sol("Given", x - a ~ b),
                "Add $(a) to both sides",
                sol("Answer", x ~ ans)
            ),
            time = 45
        )
        
    elseif problem_type == 3
        # ax = b (multiplication, ELO 500-700)
        ans = randint(-20, 20)
        a = nonzero(-12, 12)
        b = a * ans
        
        problem(
            question = "Solve for \\(x\\): \$$(a)x = $(b)\$",
            answer = ans,
            difficulty = (500, 700),
            solution = steps(
                sol("Given", a*x ~ b),
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time = 50
        )
        
    elseif problem_type == 4
        # x/a = b (division, ELO 500-700)
        a = nonzero(-15, 15)
        b = randint(-20, 20)
        ans = a * b
        
        problem(
            question = "Solve for \\(x\\): \$\\frac{x}{$(a)} = $(b)\$",
            answer = ans,
            difficulty = (500, 700),
            solution = steps(
                sol("Given", x/a ~ b),
                "Multiply both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time = 50
        )
        
    elseif problem_type == 5
        # -x = a (negation, ELO 400-600)
        ans = randint(-30, 30)
        a = -ans
        
        problem(
            question = "Solve for \\(x\\): \$-x = $(a)\$",
            answer = ans,
            difficulty = (400, 600),
            solution = steps(
                sol("Given", -x ~ a),
                "Multiply both sides by -1",
                sol("Answer", x ~ ans)
            ),
            time = 40
        )
        
    else
        # Fractional coefficient: (a/b)x = c, answer is integer (ELO 600-700)
        ans = randint(-15, 15)
        num = nonzero(-8, 8)
        den = nonzero(2, 8)
        c_num = num * ans
        
        # Simplify the fraction c_num/den if possible
        g = gcd(abs(c_num), den)
        c_num_simplified = c_num ÷ g
        den_simplified = den ÷ g
        
        problem(
            question = "Solve for \\(x\\): \$\\frac{$(num)}{$(den)}x = \\frac{$(c_num_simplified)}{$(den_simplified)}\$",
            answer = ans,
            difficulty = (600, 700),
            solution = steps(
                "Given: \$\\frac{$(num)}{$(den)}x = \\frac{$(c_num_simplified)}{$(den_simplified)}\$",
                "Multiply both sides by \$\\frac{$(den)}{$(num)}\$",
                sol("Answer", x ~ ans)
            ),
            time = 60
        )
    end
end