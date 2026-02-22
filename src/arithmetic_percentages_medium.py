"""
arithmetic - percentages (medium)
Generated: 2026-02-22T03:43:44.551959
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find percentage of a number (1200-1400)
        percent = choice([10, 15, 20, 25, 30, 40, 50, 60, 75, 80])
        number = choice([20, 25, 40, 50, 60, 80, 100, 120, 150, 200])
        ans = Rational(percent * number, 100)
        
        return problem(
            question=f"What is ${percent}\\%$ of ${number}$?",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/percentages",
            solution=steps(
                f"Convert ${percent}\\%$ to decimal: ${Rational(percent, 100)}$",
                f"Multiply: ${Rational(percent, 100)} \\times {number} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # What percent is X of Y (1300-1400)
        divisor = choice([4, 5, 10, 20, 25, 50])
        multiplier = randint(1, divisor - 1)
        total = divisor * choice([4, 5, 8, 10, 20])
        part = multiplier * choice([4, 5, 8, 10, 20])
        
        ans = Rational(part * 100, total)
        
        return problem(
            question=f"${part}$ is what percent of ${total}$?",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/percentages",
            solution=steps(
                f"Set up ratio: $\\frac{{{part}}}{{{total}}}$",
                f"Multiply by $100$ to get percentage: $\\frac{{{part}}}{{{total}}} \\times 100 = {ans}\\%$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Percent increase/decrease (1400-1500)
        original = choice([50, 80, 100, 120, 150, 200, 250])
        percent_change = choice([10, 15, 20, 25, 30, 40, 50])
        increase = choice([True, False])
        
        if increase:
            ans = original * (1 + Rational(percent_change, 100))
            action = "increase"
        else:
            ans = original * (1 - Rational(percent_change, 100))
            action = "decrease"
        
        return problem(
            question=f"A quantity is initially ${original}$. After a ${percent_change}\\%$ {action}, what is the new value?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/percentages",
            solution=steps(
                f"Calculate the change: ${original} \\times {Rational(percent_change, 100)} = {original * Rational(percent_change, 100)}$",
                f"{'Add' if increase else 'Subtract'} from original: ${original} {'+' if increase else '-'} {original * Rational(percent_change, 100)} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Find original price before discount (1400-1600)
        discount_percent = choice([10, 20, 25, 30, 40, 50])
        final_price = choice([45, 60, 72, 80, 90, 120, 150, 180])
        
        # Work backwards: final = original * (1 - discount/100)
        ans = Rational(final_price * 100, 100 - discount_percent)
        
        return problem(
            question=f"After a ${discount_percent}\\%$ discount, an item costs $\\${final_price}$. What was the original price?",
            answer=ans,
            difficulty=(1500, 1600),
            topic="arithmetic/percentages",
            solution=steps(
                f"If the discount is ${discount_percent}\\%$, then ${100 - discount_percent}\\%$ of the original price equals $\\${final_price}$",
                f"Set up equation: ${Rational(100 - discount_percent, 100)} \\times \\text{{original}} = {final_price}$",
                f"Solve: $\\text{{original}} = \\frac{{{final_price}}}{{{Rational(100 - discount_percent, 100)}}} = \\${ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Percent change calculation (1400-1500)
        old_value = choice([40, 50, 60, 80, 100, 120, 150, 200])
        increase = choice([True, False])
        
        if increase:
            change = choice([10, 12, 15, 20, 24, 25, 30, 40, 50])
        else:
            change = choice([8, 10, 12, 15, 20, 24, 25, 30])
        
        new_value = old_value + change if increase else old_value - change
        ans = Rational(abs(change) * 100, old_value)
        
        return problem(
            question=f"A value changes from ${old_value}$ to ${new_value}$. What is the percent {'increase' if increase else 'decrease'}?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/percentages",
            solution=steps(
                f"Find the change: ${new_value} - {old_value} = {change if increase else -change}$",
                f"Divide by original and multiply by $100$: $\\frac{{{abs(change)}}}{{{old_value}}} \\times 100 = {ans}\\%$"
            ),
            calculator="scientific"
        )

emit(generate())