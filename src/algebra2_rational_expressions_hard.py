"""
algebra2 - rational_expressions (hard)
Generated: 2026-02-22T04:24:03.925909
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplifying complex rational expressions with multiple terms
        a1 = nonzero(-5, 5)
        b1 = nonzero(-5, 5)
        a2 = nonzero(-5, 5)
        b2 = nonzero(-5, 5)
        
        # Create (a1*x + b1)/(x^2 - c^2) + (a2*x + b2)/(x^2 - c^2)
        c = randint(2, 5)
        denom = x**2 - c**2
        
        numer1 = a1*x + b1
        numer2 = a2*x + b2
        
        combined_numer = expand(numer1 + numer2)
        ans = simplify(combined_numer / denom)
        
        return problem(
            question=f"Simplify: $\\frac{{{latex(numer1)}}}{{{latex(denom)}}} + \\frac{{{latex(numer2)}}}{{{latex(denom)}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"The denominators are the same: ${latex(denom)}$",
                f"Add the numerators: ${latex(numer1)} + ({latex(numer2)}) = {latex(combined_numer)}$",
                f"Combined: $\\frac{{{latex(combined_numer)}}}{{{latex(denom)}}}$",
                f"Factor denominator: ${latex(factor(denom))}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Complex fraction (fraction divided by fraction)
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r1 == r2:
            r2 = nonzero(-4, 4)
        
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # (a*x + b)/(x - r1) divided by (x - r2)/(x + r1)
        numer_top = a*x + b
        denom_top = x - r1
        numer_bottom = x - r2
        denom_bottom = x + r1
        
        # Answer is (a*x + b)/(x - r1) * (x + r1)/(x - r2)
        result = simplify((numer_top * denom_bottom) / (denom_top * numer_bottom))
        ans = result
        
        return problem(
            question=f"Simplify: $\\frac{{\\frac{{{latex(numer_top)}}}{{{latex(denom_top)}}}}}{{\\frac{{{latex(numer_bottom)}}}{{{latex(denom_bottom)}}}}}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Rewrite as multiplication by the reciprocal:",
                f"$\\frac{{{latex(numer_top)}}}{{{latex(denom_top)}}} \\cdot \\frac{{{latex(denom_bottom)}}}{{{latex(numer_bottom)}}}$",
                f"Multiply: $\\frac{{({latex(numer_top)})({latex(denom_bottom)})}}{{({latex(denom_top)})({latex(numer_bottom)})}}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Subtracting rational expressions with different denominators
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r1 == r2 or r1 == -r2:
            r2 = nonzero(-5, 5)
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # a/(x - r1) - b/(x - r2)
        numer1 = a
        denom1 = x - r1
        numer2 = b
        denom2 = x - r2
        
        # LCD is (x - r1)(x - r2)
        lcd = expand((x - r1) * (x - r2))
        new_numer1 = expand(a * (x - r2))
        new_numer2 = expand(b * (x - r1))
        combined = expand(new_numer1 - new_numer2)
        
        ans = simplify(combined / lcd)
        
        return problem(
            question=f"Simplify: $\\frac{{{a}}}{{{latex(denom1)}}} - \\frac{{{b}}}{{{latex(denom2)}}}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Find LCD: $({latex(denom1)})({latex(denom2)}) = {latex(lcd)}$",
                f"Rewrite first fraction: $\\frac{{{a} \\cdot ({latex(x - r2)})}}{{{latex(lcd)}}} = \\frac{{{latex(new_numer1)}}}{{{latex(lcd)}}}$",
                f"Rewrite second fraction: $\\frac{{{b} \\cdot ({latex(x - r1)})}}{{{latex(lcd)}}} = \\frac{{{latex(new_numer2)}}}{{{latex(lcd)}}}$",
                f"Subtract: $\\frac{{{latex(new_numer1)} - ({latex(new_numer2)})}}{{{latex(lcd)}}} = \\frac{{{latex(combined)}}}{{{latex(lcd)}}}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Solving rational equations
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        r = nonzero(-5, 5)
        
        # (a*x + b)/(x - r) = c
        # Solving: a*x + b = c*(x - r)
        # a*x + b = c*x - c*r
        # a*x - c*x = -c*r - b
        # x(a - c) = -c*r - b
        
        if a == c:
            a += 1
        
        sol = (-c*r - b) / (a - c)
        ans = simplify(sol)
        
        return problem(
            question=f"Solve for $x$: $\\frac{{{latex(a*x + b)}}}{{{latex(x - r)}}} = {c}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Multiply both sides by $({latex(x - r)})$:",
                f"${latex(a*x + b)} = {c}({latex(x - r)})$",
                f"${latex(a*x + b)} = {latex(expand(c*(x - r)))}$",
                f"${latex(a*x)} - {latex(c*x)} = {-c*r} - {b}$",
                f"${latex((a-c)*x)} = {-c*r - b}$",
                f"$x = {latex(ans)}$"
            )
        )
    
    else:
        # Adding three rational expressions with different denominators
        r1 = randint(1, 4)
        r2 = randint(1, 4)
        while r2 == r1:
            r2 = randint(1, 4)
        r3 = randint(1, 4)
        while r3 == r1 or r3 == r2:
            r3 = randint(1, 4)
        
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # a/(x - r1) + b/(x - r2) + c/(x - r3)
        denom1 = x - r1
        denom2 = x - r2
        denom3 = x - r3
        
        lcd = expand((x - r1) * (x - r2) * (x - r3))
        
        term1 = expand(a * (x - r2) * (x - r3))
        term2 = expand(b * (x - r1) * (x - r3))
        term3 = expand(c * (x - r1) * (x - r2))
        
        combined = expand(term1 + term2 + term3)
        ans = simplify(combined / lcd)
        
        return problem(
            question=f"Simplify: $\\frac{{{a}}}{{{latex(denom1)}}} + \\frac{{{b}}}{{{latex(denom2)}}} + \\frac{{{c}}}{{{latex(denom3)}}}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Find LCD: ${latex(lcd)}$",
                f"First term: $\\frac{{{a}({latex((x-r2)*(x-r3))})}}{{{latex(lcd)}}} = \\frac{{{latex(term1)}}}{{{latex(lcd)}}}$",
                f"Second term: $\\frac{{{b}({latex((x-r1)*(x-r3))})}}{{{latex(lcd)}}} = \\frac{{{latex(term2)}}}{{{latex(lcd)}}}$",
                f"Third term: $\\frac{{{c}({latex((x-r1)*(x-r2))})}}{{{latex(lcd)}}} = \\frac{{{latex(term3)}}}{{{latex(lcd)}}}$",
                f"Combined numerator: ${latex(combined)}$",
                f"Answer: ${latex(ans)}$"
            )
        )

emit(generate())