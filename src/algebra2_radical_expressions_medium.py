"""
algebra2 - radical_expressions (medium)
Generated: 2026-02-22T04:25:57.017724
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Simplify sqrt(a^2 * b) where b is prime or small
        base = randint(2, 10)
        inner_factor = choice([2, 3, 5, 7, 11, 13, 17])
        radicand = base**2 * inner_factor
        ans = base * sqrt(inner_factor)

        return problem(
            question=f"Simplify $\\sqrt{{{radicand}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Factor: $\\sqrt{{{radicand}}} = \\sqrt{{{base}^2 \\cdot {inner_factor}}}$",
                f"$= \\sqrt{{{base}^2}} \\cdot \\sqrt{{{inner_factor}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Add/subtract radicals (may require simplifying first)
        n = choice([2, 3, 5, 6, 7, 10, 11])
        a_coeff = randint(1, 8)
        b_coeff = randint(1, 8)
        sign = choice([1, -1])
        result_coeff = a_coeff + sign * b_coeff
        ans = result_coeff * sqrt(n)

        sign_str = "+" if sign == 1 else "-"
        return problem(
            question=f"Simplify ${a_coeff}\\sqrt{{{n}}} {sign_str} {b_coeff}\\sqrt{{{n}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Combine like terms (both have $\\sqrt{{{n}}}$)",
                f"$= ({a_coeff} {sign_str} {b_coeff})\\sqrt{{{n}}} = {result_coeff}\\sqrt{{{n}}}$"
            )
        )

    elif problem_type == 3:
        # Multiply radicals: a√m * b√n
        a_val = randint(1, 5)
        b_val = randint(1, 5)
        m_val = randint(2, 12)
        n_val = randint(2, 12)
        product = m_val * n_val
        ans = simplify(a_val * b_val * sqrt(product))

        return problem(
            question=f"Simplify ${a_val}\\sqrt{{{m_val}}} \\cdot {b_val}\\sqrt{{{n_val}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Multiply coefficients and radicands separately:",
                f"$= ({a_val} \\cdot {b_val})\\sqrt{{{m_val} \\cdot {n_val}}} = {a_val*b_val}\\sqrt{{{product}}}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Rationalize denominator: a / sqrt(b)
        a_val = randint(1, 12)
        b_val = choice([2, 3, 5, 6, 7, 10, 11])
        ans = simplify(a_val * sqrt(b_val) / b_val)

        return problem(
            question=f"Rationalize the denominator: $\\frac{{{a_val}}}{{\\sqrt{{{b_val}}}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Multiply numerator and denominator by $\\sqrt{{{b_val}}}$",
                f"$= \\frac{{{a_val}\\sqrt{{{b_val}}}}}{{{b_val}}}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 5:
        # Simplify (√a + √b)^2 or (√a - √b)^2
        a_val = choice([2, 3, 5, 7])
        b_val = choice([2, 3, 5, 7, 11])
        while b_val == a_val:
            b_val = choice([2, 3, 5, 7, 11])
        sign = choice([1, -1])
        sign_str = "+" if sign == 1 else "-"

        ans = simplify((sqrt(a_val) + sign*sqrt(b_val))**2)

        return problem(
            question=f"Expand and simplify $(\\sqrt{{{a_val}}} {sign_str} \\sqrt{{{b_val}}})^2$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use $(a {sign_str} b)^2 = a^2 {sign_str} 2ab + b^2$",
                f"$(\\sqrt{{{a_val}}})^2 {sign_str} 2\\sqrt{{{a_val}}}\\sqrt{{{b_val}}} + (\\sqrt{{{b_val}}})^2$",
                f"$= {a_val} {sign_str} 2\\sqrt{{{a_val * b_val}}} + {b_val}$",
                f"$= {latex(ans)}$"
            )
        )

    else:
        # Simplify cube root expression: a * cbrt(b^3 * c)
        base = randint(2, 5)
        inner = choice([2, 3, 5, 7])
        coeff = randint(1, 4)
        radicand = base**3 * inner
        from sympy import cbrt
        ans = simplify(coeff * base * cbrt(inner))

        return problem(
            question=f"Simplify: ${coeff}\\sqrt[3]{{{radicand}}}$",
            answer=ans,
            difficulty=(1450, 1600),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Factor: $\\sqrt[3]{{{radicand}}} = \\sqrt[3]{{{base}^3 \\cdot {inner}}} = {base}\\sqrt[3]{{{inner}}}$",
                f"${coeff} \\cdot {base}\\sqrt[3]{{{inner}}} = {latex(ans)}$"
            )
        )

emit(generate())
