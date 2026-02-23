"""
algebra1 - exponent_rules (easy)
Generated: 2026-02-22T03:57:45.740326
"""

from problem_utils import *

BASES = [2, 3, 4, 5, 6, 7, 8, 9, 10]
VARS = [x, y, a, b]

def generate():
    problem_type = choice(['simplify_product', 'simplify_quotient', 'power_of_power',
                           'evaluate_small', 'zero_exponent', 'product_coeffs'])

    if problem_type == 'simplify_product':
        # x^a * x^b = x^(a+b) with varied bases and exponents
        base_var = choice(VARS)
        exp1 = randint(1, 8)
        exp2 = randint(1, 8)
        expr = base_var**exp1 * base_var**exp2
        ans = base_var**(exp1 + exp2)

        return problem(
            question=f"Simplify: ${latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1200),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Product rule: $x^a \\cdot x^b = x^{{a+b}}$",
                f"${latex(base_var)}^{{{exp1}}} \\cdot {latex(base_var)}^{{{exp2}}} = {latex(base_var)}^{{{exp1}+{exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 'simplify_quotient':
        # x^a / x^b = x^(a-b) where a > b
        base_var = choice(VARS)
        exp1 = randint(3, 10)
        exp2 = randint(1, exp1-1)
        ans = base_var**(exp1 - exp2)

        return problem(
            question=f"Simplify: $\\frac{{{latex(base_var**exp1)}}}{{{latex(base_var**exp2)}}}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Quotient rule: $\\frac{{x^a}}{{x^b}} = x^{{a-b}}$",
                f"$\\frac{{{latex(base_var)}^{{{exp1}}}}}{{{latex(base_var)}^{{{exp2}}}}} = {latex(base_var)}^{{{exp1}-{exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 'power_of_power':
        # (x^a)^b = x^(a*b)
        base_var = choice(VARS)
        exp1 = randint(2, 6)
        exp2 = randint(2, 5)
        ans = base_var**(exp1 * exp2)

        return problem(
            question=f"Simplify: $({latex(base_var)}^{{{exp1}}})^{{{exp2}}}$",
            answer=ans,
            difficulty=(1050, 1200),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Power rule: $(x^a)^b = x^{{ab}}$",
                f"$({latex(base_var)}^{{{exp1}}})^{{{exp2}}} = {latex(base_var)}^{{{exp1} \\cdot {exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 'evaluate_small':
        # Evaluate numeric expression: base^exp
        base = choice(BASES)
        exp = randint(1, 4)
        ans = base**exp

        return problem(
            question=f"Evaluate: ${base}^{{{exp}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"${base}^{{{exp}}}$ means multiply ${base}$ by itself ${exp}$ time(s)",
                f"$= {ans}$"
            )
        )

    elif problem_type == 'zero_exponent':
        # x^0 = 1 for any nonzero x
        base_var = choice(VARS)
        coeff = randint(2, 10)
        # coeff * x^0 = coeff
        ans = coeff

        return problem(
            question=f"Simplify: ${coeff} \\cdot {latex(base_var)}^{{0}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Any nonzero expression raised to the power $0$ equals $1$: ${latex(base_var)}^{{0}} = 1$",
                f"${coeff} \\cdot {latex(base_var)}^{{0}} = {coeff} \\cdot 1 = {coeff}$"
            )
        )

    else:  # product_coeffs
        # c1*x^a * c2*x^b = (c1*c2)*x^(a+b)
        base_var = choice(VARS)
        c1 = randint(2, 6)
        c2 = randint(2, 6)
        exp1 = randint(1, 6)
        exp2 = randint(1, 6)
        ans = (c1*c2) * base_var**(exp1+exp2)

        return problem(
            question=f"Simplify: $({c1}{latex(base_var)}^{{{exp1}}})({c2}{latex(base_var)}^{{{exp2}}})$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Multiply coefficients and apply product rule for exponents",
                f"$= ({c1} \\cdot {c2}) \\cdot {latex(base_var)}^{{{exp1}+{exp2}}}$",
                f"$= {c1*c2}{latex(base_var)}^{{{exp1+exp2}}}$"
            )
        )

emit(generate())
