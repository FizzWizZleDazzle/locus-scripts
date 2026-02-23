"""
algebra1 - exponent_rules (medium)
Generated: 2026-02-22T03:58:00.226289
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # x^a * x^b with larger exponents
        base_var = choice([x, y, a, b])
        exp1 = randint(2, 10)
        exp2 = randint(2, 10)
        ans = base_var**(exp1 + exp2)

        return problem(
            question=f"Simplify: ${latex(base_var)}^{{{exp1}}} \\cdot {latex(base_var)}^{{{exp2}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Product rule: $x^a \\cdot x^b = x^{{a+b}}$",
                f"$= {latex(base_var)}^{{{exp1}+{exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # (x^a)^b with varied exponents
        base_var = choice([x, y, a, b])
        exp1 = randint(2, 7)
        exp2 = randint(2, 5)
        ans = base_var**(exp1 * exp2)

        return problem(
            question=f"Simplify: $\\left({latex(base_var)}^{{{exp1}}}\\right)^{{{exp2}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Power rule: $(x^a)^b = x^{{ab}}$",
                f"$= {latex(base_var)}^{{{exp1} \\cdot {exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Quotient rule with large exponents
        base_var = choice([x, y, a, b])
        exp1 = randint(5, 12)
        exp2 = randint(1, 4)
        ans = base_var**(exp1 - exp2)

        return problem(
            question=f"Simplify: $\\frac{{{latex(base_var)}^{{{exp1}}}}}{{{latex(base_var)}^{{{exp2}}}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Quotient rule: $x^a / x^b = x^{{a-b}}$",
                f"$= {latex(base_var)}^{{{exp1}-{exp2}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Negative exponent
        base_var = choice([x, y, a, b])
        exp1 = randint(1, 7)
        ans = 1 / base_var**exp1

        return problem(
            question=f"Simplify: ${latex(base_var)}^{{-{exp1}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Negative exponent rule: $x^{{-a}} = \\frac{{1}}{{x^a}}$",
                f"${latex(base_var)}^{{-{exp1}}} = \\frac{{1}}{{{latex(base_var)}^{{{exp1}}}}}$"
            )
        )

    elif problem_type == 5:
        # Combined: (x^a * x^b)^c with coefficient
        base_var = choice([x, y, a, b])
        exp1 = randint(2, 5)
        exp2 = randint(2, 5)
        exp3 = randint(2, 4)
        ans = base_var**((exp1+exp2)*exp3)

        return problem(
            question=f"Simplify: $\\left({latex(base_var)}^{{{exp1}}} \\cdot {latex(base_var)}^{{{exp2}}}\\right)^{{{exp3}}}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"First: $x^{{{exp1}}} \\cdot x^{{{exp2}}} = x^{{{exp1+exp2}}}$ (product rule)",
                f"Then: $(x^{{{exp1+exp2}}})^{{{exp3}}} = x^{{{exp1+exp2} \\cdot {exp3}}} = {latex(ans)}$ (power rule)"
            )
        )

    else:
        # Simplify expression with coefficients and negative exponents
        base_var = choice([x, y])
        c1 = randint(2, 8)
        c2 = randint(2, 8)
        exp1 = randint(2, 6)
        exp2 = randint(exp1+1, exp1+5)
        # c1*x^exp1 / (c2*x^exp2)
        final_coeff = Rational(c1, c2)
        final_exp = exp1 - exp2

        if final_coeff == 1:
            ans = base_var**final_exp
        else:
            ans = final_coeff * base_var**final_exp

        return problem(
            question=f"Simplify: $\\frac{{{c1}{latex(base_var)}^{{{exp1}}}}}{{{c2}{latex(base_var)}^{{{exp2}}}}}$",
            answer=ans,
            difficulty=(1450, 1600),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Separate coefficient and variable: $\\frac{{{c1}}}{{{c2}}} \\cdot \\frac{{{latex(base_var)}^{{{exp1}}}}}{{{latex(base_var)}^{{{exp2}}}}}$",
                f"$= {latex(final_coeff)} \\cdot {latex(base_var)}^{{{exp1}-{exp2}}}$",
                f"$= {latex(ans)}$"
            )
        )

emit(generate())
