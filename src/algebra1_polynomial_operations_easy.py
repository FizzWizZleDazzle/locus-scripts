"""
algebra1 - polynomial_operations (easy)
Generated: 2026-02-22T03:58:43.200490
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Adding/subtracting monomials (1000-1100)
        coeff1 = nonzero(-9, 9)
        coeff2 = nonzero(-9, 9)
        power = randint(1, 3)
        
        term1 = coeff1 * x**power
        term2 = coeff2 * x**power
        ans = simplify(term1 + term2)
        
        return problem(
            question=f"Simplify: ${latex(term1)} + ({latex(term2)})$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Combine like terms with the same power of $x$",
                f"${coeff1} + ({coeff2}) = {coeff1 + coeff2}$",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Multiplying a monomial by a constant (1050-1150)
        const = nonzero(-8, 8)
        coeff = nonzero(-6, 6)
        power = randint(1, 3)
        
        term = coeff * x**power
        ans = simplify(const * term)
        
        return problem(
            question=f"Simplify: ${const} \\cdot ({latex(term)})$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Multiply the coefficients: ${const} \\cdot {coeff} = {const * coeff}$",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Adding three monomials, two like terms (1100-1200)
        coeff1 = nonzero(-7, 7)
        coeff2 = nonzero(-7, 7)
        coeff3 = nonzero(-7, 7)
        power1 = randint(1, 2)
        power2 = randint(1, 2)
        if power1 == power2:
            power2 = power1 + 1
        
        term1 = coeff1 * x**power1
        term2 = coeff2 * x**power2
        term3 = coeff3 * x**power1
        
        expr = term1 + term2 + term3
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify: ${latex(term1)} + {latex(term2)} + ({latex(term3)})$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Identify like terms: ${latex(term1)}$ and ${latex(term3)}$ both have $x^{power1}$",
                f"Combine: ${coeff1} + ({coeff3}) = {coeff1 + coeff3}$",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Distributing a monomial over a binomial (1200-1300)
        const = nonzero(-5, 5)
        a_coeff = nonzero(-6, 6)
        b_coeff = nonzero(-6, 6)
        
        binomial = a_coeff * x + b_coeff
        ans = expand(const * binomial)
        
        return problem(
            question=f"Expand: ${const}({latex(binomial)})$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Distribute ${const}$ to each term inside the parentheses",
                f"${const} \\cdot {latex(a_coeff * x)} = {latex(const * a_coeff * x)}$",
                f"${const} \\cdot ({b_coeff}) = {const * b_coeff}$",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    else:
        # Subtracting polynomials (1200-1300)
        a1 = nonzero(-6, 6)
        b1 = nonzero(-6, 6)
        a2 = nonzero(-6, 6)
        b2 = nonzero(-6, 6)
        
        poly1 = a1 * x + b1
        poly2 = a2 * x + b2
        ans = simplify(poly1 - poly2)
        
        return problem(
            question=f"Simplify: $({latex(poly1)}) - ({latex(poly2)})$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Distribute the negative sign: $({latex(poly1)}) + ({latex(-poly2)})$",
                f"Combine like terms for $x$: ${a1} - ({a2}) = {a1 - a2}$",
                f"Combine constants: ${b1} - ({b2}) = {b1 - b2}$",
                f"Answer: ${latex(ans)}$"
            )
        )

emit(generate())