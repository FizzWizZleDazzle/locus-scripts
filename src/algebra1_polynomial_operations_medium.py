"""
algebra1 - polynomial_operations (medium)
Generated: 2026-02-22T03:59:01.950964
"""

from problem_utils import *

def generate():
    problem_type = choice(['add_polynomials', 'subtract_polynomials', 'multiply_binomials', 'multiply_monomial'])
    
    if problem_type == 'add_polynomials':
        # (1300-1400 range) Add two polynomials with 2-3 terms each
        a1, a2, a3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        
        poly1 = a1*x**2 + a2*x + a3
        poly2 = b1*x**2 + b2*x + b3
        ans = simplify(poly1 + poly2)
        
        return problem(
            question=f"Add the polynomials: $({latex(poly1)}) + ({latex(poly2)})$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Combine like terms:",
                f"$x^2$ terms: ${a1} + {b1} = {a1+b1}$",
                f"$x$ terms: ${a2} + {b2} = {a2+b2}$",
                f"Constant terms: ${a3} + {b3} = {a3+b3}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'subtract_polynomials':
        # (1300-1500 range) Subtract two polynomials with 2-3 terms each
        a1, a2, a3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        
        poly1 = a1*x**2 + a2*x + a3
        poly2 = b1*x**2 + b2*x + b3
        ans = simplify(poly1 - poly2)
        
        return problem(
            question=f"Subtract the polynomials: $({latex(poly1)}) - ({latex(poly2)})$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Distribute the negative sign:",
                f"$({latex(poly1)}) - {b1}x^2 - ({b2})x - ({b3})$",
                f"Combine like terms:",
                f"$x^2$ terms: ${a1} - ({b1}) = {a1-b1}$",
                f"$x$ terms: ${a2} - ({b2}) = {a2-b2}$",
                f"Constant terms: ${a3} - ({b3}) = {a3-b3}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'multiply_binomials':
        # (1400-1600 range) Multiply two binomials using FOIL
        a1, a2 = nonzero(-7, 7), nonzero(-7, 7)
        b1, b2 = nonzero(-7, 7), nonzero(-7, 7)
        
        binom1 = a1*x + a2
        binom2 = b1*x + b2
        ans = expand(binom1 * binom2)
        
        first = a1 * b1
        outer = a1 * b2
        inner = a2 * b1
        last = a2 * b2
        
        return problem(
            question=f"Multiply: $({latex(binom1)})({latex(binom2)})$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Use FOIL method:",
                f"First: $({a1}x)({b1}x) = {first}x^2$",
                f"Outer: $({a1}x)({b2}) = {outer}x$",
                f"Inner: $({a2})({b1}x) = {inner}x$",
                f"Last: $({a2})({b2}) = {last}$",
                f"Combine like terms: ${first}x^2 + {outer+inner}x + {last}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    else:  # multiply_monomial
        # (1300-1400 range) Multiply monomial by polynomial
        coeff = nonzero(-6, 6)
        power = randint(1, 2)
        monomial = coeff * x**power
        
        a1, a2, a3 = nonzero(-6, 6), nonzero(-6, 6), nonzero(-6, 6)
        poly = a1*x**2 + a2*x + a3
        
        ans = expand(monomial * poly)
        
        return problem(
            question=f"Multiply: ${latex(monomial)}({latex(poly)})$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Distribute ${latex(monomial)}$ to each term:",
                f"${latex(monomial)} \\cdot {latex(a1*x**2)} = {latex(simplify(monomial * a1*x**2))}$",
                f"${latex(monomial)} \\cdot {latex(a2*x)} = {latex(simplify(monomial * a2*x))}$",
                f"${latex(monomial)} \\cdot {a3} = {latex(simplify(monomial * a3))}$",
                f"Result: ${latex(ans)}$"
            )
        )

emit(generate())