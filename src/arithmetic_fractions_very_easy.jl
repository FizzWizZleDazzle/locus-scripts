# arithmetic - fractions (very_easy)
# Generated: 2026-03-08T19:47:35.327056

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple fraction addition (same denominator) - ELO 300-500
        denom = randint(2, 12)
        num1 = randint(1, denom-1)
        num2 = randint(1, denom-1)
        ans = (num1 + num2) // denom
        
        problem(
            question="Add the fractions: \\(\\frac{$num1}{$denom} + \\frac{$num2}{$denom}\\)",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Since the denominators are the same, add the numerators",
                sol("\\frac{$num1}{$denom} + \\frac{$num2}{$denom} = \\frac{$(num1+num2)}{$denom}"),
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Simple fraction subtraction (same denominator) - ELO 300-500
        denom = randint(3, 12)
        num1 = randint(denom ÷ 2 + 1, denom-1)
        num2 = randint(1, num1-1)
        ans = (num1 - num2) // denom
        
        problem(
            question="Subtract the fractions: \\(\\frac{$num1}{$denom} - \\frac{$num2}{$denom}\\)",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Since the denominators are the same, subtract the numerators",
                sol("\\frac{$num1}{$denom} - \\frac{$num2}{$denom} = \\frac{$(num1-num2)}{$denom}"),
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Fraction multiplication - ELO 400-600
        num1 = randint(1, 8)
        denom1 = randint(2, 10)
        num2 = randint(1, 8)
        denom2 = randint(2, 10)
        ans = (num1 * num2) // (denom1 * denom2)
        
        problem(
            question="Multiply the fractions: \\(\\frac{$num1}{$denom1} \\times \\frac{$num2}{$denom2}\\)",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Multiply the numerators together and denominators together",
                sol("\\frac{$num1}{$denom1} \\times \\frac{$num2}{$denom2} = \\frac{$(num1*num2)}{$(denom1*denom2)}"),
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Simplifying fractions - ELO 400-600
        factor = randint(2, 6)
        simple_num = randint(1, 8)
        simple_denom = randint(simple_num+1, 12)
        num = simple_num * factor
        denom = simple_denom * factor
        ans = simple_num // simple_denom
        
        problem(
            question="Simplify the fraction: \\(\\frac{$num}{$denom}\\)",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Find the greatest common factor of $num and $denom, which is $factor",
                sol("\\frac{$num}{$denom} = \\frac{$num \\div $factor}{$denom \\div $factor} = \\frac{$simple_num}{$simple_denom}"),
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Fraction addition (different denominators) - ELO 500-700
        denom1 = randint(2, 6)
        denom2 = randint(2, 6)
        while denom1 == denom2
            denom2 = randint(2, 6)
        end
        num1 = randint(1, denom1-1)
        num2 = randint(1, denom2-1)
        lcd = lcm(denom1, denom2)
        new_num1 = num1 * (lcd ÷ denom1)
        new_num2 = num2 * (lcd ÷ denom2)
        ans = (new_num1 + new_num2) // lcd
        
        problem(
            question="Add the fractions: \\(\\frac{$num1}{$denom1} + \\frac{$num2}{$denom2}\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Find the least common denominator: LCD = $lcd",
                sol("\\frac{$num1}{$denom1} = \\frac{$new_num1}{$lcd} and \\frac{$num2}{$denom2} = \\frac{$new_num2}{$lcd}"),
                sol("\\frac{$new_num1}{$lcd} + \\frac{$new_num2}{$lcd} = \\frac{$(new_num1+new_num2)}{$lcd}"),
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Fraction division - ELO 500-700
        num1 = randint(1, 8)
        denom1 = randint(2, 10)
        num2 = randint(1, 8)
        denom2 = randint(2, 10)
        ans = (num1 * denom2) // (denom1 * num2)
        
        problem(
            question="Divide the fractions: \\(\\frac{$num1}{$denom1} \\div \\frac{$num2}{$denom2}\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "To divide fractions, multiply by the reciprocal of the second fraction",
                sol("\\frac{$num1}{$denom1} \\div \\frac{$num2}{$denom2} = \\frac{$num1}{$denom1} \\times \\frac{$denom2}{$num2}"),
                sol("\\frac{$num1}{$denom1} \\times \\frac{$denom2}{$num2} = \\frac{$(num1*denom2)}{$(denom1*num2)}"),
                sol("Answer", ans)
            ),
            time=120
        )
    end
end