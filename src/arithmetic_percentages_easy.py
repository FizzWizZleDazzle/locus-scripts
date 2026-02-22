"""
arithmetic - percentages (easy)
Generated: 2026-02-22T03:43:21.858613
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simple percentage of a number (1000-1100)
        whole = choice([10, 20, 25, 50, 100, 200])
        percent = choice([10, 20, 25, 50, 75])
        ans = whole * percent / 100
        
        return problem(
            question=f"What is ${percent}\\%$ of ${whole}$?",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/percentages",
            solution=steps(
                f"Convert ${percent}\\%$ to decimal: ${percent / 100}$",
                f"Multiply: ${whole} \\times {percent / 100} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Find what percentage one number is of another (1100-1200)
        whole = choice([20, 25, 50, 100, 200])
        percent = choice([10, 20, 25, 50, 75])
        part = whole * percent / 100
        
        return problem(
            question=f"${part}$ is what percent of ${whole}$?",
            answer=percent,
            difficulty=(1100, 1200),
            topic="arithmetic/percentages",
            solution=steps(
                f"Set up the equation: $\\frac{{{part}}}{{{whole}}} \\times 100\\%$",
                f"Calculate: ${part / whole} \\times 100 = {percent}\\%$"
            ),
        )
    
    elif problem_type == 3:
        # Simple increase/decrease by percentage (1200-1300)
        original = choice([50, 100, 200, 500])
        percent = choice([10, 20, 25, 50])
        increase = choice([True, False])
        
        change = original * percent / 100
        if increase:
            ans = original + change
            word = "increase"
            sign = "+"
        else:
            ans = original - change
            word = "decrease"
            sign = "-"
        
        return problem(
            question=f"${original}$ is {word}d by ${percent}\\%$. What is the new value?",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/percentages",
            solution=steps(
                f"Calculate ${percent}\\%$ of ${original}$: ${original} \\times {percent / 100} = {change}$",
                f"{word.capitalize()} the original: ${original} {sign} {change} = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Convert percentage to decimal (1000-1100)
        percent = choice([5, 10, 15, 20, 25, 30, 40, 50, 60, 75, 80])
        ans = percent / 100
        
        return problem(
            question=f"Convert ${percent}\\%$ to a decimal.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/percentages",
            solution=steps(
                f"Divide by $100$: ${percent} \\div 100 = {ans}$"
            ),
        )
    
    else:
        # Convert decimal to percentage (1000-1100)
        decimal_val = choice([0.1, 0.2, 0.25, 0.5, 0.75, 0.8])
        ans = decimal_val * 100
        
        return problem(
            question=f"Convert ${decimal_val}$ to a percentage.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/percentages",
            solution=steps(
                f"Multiply by $100$: ${decimal_val} \\times 100 = {ans}\\%$"
            ),
        )

emit(generate())