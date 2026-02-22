"""
arithmetic - decimals (hard)
Generated: 2026-02-22T03:43:07.935581
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Multi-step decimal operations with order of operations
        a = round(uniform(1.5, 9.9), 2)
        b = round(uniform(1.2, 5.8), 2)
        c = round(uniform(0.5, 3.9), 2)
        d = round(uniform(1.1, 4.5), 2)
        
        ans = round(a * b - c * d, 2)
        
        return problem(
            question=f"Calculate: ${a} \\times {b} - {c} \\times {d}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/decimals",
            solution=steps(
                f"First, multiply: ${a} \\times {b} = {round(a*b, 2)}$",
                f"Then multiply: ${c} \\times {d} = {round(c*d, 2)}$",
                f"Finally subtract: ${round(a*b, 2)} - {round(c*d, 2)} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Division with decimals resulting in repeating or terminating decimal
        dividend = round(uniform(5.5, 25.8), 2)
        divisor = round(uniform(0.15, 0.95), 2)
        
        ans = round(dividend / divisor, 2)
        
        return problem(
            question=f"Divide and round to two decimal places: ${dividend} \\div {divisor}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="arithmetic/decimals",
            solution=steps(
                f"Convert to whole numbers by multiplying both by 100: ${int(dividend*100)} \\div {int(divisor*100)}$",
                f"Calculate: ${dividend} \\div {divisor} = {round(dividend/divisor, 4)}$",
                f"Round to two decimal places: ${ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Complex fraction with decimals
        num1 = round(uniform(2.5, 8.9), 2)
        num2 = round(uniform(1.2, 5.7), 2)
        denom1 = round(uniform(0.3, 0.9), 2)
        denom2 = round(uniform(0.4, 0.8), 2)
        
        ans = round((num1 + num2) / (denom1 + denom2), 2)
        
        return problem(
            question=f"Calculate: $\\dfrac{{{num1} + {num2}}}{{{denom1} + {denom2}}}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="arithmetic/decimals",
            solution=steps(
                f"Add numerator: ${num1} + {num2} = {round(num1 + num2, 2)}$",
                f"Add denominator: ${denom1} + {denom2} = {round(denom1 + denom2, 2)}$",
                f"Divide: ${round(num1 + num2, 2)} \\div {round(denom1 + denom2, 2)} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Decimal powers and roots
        base = round(uniform(1.5, 4.5), 1)
        power = randint(3, 4)
        
        ans = round(base ** power, 2)
        
        return problem(
            question=f"Calculate ${base}^{power}$ and round to two decimal places.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="arithmetic/decimals",
            solution=steps(
                f"Multiply ${base}$ by itself {power} times",
                f"${base}^{power} = {ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Word problem with decimals
        price1 = round(uniform(12.50, 45.99), 2)
        price2 = round(uniform(8.25, 35.75), 2)
        qty1 = randint(3, 8)
        qty2 = randint(2, 6)
        discount_pct = choice([0.15, 0.20, 0.25])
        
        subtotal = round(qty1 * price1 + qty2 * price2, 2)
        discount = round(subtotal * discount_pct, 2)
        ans = round(subtotal - discount, 2)
        
        discount_display = int(discount_pct * 100)
        
        return problem(
            question=f"A customer buys {qty1} items at $\\${price1}$ each and {qty2} items at $\\${price2}$ each. If they receive a {discount_display}\\% discount on the total, what is the final price?",
            answer=ans,
            difficulty=(1800, 1900),
            topic="arithmetic/decimals",
            solution=steps(
                f"Cost of first items: ${qty1} \\times \\${price1} = \\${round(qty1*price1, 2)}$",
                f"Cost of second items: ${qty2} \\times \\${price2} = \\${round(qty2*price2, 2)}$",
                f"Subtotal: $\\${round(qty1*price1, 2)} + \\${round(qty2*price2, 2)} = \\${subtotal}$",
                f"Discount: ${discount_display}\\% \\text{{ of }} \\${subtotal} = \\${discount}$",
                f"Final price: $\\${subtotal} - \\${discount} = \\${ans}$"
            ),
            calculator="scientific"
        )

emit(generate())