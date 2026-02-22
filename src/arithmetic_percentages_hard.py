"""
arithmetic - percentages (hard)
Generated: 2026-02-22T03:44:11.779657
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Successive percentage changes
        initial = randint(50, 200) * 10
        pct1 = randint(10, 40)
        pct2 = randint(10, 40)
        increase_decrease = choice([
            (True, True),
            (True, False),
            (False, True),
            (False, False)
        ])
        
        after_first = initial * (1 + pct1/100) if increase_decrease[0] else initial * (1 - pct1/100)
        final = after_first * (1 + pct2/100) if increase_decrease[1] else after_first * (1 - pct2/100)
        
        verb1 = "increased" if increase_decrease[0] else "decreased"
        verb2 = "increases" if increase_decrease[1] else "decreases"
        
        ans = round(final, 2)
        
        return problem(
            question=f"A product's price {verb1} by ${pct1}\\%$ and then {verb2} by ${pct2}\\%$. If the original price was $\\${initial}$, what is the final price?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/percentages",
            solution=steps(
                f"Original price: $\\${initial}$",
                f"After first change: $\\${initial} \\times {1 + pct1/100 if increase_decrease[0] else 1 - pct1/100} = \\${round(after_first, 2)}$",
                f"After second change: $\\${round(after_first, 2)} \\times {1 + pct2/100 if increase_decrease[1] else 1 - pct2/100} = \\${ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Find original value after percentage change
        final_value = randint(40, 120) * 10
        pct_change = randint(15, 45)
        is_increase = choice([True, False])
        
        if is_increase:
            original = final_value / (1 + pct_change/100)
        else:
            original = final_value / (1 - pct_change/100)
        
        ans = round(original, 2)
        verb = "increase" if is_increase else "decrease"
        
        return problem(
            question=f"After a ${pct_change}\\%$ {verb}, a value becomes $${final_value}$. What was the original value?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="arithmetic/percentages",
            solution=steps(
                f"Let the original value be $x$",
                f"After ${pct_change}\\%$ {verb}: $x \\times {1 + pct_change/100 if is_increase else 1 - pct_change/100} = {final_value}$",
                f"$x = \\frac{{{final_value}}}{{{1 + pct_change/100 if is_increase else 1 - pct_change/100}}} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Percentage point vs percentage change
        initial_pct = randint(20, 60)
        point_change = randint(5, 20)
        final_pct = initial_pct + point_change
        
        pct_increase = (point_change / initial_pct) * 100
        ans = round(pct_increase, 2)
        
        return problem(
            question=f"A store's market share increased from ${initial_pct}\\%$ to ${final_pct}\\%$. What is the percentage increase in their market share?",
            answer=ans,
            difficulty=(1700, 1800),
            topic="arithmetic/percentages",
            solution=steps(
                f"Initial market share: ${initial_pct}\\%$",
                f"Final market share: ${final_pct}\\%$",
                f"Absolute change: ${final_pct} - {initial_pct} = {point_change}$ percentage points",
                f"Percentage increase: $\\frac{{{point_change}}}{{{initial_pct}}} \\times 100\\% = {ans}\\%$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Compound percentage problem with parts
        total = randint(300, 800)
        pct1 = randint(25, 45)
        pct2 = randint(15, 35)
        
        part1 = total * (pct1/100)
        part2 = total * (pct2/100)
        remaining = total - part1 - part2
        pct_remaining = (remaining / total) * 100
        
        ans = round(pct_remaining, 2)
        
        return problem(
            question=f"A budget of $\\${total}$ is allocated as follows: ${pct1}\\%$ for salaries and ${pct2}\\%$ for supplies. What percentage of the budget remains unallocated?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/percentages",
            solution=steps(
                f"Salaries: ${pct1}\\%$ of $\\${total}$ = $\\${round(part1, 2)}$",
                f"Supplies: ${pct2}\\%$ of $\\${total}$ = $\\${round(part2, 2)}$",
                f"Total allocated: $\\${round(part1 + part2, 2)}$",
                f"Remaining: $\\${total} - \\${round(part1 + part2, 2)} = \\${round(remaining, 2)}$",
                f"Percentage remaining: $\\frac{{{round(remaining, 2)}}}{{{total}}} \\times 100\\% = {ans}\\%$"
            ),
            calculator="scientific"
        )
    
    else:
        # Reverse percentage calculation with ratio
        ratio_a = randint(2, 5)
        ratio_b = randint(2, 5)
        if ratio_a == ratio_b:
            ratio_b += 1
        
        total_parts = ratio_a + ratio_b
        total_value = randint(30, 90) * 10
        
        value_a = total_value * (ratio_a / total_parts)
        value_b = total_value * (ratio_b / total_parts)
        
        pct_a = (value_a / total_value) * 100
        ans = round(pct_a, 2)
        
        return problem(
            question=f"Two investments total $\\${total_value}$ and are in the ratio ${ratio_a}:{ratio_b}$. What percentage of the total is the first investment?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="arithmetic/percentages",
            solution=steps(
                f"Ratio ${ratio_a}:{ratio_b}$ means ${ratio_a}$ parts to ${ratio_b}$ parts",
                f"Total parts: ${ratio_a} + {ratio_b} = {total_parts}$",
                f"First investment: $\\frac{{{ratio_a}}}{{{total_parts}}} \\times \\${total_value} = \\${round(value_a, 2)}$",
                f"Percentage: $\\frac{{{round(value_a, 2)}}}{{{total_value}}} \\times 100\\% = {ans}\\%$"
            ),
            calculator="scientific"
        )

emit(generate())