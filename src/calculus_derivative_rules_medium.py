"""
calculus - derivative_rules (medium)
Generated: 2026-02-22T05:02:45.892937
"""

from problem_utils import *

def generate():
    problem_type = choice(['power_rule', 'product_rule', 'quotient_rule', 'chain_rule', 'chain_product'])
    
    if problem_type == 'power_rule':
        # Standard polynomial derivative (1300-1400)
        num_terms = randint(2, 3)
        terms = []
        for _ in range(num_terms):
            coeff = nonzero(-8, 8)
            power = randint(2, 5)
            terms.append(coeff * x**power)
        
        # Add constant or linear term
        if choice([True, False]):
            terms.append(nonzero(-10, 10) * x)
        if choice([True, False]):
            terms.append(nonzero(-10, 10))
        
        expr = sum(terms)
        ans = diff(expr, x)
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Apply the power rule to each term of ${latex(expr)}$",
                f"For $x^n$, the derivative is $nx^{{n-1}}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'product_rule':
        # Product rule with two simple functions (1400-1500)
        power1 = randint(2, 4)
        power2 = randint(2, 4)
        coeff1 = nonzero(-5, 5)
        coeff2 = nonzero(-5, 5)
        
        f = coeff1 * x**power1
        g = coeff2 * x**power2
        expr = f * g
        
        f_prime = diff(f, x)
        g_prime = diff(g, x)
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the product rule: $(fg)' = f'g + fg'$",
                f"Let $f = {latex(f)}$ and $g = {latex(g)}$",
                f"Then $f' = {latex(f_prime)}$ and $g' = {latex(g_prime)}$",
                f"$(fg)' = ({latex(f_prime)})({latex(g)}) + ({latex(f)})({latex(g_prime)})$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'quotient_rule':
        # Quotient rule (1500-1600)
        power_num = randint(2, 3)
        power_den = randint(1, 2)
        coeff_num = nonzero(-6, 6)
        coeff_den = nonzero(-6, 6)
        
        numerator = coeff_num * x**power_num
        denominator = coeff_den * x**power_den
        
        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)
        
        ans = simplify(diff(numerator / denominator, x))
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[\\frac{{{latex(numerator)}}}{{{latex(denominator)}}}\\right]",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the quotient rule: $\\left(\\frac{{f}}{{g}}\\right)' = \\frac{{f'g - fg'}}{{g^2}}$",
                f"Let $f = {latex(numerator)}$ and $g = {latex(denominator)}$",
                f"Then $f' = {latex(num_prime)}$ and $g' = {latex(den_prime)}$",
                f"$\\frac{{({latex(num_prime)})({latex(denominator)}) - ({latex(numerator)})({latex(den_prime)})}}{{({latex(denominator)})^2}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'chain_rule':
        # Chain rule with polynomial inside (1400-1500)
        outer_power = randint(2, 4)
        inner_coeff = nonzero(-5, 5)
        inner_const = nonzero(-8, 8)
        
        inner = inner_coeff * x + inner_const
        expr = inner**outer_power
        
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the chain rule: $\\frac{{d}}{{dx}}[f(g(x))] = f'(g(x)) \\cdot g'(x)$",
                f"Let $u = {latex(inner)}$, so we have $u^{outer_power}$",
                f"Outer derivative: ${outer_power}u^{{{outer_power-1}}}$",
                f"Inner derivative: $\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Multiply: ${outer_power}({latex(inner)})^{{{outer_power-1}}} \\cdot {latex(diff(inner, x))}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    else:  # chain_product
        # Combination of chain and product rule (1500-1600)
        power = randint(2, 3)
        coeff1 = nonzero(-4, 4)
        coeff2 = nonzero(-4, 4)
        const = nonzero(-5, 5)
        
        f = coeff1 * x**2
        g_inner = coeff2 * x + const
        g = g_inner**power
        expr = f * g
        
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the product rule: $(fg)' = f'g + fg'$",
                f"Let $f = {latex(f)}$ and $g = {latex(g)}$",
                f"$f' = {latex(diff(f, x))}$",
                f"For $g'$, use the chain rule on ${latex(g)}$:",
                f"$g' = {power}({latex(g_inner)})^{{{power-1}}} \\cdot {latex(diff(g_inner, x))} = {latex(simplify(diff(g, x)))}$",
                f"Apply product rule and simplify: ${latex(ans)}$"
            )
        )

emit(generate())